document.addEventListener("turbo:load", () => {
  const addItemButton = document.getElementById("add-item");
  const listItemsContainer = document.getElementById("list-items");

  if (!addItemButton || !listItemsContainer) return;

  addItemButton.addEventListener("click", () => {
    const index = listItemsContainer.children.length;
    const displayIndex = index + 1;

    const template = `
      <div class="list-item-fields">
        <span class="item-position">${displayIndex}</span>
        <input
          type="text"
          name="list[list_items_attributes][${displayIndex}][name]"
          id="list_list_items_attributes_${displayIndex}_name"
          placeholder="Item name"
        />
       <button type="button" class="remove-item">Remove item</button>
      </div>
    `;

    listItemsContainer.insertAdjacentHTML("beforeend", template);
  });

  listItemsContainer.addEventListener("click", (event) => {
    if (event.target.classList.contains("remove-item")) {

      const itemToRemove = event.target.closest(".list-item-fields");
      const allItems = Array.from(listItemsContainer.querySelectorAll(".list-item-fields"));
      const index = allItems.indexOf(itemToRemove);

      if(index < 3) return;

      itemToRemove.remove();

      Array.from(listItemsContainer.children).forEach((child, idx) => {
        const span = child.querySelector(".item-position");
        const position = child.querySelector(".item-position");
        if (span) span.textContent = idx + 1;
        if (position) position.textContent = idx + 1;
      });
    }
  });
});
