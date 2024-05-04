const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.sendNotification = functions.firestore
    .document('Organisations/{orgID}/annonces/{annonceID}')
    .onCreate(async (snapshot, context) => {
        try {
            // Get data from the newly added annonce document
            const annonceData = snapshot.data();

            // Get the organization ID from the context
            const orgID = context.params.orgID;

            // Retrieve the sender's name from the "Organisations" collection
            const orgDoc = await admin.firestore().collection('Organisations').doc(orgID).get();
            if (!orgDoc.exists) {
                console.error('Organization document not found');
                return;
            }

            const orgData = orgDoc.data();
            const senderName = orgData.name; // Assuming sender name is stored in 'name' field

            // Construct the notification payload
            const payload = {
                notification: {
                    title: `From ${senderName}`,
                    body: `Description: ${annonceData.description}` // Assuming description is stored in 'description' field
                }
            };

            // Send the notification
            const response = await admin.messaging().sendToTopic('notifications', payload);

            console.log('Notification sent:', response);

            // Subscribe user to notifications
            const userId = orgData.userId; // Assuming userId is stored in 'userId' field
            await subscribeToNotifications(userId);

        } catch (error) {
            console.error('Error sending notification:', error);
        }
    });

async function subscribeToNotifications(userId) {
    const messaging = firebase.messaging();
    messaging.getToken()
        .then(token => {
            return messaging.subscribeToTopic('notifications')
                .then(() => {
                    console.log('Successfully subscribed to notifications topic');
                })
                .catch(error => {
                    console.error('Error subscribing to notifications topic:', error);
                });
        })
        .catch(error => {
            console.error('Error getting FCM token:', error);
        });
    
}

