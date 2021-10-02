import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const html = `<div id="comment-${data.content.id}">
                    <strong>${data.name}：</strong> ${data.content.text}
                    <div>
                      <a data-remote="true" href="${data.content.article_id}/comments/${data.content.id}/edit">編集</a>
                      <a data-remote="true" rel="nofollow" data-method="delete" href="${data.content.article_id}/comments/${data.content.id}">削除</a>
                    </div>
                  </div>`;
    const comments = document.getElementById('comments');
    const newMessage = document.getElementById('comment_text');
    comments.insertAdjacentHTML('afterbegin', html);
    newMessage.value='';
  }
});