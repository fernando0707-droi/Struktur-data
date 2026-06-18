import 'dart:io';
import 'konsepPBO.dart';
import 'konsepStruturData.dart';
void main() {
  var searchEngine = SearchEngine();
  var history = HistoryManager();
  var queue = TransactionQueue();
  var calculator = CreditCalculator();

  // Data Awal
  searchEngine.addCar(Car('C01', 'Avanza', 'Toyota', 200000000, 'MPV', 5000));
  searchEngine.addCar(Car('C02', 'Brio', 'Honda', 150000000, 'Hatchback', 2000));
  searchEngine.addCar(Car('C03', 'Civic', 'Honda', 500000000, 'Sedan', 1000));
  searchEngine.addCar(Car('C04', 'BR-V', 'Honda', 374000000,'SUV',4000));

  while (true) {
    print('\n SISTEM MANAJEMEN MOBIL ');
    print('1. Lihat Semua Mobil ');
    print('2. Cari Mobil ');
    print('3. Lihat Riwayat');
    print('4. Antrian Transaksi');
    print('5. Simulasi Kredit');
    print('6. Keluar');
    stdout.write('Pilih menu (1-6): ');
    
    String? input = stdin.readLineSync();
    
    switch (input) {
      case '1':
        print('\n Daftar Mobil ');
        searchEngine.sortByNama();
        for (var car in searchEngine.allCars) car.displayInfo();
        break;

      case '2':
        stdout.write('\nMasukkan nama mobil yang dicari: ');
        String? target = stdin.readLineSync();
        if (target != null && target.isNotEmpty) {
          Car? found = searchEngine.searchByName(target);
          if (found != null) {
            print('Ditemukan!');
            found.displayInfo();
            history.addToRecentlyViewed(found);
          } else {
            print('Mobil "$target" tidak ditemukan.');
          }
        }
        break;

      case '3':
        history.displayHistory();
        break;

 case '4':
        print('\n--- Menu Antrean ---');
        print('a. Tambah ke Antrian');
        print('b. Proses Antrian');
        stdout.write('Pilih (a/b): ');
        String? qMenu = stdin.readLineSync();
        if (qMenu == 'a') {
          stdout.write('Masukkan Nama Customer: ');
          String name = stdin.readLineSync() ?? '';
          stdout.write('Masukkan Mobil yang Dipesan: ');
          String carName = stdin.readLineSync() ?? '';
          
          if (name.isNotEmpty && carName.isNotEmpty) {
            queue.addToPendingQueue(name, carName);
          } else {
            print('Data tidak boleh kosong!');
          }
        } else if (qMenu == 'b') {
          queue.processQueue();
        }
        break;

      case '5':
        stdout.write('\nMasukkan Harga Mobil: ');
        int harga = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
        stdout.write('Masukkan DP: ');
        int dp = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
        stdout.write('Masukkan Tenor (bulan): ');
        int tenor = int.tryParse(stdin.readLineSync() ?? '') ?? 1;
        
        var hasil = calculator.calculateInstallment(harga, dp, tenor);
        print('\n Hasil Simulasi ');
        print('Pinjaman: Rp ${hasil['loanAmount']}');
        print('Cicilan/bulan: Rp ${hasil['monthlyPayment']}');
        print('Total Bayar: Rp ${hasil['totalPayment']}');
        break;

      case '6':
        print('Terima kasih!');
        return;

      default:
        print('Pilihan tidak valid.');
    }
  }
}