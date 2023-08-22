class UserData {
  String firstName;
  String lastName;
  String email;
  String password;

  UserData(this.firstName, this.lastName, this.email, this.password);

  Map toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      };

  @override
  String toString() {
    return 'UserData{firstName: $firstName, lastName: $lastName, email: $email, password: $password}';
  }
}
