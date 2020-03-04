require('dotenv').config()
const TeleBot = require('telebot');
const { cards } = require('./cards.js');


function dayOfYear() {
  const now = new Date();
  const start = new Date(now.getFullYear(), 0, 0);
  const diff = now - start;
  const oneDay = 1000 * 60 * 60 * 24;
  const day = Math.floor(diff / oneDay);
  return day;
}

const bot = new TeleBot({
  token: process.env.API_TOKEN,
  polling: {
    interval: 1000,
    timeout: 0,
    limit: 100,
    retryTimeout: 5000
  },
  allowedUpdates: ["text"],
  usePlugins: []
});

bot.on(['/draw'], (msg) => {
  const mIndex = msg.from.id + dayOfYear();
  const mCard = cards[mIndex % cards.length];
  msg.reply.text(`Your algorithm is:\n${mCard.name}`).then(() => {
    bot.sendSticker(msg.chat.id, mCard.sticker_id).then(() => {
      msg.reply.text(`${mCard.message}`).then(() => {
        msg.reply.text('🔮 Come back tomorrow for a new algorithm 🔮');
      });
    });
  });
});

bot.start();
