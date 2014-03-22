library GiveMeMoney;

import 'Usuario.dart';
import 'Gasto.dart';
/*
class Principal{
  
  List<Usuario> usuarios;
  /* Constructors */
  Principal(){
    this.usuarios = new List<Usuario>();
  }
  
  /* Setters / Getters. */
  /* Setters. */
  void setUsuarios(List<Usuario> listaUsuarios){
    this.usuarios = listaUsuarios;
  }
  /* Getters. */
  List<Usuario> getUsuarios(){
    return this.usuarios;
  }
  /* Class Methods */
  void aniadirUsuario(Usuario user){
    if(this.usuarios.length > 0){
      bool repetido = false;
      for(int i=0; i < this.usuarios.length && repetido; i++){
        if(this.usuarios.elementAt(i).getDNI == user.getDNI){
          repetido = true;
        }
      }
      if(repetido != true){
        this.usuarios.add(user);
      }
    }
    this.usuarios.add(user);
  }
  
}*/

void main(){
    
    DateTime hoy = new DateTime.now();
    
  /*  int dia = hoy.day;
    while (dia == hoy.day)
      print("hola");*/
    Usuario nuevo = new Usuario("Ramón","Rueda","12345678R", "2565985ejri", 50.0);
   
    nuevo.mostrarDatos();
    nuevo.recordarPassword();
    nuevo.cambiarPass("12aa54");
    nuevo.recordarPassword();
    nuevo.setLogin("Ramonchu");
  //  nuevo.mostrarAlumno();
 //   Gasto a(3,"pan");
    List<num> dinero = new List<num>();
    List<String> categoria = new List<String>();
    dinero.add(3);
    categoria.add("Ocio");
    dinero.add(5);
    categoria.add("Viajes");
    nuevo.introducirGastos(dinero,categoria);
 //   nuevo.introducirGastos(5,"Viajes");
    nuevo.consultarGastos();
    num media = nuevo.gastoMedioSemanal();
    print ("La media del gasto semanal en € es: ");
    print (media);
   // num dinero = nuevo.saldoRestante();
    //print (dinero);
  //  print (b);
  }