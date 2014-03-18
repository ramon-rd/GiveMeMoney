library GiveMeMoney;

import 'GastoDiario.dart';

class Usuario
{
  String nombre, apellidos, password, login;
  String DNI;
  double saldo;

  List<GastoDiario> gasto_diario;
  List<GastoDiario> gasto_semanal;
  List<GastoDiario> gasto_mensual;
  List<GastoDiario> gasto_anual;
    
  /* Constructors. */
  Usuario(String n, String ap, String dni, String pass, double money)
  {
    this.nombre = n;
    this.apellidos = ap;
    this.DNI = dni;
    this.password = pass;
    this.saldo = money;
    this.gasto_diario = new List<GastoDiario>();
    this.gasto_semanal = new List<GastoDiario>();
    this.gasto_mensual = new List<GastoDiario>();
    this.gasto_anual = new List<GastoDiario> ();
    
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
  
  void cerrarGasto(){
    
    if(gasto_diario.elementAt(0).getFecha().hour == 23 && gasto_diario.elementAt(0).getFecha().minute > 59){
      
    }
  }
  void introducirGastos(List<Gasto> nuevo_gasto)
  {
    for (int i = 0; i < nuevo_gasto.length;i++)
    {
      
    }
  }
  /*
  double consultarGastos()
  {
    double total = 0;
    for (int i = 0; i < gasto_diario.length; i++){
      /* Hacer método para dar el gasto total de un día */ 
      total += gasto_diario.elementAt(i).getGastosRealizados();
    }
    return total;
  }*/
  /*
  double saldoRestante()
  {
    double total = consultarGastos();
    double res = saldo-total;
    
    return res;
  }
  */
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
  void mostrarAlumno(){
    String cadena = this.getNombre() + " " + this.getApellidos();
    print(cadena);
    print(this.getDNI());
    String cadena2 = "Tu nombre de usuario -> " + this.getLogin();
    print(cadena2);
  }
 
}
