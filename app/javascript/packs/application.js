require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "bootstrap";
import { initRoomCable } from '../channels/room.js';

document.addEventListener('turbolinks:load', () => {
  initRoomCable();
});
