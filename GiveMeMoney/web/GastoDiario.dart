library GiveMeMoney;

//part 'Gasto.dart';
import 'Gasto.dart';

class GastoDiario{
  
  List<Gasto> totales;
  num total;
  DateTime fecha;
  
  /* Constructors. */
  GastoDiario(){
    /* Establece la fecha en la que se introdujo el gasto. */
    this.total = 0;
    this.fecha = new DateTime.now();
  //  this.gastosRealizados = new List<Gasto>();
    this.totales = new List<Gasto>();
    
    /* Inicializar los gastos totales */
    /* Lista estática que sirve como acumulador de los gastos que realiza un usuario al día. */
    Gasto categoria1 = new Gasto(0, "Ocio");
    this.totales.add(categoria1);
    Gasto categoria2 = new Gasto(0, "Primera Necesidad");
    this.totales.add(categoria2);
    Gasto categoria3 = new Gasto(0, "Formación");
    this.totales.add(categoria3);
    Gasto categoria4 = new Gasto(0, "Actividades Deportivas");
    this.totales.add(categoria4);
    Gasto categoria5 = new Gasto(0, "Viajes");
    this.totales.add(categoria5);
    Gasto categoria6 = new Gasto(0, "Transportes");
    this.totales.add(categoria6);
    Gasto categoria7 = new Gasto(0, "Otros");
    this.totales.add(categoria7);

    
  }
  /* Setters // Getters. */
  /* Setters. */
  void setFecha(var fechaEntrada){
    this.fecha = fechaEntrada;
  }
  void setGastos(List<Gasto> gastosEntrada){
    //this.gastosRealizados = gastosEntrada;
    this.totales = gastosEntrada;
  }
  /* Getters. */
  DateTime getFecha(){
    return this.fecha;
  }
  num getTotal(){
    return this.total;
  }
  /*void getGastosRealizados(){
   // return this.totales; //cambiado
    for (int i = 0; i < this.totales.length; i++)
      print(this.totales.elementAt(i).valor);
  }*/
  List getGastosRealizados(){
    List<Gasto> gastosRealizados = new List<Gasto>();
    
    for (int i = 0; i < this.totales.length; i++){
      gastosRealizados.add(totales.elementAt(i));
    }
    
    return gastosRealizados;
  }
  //con este método se arregla el problema a la hora de añadir gastos, no lo actualizábamos
  //y a causa de esto luego no se calculaba bien la media...
  void actualizarGastoDiario (num precio)
  {
    this.total += precio;
  }
 
  /* Añadir un gasto al total diario. =) */
  void aniadirGasto(Gasto gasto){
    /* Determinar si el gasto es correcto para añadirlo. */
    if(gasto.valor == null || gasto.valor <= 0){
      print("Un gasto nulo, negativo o 0 no se considera gasto.");
    }
    else{
      // Esto podría hacerse accediendo directamente al índice de la categoría.
      for(int i=0; i < this.totales.length; i++){
        /* Si coinciden las categorías, acumular el gasto en dicha categoría. */
        if(gasto.getCategoria() == totales.elementAt(i).getCategoria()){
          totales.elementAt(i).aumentarGasto(gasto.getGasto());
          actualizarGastoDiario(gasto.getGasto());
        }
      }
    }
    
  }
  num calcularTotal()
  {
    num total = 0;
    
    for (int i = 0; i < totales.length; i++)
    {
      total+= totales.elementAt(i).valor;      
    }
    return total;
  } 
  
}