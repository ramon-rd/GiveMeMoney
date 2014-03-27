library GiveMeMoney;

import 'GastoDiario.dart';
import 'Gasto.dart';
import 'dart:math';

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

  void introducirGastos(List<num> precio, List<String> tipo)
  {
    List<Gasto> nuevo_gasto = new List<Gasto>();
    for(int i = 0; i < precio.length; i++){
      Gasto g_aux = new Gasto(precio.elementAt(i),tipo.elementAt(i));
      g_aux.setGastoCategoria(precio.elementAt(i), tipo.elementAt(i));
      nuevo_gasto.add(g_aux);
      
    }
    // Gasto nuevo_gasto = new Gasto(precio,tipo);
    GastoDiario gasto_aux = new GastoDiario();
    
    for (int i = 0; i < nuevo_gasto.length; i++){
      gasto_aux.aniadirGasto(nuevo_gasto.elementAt(i));
     this.saldo = this.saldo-nuevo_gasto.elementAt(i).valor;
    }
    
    gasto_semanal.add(gasto_aux);
  }
  
  void consultarGastos()
  {  
    List<Gasto> aux = new List<Gasto>();
    aux = gasto_semanal.elementAt(0).getGastosRealizados();
    
    for (int i = 0; i < aux.length; i++){
      print(aux.elementAt(i).getCategoria()+":");
      print(aux.elementAt(i).getGasto());
    }
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
  num desviacionTipicaSemanal ()
  {
    num media = gastoMedioSemanal();
    num aux = 0;
    for (int i = 0; i < gasto_semanal.length; i++){
      aux += (gasto_semanal.elementAt(i).total-media)*(gasto_semanal.elementAt(i).total-media);
    }
    aux = aux/gasto_semanal.length;
    num res = sqrt(aux);
    
    return res;
  }
  void nuevoIngreso (num ingreso)
  {
    this.saldo += ingreso;
  }

}
