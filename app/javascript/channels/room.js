import consumer from "./consumer";

const initRoomCable = () => {
  const ticketsContainer = document.getElementById('tickets');
  if (ticketsContainer) {
    const id = ticketsContainer.dataset.roomId;

    consumer.subscriptions.create({ channel: "RoomChannel", id: id }, {
      received(data) {
        // console.log(data); // called when data is broadcast in the cable

        fetch(window.location.href,  {
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          }
        })
        .then(response => response.json())
        .then((data) => {
          // console.log(data);
          ticketsContainer.innerHTML = data.tickets_html;
        });

      },
    });
  }

}

export { initRoomCable };