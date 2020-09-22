function itemSort(){
  if(document.getElementById('search-item-sort') != null){
    const sortSelect = document.getElementById('search-item-sort')
    const searchForm = document.getElementById('detailed-item-search')
    sortSelect.addEventListener("change", () => {
      searchForm.submit()
    })
  }
}

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
  }
}

function checkPriceNumber(elm){
  elm.addEventListener("input", () => {
    elm.value = elm.value.replace(/[^0-9]+/i,'')
  });
  elm.addEventListener("blur", () => {
    elm.value = elm.value.replace(/[^0-9]+/i,'')
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

function checkBoxSelect(){
  if (document.getElementById("search-price-select") != null){ 
    const statusBoxes = document.querySelectorAll('.q_status_ids')
    const ShippingFeeBoxes = document.querySelectorAll('.q_shipping_fee_ids')
    const SalesStatusBoxes = document.querySelectorAll('.q_sales_status_ids')
    // 「すべて」チェックボックスのイベント
    checkBoxAll(statusBoxes)
    checkBoxAll(ShippingFeeBoxes)
    checkBoxAll(SalesStatusBoxes)
    // 「すべて」以外のチェックボックスのイベント
    checkBoxAllSelect(statusBoxes)
    checkBoxAllSelect(ShippingFeeBoxes)
    checkBoxAllSelect(SalesStatusBoxes)
  }
}

function checkBoxAll(elm){
  elm[0].addEventListener("change", () => {
    if (elm[0].checked === true){             //「すべて」にチェックが入っているとき
      elm.forEach((e) => {                    // 「すべてのチェックボックス」にチェックを入れる
        if (e.value !== '1'){
          e.checked = true;
        }
      })
    } else {                                 //「すべて」にチェックが入っていないとき
      elm.forEach((e) => {                   // 「すべてのチェックボックス」からチェックを外す
        e.checked = false;
      })
    }
  })
}

function checkBoxAllSelect(elm){
  const elmentLength = elm.length
  elm.forEach((e) => {
    if (e.value != '1'){
      e.addEventListener("change", () => {
        if (elm[0].checked === true){                           //「すべて」にチェックが入っているとき
          for (let count = 1; count < elmentLength; count ++){
            if (elm[count].checked === false){                  // 「すべて」以外一つでもチェックボックスにチェックが入っていなければ
              elm[0].checked = false;                         //「すべて」のチェックを外す
              break;
            }
          }
        } else {                                                //「すべて」にチェックが入っていないとき
          let checkAll = true;
          for (let count = 1; count < elmentLength; count ++){
            if (elm[count].checked === false){                  // 「すべて」以外一つでもチェックボックスにチェックが入っていなければ
              checkAll = false;                                 //「すべて」のチェックを外す
              break;
            }
          }
          elm[0].checked = checkAll;
        }
      })
    }
  })
}

window.addEventListener("load", searchPriceInfo);
window.addEventListener("load", itemSort);
window.addEventListener("load", checkBoxSelect);