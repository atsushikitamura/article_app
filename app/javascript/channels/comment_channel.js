import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const html = `<p><strong>${data.name}：</strong> ${data.content.text}</p>
                  <div>
                    <a rel="nofollow" data-method="delete" href="${data.content.article_id}/comments/${data.content.id}">削除</a>
                  </div>`;
    const comments = document.getElementById('comments');
    const newMessage = document.getElementById('comment_text');
    comments.insertAdjacentHTML('afterbegin', html);
    newMessage.value='';
  }
});