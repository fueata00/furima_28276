function priceInfo() {
  if (document.getElementById("item-price") != null) {
    const inputPrice = document.getElementById("item-price");
    const fee = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    
    inputPrice.addEventListener("input", () => {
      const price = inputPrice.value;
      const priceFee = Math.floor(price * 0.1);
      const priceProfit = price - priceFee;
      fee.innerHTML = priceFee;
      profit.innerHTML = priceProfit;
    });
  };
}

window.addEventListener("load", priceInfo);