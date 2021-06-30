if (location.pathname.match("/")){
  document.addEventListener("DOMContentLoaded", () => {
    const inputElement = document.getElementById("input-box");
    inputElement.addEventListener("keyup", () => {
      const keyword = document.getElementById("input-box").value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `/items/search/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const searchResult = document.getElementById("suggestion");
        if (XHR.response) {
          const tagName = XHR.response.keyword;
          tagName.forEach((tag) => {
            if (tag.tag_name != document.getElementById("input-box").value) {
              const childElement = document.createElement("option");
              childElement.setAttribute("value", tag.tag_name);
              childElement.setAttribute("id", tag.id);
              childElement.innerHTML = tag.tag_name;
              searchResult.appendChild(childElement);
              const clickElement = document.getElementById(tag.id);
              clickElement.addEventListener("click", () => {
                document.getElementById("input-box").value = clickElement.textContent;
                clickElement.remove();
              });
            };
          });
        };
      };
    })
  });
};