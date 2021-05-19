// SPDX-License-Identifier: GPL-3.0 

pragma solidity 0.8.0; 

contract Property { 
  
    int public value;  // create variable value 
    
    function setValue(int _value) public { 
     // function that takes input _value and updates our public variable value to be equal to _value 
     value = _value;    
    }
} 

