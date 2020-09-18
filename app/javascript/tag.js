if (document.getElementsByClassName("tags-text")){
  window.addEventListener("load", () => {
    let count = 0
    const inputElements = document.querySelectorAll(".tags-text");

    let tagLength = inputElements.length
    const addButton = document.getElementById('add-tag-button')
    addButton.addEventListener("click", (b)=> {
      b.preventDefault();
      if (tagLength <= 2){
        lastTagElement = document.getElementById(`tag-name-${tagLength}`)
        let tagHtml = `<input class="tags-text" id="tag-name-${tagLength + 1}" placeholder="タグ（任意 10文字まで)" maxlength="10" name="item[tags][name][]" multiple="multiple" size="10" type="text" />`
        tagLength += 1
        lastTagElement.insertAdjacentHTML("afterend", tagHtml);
      }
    })
    const removeButton = document.getElementById('remove-tag-button')
    removeButton.addEventListener("click", (b)=> {
      b.preventDefault();
      if (tagLength >= 2){
        lastTagElement = document.getElementById(`tag-name-${tagLength}`)
        lastTagElement.remove()
        tagLength -= 1
      }
    })

    document.addEventListener("keyup", (eKeyUp) => {
      for (let step=1; step<=3; step++){
        if (eKeyUp.target.id ===`tag-name-${step}`) {
          let input = document.getElementById(`tag-name-${step}`).value;
          if (input){
            let xhr = new XMLHttpRequest();
            xhr.open("GET", `search/?input=${input}`, true);
            xhr.responseType = "json";
            xhr.send();
            xhr.onload = () => {
              let tagName = xhr.response.keyword;
              let searchResult = document.getElementById('search-result')
              let searchRemoveButton = `<button type="button" id="remove-serach-button">-</button>`
              searchResult.innerHTML = ''
              searchResult.insertAdjacentHTML("afterbegin", searchRemoveButton)
              tagName.forEach((tag) => {
                let parentsElement = document.createElement('div')
                let childElement = document.createElement('div')

                parentsElement.setAttribute('class', 'tag-parents')
                childElement.setAttribute('id', tag.id )
                childElement.setAttribute('class', 'tag-child' )

                parentsElement.appendChild(childElement)
                childElement.innerHTML = tag.name
                searchResult.appendChild(parentsElement)

                let clickElement = document.getElementById(tag.id)
                clickElement.addEventListener("click", () => {
                  let searchElements = document.querySelectorAll('.child')
                  document.getElementById(`tag-name-${step}`).value = clickElement.textContent;
                  searchResult.innerHTML = ''
                })
              })
              document.addEventListener("click", (eClick) => {
                if(eClick.target.id === "remove-serach-button"){
                  searchResult.innerHTML = ''
                }
              })
            }
          }
        }
      }
    })
  })
};