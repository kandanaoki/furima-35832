function tax(){
  const price = document.getElementById("item-price")
  price.addEventListener("keyup", () =>{
    const addTaxPrice = document.getElementById("add-tax-price")
    const profit = document.getElementById("profit")
    const tax = 0.1
    const profitRate = 1 - tax
    addTaxPrice.innerHTML = price.value * tax
    profit.innerHTML = price.value * profitRate
    console.log(`${price.value}`)
  })
}

window.addEventListener('load', tax)