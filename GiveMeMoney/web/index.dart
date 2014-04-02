import 'dart:html';
//import 'dart:convert';
//import 'dart:js';
/*
formulario(FormElement form){
  
  var dato = {};
  
  form.querySelectorAll('input,select').forEach((Element element){
    if (element is InputElement)
      dato[element.name] = element.value; 
  });
  
  return dato;
}
*/
void main(){
  InputElement usuario, password;
  
  //FormElement form = querySelector('#login');
  ButtonElement button = querySelector('#entrar');
  ButtonElement buttonReg = querySelector('#registrar');
  
  usuario = querySelector('#usuario');
  password = querySelector('#password');
  /*
  buttonReg.onClick.listen((e){
    window.location.assign("Registro.html");
  });*/

  button.onClick.listen((e){
    //Con "usuario.value" recojo el valor que introduces en el formulario y solo queda llamar a la función que mira en la 
    //base de datos si el usurio es correcto y dejar pasar a la página principal del proyecto
    print(usuario.value);
    print(password.value);
    window.alert("Bienvenido a GiveMeMoney");
    window.location.assign('givememoney.html');
    /*var entrada = new HttpRequest();
    
    entrada.onReadyStateChange.listen((ProgressEvent e){
      if(entrada.readyState == 4){
        if(entrada.status==201){
          var micontenido = entrada.response;
          micontenido = JSON.decode(micontenido);
         
          if(micontenido["contrasenia"]==true){
            window.alert("Bienvenido a GiveMeMoney");
            window.location.assign('givememoney.html');
          }else{
              window.alert("[ERROR] - Inténtelo de nuevo.");
              window.location.assign('index.html');
          }
        }
      }
    });
    
    entrada.open('POST', form.action);
    entrada.send(JSON.encode(formulario(form)));*/
  });
}