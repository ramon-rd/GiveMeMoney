//library GiveMeMoney;

import 'package:sqljocky/sqljocky.dart';
import 'package:sqljocky/utils.dart';

import 'dart:async';
import 'GastoDiario.dart';

class ManejaSQL {
  
  ConnectionPool pool;
  
  ManejaSQL(this.pool);

//Metodos limpios.
//*****************

//Insertar nuevo alumno en BD.

  Future addUsuario(nombre_user, nombre, apellidos, email, password) {
    
    var completer = new Completer();
    
    pool.query('insert into usuario (nombre_user, nombre, apellidos, email, password) values ("$nombre_user", "$nombre", "$apellidos", "$email", "$password")').then((query){
      print("Consulta preparada...");
    });
    
    print("Usuario insertado.");
    return completer.future;
  }
  
//Leer un usuario de la BD.
  
  Future readUsuario(nombre_user) {
    
    var completer = new Completer();
    
    pool.query('select * from usuario where nombre_user = "$nombre_user"').then((query) {
      print("Consulta preparada...");
      query.forEach((row) {
        print("Nombre de usuario: ${row[0]} \nNombre: ${row[1]} \nApellidos: ${row[2]} \nEmail: ${row[3]} \nPassword: ${row[4]}");
      });
    });
    
    print("Usuario consultado.");
    return completer.future;
  }
  
//Establecer saldo de un usuario.
  
  Future setSaldoUsuario(nombre_user, saldo) {
    
    var completer = new Completer();
    
    pool.query('update usuario set saldo = "$saldo" where nombre_user = "$nombre_user"').then((result){
      print("Consulta preparada...");
    });
    
      print("Saldo insertado.");
      return completer.future;
  }
  
//Obtener el saldo de un usuario.
  
  Future getSaldoUsuario(nombre_user) {
    
    var completer = new Completer();
    
    pool.query('select saldo from usuario where nombre_user = "$nombre_user"').then((query) {
      print("Consulta preparada...");
      query.forEach((row){
        print("Saldo: ${row[0]}");
      });
    });
    
    print("Saldo consultado.");
    return completer.future;   
  }
  
//Insertar nuevo ingreso en BD.
  
  Future addIngreso(valor) {
      
      var completer = new Completer();
      
      DateTime fecha_ingreso = new DateTime.now();
      
      pool.query('insert into ingreso (valor, fecha_ingreso) values ("$valor", "$fecha_ingreso")').then((query){
        print("Consulta preparada...");
      });
      
      print("Usuario insertado.");
      return completer.future;
  }
  
//Leer un ingreso de la BD.
  
  Future readIngreso() {
    
    var completer = new Completer();
    
    pool.query('select * from ingreso').then((query){
      print("Consulta preparada...");
      query.forEach((row){
        print("ID: ${row[0]} \nValor: ${row[1]} \nFecha: ${row[2]}");
      });
    });
        
    print("Usuario insertado.");
    return completer.future;
  
  }
  
//Insertar nuevo gasto en BD.
  
  Future addGasto(){
    
    var completer = new Completer(descripcion);
    
    pool.query('insert into gasto (descripcion) values ("$descripcion")')
  }
    
 
}

/*

void main() {

  //Configuración
  
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

  print("running example");
  example.run().then((_) {

   
    print("K THNX BYE!");
    pool.close();
  });
}*/