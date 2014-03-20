//library GiveMeMoney;

import 'package:sqljocky/sqljocky.dart';
import 'package:sqljocky/utils.dart';

import 'dart:async';
import 'GastoDiario.dart';

class ManejaSQL {
  
  ConnectionPool pool;
  
  ManejaSQL(this.pool);
  
  Future run() {
    var completer = new Completer();
    
    addData(num).then((_) {
      return readData();
    }).then((_) {
      completer.complete(null);
    });
    return completer.future;
  }

  Future dropTables() {
    print("dropping tables");
    var dropper = new TableDropper(pool, ['pets', 'people']);
    return dropper.dropTables();
  }
  
  
 
  Future createTables() {
    print("creating tables");
    var querier = new QueryRunner(pool, ['create table people (id integer not null auto_increment, '
                                        'name varchar(255), '
                                        'age integer, '
                                        'primary key (id))',
                                        
                                        'create table pets (id integer not null auto_increment, '
                                        'name varchar(255), '
                                        'species text, '
                                        'owner_id integer, '
                                        'primary key (id),'
                                        'foreign key (owner_id) references people (id))'
                                        ]);
    print("executing queries");
    return querier.executeQueries();
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
  
  
  Future addData(saldo_nuevo) {
    
    var completer = new Completer();
    pool.prepare("insert into usuario (saldo) values (?)").then((query){
    print("Preparando consulta insertar usuario...");
    var parameters = [
          [saldo_nuevo]];
    return query.executeMulti(parameters);
  }).then((results) {
    print("Ejecutar consulta (insertar)");
    completer.complete(null);
  });
    print("insertado");
    return completer.future;
    
  }
  
  //para introducir un gasto en una categoría determinada
  /*Future addGastoDeterminado(gasto) {
    
    var completer = new Completer();
    
    if(gasto.getCategoria() == 'Ocio'){
      pool.prepare("insert into ocio (valor) values (?)").then((query){
        print("Preparando consulta insertar usuario...");
            var parameters = [
                  [gasto.getGasto()]];
            return query.executeMulti(parameters);
          }).then((results) {
            print("Ejecutar consulta (insertar)");
            completer.complete(null);
          });
            print("insertado");
            return completer.future;
    }
    
    if(gasto.getCategoria() == 'Viajes'){
          pool.prepare("insert into viajes (valor) values (?)").then((query){
            print("Preparando consulta insertar usuario...");
                var parameters = [
                      [gasto.getGasto()]];
                return query.executeMulti(parameters);
              }).then((results) {
                print("Ejecutar consulta (insertar)");
                completer.complete(null);
              });
                print("insertado");
                return completer.future;
        } 
}*/
  
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
  
  Future readData() {
    var completer = new Completer();
    print ("querying");
    return pool.query('select * from usuario').then((result) {
          print("Resultados: ");
          return result.forEach((row) {
            String aux = row[0];
            print(aux);
            //nuevoIngreso(row[1]);
            print("nombre_user: ${row[0]}");
            return aux;
          });
        });
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
