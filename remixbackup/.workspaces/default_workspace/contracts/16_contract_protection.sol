//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;

contract Deposit { 
   
  address public owner;
  
  constructor(){ 
   owner = msg.sender;   
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
     
     require(owner == msg.sender, "Transfer failed, you are not the owner!!");
     
     // IF owner calls this function, then send the ETH
     // can't send more than the contract has!
      if( amount <= getBalance() ) { 
          // if test passed
          // transfer amount to recipient address & return TRUE
          recipient.transfer(amount);
          return(true);
     } else { 
      return(false);   
     }
  } 

}

