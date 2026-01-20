# ELLA - Efficient Lifting. Logged Right.

A **clean, local-first iOS fitness tracking app** built for personal use.

PersonalLift is designed around a simple philosophy:
**programs are plans — workouts are reality.**

The app allows full flexibility during workouts while preserving long-term program structure and rich training context.

---

## ✨ Core Features

### 🏋️ Workout Tracking

* Start workouts from a planned program day or empty
* Fully editable sets during workouts

  * Add / remove sets
  * Adjust reps & weight with + / − controls
  * Mark warmup & completed sets
* Add or remove exercises mid-workout
* Replace movements without breaking the program

---

### 📅 Program Planning

* Create reusable training programs
* Organize by days (Push / Pull / Legs, Upper / Lower, etc.)
* Planned sets act as **placeholders**, not restrictions
* Programs are never modified during workouts

---

### 🧠 Context-Aware Logging

* Track *why* a workout or exercise was changed

  * Quick-pick reasons (fatigue, equipment busy, pain, etc.)
  * Optional custom notes
* Optional post-workout reflection
* Per-set notes for pain, technique, or performance
* Notes resurface automatically when repeating workouts or exercises

---

### 📊 Body Metrics

* Height tracking
* Bodyweight logging over time
* Optional notes per weigh-in

---

### 🎯 Strength Progress (Planned)

* Estimated 1RM calculations
* Comparison against age-based lifting standards
* Avatar-style visual progress indicators

---

## 🛠 Tech Stack

* **Language**: Swift
* **UI**: SwiftUI
* **Persistence**: SwiftData (local-only)
* **Architecture**: MV-style with SwiftData models
* **Platform**: iOS (iPhone-first)

---

## 📱 Target Device

* Built and tested on **iPhone 16 Pro Max**
* Deployment target: **iOS 18+**
* Designed for large-screen clarity and one-handed use

---

## 🚫 Non-Goals

* No accounts
* No cloud sync (for now)
* No social features
* No ads
* No analytics tracking

This app is intentionally personal, fast, and distraction-free.

---

## 🧩 Project Structure

```
PersonalLift
├── App
├── Models
├── Views
│   ├── Workout
│   ├── Programs
│   ├── Exercises
│   └── Body
├── Services
├── Resources
└── Utilities
```

---

## 🚀 Status

Early development (v1).

This project is actively evolving and optimized for real-world training workflows rather than generic fitness tracking.

---

## 📄 License

Private / personal use only.
