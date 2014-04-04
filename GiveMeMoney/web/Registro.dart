import 'dart:html';

void main(){
  
  //Elementos de entrada de usuario.
  InputElement nombre, apellidos, fecha, dni, correo, telefono, password, password2;
  
  
  //FormElement form = querySelector('#login');
  ButtonElement buttonSend = querySelector('#enviar');
  //ButtonElement buttonClear = querySelector('#boton2');
  
  nombre = querySelector('#nombre');
  apellidos = querySelector('#apellidos');
  fecha = querySelector('#fecha');
  dni = querySelector('#dni');
  correo = querySelector('#correo');
  telefono = querySelector('#telefono');
  password = querySelector('#password');
  password2 = querySelector('#password');

  
  /*
  buttonReg.onClick.listen((e){
    window.location.assign("Registro.html");
  });*/

  buttonSend.onClick.listen((e){
    //Con "usuario.value" recojo el valor que introduces en el formulario y solo queda llamar a la función que mira en la 
    //base de datos si el usurio es correcto y dejar pasar a la página principal del proyecto
    print(nombre.value);
    print(apellidos.value);
    print(fecha.value);
    print(dni.value);
    print(correo.value);
    print(telefono.value);
    print(password.value);
    //window.alert("Bienvenido a GiveMeMoney");
    //window.location.assign('Registro.html');
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