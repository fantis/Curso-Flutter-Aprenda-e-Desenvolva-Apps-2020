printProductNamedParameters({String name, double price}) {
     print("Imprime produto com parâmetros nomeados \n Nome: " + name +  "  Preço: " + price.toString()); 
}



class Product {
  String name;
  int numberCode;
  double price;  

  // Product() {
  //   this.name = "";
  //   this.numberCode = 0;
  //   this.price = 0.0;
  // }

  // Product();

  // Product(this.name, this.price);
  Product(this.name, this.numberCode, this.price);

  // Product(String name, int numberCode, double price) {
  //   this.name = name;
  //   this.numberCode = numberCode;
  //   this.price = price;
  // }



  toString() {
    print("Nome: " + this.name + "  Código: " + this.numberCode.toString() + "  Preço: " + this.price.toString());
  }

}

main() {
  // var prod1 = new Product();
  // prod1.name = 'Lápis ';
  // prod1.numberCode = 01001;
  // prod1.price = 1.50;
  Product prod1 = Product('Caneta', 01002, 3.33);
  Product prod2 = Product('Carro ', 01003, 100000.00);

  prod1.toString();
  print(prod1.runtimeType);
  print("O produto ${prod1.name} tem preço ${prod1.price}");

  print('----------------------');
  prod2.toString();
  
  print('----------------------');
  printProductNamedParameters(name: prod1.name, price: prod1.price);
  printProductNamedParameters(name: prod2.name, price: prod2.price);
  

}