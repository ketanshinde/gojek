GO-JEK iOS Problem Statement
Acceptance Criteria
Your selection chances are higher if
● You use the latest version of Swift
● You adhere to Apple’s Human Interface Guidelines and coding conventions
● Your app performs well in terms of CPU, memory and energy usage
● Your code is loosely coupled, testable and uses an architecture similar to VIPER,
MVVM, MVP, etc.
● You tastefully customise the UI and add animations etc.
● Your app does not have too many dependencies on third party frameworks
We may reject your application if
● Your project fails to compile or compiles with warnings with the current version of Xcode
● Your app does not layout correctly for all iOS devices that can run the current release of
iOS
● Your app has UI/logical flaws that make it difficult to use
● You do not have UI and unit tests in your application with decent code coverage
● Your UI/unit tests fail
Your Assignment – A Contacts App
As an assignment, you will be creating an app similar to the iOS Contacts app but with a much
smaller feature set. The screens and features are described in the following sections.
Home Screen
This screen lists all available contacts in the app along with their photo. The contacts
are fetched from the backend. Along with the list of contacts, it shows which contacts
are marked favourite.
Contact Detail Screen
Tapping on a contact in the home screen leads you to the Contact Detail screen. This
screen shows the details of the contact such as their phone number, name, image,
email address etc. You can call, message and email a contact from this screen as well
as mark/unmark them as a favourite.
Edit Contact Screen
Tapping on the contact button in the Contact Detail screen leads you to this screen. You
can edit all fields of the contact in this screen including the contact’s photo. Saving the
contact’s information should also save it on the backend.
Add Contact Screen
This screen looks similar to the Edit Contact screen. Tapping on the Add button in the
Home screen leads you to the Add Contact screen. Here you can add a new contact to
the database along with its phone number, email address, photo, etc. All fields of the
new contact are mandatory in this screen.
Backend API
The backend is a RESTful application developed in Rails:
● API base URL : http://gojek-contacts-app.herokuapp.com
● Documentation : http://gojek-contacts-app.herokuapp.com/apipie/1.0/contacts
● Source code : https://github.com/anagri/contacts-server
● Postman Collection:
https://docs.google.com/document/d/1SroU6qiqkTTaON_5N3tl0p29ubrqcODB_LnqoYfM
qRM/edit?usp=sharing
Other Notes
● We expect you to use git and commit frequently
● You should submit your solution to us as a zip archive
● The zip archive should also include your git commit history
● Please use system fonts everywhere. It’s not important to match the font size
with the design, but you can infer the sizes from the designs
Please feel free to reach out to us in case of any queries related to the backend or the
design. Wish you all the best!
Design Guidelines
