//library GiveMeMoney;

import 'Usuario.dart';
import 'Gasto.dart';
import 'conectaMysql.dart';


import 'package:sqljocky/sqljocky.dart';
import 'package:sqljocky/utils.dart';
//import 'package:polymer/polymer.dart';
//import 'dart:async';
/*
class FormularioUsuario extends PolymerElement{
  
  @observable String name;
  
  @observable String apellidos;
  @observable String usuario;
  @observable String correo;
  
  FormularioUsuario.created() : super.created(); 
  
 
}

@observable Map datos = toObservable ({
  'nombre': "rew"

});*/


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

//@observable String nombreU;

void main(){
    String user = "root";
    String password = "09l09r88e";
    int port = 3306;
    String db = "givememoney";
    String host = "localhost";
    print("Configuración aceptada");
        
//ConnectionPool pool = new ConnectionPool(host: "localhost", port: 3306, user: "root", password: "09l09r88e", db: "givememoney", max:1);

    print("opening connection");
    var pool = new ConnectionPool(host: host, port: port, user: user, password: password, db: db, max:1);
    print("connection open");

    
    var example = new ManejaSQL(pool);
    /*print("running example");
    example.run().then((_) {

     
      print("K THNX BYE!");
      pool.close();
    });*/
  
  
    Usuario nuevo = new Usuario("Ramón","Rueda","12345678R", "2565985ejri", 50.0);
   
    nuevo.mostrarDatos();
    nuevo.recordarPassword();
    nuevo.cambiarPass("12aa54");
    nuevo.recordarPassword();
    nuevo.setLogin("Ramonchu");
  //  nuevo.mostrarAlumno();
 //   Gasto a(3,"pan");
    Gasto nuevo_gasto = new Gasto(40,"Viajes");
    nuevo.introducirGastos(nuevo_gasto);
    //nuevo.introducirGastos(5,"Viajes");
    //nuevo.consultarGastos();
    nuevo.nuevoIngreso(30);
    num dinero = nuevo.saldoRestante();
   // example.addData(dinero);
    //example.addGastoDeterminado(nuevo_gasto);
    //example.readData();
    
    DateTime dia = new DateTime.now();
    //String cadena = dia.year.toString() + "-" + dia.month.toString() + "-" + dia.day.toString();

    //addDataIngreso()
    example.addDataIngreso(222223, dia);
    
    //addDataCategoria()
  //  example.addDataCategoria(222, dia, "ocio");
    
    print("K THNX BYE!");
    pool.close();
  }