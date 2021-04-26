1. [Create a bot](https://core.telegram.org/bots#6-botfather)
2. Get the bot's API token from [@BotFather](https://telegram.me/BotFather)
3. Add your bot to the chat you'll be sending messages to
3. Get the ID of the chat  
   a. Fetch bot updates and look for the chat id:  
      ```
      curl https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/getUpdates | jq .message.chat.id
      ```
   b. OR, run [bot.rb](https://gist.github.com/dideler/85de4d64f66c1966788c1b2304b9caf1#file-bot-rb) and @-mention your bot in the chat. The chat id will appear in `bot.rb`'s output.  
     The bot may need temporary message access: `@BotFather > Bot Settings > Group Privacy > Turn off`
4. Send a message using the HTTP API: https://core.telegram.org/bots/api#sendmessage  
   ```shell
   curl -X POST \
        -H 'Content-Type: application/json' \
        -d '{"chat_id": "123456789", "text": "This is a test from curl", "disable_notification": true}' \
        https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage
   ```