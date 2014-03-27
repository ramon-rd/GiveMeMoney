import 'package:sqljocky/sqljocky.dart';
import 'package:sqljocky/utils.dart';

import 'dart:async';
import 'GastoDiario.dart';



class ManejaSQL {
  
  ConnectionPool pool;
  
  ManejaSQL(this.pool);
  
  Future run() {
    var completer = new Completer();


    dropTables().then((_) {
      print("dropped tables");
      // then recreate the tables
      return createTables();
    }).then((_) {
      print("created tables");
      // add some data
      return addData();
    }).then((_) {
      // and read it back out

      return readData();
    }).then((_) {
      completer.complete(null);
    });
    return completer.future;
  }


  Future addDataIngreso(valor, fecha) {

      var completer = new Completer();
      pool.prepare("insert into ingreso (valor, fecha_ingreso) values (?, ?)").then((query){
      print("Preparando consulta insertar ingreso...");
      var parameters = [
            [valor, fecha]];
      return query.executeMulti(parameters);
    }).then((results) {
      print("Ejecutar consulta (insertar ingreso)");
      completer.complete(null);
    });
      print("insertado");
      
      return completer.future;
      
    }
  
  
  Future addData(saldo_nuevo,nombre) {
    
    var completer = new Completer();
    pool.query('update usuario set saldo="$saldo_nuevo" where nombre_user="$nombre"').then((query){
    print("Preparando consulta insertar usuario...");
  /*  return query.executeMulti(parameters);
  }).then((results) {
    print("Ejecutar consulta (insertar)");
    completer.complete(null);*/
  });
  /*  print("insertado");
    return completer.future;*/
    return completer.future;
    
  }
   
  Future addDataCategoria(valor, fecha, categoria) {

      var completer = new Completer();
      pool.prepare("insert into $categoria (valor, fecha) values (?, ?)").then((query){
      print("Preparando consulta insertar gasto en categoria...");
      var parameters = [
            [valor, fecha]];
      return query.executeMulti(parameters);
    }).then((results) {
      print("Ejecutar consulta (insertar $categoria)");
      completer.complete(null);
    });
      print("insertado");
      return completer.future;
      
}  
  
  Future readData(nombre) {
    
    var completer = new Completer();
       print("querying");
       return pool.query('select saldo '
           'from usuario u '
           'where u.nombre_user = "$nombre"').then((result) {
           //  print(result.elementAt(4));
             
         return result.forEach((row) {
           print("Saldo: ${row[0]}");
         /*
           if (row[3] == null) {
             print("ID: ${row[0]}, Name: ${row[1]}, Age: ${row[2]}, No Pets");
           } else {
             print("ID: ${row[0]}, Name: ${row[1]}, Age: ${row[2]}, Pet Name: ${row[3]}, Pet Species ${row[4]}");
           }*/
         });
       });
    
  }
}



