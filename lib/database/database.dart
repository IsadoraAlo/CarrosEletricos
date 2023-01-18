// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  Future<Database> getDatabase() async {
    final path = join(await getDatabasesPath(), 'zzzzzz.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(_feedbacks);
    await db.execute(_products);
    await db.execute(_user);
    await db.execute(_charges);
    await db.insert('products', {
      '_id': 101,
      'descripion':
          'Com o Novo Peugeot e-208 GT você economiza por ter uma baixa frequência de manutenções e revisões apenas a cada 20.000 km, sendo em média uma economia superior a 40%, em comparação aos carros de combustão. Além disso, a motorização elétrica permite uma condução com zero ruídos, zero vibração, zero trocas de marchas e zero odor, colaborando de forma responsável com o meio ambiente.',
      'name': 'Peugeot e-208 GT',
      'barCode': '989-908-890-654-869',
      'note': '4.9',
      'image': 'Peugeote208GT.png',
      'color': '0xFF448AFF'
    });
    await db.insert('products', {
      '_id': 102,
      'descripion':
          'Um autêntico 500, mas totalmente novo. O Fiat 500e está 61 cm mais longo e 56 cm mais largo, ou seja, mais robusto por fora e com mais espaço para os passageiros. Sem contar a sofisticação presente em todos os detalhes, como elementos cromados e novos badges. A caixa de rodas do Fiat 500e ficou maior para receber a nova roda de liga leve de 16 polegadas. Além do tamanho, seu acabamento escuro deixa o carro ainda mais bonito.',
      'name': 'Fiat 500e',
      'barCode': '979-345-345-976-343',
      'note': '2.3',
      'image': 'Fiat500e.png',
      'color': '0xFF46A2D1'
    });
    await db.insert('products', {
      '_id': 103,
      'descripion':
          'Além de #1 no coração dos aventureiros, o Jeep Compass é também um grande colecionador de prêmios: consagrado “Melhor Compra do Ano” na categoria SUV Premium e tetracampeão de “Melhor Valor de Revenda” em SUV Compacto, o veículo também é o vencedor dos prêmios Carsughi e UOL Carro na categoria SUV Médio. Como se tudo isso não bastasse o Jeep Compass foi a estrela no Comparativo da Motor1 de “Hits do Momento” em todos os 4 quesitos: design, sofisticação, performance e tecnologia.',
      'name': 'Jeep Compass 4xe',
      'barCode': '456-795-765-218-254',
      'note': '2.4',
      'image': 'JeepCompass4xe.png',
      'color': '0xFF48B4AE'
    });
    await db.insert('products', {
      '_id': 104,
      'descripion':
          'Inovador por natureza, o Ë-JUMPY CARGO é o primeiro elétrico da Citroën no Brasil que vai mudar o jeito de transportar seu negócio pelas ruas. Zero ruídos, zero vibrações e zero emissões para até 1 tonelada de carga e garantia de performance de um motor com resposta instantânea, com velocidade máxima de até 130 km/h. Sua praticidade fica por conta do carregamento, que pode ser realizado com rapidez em diversos tipos de carregadores ou em estações públicas, chegando a ter uma autonomia de até 330 km. Chegou a vez de fazer diferente com uma frota totalmente elétrica e sustentável, sem deixar de lado a segurança e o conforto.',
      'name': 'Citroën e-Jumpy',
      'barCode': '534-556-867-246-678',
      'note': '3.9',
      'image': 'CitroeneJumpy.png',
      'color': '0xFF49BF99'
    });
    await db.insert('products', {
      '_id': 105,
      'descripion':
          'A eletrificação é a inovação tecnológica que coloca sua empresa em um novo patamar de mobilidade. Com zero emissões e sem ruídos e vibrações, a Nova Peugeot e-Expert garante uma frota com agilidade e economia. Esteja pronto para qualquer desafio com o novo motor 1.5 Turbo Diesel Blue HDI de 120 cv de potência e câmbio manual de 6 marchas que garantem mais eficiência e melhor consumo, sendo nota "A" no Inmetro, realizando 12,4 km/L na cidade e 11,9km/L na estrada, garantindo mais de 1000 km de autonomia.',
      'name': 'Peugeot e-Expert',
      'barCode': '989-908-456-654-869',
      'note': '4.9',
      'image': 'PeugeoteExpert.png',
      'color': '0xFF49C68B'
    });
    await db.insert('products', {
      '_id': 106,
      'descripion':
          'Menor do que o Renegade, o Avenger não será tão diferente assim da versão elétrica, ao menos na parte visual. Não terá o emblema "e" na grade dianteira e conta com um escapamento. A unidade de testes também não trazia o adesivo amarelo usado nos protótipos para indicar que é um carro elétrico, algo obrigatório.',
      'name': 'Jeep Avenger',
      'barCode': '345-908-666-678-123',
      'note': '5.0',
      'image': 'JeepAvenger.png',
      'color': '0xFF3DB364'
    });
    await db.insert('products', {
      '_id': 107,
      'descripion':
          'O e-Scudo é um veículo elétrico a bateria (BEV), com a mesma modularidade e capacidade volumétrica da versão movida a combustível. Com ele, você tem zero vibrações e zero emissões de CO2. Experimente a economia e a autonomia do motor elétrico de 136 Cv que pode chegar a até 330 km - sem paradas para carregamento.',
      'name': 'Fiat e-Scudo',
      'barCode': '123-354-666-666-789',
      'note': '1.5',
      'image': 'FiateScudo.png',
      'color': '0xFF40D055'
    });
    await db.insert('user', {
      'id': 777,
      'username': 'Anonymous',
      'name': 'Anonymous',
      'email': 'anonymous.user@gmail.com',
      'password': 'anonymous'
    });
  }

  String get _products => '''
    CREATE TABLE IF NOT EXISTS products (
      _id INTEGER,
      descripion TEXT,
      name TEXT,
      barCode TEXT,
      note TEXT,
      image TEXT,
      color TEXT
    );
  ''';

  String get _charges => '''
    CREATE TABLE IF NOT EXISTS charges (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date INTEGER,
      porcentCharged TEXT,
      productId INTEGER,
      FOREIGN KEY(productId) REFERENCES products(_id)
    );
  ''';

  String get _feedbacks => '''
    CREATE TABLE IF NOT EXISTS feedbacks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      evaluation TEXT,
      rating TEXT,
      productId INTEGER,
      FOREIGN KEY(productId) REFERENCES products(_id)
    );
  ''';

  String get _user => '''
    CREATE TABLE user(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      name TEXT,
      email TEXT,
      password TEXT
    );
  ''';
}
