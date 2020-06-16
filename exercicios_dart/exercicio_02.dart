


int soma(int a, int b) {
  return a + b;
}

int exec (int a, int b, Function(int, int) function) {
  return function(a, b);
}



main() {
  print(soma(5, 6));

  final result = exec(200, 3, (a, b) {
    return a - b;
  });
  print('O resultado é $result');
}

