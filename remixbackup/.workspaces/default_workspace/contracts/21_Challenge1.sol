//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

/*
Challenge #1

Consider this Smart Contract.

contract CryptosToken{
    string name = "Cryptos";
    uint supply;
}

Change the state variable name to be declared as a public constant.

Declare a setter and a getter function for the supply state variable.

*/

contract CryptosToken{
    string public name = "Cryptos";
    uint supply;
    
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