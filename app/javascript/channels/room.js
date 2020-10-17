import consumer from "./consumer";

const initRoomCable = () => {
  const ticketsContainer = document.getElementById('tickets');
  if (ticketsContainer) {
    const id = ticketsContainer.dataset.roomId;

    consumer.subscriptions.create({ channel: "RoomChannel", id: id }, {
      received(data) {
        console.log(data); // called when data is broadcast in the cable
      },
    });
  }
}

export { initRoomCable };