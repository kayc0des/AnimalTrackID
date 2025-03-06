import { NextResponse } from "next/server";
import { auth } from "@/lib/firebase-admin"; // Adjust the path as needed

export async function GET() {
  try {
    // Fetch all users from Firebase Authentication
    const listUsersResult = await auth.listUsers();
    const users = listUsersResult.users.map((userRecord) => ({
      id: userRecord.uid,
      email: userRecord.email || "No email",
      provider: userRecord.providerData[0]?.providerId || "Unknown",
      createdAt: userRecord.metadata.creationTime, // Add creation time
    }));

    return NextResponse.json(users);
  } catch (error) {
    console.error("Error fetching users:", error);
    return NextResponse.json(
      { error: "Failed to fetch users" },
      { status: 500 }
    );
  }
}