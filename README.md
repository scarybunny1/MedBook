# MedBook
An iOS app -MedBook which includes Landing, User registration, Login flow along with the Home - Logout mechanism.

Steps to follow:
1. Clone the project
2. Open in Xcode
3. Build and Run

Note:
1. Country list data is fetched from the network when Internet is available. Otherwise, it is fetched from the json file.
2. App is supported for both Light and Dark themes.
3. Running on simulator might have a few issues. For example: On login screen, the login button's state will not be updated from Disabled to Enabled. That's because on textfield's didEndEditing method, I'm deciding if the button will be enabled or not. Will have to look into it later to improve handling.
