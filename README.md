# 🌿 Organibot – OrganiGPT AI Bot

<p align="center">
  <img src="https://i.postimg.cc/Jh7PRjJ2/organi.png" alt="Organibot Preview" width="400"/>
</p>

[![Flutter](https://img.shields.io/badge/Flutter-3.8.1-blue?logo=flutter&logoColor=white)](https://flutter.dev)  
[![Dart](https://img.shields.io/badge/Dart-3.0-blue?logo=dart&logoColor=white)](https://dart.dev)  
[![Version](https://img.shields.io/badge/version-1.0.0+-green)]()  
[![License](https://img.shields.io/badge/license-Unpublished-lightgrey)]()  

**Organibot** is an AI-powered chatbot designed for **learning and collaborating in organic chemistry**. Using Gemini AI, it provides interactive learning, explanations, and problem-solving support for students and enthusiasts.  

---

## 🌟 Features

- AI-driven answers for organic chemistry questions  
- Collaborative learning with real-time AI responses  
- Text animations for engaging user experience  
- Multi-language support and internationalization  
- Easy configuration with `.env`  
- Flutter-powered for cross-platform deployment  

---

## 🛠 Tech Stack

- **Flutter SDK:** ^3.8.1  
- **Dart:** ^3.0  
- **State Management:** Riverpod  
- **Networking:** Dio  
- **Environment Variables:** flutter_dotenv  
- **Animations:** animated_text_kit  


---

## 🖼 Screenshots

<p align="center">
  <table>
    <tr>
      <td><img src="screenshot/1.png" alt="Screenshot 1" width="200"/></td>
      <td><img src="screenshot/2.png" alt="Screenshot 2" width="200"/></td>
      <td><img src="screenshot/3.png" alt="Screenshot 3" width="200"/></td>
    </tr>
    <tr>
      <td><img src="screenshot/4.png" alt="Screenshot 4" width="200"/></td>
      <td><img src="screenshot/5.png" alt="Screenshot 5" width="200"/></td>
      <td><img src="screenshot/6.png" alt="Screenshot 6" width="200"/></td>
    </tr>
  </table>
</p>

---

## ⚡ Getting Started

1. **Clone the repository**

```bash
git clone <your-repo-url>
cd organibot
````

2. **Install dependencies**

```bash
flutter pub get
```

3. **Configure environment variables**

Create a `.env` file in the root folder and add your Gemini AI API key:

```env
GEMINI_API_KEY=your_gemini_api_key_here
```

4. **Run the app**

```bash
flutter run
```

---

## 🔗 Gemini AI Integration

Organibot uses **Gemini AI** for processing organic chemistry queries:

1. Sign up for Gemini AI and get an API key
2. Store your API key in `.env` as `GEMINI_API_KEY`
3. The app uses `dio` for HTTP requests to Gemini endpoints
4. Responses are parsed and displayed dynamically in the chat interface

---

## 💻 Development

Organibot is open for collaboration. To contribute:

* Fork the repository
* Create a new feature branch
* Make your changes
* Submit a pull request

---





