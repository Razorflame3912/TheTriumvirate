class DLList //originally general typed, but I'm bad at general typing so this is now exclusively for Levels
{ 

  //instance vars
  DLLNode _head;
  int _size;

  // constructor -- initializes instance vars
  DLList( ) 
  {
    _size = 0;
  }


  //--------------v  List interface methods  v--------------

  boolean add( Level L) {
    if (_size == 0) {
      _head = new DLLNode(L, null, null);
      _size += 1;
    } else {
      DLLNode tmp = _head;
      for (int i = 0; i < _size-1; i ++)
        tmp = tmp.getNext();
      DLLNode n = new DLLNode(L, tmp, null);
      tmp.setNext(n);
      n.setPrev(tmp);
      _size += 1;
    }
    return true;
  }
  void add(int index, Level newVal) {
    if (index == 0) {
      _head = new DLLNode(newVal, null, _head);
      DLLNode tmp = _head.getNext();
      tmp.setPrev(_head);
    } else {
      DLLNode tmp1 = _head;
      for (int i = 0; i < index - 1; i ++)
        tmp1 = tmp1.getNext();
      //tmp1 is the node right before the new node
      DLLNode tmp2 = new DLLNode( newVal, tmp1, tmp1.getNext() );
      DLLNode tmp3 = tmp1.getNext();
      tmp1.setNext(tmp2);
      tmp3.setPrev(tmp2);
    }
    _size += 1;
  }
  Level remove(int index) {
    Level ret = get(index);
    if (index == 0) {
      _head = _head.getNext();
      _head.setPrev(null);
    } else if (index == _size - 1) {
      DLLNode tmp = getN(index - 1);
      tmp.setNext(null);
    } else {
      DLLNode tmp2 = getN(index);
      DLLNode tmp1 = tmp2.getPrev();
      DLLNode tmp3 = tmp2.getNext();
      tmp1.setNext(tmp3);
      tmp3.setPrev(tmp1);
    }
    _size -= 1;
    return ret;
  }

  public Level get( int i) {
    DLLNode tmp = _head;
    for (int x = 0; x < i; x ++)
      tmp = tmp.getNext();
    return tmp.getCargo();
  }
  public DLLNode getN( int i) {
    DLLNode tmp = _head;
    for (int x = 0; x < i; x ++)
      tmp = tmp.getNext();
    return tmp;
  }
  public Level set( int i, Level o) {
    DLLNode tmp = _head;
    for (int x = 0; x < i; x ++)
      tmp = tmp.getNext();
    Level ret = tmp.getCargo();
    tmp.setCargo(o);
    return ret;
  }



  //return number of nodes in list
  public int size() { 
    return _size;
  } 

  //--------------^  List interface methods  ^--------------

  /*
  // override inherited toString
  public String toString() { 
    String retStr = "HEAD->";
    DLLNode tmp = _head; //init tr
    while ( tmp != null ) {
      retStr += tmp.getCargo() + "->";
      tmp = tmp.getNext();
    }
    retStr += "NULL";
    return retStr;
  }
  */
}//end class LList