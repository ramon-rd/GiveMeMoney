<<<<<<< HEAD
//library GiveMeMoney;

=======
>>>>>>> e8cbe91b18ee45f44fc41b65fc9ef8033948e4ff
import 'package:sqljocky/sqljocky.dart';
import 'package:sqljocky/utils.dart';

import 'dart:async';
<<<<<<< HEAD
import 'GastoDiario.dart';
=======


>>>>>>> e8cbe91b18ee45f44fc41b65fc9ef8033948e4ff

class ManejaSQL {
  
  ConnectionPool pool;
  
  ManejaSQL(this.pool);
  
  Future run() {
    var completer = new Completer();
<<<<<<< HEAD
    
    addData(num).then((_) {
=======

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
>>>>>>> e8cbe91b18ee45f44fc41b65fc9ef8033948e4ff
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
  
<<<<<<< HEAD
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
=======
  Future addData() {
    var completer = new Completer();
    pool.prepare("insert into people (name, age) values (?, ?)").then((query) {
      print("prepared query 1");
      var parameters = [
          ["Dave", 15],
          ["John", 16],
          ["Mavis", 93]
        ];
      return query.executeMulti(parameters);
    }).then((results) {
      print("executed query 1");
      return pool.prepare("insert into pets (name, species, owner_id) values (?, ?, ?)");
    }).then((query) {
      print("prepared query 2");
      var parameters = [
          ["Rover", "Dog", 1],
          ["Daisy", "Cow", 2],
          ["Spot", "Dog",  2]];
//          ["Spot", "D\u0000og", 2]];
      return query.executeMulti(parameters);
    }).then((results) {
      print("executed query 2");
      completer.complete(null);
    });
    return completer.future;
  }
  
  Future readData() {
    var completer = new Completer();
    print("querying");
    return pool.query('select p.id, p.name, p.age, t.name, t.species '
        'from people p '
        'left join pets t on t.owner_id = p.id').then((result) {
      print("got results");
      return result.forEach((row) {
        if (row[3] == null) {
          print("ID: ${row[0]}, Name: ${row[1]}, Age: ${row[2]}, No Pets");
        } else {
          print("ID: ${row[0]}, Name: ${row[1]}, Age: ${row[2]}, Pet Name: ${row[3]}, Pet Species ${row[4]}");
        }
      });
    });
  }
}


>>>>>>> e8cbe91b18ee45f44fc41b65fc9ef8033948e4ff

void main() {

  //Configuración
  
<<<<<<< HEAD
      String user = "root";
      String password = "09l09r88e";
      int port = 3306;
      String db = "givememoney";
      String host = "localhost";
      print("Configuración aceptada");
      
//ConnectionPool pool = new ConnectionPool(host: "localhost", port: 3306, user: "root", password: "09l09r88e", db: "givememoney", max:1);
=======
      String user = "pepe";
      String password = "1234";
      int port = 3306;
      String db = "test";
      String host = "localhost";
      print("hola");
      
  //
>>>>>>> e8cbe91b18ee45f44fc41b65fc9ef8033948e4ff

  print("opening connection");
  var pool = new ConnectionPool(host: host, port: port, user: user, password: password, db: db, max:1);
  print("connection open");

  
  var example = new ManejaSQL(pool);

  print("running example");
<<<<<<< HEAD
  example.run().then((_) {
=======
 example.run().then((_) {
>>>>>>> e8cbe91b18ee45f44fc41b65fc9ef8033948e4ff

   
    print("K THNX BYE!");
    pool.close();
  });
<<<<<<< HEAD
}*/
=======
}
>>>>>>> e8cbe91b18ee45f44fc41b65fc9ef8033948e4ff
