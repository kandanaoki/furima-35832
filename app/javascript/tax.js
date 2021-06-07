function tax(){
  const price = document.getElementById("item-price")
  price.addEventListener("keyup", () =>{
    const addTaxPrice = document.getElementById("add-tax-price")
    const profit = document.getElementById("profit")
    const taxRate = 0.1
    const tax = price.value * taxRate
    const taxRounded = Math.round(tax)
    addTaxPrice.innerHTML = taxRounded
    profit.innerHTML = price.value - taxRounded
  })
}

window.addEventListener('load', tax)