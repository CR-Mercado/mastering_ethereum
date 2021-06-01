//SPDX-License-Identifier: GPL-3.0

//pragma solidity >= 0.5.0 <0.9.0;

// showing overflow error risk in older version of solidity
//pragma solidity 0.5.0;

// solidity 0.8.0 makes SafeMath checks implicit makes calling f1 return a revert error. 
 pragma solidity ^0.8.0; 

contract Property {
    
    // 1. Boolean type 
    bool public sold; // public boolean variable sold, default FALSE - getter function automatic when public
    
    // 2. Integer type -  a little complicated, as you have to specify int as signed (+/-) or unsigned and also 
    // specify it's memory allocation (8 bits versus 256 bits) 
    
    uint8 public x = 255; // unsigned Integer of 8 bits, stores a max number of 255. 
    // uint8 public x = 256; // memory overflow error. 
    int8 public y = -10; 
    
    // exposing overflow/underflow vulnerability 
    // add 1 to x which is already at max (Integer overflow)
    // in solidity 0.5.0 - this contract can be deployed and calling f1() does x = 255 --> 255 + 1 --> x = 0 
    function f1() public { 
        x += 1; // x = x + 1 but for programmers lol
        
        // in higher versions of solidity, you can ignore safe arithmetic with unchecked 
        // unchecked { x+= 1; }
    }
    
}