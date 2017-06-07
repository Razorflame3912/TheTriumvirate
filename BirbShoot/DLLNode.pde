class DLLNode
{

  Level _cargo;    //cargo may be of type T
  DLLNode _prevNode; //pointer to previous LLNode
  DLLNode _nextNode; //pointer to next LLNode

  // constructor -- initializes instance vars
  DLLNode( Level value, DLLNode prev, DLLNode next ) 
  {
    _cargo = value;
    _prevNode = prev;
    _nextNode = next;
  }


  //--------------v  ACCESSORS  v--------------
  public Level getCargo() { 
    return _cargo;
  }
  public DLLNode getPrev() {
    return _prevNode;
  }
  public DLLNode getNext() { 
    return _nextNode;
  }
  //--------------^  ACCESSORS  ^--------------


  //--------------v  MUTATORS  v--------------
  public Level setCargo( Level newCargo ) 
  {
    Level ret = _cargo;
    _cargo = newCargo;
    return ret;
  }
  public DLLNode setPrev(DLLNode newPrev)
  {
    DLLNode ret = _prevNode;
    _prevNode = newPrev;
    //if( !( _prevNode.getNext().equals(this) ) )
    //  _prevNode.setNext(this);
    return ret;
  }

  public DLLNode setNext( DLLNode newNext ) 
  {
    DLLNode ret = _nextNode;
    _nextNode = newNext;
    //if( !(_nextNode.getPrev().equals(this) ) )
    //  _nextNode.setPrev(this);
    return ret;
  }
  //--------------^  MUTATORS  ^--------------

  /*
  // override inherited toString
  public String toString() { 
    return _cargo.toString();
  }
  */
  
}//end class DLLNode