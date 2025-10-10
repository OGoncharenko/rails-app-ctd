document.addEventListener("turbo:load", setupListForm);

function setupListForm() {
  const addItemButton = document.getElementById("add-item");
  const listItemsContainer = document.getElementById("list-items");

  if (!addItemButton || !listItemsContainer) return;

 const updateItemNumbers = () => {
    Array.from(listItemsContainer.querySelectorAll(".list-item-fields"))
      .filter((el) => el.style.display !== "none")
      .forEach((child, idx) => {
        const position = child.querySelector(".item-position");
        if (position) position.textContent = idx + 1;

        const hiddenPosition = child.querySelector('input[name*="[position]"]');
        if (hiddenPosition) hiddenPosition.value = idx + 1;
      });
  }

  const createListItem = () => {
    const uniqueId = new Date().getTime();
    return`
      <div class="list-item-fields">
        <span class="item-position"></span>
        <input type="text"
               name="list[list_items_attributes][${uniqueId}][name]"
               id="list_list_items_attributes_${uniqueId}_name" />
        <button type="button" class="remove-item">Remove item</button>
      </div>
    `;
  }

    const handleAddItem = () => {
      listItemsContainer.insertAdjacentHTML("beforeend", createListItem());
    updateItemNumbers();
  }

  const handleRemoveItem = (event) => {
    const removeBtn = event.target.closest(".remove-item");
    if (!removeBtn) return;

    const itemWrapper = removeBtn.closest(".list-item-fields");
    const destroyInput = itemWrapper.querySelector('input[name*="[_destroy]"]');

    if (destroyInput) {
      destroyInput.value = "1";
      itemWrapper.style.display = "none";
    } else {
      itemWrapper.remove();
    }

      updateItemNumbers();
    }

  addItemButton.addEventListener("click", handleAddItem);
  listItemsContainer.addEventListener("click", handleRemoveItem);

  updateItemNumbers();
}

