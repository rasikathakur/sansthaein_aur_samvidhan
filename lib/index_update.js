const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.updateUserProgress = functions.firestore
    .document('user_activity/{userId}')
    .onUpdate(async (change, context) => {
        const newData = change.after.data();
        const userId = context.params.userId;

        // Extract fields
        const eCount = (newData.e_count || 0);
        const lCount = (newData.l_count || 0);
        const jCount = (newData.j_count || 0);
        const game1Count = (newData.game_1_level_count || 0);
        const game2Count = (newData.game_2_level || 'EEE').toString().length;
        const game3Count = (newData.game_3_level || 'EEE').toString().length;

        // Calculate weights
        const executiveWeight = eCount / 30;
        const legislatureWeight = lCount / 30;
        const judiciaryWeight = jCount / 28;
        const game1Weight = game1Count / 88;
        const game2Weight = game2Count / 3;
        const game3Weight = game3Count / 3;

        // Calculate total progress
        let totalProgress = (
            executiveWeight +
            legislatureWeight +
            judiciaryWeight +
            game1Weight +
            game2Weight +
            game3Weight
        ) / 6;

        totalProgress = Math.min(1, Math.max(0, totalProgress)); // Clamp between 0 and 1

        // Update the progress_total field only if it changed
        if (newData.progress_total !== totalProgress) {
            await admin.firestore().collection('user_activity').doc(userId).update({
                progress_total: totalProgress
            });
        }

        return null;
    });

