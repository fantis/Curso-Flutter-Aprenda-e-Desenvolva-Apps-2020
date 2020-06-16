import 'dart:ffi';

main() {
  print('Rubens');

  Set items = {1, 2, 3, 4, 5, 6, 7, 8, 9};

  for (var item in items) {
    print(item);
  }

  Map<String, double> notasAlunos = {
    'Aluno 1': 9.7,
    'Aluno 2': 8.7,
    'Aluno 3': 6.7,
    'Aluno 4': 6.5,
    'Aluno 5': 5.4,
  'Aluno 6': 10.0,  
  };

  for (var item in notasAlunos.entries) {
    print('${item.key} = ${item.value}');    
  }


}