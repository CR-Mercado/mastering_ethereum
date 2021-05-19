//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;

contract Property { 
  int public price;  // state variable, default 0 
  // default to private; make public
  string public location = "London"; 
  
  // Remix will create buttons for interacting with setter and getter functions (orange and blue respectively)
  
  
  // setter- setter functions cost gas 
  // function NAME(type parameter)
  // _price is a local variable 
  // public functions are available in contract's interface; can be called internally or by others 
   // public vs private vs internal vs external discussed later
  // intereacting with the contract
  
  function setPrice(int _price) public { 
      price = _price;
  }
  
  // getter (of state variable) - getter functions are free reads
  // view is for read only - unlike pure, which neither reads or writes from the chain
  // return indicates it returns an integer 
   // NOTE: this function is not needed for public state variables
  function getPrice() public view returns(int){ 
      return price;
  }
  
  // make a local variable for setting and getting location
  function setLocation(string memory _location) public { 
      location = _location; 
  }
  
  // retrieve string from memory
  function getLocation() public view returns(string memory){
   return location;   
  }
  
  
} 