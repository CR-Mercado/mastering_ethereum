//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;

// mappings are a more restricted struct. Requires keys to be all of same type and values must all have the same type. 
 // keys cannot be mappings, arrays, enums, or structs; but the values can be any type
 // always in storage - it's a state variable. Even inside a function they are in storage.
 
 // benefit of mappings is that it has a constant lookup time, while arrays have linear search time. 
 // mappings are not iterable (cannot use a for loop on them!)
 // the keys are not saved!!! - mappings use hash table structures to acheive constant lookup. 
    // so keys are transformed into a hash that gets the index for the value we want from the mapping.
    // if you try to use a non-existent key within a mapping, you get a default value 
        // here, the default value of uint is 0, so putting in an address that has never used this contract 
        // will return a value of 0, not an error.
    
    
    // this contract will be revisited in projects. 
    // Create an auction contract with tracking of bids!
    // biddders will bid ETH value for a product 
    // highest bidder wins!
    
contract Auction { 
  
  // Store addresses and their bids in form addresses => bid 
  // where address is type address; and bid is type uint 
  // thus mapping(address => uint)
  mapping( address => uint ) public bids;  // a public mapping named bids
    
  // a function to accept bids into the contract 
  // the payable declaration provides way to accept funds in Ether
  function bid() payable public { 
      // within the bids mapping; 
      // update the transaction maker address (msg.sender) key to have the bid value of transaction value (in wei)
      bids[msg.sender] = msg.value; // essentially- saving the global variables to the mapping
      
  } 
    
} 

/* Instructor's version
//SPDX-License-Identifier: GPL-3.0
 
pragma solidity >=0.5.0 <0.9.0;
contract Auction{
    
    // declaring a variable of type mapping
    // keys are of type address and values of type uint
    mapping(address => uint) public bids;
    
    // initializing the mapping variable
    // the key is the address of the account that calles the function
    // and the value the value of wei sent when calling the function
    function bid() payable public{
        bids[msg.sender] = msg.value;
    }
}
*/
    