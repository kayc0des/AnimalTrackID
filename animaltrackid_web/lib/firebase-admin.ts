import { initializeApp, cert } from "firebase-admin/app";
import { getAuth } from "firebase-admin/auth";

const serviceAccount = require("./animaltrackid-firebase-adminsdk-fbsvc-87ef470a9e.json");

const app = initializeApp({
  credential: cert(serviceAccount),
});

export const auth = getAuth(app);