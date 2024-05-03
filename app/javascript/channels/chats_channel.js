import consumer from "channels/consumer"

// document.addEventListener("turbo:load", () => {
    console.log('running')
    // let chat = document.querySelectorAll('.user-pic')
    // for (const ch of chat) {
    // ch.addEventListener('click', function() {
    consumer.subscriptions.create({channel: "ChatsChannel"}, {
      connected() {
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        // console.log(data)
        let chatId = data.chat_id
        const chatBox = document.querySelector(`a[data-chat-id="${chatId}"]`)
        this.template2(chatBox,data)
        if (data.chat_id == chatId) {
          const messageDisplay = document.querySelector('#messages')
          messageDisplay.insertAdjacentHTML('beforeend', this.template(data))}
      },
      template(data) {
        let currentUser = document.querySelector('#message_user_id').value
        // console.log(data.is_date)
        // console.log(data.is_date == true)
        if (data.is_date == true) {
          console.log('is date')
          return `<div class='chat-date'>
                    <p class='date'>${data.message}</p>
                  </div>`
        }
        // console.log('not a date')
        let firstDiv = ''
        if (data.current_user == currentUser) {
          firstDiv = '<div class="chat-message-user">'
        }
        else {
          firstDiv = '<div class="chat-message">'
        }
        return `${firstDiv}
                    <p>${data.message}</p>
                    <p class="message-date">${data.date}</p>
                </div>`
      },
      template2(chat, data) {
        if (chat.children[1].children[1].children[0] == null) {
          chat.children[1].children[1].insertAdjacentHTML('beforeend', '<p class="post-user" id="user-last-message"></p>')
        }
        let currentUser = document.querySelector('#message_user_id').value
        if (data.current_user == currentUser) {
        chat.children[1].children[1].children[0].textContent = `You: ${data.message}`}
        else {
          chat.children[1].children[1].children[0].textContent = data.message
          let count = chat.children[1].children[1].children[1]
          if (count == null) {
            return chat.children[1].children[1].insertAdjacentHTML('beforeend', "<div class='messages-count'>1</div>")}
          else {
              count.textContent = parseInt(count.textContent) + 1
            }
        }
      }
})//})}});
// document.addEventListener("turbo:load", () => {
//   let form = document.querySelector('#message-form')
//   if(form) {
//     form.addEventListener('submit', (e) => {
//       e.preventDefault()
//       let messageInput = document.querySelector('#message-input').value
//       if(messageInput == '') return;
//       const message = {
//         body: messageInput
//       }
//       chatsChannel.send({message: message})
//     })
//   }
// })
