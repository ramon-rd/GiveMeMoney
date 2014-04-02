library GiveMeMoney;

import 'Usuario.dart';
import 'Gasto.dart';
import 'conectaMysql.dart';

//import 'package:sqljocky/sqljocky.dart';
//import 'package:sqljocky/utils.dart';


void main(){
  
      String user = "root";
      String password = "10071992r";
      int port = 3306;
      String db = "givememoney";
      String host = "localhost";
      print("Configuración aceptada");

      print("opening connection");
      var pool = new ConnectionPool(host: host, port: port, user: user, password: password, db: db, max:1);
      print("connection open");

      
      var example = new ManejaSQL(pool);
  
  
    
    DateTime hoy = new DateTime.now();
    
    Usuario nuevo = new Usuario("Ramón","Rueda","12345678R", "2565985ejri", 50.0);
   
    nuevo.mostrarDatos();
    nuevo.recordarPassword();
    nuevo.cambiarPass("12aa54");
    nuevo.recordarPassword();
    nuevo.setLogin("Luisre");
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
    num desviacion = nuevo.desviacionTipicaSemanal();
    print ("La desviación típica es: ");
    print (desviacion);
   // num dinero = nuevo.saldoRestante();
    //print (dinero);
  //  print (b);
    String nombre = nuevo.getLogin();
    print(nombre);
    //example.addDataIngreso(3, hoy);
    example.addData(150,nombre);
    example.readData(nombre);
 
    
  }