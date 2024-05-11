const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

var msData;
exports.annoncesTrigger = functions.firestore.document(
    'annonces/{annonceID}'
).onCreate((snapshot, context) => {
    msData = snapshot.data();

    admin.firestore().collection('tokens').get().then((snapshots) => {
        var tokens = [];
        if (snapshots.empty) {
            console.log('no devices');
        } else {
            snapshots.forEach(doc => {
                tokens.push(doc.data().token);
            });

            var payload = {
                "notification": {
                    "title": "from " + msData.name,
                    "body": "description " + msData.logoURL,
                    "sound": "default"
                },
                "data": {
                    "sendername": msData.name,
                    "message": msData.logoURL
                }
            };

            return admin.messaging().send(payload).then((response) => {
                console.log('pushed them all');
            }).catch((err) => {
                console.error('Error sending message:', err);
            });
        }
    }).catch(error => {
        console.error('Error fetching tokens:', error);
    });
});



