import firebase_admin
from firebase_admin import credentials

# Initialize Firebase Admin SDK
def initialize_firebase():
    cred = credentials.Certificate("animaltrackid-firebase-adminsdk-fbsvc-87ef470a9e.json")
    firebase_admin.initialize_app(cred)