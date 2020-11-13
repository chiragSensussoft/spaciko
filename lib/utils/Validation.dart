class Validation{

  static bool isEmailValid(String value){
    Pattern pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if(!regExp.hasMatch(value)){
      return true;
    }
    else{
      return false;
    }
  }

  static bool isNameEmpty(String name){
    if(name.isEmpty){
      return true;
    }
    else{
      return false;
    }
  }

  static bool isPswValid(String psw){
    if(psw.length <= 8||psw.isEmpty)
      return true;
    else
      return false;
  }
  static bool tAndC(bool tc){
     if(tc==false){
       return true;
     }
     else{
       return false;
     }
  }

}