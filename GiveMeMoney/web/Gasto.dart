part of GiveMeMoney;

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
  void setGasto(num valorGasto){ 
    this.valor = valorGasto;   
  }
  void setOpcion(String tipoCategoria){
    this.categoria = tipoCategoria;
  }
  void setClave(){
    
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