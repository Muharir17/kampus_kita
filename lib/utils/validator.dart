class Validator{

  String validateName(String value){
    String pattern = r'(^[a-zA-Z]*$)';
    RegExp regExp = new RegExp(pattern);

    if(value.length == 0){
      return "Nama Wajib Di Isi";
    }else if(!regExp.hasMatch(value)) {
      return "Nama Harus a-z dan A-Z";
    }
    return null;
  }

  String validateMobile(String value){
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);

    if(value.length == 0){
      return "Telepon Wajib Di Isi";
    }else if(value.length != 12){
      return "Telepon Harus 12 Digit";
    }else if(!regExp.hasMatch(value)) {
      return "Telepon Harus Angka";
    }
    return null;
  }

  String validatePasswordLength(String value){
    if(value.length == 0){
      return "Password Tidak Boleh Kosong";
    }else if(value.length < 3) {
      return "Tidak Boleh Kurang Dari 3 Karakter";
    }
    return null;
  }

  String validateEmail(String value){
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(pattern);
    if(value.length == 0){
      return "Email Harus Di isi";
    }else if(!regExp.hasMatch(value)){
      return "Email Tidak valid";
    }else{
      return null;
    }
  }


}