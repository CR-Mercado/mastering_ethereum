//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;

contract Property { 
  int public price;  // state variable, default 0 
  // default to private; make public
  string public location = "London"; 
  address public owner; // owner of this contract 
  
  // Remix will create buttons for interacting with setter and getter functions (orange and blue respectively)
  
  
  // Modifiers can put a condition on certain functions all at once
  // here, we modify the *set* functions to force only the owner to be able to call them 
  // you can either copy/paste require(owner==msg.sender); inside each fuction, 
  // or just create a modifier 
  
  constructor(){ 
   owner = msg.sender; // record deployer as owner    
  }
  
  modifier onlyOwner(){ 
   require(owner == msg.sender);
   _; // special designation for where the modification occurs, i.e., require() is before the modified function body. 
      // you could place this in the beginning to run the function body before the require stops it, for any desired side effects.
  }
  
  
  // setter- setter functions cost gas 
  // function NAME(type parameter)
  // _price is a local variable 
  // public functions are available in contract's interface; can be called internally or by others 
   // public vs private vs internal vs external discussed later
  // interacting with the contract
  
  function setPrice(int _price) public onlyOwner {  // onlyOwner modifier added
      price = _price;
  }
  
  // make a local variable for setting location to a new value
  // does not update the blockchain! that would be string storage
  function setLocation(string memory _location) public onlyOwner { // onlyOwner modifier added
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