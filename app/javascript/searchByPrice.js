function pullDown() {

  const searchByPriceParent = document.getElementById("search-by-price-parent")
  const searchByPriceChild = document.getElementById("search-by-price-child")
  // const pullDownChild = document.querySelectorAll(".pull-down-list")
  // const currentList = document.getElementById("current-list")

  // searchByPriceParent.addEventListener('mouseover', function(){
  //   this.setAttribute("style", "background-color:#FFBEDA;")
  // })

  // searchByPriceParent.addEventListener('mouseout', function(){
  //   this.removeAttribute("style", "background-color:#FFBEDA;")
  // })

  searchByPriceParent.addEventListener('click', function() {
    if (searchByPriceChild.getAttribute("style") == "display:block;") {
      searchByPriceChild.removeAttribute("style", "display:block;")
    } else {
      searchByPriceChild.setAttribute("style", "display:block;")
    }
  })
}

window.addEventListener('load', pullDown)