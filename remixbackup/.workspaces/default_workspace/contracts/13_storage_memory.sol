//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;

// Toy contract just to show nuance of storage vs memory 
contract A { 
    
    // normally string is fixed with no index, pop, or push methods
    // but making a string *array* does allow index, pop, and push (f the array)!
  string[] public cities = ['Prague','Bucharest']; // state variables are in storage upon contract launch
  
 // normally string can't be indexed; but because we made it an array with []
 // it CAN be indexed so the following function works for updating our string in storage: 
   function changeCities(string memory _city, uint i) public { 
    cities[i] = _city;  
  } 
  
  // VERY IMPORTANT
  // In this storage function when s1 = cities; it does not copy cities.
  // It points s1 to the same location on storage
  // THUS, changes to s1 in storage which shares cities location in storage
  // CHANGES THE VALUE OF cities in storage too!
  // This is NOT like R, where items are stored in RAM and even when using pointers, 
  // it will implicitly duplicate when a change is made. 
  function f_storage() public { 
    string[] storage s1 = cities; 
    s1.push('Berlin'); // adds Berlin to the cities variable due to memory sharing 
  } 
  
  // Proof - note this getter function is created implicitly for state variables 
  function getCities(uint i) public view returns(string memory) { 
    return(cities[i]);
  } 
  
  
  // This doesn't do anything, as the function explicitly only views the blockchain, does not write to it
  function f_memory() public view { 
    string[] memory s1 = cities; 
    s1[0] = 'Berlin';
  } 
  
  // This getter function doesn't work because s1 is not a state variable 
  // and is not accessible outside of f_memory() or f_storage. 
  /*
  function gets1(uint i) public view returns(string memory) { 
    return(s1[i]);
  } 
  */
  
} 