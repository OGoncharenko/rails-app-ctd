// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "add_list_item"

document.addEventListener("turbo:load", () => {
  const flashMessages = document.querySelectorAll(".flash-message");

  flashMessages.forEach((msg) => {
    setTimeout(() => {
      msg.style.transition = "opacity 1s ease-out";
      msg.style.opacity = "0";
      setTimeout(() => msg.remove(), 1000);
    }, 3000);
  });
});
