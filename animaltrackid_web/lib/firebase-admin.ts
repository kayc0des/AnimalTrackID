import { initializeApp, cert } from "firebase-admin/app";
import { getAuth } from "firebase-admin/auth";

const serviceAccount = require("./animaltrackid-firebase-adminsdk-fbsvc-5513fa817f.json");

const app = initializeApp({
  credential: cert(serviceAccount),
});

export const auth = getAuth(app);