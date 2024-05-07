const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.tryn = functions.pubsub.schedule('every 1 minutes').onRun(async (context) => {
    const db = admin.firestore();
    const eventRoomsRef = db.collection('event_rooms');

    const currentDate = new Date();
    console.log('Current Date:', currentDate);
    const snapshot = await eventRoomsRef.where('isStarted', '==', false).get();

    const updatePromises = [];

    snapshot.forEach((doc) => {
        const eventData = doc.data();
        const eventDate = eventData.eventDate; // "20/04/2024"
        const eventTime = eventData.eventTime; // "9.05 PM" or "12.30 AM" or "21:16"

        // Parse the eventDate and eventTime strings into a Date object
        const [day, month, year] = eventDate.split('/');
        const parsedEventDateTime = new Date(`${month}/${day}/${year} ${eventTime}`);

        console.log('Parsed Event Date:', parsedEventDateTime);
        if (currentDate > parsedEventDateTime) {
            updatePromises.push(doc.ref.update({ isStarted: true }));
        }
    });

    await Promise.all(updatePromises);

    console.log('Event statuses updated successfully.');

    return null;
});