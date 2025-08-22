# 🎵 Playem

Playem is a music app that uses the **Audius API** to search and stream tracks. The app allows users to find trending tracks, listen to music, and fetch track metadata via Audius integration.

---

## 🚀 Features

- View **trending tracks**
- Stream music via the **Audius API**
- Simple and stylish UI with **neumorphism** elements
- Easy to set up and customize for different needs

---

## 📦 Installation & Setup

Follow these steps to get the app up and running locally:

### 1. Clone the repository

```bash
git clone https://github.com/LoLoL200/Playem.git
```

### 2. Navigate to the project directory

```bash
cd Playem
```

### 3. Install dependencies

Install the required dependencies using Flutter's package manager:

```bash
flutter pub get
```

### 4. Set up Firebase

You need to set up Firebase for the app to work properly.

**For Android:**

- Download the `google-services.json` file from the Firebase Console  
- Place it into the `android/app/` directory of your project

**For iOS:**

- Download the `GoogleService-Info.plist` file from Firebase  
- Add the file to your project in Xcode

### 5. Run the app

After everything is set up, you can run the app on a device or emulator:

```bash
flutter run
```

---

## 💻 Project Structure

```
Playem/
├── lib/
│   ├── main.dart
│   ├── utils/
│   └── models/
├── assets/
├── android/
├── ios/
└── README.md
```

---

## 🔧 Dependencies

- **Flutter** — Core framework for building cross-platform apps  
- **Firebase** — Authentication and database functionality  
- **Audius API** — Fetching track data and streams  
- **flutter_dotenv** — Secure storage for confidential data like API keys

---

## 🔒 Security

Use a `.env` file to store sensitive information (API keys, tokens, etc.):

1. Create a `.env` file in the root of the project  
2. Add your keys:

```
API_KEY=your_api_key
API_SECRET=your_api_secret
```

3. Add `.env` to your `.gitignore` to prevent it from being committed

---

## 📜 License

This project is open-source and licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
