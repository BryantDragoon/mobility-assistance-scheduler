
# Digital Scheduling App for Accessible Transportation Services [Development discontinued]

Prototype of an app for scheduling mobility assistance for people with physical impairments.

## 🎯 Problem Description

Users with physical limitations may not always have the daily support of family members or acquaintances. Therefore, they can request the assistance of trained personnel to help them during transportation to their scheduled activities, as well as provide support while those activities are being carried out.

## 🛠️ Proposed Solution

A digital application was developed—designed for both mobile and web platforms—that enabled users to schedule appointments or request assistance several days in advance. The application was specifically intented for individuals with physical limitations. Users could specify the type of assistance they required, allowing the assigned personnel to be adequately prepared ahead of time. More importantly, the app facilitated early requests for support related primarily to transportation and accompaniment throughout the activity, including the return trip home.

## ✨ Main Results

A functional proposal was successfully delivered, meeting the essential requirements for managing appointment scheduling, functioning as a basic CRUD (Create, Read, Update, Delete) application.
- Two versions of the application were developed: one for end users and another for administrators. Both versions shared the same core functionalities; however, the administrator version included additional features that allowed for comprehensive management and control of appointments.
- Users were able to create new appointments and view the overall daily demand but had limited access to appointment details.
- In contrast, administrators had full control over appointment records, including the ability to view detailed information, update, and cancel appointments as necessary.
- Application designed and developed to be fully compatible with native accessibility tools, including Android's TalkBack, to provide an inclusive and seamless experience for visually impaired users.

## 📸 Visual Overview

### User Login Interface

Users could register as new users using their email accounts or sign in with their existing Google accounts, providing greater trust and security. This flexibility enhanced user accessibility and streamlined the authentication process.

<img src="/images/sign_in_page.jpeg" alt="Sign in Page" width="20%">
<img src="/images/google_sign_in.jpeg" alt="Sign with Google" width="20%">

### Assistance Scheduling System

Unfortunately, no screenshots were captured while the application was fully functional. However, it can be stated that the date and time scheduling feature was implemented through a simple and familiar calendar-style interface.

Users were able to identify days with existing reservations, which were visually highlighted in a different color.

Reservations could only be made for the remaining days of the current month, starting from the current date until the end of the month.

Users had the option to view the day's demand in detail, including a visual representation of the time slots already reserved within the 24-hour period. 

While users were free to schedule appointments even in overlapping time slots, they were informed that in cases of limited availability, administrators would determine priority — typically favoring the user who reserved the time slot first.

Once the user selected a time slot and confirmed the intent to schedule, the system would immediately redirect them to a contact form page to complete the booking. Upon successful submission, the reservation was added to the day's demand overview, allowing other users to see which time slots remained available.

The application was developed with full compatibility for built-in accessibility features, such as Android's TalkBack, to ensure an inclusive experience for users with visual impairments. Each button and input field was designed to provide clear and meaningful audio descriptions, enabling a smooth and accessible user experience.

<img src="/images/main_page.jpeg" alt="Scheduling Main Page" width="20%">
<img src="/images/scheduled.jpeg" alt="Scheduling in a Specific Day" width="20%">
<img src="/images/scheduling form.jpeg" alt="Scheduling Form" width="20%">

## 📁 Project Structure

```
main/
├── images/ # Images used in README.md
├── source/ # Source codes of the project
│ ├── admin/ # Administrators program code (extended capabilities with more functions)
│ └── user/ # End users program code
└── README.md # Project overview
```

## 🧰 Technologies Used

- Dart
  - Flutter
    - Firebase
    - Firebase_ui_auth
    - Firebase_ui_oauth_google
    - Cloud_firestore
    - Calendar

      
