//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;

contract Property { 
    int public price; 
    string public location; 
    address immutable public owner; // type address, publicly visible, but cannot be changed. So once the contract is deployed, 
                                    // the constructor below sets it to msg.sender - it will then be permanent  
    int constant area = 100; // use constant to make immutable state variables upfront (not in constructor)
    // if you want something immutable and constant, but want it to be initialized within the constructor, use immutable instead 
    // int immutable area;
    
    
    
    // manually initialize state variables; you can do this above instead of using constructor (except for constant)
     // strings are a reference type, so you must state where they are found (in memory, not storage or stack)
     // in remix you include these constructor arguments next to the Deploy button 
    constructor(int _price, string memory _location){ 
     price = _price;
     location = _location; 
     owner = msg.sender; // initialize the state owner variable as whoever first deploys this contract. 
                        // msg.sender is a global variable
                        
     // area = 100; // this line not compatible with int constant area = 100 above. It is compatible with int immutable area; 
    }
    
    
    // these should be familiar 
    function setPrice(int _price) public { 
      price = _price;
      }
  
 
  function getPrice() public view returns(int){ 
      return price;
  }
  
}
  