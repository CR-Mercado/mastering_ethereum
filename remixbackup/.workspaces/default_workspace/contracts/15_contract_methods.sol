//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;

/*
- Contracts have addresses (derived from deployer address + no of transactions of deployer account; can't be calculated in advance)
- addresses can be 'plain' or 'payable'|   plain cant receive ETH; payable can. payable contracts must have payable function
- Address variables have the following methods: 
 - balance - how much ETH they hold 
 - *transfer() - safest way to send ETH 
 - *send() - low level transfer(); if execution fails, contract continues but send() returns FALSE 
 - call()
 - callcode()
 - delegatecall() 
 
* transfer and send only available in payable addresses 

Contracts receive ETH by: 
 - recieving it via receive() or fallback()
 - calling a payable function and sending ETH with that transaction
*/

contract Deposit { 
    // explicitly note this contract can receive ETH externally
    // receive() - syntax (function without a function call) is unique and can only be used once per contract - NO args; NO return;
    // external - function must be externally callable
    // payable - must have changeable state
  
  receive() external payable { 
      
  } 
    
  // either receive or fallback or both must be in a contract or else efforts to give the contract ETH will fail.   
  fallback() external payable { 
      
  } 
  
  // return balance of contract 
  // address(this) is the contract address
  function getBalance() public view returns(uint){ 
     return(address(this).balance); 
  }
  
  // a public payable function; anyone can call the function and include ETH with their call
  // to add money to the contract 
  function sendEther() public payable { 
    // can be empty
  } 
  
  
  // a public function, transferEther, that sends 'amount' to payable address 'recipient'
  // returns a boolean for success or failed 
  function anyoneTransferEther(address payable recipient, uint amount) public returns(bool) { 
     
     // can't send more than the contract has!
      if( amount <= getBalance() ){
          // if test passed
          // transfer amount to recipient address & return TRUE
          recipient.transfer(amount);
          return(true);
     } else { 
      return(false);   
     }
  } 
  
    
}

