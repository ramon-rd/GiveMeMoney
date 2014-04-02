//import 'package:sqljocky/sqljocky.dart';
//import 'package:sqljocky/utils.dart';
import 'dart:async';
import 'GastoDiario.dart';
import 'dart:io';
import 'dart:convert';



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
/*
const String webHost = "127.0.0.1";
const int webPuerto = 6666;
var contenidos;

void main() {
  
  HttpServer.bind(webHost, webPuerto).then((server){
    server.listen((HttpRequest request){
     request.listen((List<int> buffer){
       var jsonString = new String.fromCharCodes(buffer);
       Map data = JSON.decode(jsonString);
       print(data[0]);
       print(data[1]);
       switch(request.uri.path){
         case "/login":
           //registro en bd
           //contenidos = login(data);
           contenidos = JSON.encode(contenidos);
           data = {};
           break;
         
         default:
           print("default");
           break;
       }
     });
     Responde(request);
    });
  });
  
}

void Responde(HttpRequest request){
  if (contenidos != null){
    request.response
      ..headers.add('Acces-Control-Allow-Origin', '*')
      ..headers.add('Content-Type','application/x-www-form-urlencoded')
      ..headers.add('Acept')
      ..statusCode = 201
      ..write(contenidos)
      ..close();
  }else{
    request.response
          ..headers.add('Acces-Control-Allow-Origin', '*')
          ..headers.add('Content-Type','text/plain')
          ..statusCode = 500
          ..write("Error")
          ..close();
  } 
}
*/


