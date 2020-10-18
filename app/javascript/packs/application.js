require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "bootstrap";
import { initRoomCable } from '../channels/room.js';
import { initSelect2 } from '../components/init_select2.js';

document.addEventListener('turbolinks:load', () => {
  initRoomCable();
  initSelect2();

  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  })

});
