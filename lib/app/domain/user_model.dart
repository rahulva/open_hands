class UserModel {
  String firsName;
  String lastName;
  String email;
  String password;

  UserModel(this.firsName, this.lastName, this.email, this.password);

  Map toJson() => {
        'firsName': firsName,
        'lastName': lastName,
        'email': email,
        'password': password,
      };

  @override
  String toString() {
    return 'UserModel{firsName: $firsName, lastName: $lastName, email: $email, password: $password}';
  }
}
