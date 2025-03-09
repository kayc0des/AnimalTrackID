import firebase_admin
from firebase_admin import credentials

# Initialize Firebase Admin SDK
def initialize_firebase():
    cred = credentials.Certificate("animaltrackid-firebase-adminsdk-fbsvc-5513fa817f.json")  # Path to your Firebase service account key
    firebase_admin.initialize_app(cred)