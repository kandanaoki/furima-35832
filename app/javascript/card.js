const pay = ()=>{
  if (document.getElementById("charge-form")) {
    Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
    const form = document.getElementById("charge-form");
    form.addEventListener("submit", (e) =>{
      e.preventDefault();
      const formResult = document.getElementById("charge-form");
      const formData = new FormData(formResult);

      const card = {
        number: formData.get("card[number]"),
        exp_month: formData.get("card[exp_month]"),
        exp_year: `20${formData.get("card[exp_year]")}`,
        cvc: formData.get("card[cvc]"),
      };
      Payjp.createToken(card, (status, response) => {
        if (status == 200) {
          const card_token = response.id;
          console.log(card_token)
          const renderDom = document.getElementById("charge-form");
          const tokenObj = `<input value=${card_token} name='card_token' type="hidden"> `;
          renderDom.insertAdjacentHTML("beforeend", tokenObj);
        };
        
        document.getElementById("card-number").removeAttribute("name");
        document.getElementById("card-exp-month").removeAttribute("name");
        document.getElementById("card-exp-year").removeAttribute("name");
        document.getElementById("card-cvc").removeAttribute("name");

        document.getElementById("charge-form").submit();
      });
    });
  };
}

window.addEventListener('load', pay)