import 'package:sqljocky/sqljocky.dart';
import 'package:sqljocky/utils.dart';

import 'dart:async';



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



void main() {

  //Configuración
  
      String user = "pepe";
      String password = "1234";
      int port = 3306;
      String db = "test";
      String host = "localhost";
      print("hola");
      
  //

  print("opening connection");
  var pool = new ConnectionPool(host: host, port: port, user: user, password: password, db: db, max:1);
  print("connection open");

  
  var example = new ManejaSQL(pool);

  print("running example");
 example.run().then((_) {

   
    print("K THNX BYE!");
    pool.close();
  });
}
