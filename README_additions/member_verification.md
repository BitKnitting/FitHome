[Back to Readme](../README.md)
# Thanks to Those that went Before  
* The member verification code relies heavily on the info Andrea Bizotto gives in his YouTube videos on building in Firebase authentication into a Flutter app.  I find Adrea's method and explanation to be very clear and easy to follow.  THANK YOU.
# Description 
A person using FitHome must be a Member.  Member accounts are held in Firebase Auth.  When a person launches FitHome, the app verifies the person is a Member.  If the app has enough info without prompting the person, the app shows the person the Dashboard.  If the app can't verify Membership, it shows UI to get an email and password from the person.  If the app has an email and password but the account does not exist within Firebase, the account will be created.
## Challenge
Note the app __must__ verify the person in Firebase.  This means the device __must__ be connected to the internet.  Given that what the Member is doing is monitoring their energy, perhaps they should not need to have constant internet connection.  For now, it simplifies the coding.
# Design Pattern
The design follows:  
* [Andreas Bizotto's recommendation for a root page (for routing)](https://youtu.be/Pl1rKBnmDkU).  
* [Andreas Bizotto's advice on state management using an inherited widget](https://youtu.be/Pl1rKBnmDkU)