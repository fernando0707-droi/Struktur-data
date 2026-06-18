class Node<T> {
  T data;
  Node<T>? next;
  Node(this.data, {this.next});
}

class CustomLinkedList<T> {
  Node<T>? head;
  Node<T>? tail;

  //  (Sifat Stack / LIFO)
  void insertFirst(T item) {
    head = Node<T>(item, next: head);
    if (tail == null) tail = head;
  }

  //  (Sifat Queue / FIFO)
  void insertLast(T item) {
    Node<T> newNode = Node<T>(item);
    if (tail == null) {
      head = tail = newNode;
    } else {
      tail!.next = newNode;
      tail = newNode;
    }
  }

  // Fungsi Hapus Depan (Untuk memproses Antrean)
  T? removeFirst() {
    if (head == null) return null;
    T poppedData = head!.data;
    head = head!.next;
    if (head == null) tail = null;
    return poppedData;
  }

  // Cek apakah list kosong
  bool get isEmpty => head == null;
}