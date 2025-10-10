document.addEventListener("turbo:load", setupListForm);

function setupListForm() {
  const addItemButton = document.getElementById("add-item");
  const listItemsContainer = document.getElementById("list-items");

  if (!addItemButton || !listItemsContainer) return;

 function updateItemNumbers() {
    Array.from(listItemsContainer.querySelectorAll(".list-item-fields"))
      .filter((el) => el.style.display !== "none")
      .forEach((child, idx) => {
        const position = child.querySelector(".item-position");
        if (position) position.textContent = idx + 1;

        const hiddenPos = child.querySelector('input[name*="[position]"]');
        if (hiddenPos) hiddenPos.value = idx + 1;
      });
  }

  addItemButton.addEventListener("click", () => {
    const uniqueId = new Date().getTime();

    const template = `
      <div class="list-item-fields">
        <span class="item-position"></span>
        <input type="text"
               name="list[list_items_attributes][${uniqueId}][name]"
               id="list_list_items_attributes_${uniqueId}_name" />
        <input type="hidden"
               name="list[list_items_attributes][${uniqueId}][position]"
               id="list_list_items_attributes_${uniqueId}_position"
               value="" />
        <input type="hidden"
               name="list[list_items_attributes][${uniqueId}][_destroy]"
               id="list_list_items_attributes_${uniqueId}__destroy"
               value="false" />
        <button type="button" class="remove-item">Remove item</button>
      </div>
    `;

    listItemsContainer.insertAdjacentHTML("beforeend", template);
    updateItemNumbers();
  });

  listItemsContainer.addEventListener("click", (event) => {
    if (event.target.classList.contains("remove-item")) {
      const wrapper = event.target.closest(".list-item-fields");
      const destroyField = wrapper.querySelector('input[name*="[_destroy]"]');

      if (destroyField) {
        destroyField.value = "1";
        wrapper.style.display = "none";
      } else {
        wrapper.remove();
      }

      updateItemNumbers();
    }
  });

  updateItemNumbers();
}

