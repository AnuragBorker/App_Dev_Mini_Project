# FireChat

**FireChat** is a simple and intuitive one-on-one messaging application built with **Flutter** and **Firebase**. It allows users to browse participants, start private chats, and manage profiles with real-time text messaging. The app demonstrates Firebase authentication, state management with Provider, and a clean responsive UI.

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

* Build a fully functional messaging app using Flutter and Firebase.
* Gain experience across the development lifecycle: design, coding, testing on emulators, and deploying APK on Android.
* Ensure the app is seamless, easy to use, and downloadable.

---

## Overview

FireChat is a simple and intuitive one-on-one messaging application. The first version supports only a single collaboration at a time. Users can browse all participants and start private chats instantly, making communication quick, secure, and smooth.

---

## Use Cases

* **Campus Chat:** Connect with classmates and friends.
* **Small Team Collaboration:** Discuss tasks in project groups.
* **Corporate Messaging:** Quick chats with colleagues.
* **Community Groups:** Share ideas in clubs or interest groups.

---

## Download & Usage

* **Download APK:** [[Click here to start apk download](https://github.com/AnuragBorker/App_Dev_Mini_Project/releases/download/v1.0.0/app-release.apk)]
* **Install:** Enable installation from unknown sources and install APK.
* **Use:** Open app → browse participants → start chatting.

> **Invite Friends:**
> There is an **Invites Screen** where you can copy/share the APK link to invite friends. A **QR code** is also provided to directly start the APK download when scanned.

---

## Functional Overview

* Lists all registered users.
* One-on-one messaging in real-time (text only).
* Simple, intuitive interface.
* Users can change password and logout from the **Profiles Page**.
* Supports only one active collaboration per user in this version.
* **Sign In / Sign Up Screens:** Handle authentication.
* **Profile photo upload:** Not currently supported due to Firebase Blaze subscription requirement.

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

## Usage

* **Chat List Screen:** Shows all participants/users. Tap a chat tile to enter a **one-to-one conversation interface** where text messages can be exchanged.
* **Invites Screen:** Copy/share APK link or scan QR code to invite friends.
* **Profiles Page:** Change password or logout.
* **Sign In / Sign Up Screens:** Handle authentication.

---

## Architecture & Technical Details

* **Frontend:** Flutter app for cross-platform mobile development.
* **Backend:** Firebase for authentication, real-time database, and storage.
* **Data Model:** Users & messages stored in Firebase collections.
* **State Management:** Provider for Flutter state management.
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
