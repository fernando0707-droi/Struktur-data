abstract class Vehicle { 
  // Encapsulation: Menggunakan private properties (_)
  final String _id; 
  final String _nama; 
  final String _merk; 
  final int _harga; 
   
  
  Vehicle(this._id, this._nama, this._merk, this._harga); 
   
  // Abstract methods: Polymorphism (harus di-override oleh subclass)
  void displayInfo(); 
  int getHarga();
  
  // Getter untuk akses data private
  String get id => _id;
  String get nama => _nama;
  String get merk => _merk;
  int get harga => _harga;
} 
 
// INHERITANCE: Car mewarisi sifat dari Vehicle
class Car extends Vehicle { 
  final String tipe; 
  final int kilometer; 
   
  Car(String id, String nama, String merk, int harga, this.tipe, this.kilometer)  
    : super(id, nama, merk, harga); 
   
  // POLYMORPHISM: Override method dari abstract class
  @override 
  void displayInfo() { 
    print('ID: $_id | Mobil: $_nama ($_merk) - Tipe: $tipe - Rp $_harga'); 
  } 
   
  @override 
  int getHarga() => _harga; 
} 