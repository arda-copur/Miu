const OneSignal = require('onesignal-node');

const client = new OneSignal.Client(
  process.env.ONESIGNAL_APP_ID,
  process.env.ONESIGNAL_API_KEY
);

const sendNotification = async (playerIds, message, data = {}) => {
  try {
    const notification = {
      include_player_ids: playerIds,
      contents: {
        'en': message,
        'tr': message
      },
      data: data
    };

    const response = await client.createNotification(notification);
    console.log('OneSignal Notification sent:', response.body);
    return response;
  } catch (error) {
    console.error('OneSignal Error:', error);
    throw error;
  }
};

module.exports = { sendNotification };