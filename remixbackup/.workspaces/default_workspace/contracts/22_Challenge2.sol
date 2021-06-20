//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

/*
Challenge #2

Consider the solution from the previous challenge.

Add a public state variable of type address called owner.

Declare the constructor and initialize all the state variables in the constructor. 
The owner should be initialized with the address of the account that deploys the contract.

*/


contract CryptosToken{
    //string public name = "Cryptos";
    string public name;
    uint supply;
    address public owner;
    
    constructor(uint new_supply){ 
      name = "Cryptos";
      supply = new_supply; // force deployer to put initial value
      owner = msg.sender; 
    } 
    
    function setSupply(uint new_supply) public returns(bool){ 
     
     if(new_supply >= 0) { 
     supply = new_supply;
     return(true); 
     } else { 
     return false;
     }
    }
    
    
    function getSupply() public view returns (uint) { 
     return supply;   
    }
    
}

