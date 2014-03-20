library GiveMeMoney;

import 'GastoDiario.dart';
import 'Gasto.dart';
//import 'package:sqljocky/sqljocky.dart';

//import 'conectaMysql.dart';

//ConnectionPool pool = new ConnectionPool(host: "localhost", port: 3306, user: "root", password: "09l09r88e", db: "givememoney", max:1);

class Usuario
{
  String nombre, apellidos, password, login;
  String DNI;
  num saldo;

  //List<GastoDiario> gasto_diario;
  List<GastoDiario> gasto_semanal;
  List<GastoDiario> gasto_mensual;
  //List<GastoDiario> gasto_anual;
    
  /* Constructors. */
  Usuario(String n, String ap, String dni, String pass, num ingreso)
  {
    this.nombre = n;
    this.apellidos = ap;
    this.DNI = dni;
    this.password = pass;
    this.saldo = 0;
    this.saldo += ingreso;
  //  this.gasto_diario = new List<GastoDiario>();
    this.gasto_semanal = new List<GastoDiario>();
    this.gasto_mensual = new List<GastoDiario>();
  //  this.gasto_anual = new List<GastoDiario> ();
    
  }
  /* Setters / Getters. */
  void setNombre(String nombreEntrada){
    this.nombre = nombreEntrada;
  }
  void setApellidos(String apellidosEntrada){
      this.apellidos = apellidosEntrada;
  }
  void setDNI(String DNIEntrada){
    this.DNI = DNIEntrada;
  }
  void setLogin(String loginEntrada){
      this.login = loginEntrada;
  }  
  void setPassword(String passwordEntrada){
      this.password = passwordEntrada;
  }
  /* Getters. */
  String getNombre(){
      return this.nombre;
  }
  String getApellidos(){
      return this.apellidos;
  }
  String getDNI(){
    return this.DNI;
  }
  String getLogin(){
      return this.login;
  }  
  String getPassword(){
    return this.password;
  }
  /*
  void cerrarGasto(){
    
    if(gasto_diario.elementAt(0).getFecha().hour == 23 && gasto_diario.elementAt(0).getFecha().minute > 59){
      
    }
  }*/
  void introducirGastos(Gasto nuevo_gasto)
  {

  //  Gasto nuevo_gasto = new Gasto(precio,tipo);
    
    GastoDiario gasto_aux = new GastoDiario();
    
    
    gasto_aux.aniadirGasto(nuevo_gasto);
    
    this.saldo = this.saldo-nuevo_gasto.valor;
    print(this.saldo);
    
    gasto_semanal.add(gasto_aux);
  }
  
  void consultarGastos()
  {  
    gasto_semanal.elementAt(1).getGastosRealizados();
  }
  
  num saldoRestante()
  {    
    return this.saldo;
  }
  
  void cambiarPass (String pass_nueva)
  {
    password = pass_nueva;
  }
  
  void mostrarDatos ()
  {
    print(nombre);
    print(apellidos);
  }
  void recordarPassword ()
  {
    print(password);
  }
  void mostrarUsuario(){
    String cadena = this.getNombre() + " " + this.getApellidos();
    print(cadena);
    print(this.getDNI());
    String cadena2 = "Tu nombre de usuario -> " + this.getLogin();
    print(cadena2);
  }
  num gastoMedioSemanal ()
  {
    num media = 0;
    for (int i = 0; i < gasto_semanal.length; i++){
      media += gasto_semanal.elementAt(i).total;
    }
    media /= 7;
    
    return media;
  }
 /* num gastoMedioMensual ()
  {
    
  }*/
  void nuevoIngreso (num ingreso)
  {
    this.saldo += ingreso;
   // ManejaSQL aux = new ManejaSQL(pool);
  //  aux.addData(this.saldo);
  }
 
}
