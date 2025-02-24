import 'package:ms_maintain/API/classes.dart';

class CurrentUser {
  static User? loggedInUser;
  static Client? loggedInClient; // New property for client

  // Method for User
  static void setLoggedInUser(User user) {
    loggedInUser = user;
  }

  static User? getLoggedInUser() {
    return loggedInUser;
  }

  // Method for Client
  static void setLoggedInClient(Client client) {
    loggedInClient = client;
  }

  static Client? getLoggedInClient() {
    return loggedInClient;
  }

  // Method for both User and Client (if needed)
  void loginUser(User user) {
    setLoggedInUser(user);
  }

  void loginClient(Client client) {
    setLoggedInClient(client);
  }
}
