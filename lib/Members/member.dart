// ***************************************************************************
// The Member class abstracts the information associated with the FitHome Member.
// It includes:
// - email (local values are get / set in SharedPreferences.  Authentication occurs in FireBase)
// - password (get / set in SharedPreferences)
// - verification (i.e.: sign in to Firebase Auth)
// - checking if the person is already authenticated (i.e.: FirebaseAuth.instance.currentUser())
// ***************************************************************************
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';

class Member {
  static const emailKey =
      'email'; // The key to get the email from SharedPreferences.
  static const passwordKey = 'password'; // The key to get the password.
  String explanatoryText = '';
  Logger log = Logger('member.dart');
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //**************************************************************************
  // email property
  //**************************************************************************
  // email property get.
  // Returns a string (Could be empty).
  get email async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check to see if the key exists.  If not, return an empty string.
    if (prefs.containsKey(emailKey)) {
      return prefs.getString(emailKey);
    }
    log.info('got email from local store: $email');
    return '';
  }

  set email(String emailString) {
    _setEmail(emailString);
  }

  Future<void> _setEmail(String emailString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(emailKey, emailString);
  }
  //**************************************************************************
  // password property
  //**************************************************************************

  // password property get.
  // Returns a string (Could be empty).
  get password async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(passwordKey)) {
      return prefs.getString(passwordKey);
    }
    log.info('got password from local store: $password');
    return '';
  }

  set password(String pwd) {
    _setPassword(pwd);
  }

  Future<void> _setPassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(passwordKey, password);
  }

  //**************************************************************************
  // check if the email and password are stored in Shared Preferences.
  //**************************************************************************
  Future<bool> isCredsInLocalStore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(passwordKey) && prefs.containsKey(emailKey)) {
      return true;
    }
    return false;
  }

// ********************************************************
// use the email and password to sign into Firebase.
// If this is the first time the person is launching FitHome, they
// will be directed to a "Verify Membership" page where they
// Enter ther email and password.  We sign them in or try to
// fail gracefully.
// ********************************************************
  Future<String> signIn() async {
    // TEST TEST TEST TEST TEST TEST TEST TEST TEST
    // TEST - CLEAR OUT LOCAL STORE, no longer have email and password
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.clear();
    String _email = await email;
    String _password = await password;
    log.info('email: $_email, password: $_password');
    // Check to see if there is a password and email locally stored.
    bool credsInLocalStore = await isCredsInLocalStore();
    if (credsInLocalStore != true) {
      log.info('email and password are not in the local store');
      explanatoryText = 'Please enter an email and password.';
      return null;
    }

    try {
      // Try to sign in the Member.
      FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
          email: _email, password: _password);
      log.info('Signed in: ${user.uid}');
      return user.uid;
    } catch (e) {
      // Couldn't verify the user
      explanatoryText = e.message + ' Error code: ' + e.code;
      log.info('sign in failed. message:' + explanatoryText);
      // If the error was something like "wrong password"...we'll need to show the "Verify Member" page and ask
      // for them to re-enter the email and password.  However, if the error is because the email/password does not
      // have an account, we will go on and create the account.
      if (e.code != 'ERROR_USER_NOT_FOUND') {
        return null;
      }
      // Create the Member entry in the auth db if the error was because there was no account with the email and
      // password.
      try {
        FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        log.info("Created user: ${user.uid}");
      } catch (e) {
        // Member couldn't be created even though the previous error told us there was no account for the email and password..
        // At this point, it is not obvious to us what failed.  The caller can use the errorMessage and errorCode
        // to figure out what is up.

        explanatoryText = e.message + ' Error code: ' + e.code;
        log.info('create user failed. message:' + explanatoryText);
        return null;
      }
      // Successfully created the Member, so sign in.
      FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
          email: _email, password: _password);
      log.info('Signed in: ${user.uid}');
      return user.uid;
    }
  }

  // We'll check first to see if the person is already authenticated.
  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    log.info('Check on current user: $user');
    String returnString = user == null ? null : user.uid;
    return returnString;
  }
}
