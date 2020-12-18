class User{
  final int id;
  final String fName;
  final String lName;
  final String email;
  final String password;
  final String isLoginWith;

  static final column = ['id','fName','lName','email','password','isLoginWith'];

  User(this.id, this.fName, this.lName, this.email, this.password,
      this.isLoginWith);

  factory User.fromMap(Map<String, dynamic> data){
    return User(data['id'], data['fName'], data['lName'], data['email'], data['password'], data['isLoginWith']);
  }

  Map<String,dynamic> toMap() =>{
    "id" : id,
    "fName" : fName,
    'lName' : lName,
    'email' : email,
    "password" : password,
    'isLoginWith' : isLoginWith
  };

}