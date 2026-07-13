# 🎬 Movie Recommendation App (iOS)

A modern iOS Movie Recommendation application developed using **SwiftUI** following the **MVVM Architecture**. The application integrates **TMDB APIs** to provide movie recommendations, trending movies, search functionality, trailers, cast details, and personalized watchlists using **Firebase Authentication** and **Cloud Firestore**.

> Developed as part of the **Encora/Coforge iOS Training Program**.

---

## 📱 Features

### 🔐 Authentication
- User Sign Up
- User Login
- Firebase Authentication
- Secure Session Management

---

### 🏠 Home Screen
- Trending Movies
- Popular Movies
- Top Rated Movies
- Upcoming Movies
- Featured Banners

---

### 🔍 Movie Search
- Search movies by title
- Real-time search results
- Movie suggestions

---

### 🎥 Movie Details
- Movie overview
- Release date
- Ratings
- Runtime
- Genres
- Cast information
- Official trailers
- Similar movie recommendations

---

### ❤️ Watchlist
- Add movies to watchlist
- Remove movies from watchlist
- Persistent watchlist using Cloud Firestore

---

### 👤 User Profile
- View profile
- Logout functionality
- Personalized experience

---

## 🛠 Technologies Used

- Swift
- SwiftUI
- MVVM Architecture
- Firebase Authentication
- Cloud Firestore
- TMDB API
- Xcode
- Git & GitHub

---

## 🏗 Architecture

The application follows the **MVVM (Model-View-ViewModel)** architecture.

```
View
   │
ViewModel
   │
Repository / API Service
   │
TMDB API
Firebase
```

---

## 📂 Project Structure

```
MovieApp
│
├── Models
├── Views
├── ViewModels
├── Services
├── Authentication
├── Firebase
├── Resources
└── Utilities
```

---

## 🚀 Key Functionalities

- User Authentication
- Movie Browsing
- Movie Search
- Movie Details
- Cast Details
- Trailer Playback
- Watchlist Management
- Responsive SwiftUI UI
- REST API Integration

---

## 📸 Application Screenshots

### Home Screen

<img width="216" height="492" alt="image" src="https://github.com/user-attachments/assets/67df3b21-5f85-4774-b8e7-969ab5f182d1" />

<img width="199" height="457" alt="image" src="https://github.com/user-attachments/assets/5b0881f4-33e0-43e7-8a0e-d9f9d69ba545" />


---

### Search Movies

<img width="170" height="347" alt="image" src="https://github.com/user-attachments/assets/69787a02-ceec-4aac-96c4-428b0cd5acdb" />


---

### Movie Details

<img width="174" height="343" alt="image" src="https://github.com/user-attachments/assets/7c716b7f-e64e-4d4a-b3bc-8fd1da97038a" />

<img width="142" height="298" alt="image" src="https://github.com/user-attachments/assets/a766e8cb-ebd7-4406-9b37-896fa8eba3db" />

<img width="173" height="369" alt="image" src="https://github.com/user-attachments/assets/5b9fd793-6987-4f7a-af9b-085aed190ab4" />

<img width="191" height="359" alt="image" src="https://github.com/user-attachments/assets/f06258cd-c0b9-4b70-909b-e01610ea025d" />

<img width="176" height="351" alt="image" src="https://github.com/user-attachments/assets/c25903a2-fad5-4f1e-995f-7bf080d91506" />



---

### Cast Details

<img width="166" height="355" alt="image" src="https://github.com/user-attachments/assets/ad393a4c-b4ea-4c27-a404-970409bcf619" />


---

### Watchlist

<img width="201" height="375" alt="image" src="https://github.com/user-attachments/assets/82bc0871-6be6-4eae-8bcd-cfc44e7d6692" />


---

### Profile

<img width="192" height="371" alt="image" src="https://github.com/user-attachments/assets/b335e2eb-af67-4305-831d-aab3a376a953" />



---

## 🔄 Application Workflow

```
User Login
      │
      ▼
Home Screen
      │
      ├───────────────┐
      ▼               ▼
Search Movies     Browse Categories
      │               │
      └──────┬────────┘
             ▼
      Movie Details
             │
      ┌──────┴───────┐
      ▼              ▼
Watch Trailer   Add to Watchlist
      │
      ▼
Cloud Firestore
```

---


## 🎯 Learning Outcomes

Through this project we gained hands-on experience with:

- Swift Programming
- SwiftUI
- MVVM Architecture
- Firebase Authentication
- Cloud Firestore
- REST API Integration
- JSON Parsing
- Async Network Calls
- Git Version Control
- Team Collaboration

---

## 🔮 Future Enhancements

- Offline Movie Caching
- Push Notifications
- Dark Mode
- Movie Reviews
- Ratings
- User Preferences
- AI-based Movie Recommendation
- Multi-language Support

---

## 📦 Setup Instructions

### Prerequisites

- macOS
- Xcode
- Swift
- Firebase Project
- TMDB API Key

### Steps

1. Clone the repository

```bash
git clone https://github.com/ayush-singh4347/MovieApp.git
```

2. Open the project in Xcode

3. Configure Firebase

4. Add your TMDB API Key

5. Run the project

---

## 📖 Project Summary

The Movie Recommendation App demonstrates the implementation of a scalable iOS application using SwiftUI and MVVM architecture. It integrates third-party APIs and Firebase services to deliver a secure, responsive, and user-friendly movie discovery experience. The project emphasizes clean architecture, reusable components, and collaborative software development practices.

---

## ⭐ Acknowledgements

- TMDB API
- Firebase
- Apple SwiftUI
- Encora
- Coforge

---

**Developed during Encora/Coforge iOS Training Program**
