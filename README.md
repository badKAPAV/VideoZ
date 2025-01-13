# VideoZ
A short video uploading social media platform made using Flutter and Firebase. For advanced state management, GetX has been used. A clean look with clear user friendly controls and familiarity with modern social media apps.

## Features
### Short Video
- Watching Videos: The home screen of the app shows videos to the user and the user can swipe to watch the next video.
- Interaction with the Video: Users can like, comment on the video, reply to other people and see who posted the video.
- Video Uploading: Users can upload any video they want to the cloud and have it appear in the home screen.
- Search for Users: Users can search for other users using the search user feature and have a look at their profile.
- Interaction with users: Users can view their own profile, number of posts they've done and the number of other users that they follow and the users that follow them.

### State Management
- GetX: GetX has been used for state management in this application due to the ease of handling of state for large projects like this.
- Library: GetX also provides a huge library of custom made widgets for the users to use in their projects.

### UI/UX
- Industry Standard: This app uses an industry standard easy to use UI for the people to be pretty familiar with the app keeping clean design in mind.

## Project Structure

'''
lib/
│
├── controllers/                                # Contains workflow controllers
│   ├── auth_controller.dart              # Controls auth functions
│   ├── comment_controller.dart      # Controls commenting functions
│   ├── profile_controller.dart           # Controls profile functions
│   ├── search_controller.dart           # Controls searching functions
│   ├── video_upload_controller.dart      # Controls video uploading functions
│   └── video_controller.dart            # Controls video playing functions
│
├── models/                                     # Contains data models
│   ├── comment.dart                       # Comment database model
│   ├── user.dart                               # User data model
│   └── video.dart                             # Video data model
│
├── views/                                        # Contains the UI pages/screens
│   ├── screens/   
│        ├── auth/                               # Contains the auth pages/screens
│             ├── login_screen.dart
│             ├── signup_screen.dart
│        ├── add_video_screen.dart
│        ├── comment_screen.dart
│        ├── confirm_screen.dart
│        ├── home_screen.dart
│        ├── message_screen.dart
│        ├── profile_screen.dart
│        ├── profile_video_screen.dart
│        ├── search_screen.dart
│        ├── video_screen.dart
│   ├── widgets/                               # Contains additional UI elements
│        ├── circle_animation.dart
│        ├── custom_icon.dart
│        ├── showSnackbar.dart
│        ├── text_input_field.dart
│        ├── video_player_item.dart
│
├── constants.dart                           # Contains every constants used
└── main.dart                                  # Entry point of the application
'''
