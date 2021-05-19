//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;

contract Property { 
  int public price;  // state variable, default 0 
  string location = "London"; 
  
  // Remix will create buttons for interacting with setter and getter functions (orange and blue respectively)
  
  
  // setter- setter functions cost gas 
  // function NAME(type parameter)
  // _price is a local variable 
  // public functions are available in contract's interface; can be called internally or by others 
   // public vs private vs internal vs external discussed later
  // intereacting with the contract
  
  function setPrice(int _price) public{ 
      price = _price;
  }
  
  // getter (of state variable) - getter functions are free reads
  // view is for read only (similar to pure) 
  // return indicates it returns an integer 
  function getPrice() public view returns(int){ 
      return price;
  }
} 