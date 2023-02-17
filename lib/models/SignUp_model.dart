class SignUp{
  String name;
  String email;
  String password;
  String phone;
  SignUp({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
});
  Map<String ,dynamic> toJson(){
    final Map<String,dynamic> data = <String,dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}