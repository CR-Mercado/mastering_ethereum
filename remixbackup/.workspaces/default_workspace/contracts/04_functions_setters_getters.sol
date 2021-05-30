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
  // interacting with the contract
  
  function setPrice(int _price) public { 
      price = _price;
  }
  
  // make a local variable for setting location to a new value
  // does not update the blockchain! that would be string storage
  function setLocation(string memory _location) public { 
      location = _location; 
  }
  
   // getter (of state variable) - getter functions are free reads
  // view is for read only - unlike pure, which neither reads or writes from the chain
  // return indicates it returns an integer 
   // NOTE: this function is not technically needed for public state variables, but best practice is to be explicit
  function getPrice() public view returns(int){ 
      return price;
  }
  
  // retrieve string from memory
  function getLocation() public view returns(string memory){
   return location;   
  }
  
  
} 