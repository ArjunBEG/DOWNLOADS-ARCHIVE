# Use this script to test that your Telegram bot works.
#
# Install the dependency
#
#   $ gem install telegram_bot
#
# Run the bot
#
#   $ ruby bot.rb
#
# Send a message to the bot to get the current chat's ID in the console output.
# If it's a group chat, invite them to the chat first.

require 'logger'
require 'telegram_bot'

TELEGRAM_BOT_TOKEN = "YOUR_BOT_API_TOKEN"

bot = TelegramBot.new(token: TELEGRAM_BOT_TOKEN, logger: Logger.new(STDOUT))

bot.get_updates(fail_silently: true) do |message|
  puts "@#{message.from.username}: #{message.text}"
  puts "Chat-ID: #{message.chat.id}"
end
