// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;

// state variables are expensive, saved on chain, and applied at the contract level 
contract Property { 
    int public price = 100;  // all types have a default value, NULL does not exist in Solidity. ints default to 0
    string constant public location = "London";  // location is a constant, public, string with value = London.
    
    
    // you cannot change a state variable arbitrarily 
    // price = 101; // will fail 
    // must use a constructor, setter function, or setting it at declaration

    
    // local variables are free and do not use chain for memory
    // pure designation means it does not read or write to the blockchain
    function f1() public pure returns(int){ 
      int x = 5;
      x = x * 2;
      return x;
      
      // but certain types are be default saved in storage (expensive) you'll get a warning for this 
      // requiring you to specify storage plan 
      // string s1 = "abc";
      
      // specify memory (free) 
      string memory s1 = "abc";
      
      // The 3 types of ways to save data: 
      // Storage (on blockchain, expensive)
      // Stack (holds local variables inside functions as long as they don't require reference types, i.e. Stack can hold int, but not strings 
      // Memeory free, but must be declared with memory. works with reference types (string, array, struct, mapping)
    } 
    
    
} 