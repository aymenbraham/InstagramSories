# InstagramStories

## Overview
This project is a Swift-based app for viewing Instagram-style stories, with the ability to like stories, view them, and navigate between different users' stories.

## Features
- Horizontal scrolling list of users with their associated stories
- Tap on a user to view their story in full-screen
- Ability to like a story, which is saved across app sessions
- Swipe left and right to navigate between users' stories
- Stories are dynamically loaded via a remote API and are updated when a new user is selected

## Architecture
### MVVM Pattern
The app follows the **MVVM** (Model-View-ViewModel) design pattern to separate concerns and enhance maintainability:

- **Model**: The `User` and `Story` models represent the user and story data structures respectively. The `StoryViewModel` class fetches data from the server and processes the logic related to users and their stories.
  
- **View**: The UI components are designed in SwiftUI. The `StoryListView` and `StoryView` handle the display and interaction of stories. The `StoryItemView` displays individual user story items.

- **ViewModel**: The `StoryViewModel` is responsible for managing the list of users, fetching data, and handling business logic related to marking stories as seen and liked. It interacts with the backend API to load and update user data.

### Data Flow
- The data is fetched from a remote API endpoint (JSON) containing users and their associated stories.
- The list of users is loaded at the beginning, and stories are dynamically updated as users navigate through them.
- Users can like a story, and the state is saved using `UserDefaults`.

## Architectural Decisions
  
- **State Management**: The app uses `@StateObject` and `@Binding` properties to manage the state of the UI and user interactions in SwiftUI. The `StoryViewModel` is the central place for managing data and logic.

- **User Preferences**: User interactions such as liking a story are saved using `UserDefaults`. This allows the state to persist between app sessions.

## Setup and Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/aymenbraham/InstagramSories.git
