import 'konsepPBO.dart';
import 'singlyLinkedList.dart';
class SearchEngine { 
  List<Car> _carList = []; 
   
  void addCar(Car car) { 
    _carList.add(car); 
    sortByNama();
    print('${car.nama} berhasil ditambahkan dan data langsung diurutkan');
  } 
 
  // ALGORITMA SORTING: Bubble Sort 
  void sortByNama() {
    int n = _carList.length;
    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        if (_carList[j].nama.toLowerCase().compareTo(_carList[j + 1].nama.toLowerCase()) > 0) {
          Car temp = _carList[j];
          _carList[j] = _carList[j + 1];
          _carList[j + 1] = temp;
        }
      }
    }
  }


  // ALGORITMA PENCARIAN: Binary Search(secara terurut)
  Car? searchByName(String targetNama){
   int low = 0;
   int high = _carList.length - 1;
   String target = targetNama.toLowerCase();

   //esekusi binary searchnya
   while (low <= high){
    int mid = (low + high) ~/ 2;
    String midNama = _carList[mid].nama.toLowerCase();

    if (midNama == target) return _carList[mid];
    if(midNama.compareTo(target) < 0){low = mid + 1;
    } else {high = mid - 1;}
   }
   return null;
  }

  List<Car> get allCars => _carList;
}

// singly LINKED LIST: History Manager (stack)
class HistoryManager {
  final CustomLinkedList<Car> _historyList = CustomLinkedList<Car>();
  void addToRecentlyViewed(Car car) {
    _historyList.insertFirst(car); 
  }

  void displayHistory() {
    print('\n Riwayat Terakhir Dilihat ');
    var current = _historyList.head;
    if (current == null) print('Belum ada riwayat.');
    while (current != null) {
      print('- ${current.data.nama}');
      current = current.next;
    }
  }
}

// QUEUE: Transaction Queue menggunakan Linked List 
class Transaction {
  final String id;
  final String customerName;
  final String carOrdered;
  Transaction({required this.id, required this.customerName, required this.carOrdered});
}
class TransactionQueue { 
  final CustomLinkedList<Transaction> _queueList = CustomLinkedList<Transaction>();
  int _counter = 1;
  
  // Fungsi menambah antrean(Memasukkan pelanggan baru yang ingin membeli mobil ke barisan antrean paling belakang.)
  void addToPendingQueue(String name, String car) { 
    String uniqueId = 'TX-${_counter.toString().padLeft(3,'0')}';
    _counter ++;

    Transaction newTx = Transaction(id: uniqueId, customerName: name, carOrdered: car);
    _queueList.insertLast(newTx); // Masuk di tail (Queue FIFO)

    print('Sukses: Pelanggan $name masuk antrean dengan Kode: $uniqueId');
  } 
   
  // Fungsi memproses antrean(Memanggil dan melayani pelanggan yang berada di urutan antrean paling depan)
  void processQueue() { 
    if (_queueList.isEmpty) {
      print('Antrian kosong');
      return;
    }
    
    // Mengambil sekaligus menghapus data transaksi terdepan (head)
    Transaction? currentTx = _queueList.removeFirst();
    if (currentTx != null) {
      print('Memproses Transaksi: ${currentTx.id}');
      print('Nama Pelanggan     : ${currentTx.customerName}');
      print('Pesanan Mobil      : ${currentTx.carOrdered}');
    }
  }  
}

// CLASS: Credit Calculator
class CreditCalculator { 
  final int _interestRate; 
  CreditCalculator({int interestRate = 25}) : _interestRate = interestRate; 
   
  Map<String, dynamic> calculateInstallment(int carPrice, int downPayment, int tenor) { 
    int loanAmount = carPrice - downPayment; 
    double monthlyInterest = (loanAmount * _interestRate / 100) / 12; 
    double monthlyPayment = (loanAmount / tenor) + monthlyInterest; 
     
    return { 
      'loanAmount': loanAmount, 
      'monthlyPayment': monthlyPayment.toStringAsFixed(0), 
      'totalPayment': (monthlyPayment * tenor).toStringAsFixed(0), 
    }; 
  } 
} 
