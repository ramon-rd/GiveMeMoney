//part of GiveMeMoney;
//library GiveMeMoney;

class Gasto{
  
  num valor;
  String categoria;
  String clave;
  

  /* Constructors */
  Gasto(num valorGasto, String opcion){
    
    this.valor = valorGasto;
    this.categoria= opcion;
    
  }
  /* Setters // Getters. */
  /* Setters. */
/*  void setGasto(num valorGasto){ 
    this.valor = valorGasto;   
  }
  void setOpcion(String tipoCategoria){
    this.categoria = tipoCategoria;
  }*/
  //En lugar de tener dos métodos para añadir por separado, sería mejor un solo método para introducir la pareja...
  void setGastoCategoria (num valorGasto, String tipoCategoria)
  {
    this.valor = valorGasto;
    this.categoria = tipoCategoria;
  }
  /* Getters. */
  num getGasto(){
    return this.valor;
  }
  String getCategoria(){
    return this.categoria;
  }
  String getClave(){
    return this.clave;
  }
  /* Métodos */
  void aumentarGasto(num importe){
    this.valor += importe;
  }
  
}