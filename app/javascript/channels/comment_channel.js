import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data)
    const html = `
        <p>Commennted by あなた</p>
        <p>${data.content.text}</p>
        <h1 class='form-header-text'>
        </h1>`;
    const messages = document.getElementById('comments');
    const newMessage = document.getElementById('comment_text');
    messages.insertAdjacentHTML('afterbegin', html);
    newMessage.value='';
  }
});
