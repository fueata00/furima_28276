function searchPriceInfo() {
  if (document.getElementById("search-price-select") != null) {
    const priceSelect = document.getElementById('search-price-select')
    const inputPriceMax = document.getElementById("search-price-max");
    const inputPriceMin = document.getElementById("search-price-min");
    
    priceSelect.addEventListener("input", () => {
      let {min,max} = priceSelectJudge(priceSelect)
      inputPriceMax.value = max;
      inputPriceMin.value = min;
    });

    checkPriceNumber(inputPriceMax);
    checkPriceNumber(inputPriceMin);
  };
}

function checkPriceNumber(elm){
  elm.addEventListener("input", () => {
    elm.value = elm.value.replace(/[^0-9０-９]+/i,'')
  });
  elm.addEventListener("blur", () => {
    elm.value = elm.value.replace(/[^0-9０-９]+/i,'')
  });
}

function priceSelectJudge(psj){
  let min = null;
  let max = null;
  switch (psj.value){
    case '1':
      break;
    case '2':
      min = 300;
      max = 1000;
      break;
    case '3':
      min = 1000;
      max = 5000;
      break;
    case '4':
      min = 5000;
      max = 10000;
      break;
    case '5':
      min = 10000;
      max = 30000;
      break;
    case '6':
      min = 30000;
      max = 50000;
      break;
    case '7':
      min = 50000;
      break;
  }
  return {min,max};
}

window.addEventListener("load", searchPriceInfo);