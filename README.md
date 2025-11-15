# FireChat

**FireChat** offers fast and reliable real-time text messaging through a clean responsive Flutter interface powered by Firebase.

---

## Table of Contents

1. [Objective](#objective)
2. [Overview](#overview)
3. [Use Cases](#use-cases)
4. [Download & Usage](#download--usage)
5. [Functional Overview](#functional-overview)
6. [Installation & Setup](#installation--setup)
7. [Usage](#usage)
8. [Architecture & Technical Details](#architecture--technical-details)
9. [Dependencies](#dependencies)
10. [Future Enhancements](#future-enhancements)
11. [Acknowledgements / References](#acknowledgements--references)

---

## Objective

* Build a real-time text messaging application using Flutter and Firebase.
* Implement basic use authentication.
* Design an intuitive, mobile UI for sending and receiving text messages.
* Learn practical integration of a mobile frontend with a cloud backend (cloud_firestore).
* Demonstrate coding skills in application development,testing, and deployment.

---

## Overview

FireChat is a simple and intuitive one-on-one messaging application. The first version supports single collaboration at a time. Users can browse all participants and start private chats instantly with any one, making communication quick and smooth.

---

## Use Cases

* **Campus Chat:** Connect with classmates and friends.
* **Small Team Collaboration:** Discuss tasks in project groups.
* **Corporate Messaging:** Quick chats with colleagues.
* **Community Groups:** Share ideas in clubs, projects, or interest groups.

---

## Download & Usage

* **Download APK:** [[Click Here to start apk download](https://github.com/AnuragBorker/App_Dev_Mini_Project/releases/download/v1.0.0/app-release.apk)]
* **Install:** Enable installation from unknown sources and install APK.
* **Use:** Open app → browse participants → start chatting.

> **Invite Friends:**
> There is an **Invites Screen** where you can copy/share the APK link to invite friends. A **QR code** is also provided to directly start the APK download when scanned.

---

## Functional Overview

* **Authentication**
  * Enter login name and password to login.
  * To sign up, enter the password twice and confirm.
  * Visit the Profile section.
    * To reset password.
    * To logout from the application.

* **Application Functionality**
  * List all registered users.
  * Tap on a listed user tile to initiate a conversation or send a message.
    * Type the message and submit (text only). One-on-one messaging in real-time (text only) supported.
    * Only the recepient can see the message sent to him.
    * Recepient will see the unread message count and preview of last message received is displayed for each chat conversation.

---

## Installation & Setup

1. **Clone the Repository**

```bash
git clone https://github.com/AnuragBorker/App_Dev_Mini_Project.git
cd App_Dev_Mini_Project
```

2. **Install Flutter Dependencies**

```bash
flutter pub get
```

3. **Setup Firebase**

   * Go to [Firebase Console](https://console.firebase.google.com/).
   * Create a new project.
   * Add **Android & iOS apps** to the project.
   * Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).
   * Place them in their respective platform folders:

     * Android: `android/app/`
     * iOS: `ios/Runner/`

4. **Configure FlutterFire**

```bash
flutterfire configure
```

5. **Run the App**

```bash
flutter run
```

> Note: For profile photo upload functionality, Firebase **Blaze subscription** is required. Currently, uploading profile photos is not supported.

---

## User Interface

* **Sign In / Sign Up Screens:** Handle authentication.
* **Chat List Screen:** Shows all participants/users. 
* **1-1 Conversation Screen** where text messages can be exchanged.
* **Invites Screen:** Copy/share APK link or scan QR code to invite friends.
* **Profiles Screen:** Change password and logout.

---

## Architecture & Technical Details

* **Frontend:** Flutter for cross-platform mobile development.
* **Backend:** Firebase for authentication, real-time database, and storage.
* **Data Model:** Firebase collections.
* **State Management:** Provider dependency for Flutter state management.
* **Design Pattern:** Implements **Model-View-ViewModel (MVVM)** pattern where:
  * **Model:** Represents data objects (User, Message).
  * **View:** UI screens (chat, profile, invites).
  * **ViewModel:** Handles business logic, manages state, and connects the Model with the View.

---

## Dependencies

* `firebase_core`
* `firebase_auth`
* `cloud_firestore`
* `firebase_storage`
* `provider`
* `flutter/material.dart`
* Other dependencies as listed in `pubspec.yaml`

---

## Future Enhancements

* Group chats & multiple collaborations.
* Push notifications.
* Multimedia support (images, videos, voice notes).
* Improved security (end-to-end encryption).

---

## Acknowledgements / References

* [YouTube Reference Video](https://youtu.be/VO3W__bPHAE?si=sN8jT_hN043h8zwi) — referred for Firebase & Flutter integration.
* Flutter official docs: [https://docs.flutter.dev](https://docs.flutter.dev)
