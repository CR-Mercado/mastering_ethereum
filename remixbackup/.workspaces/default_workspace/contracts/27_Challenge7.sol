
/*Challenge #7

Consider this smart contract.
pragma solidity >=0.5.0 <0.9.0;

contract Game{
    address[] public players;
}

Add a function called start() that adds the address of the account that calls it to the dynamic array called players.

Deploy and test the contract on Rinkeby Testnet.

*/

//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Game{
    
    address[] public players;
    
    function start() public { 
     address _newplayer = msg.sender; // not sure what best practice is, here I store the msg sender before I push
     players.push(_newplayer);   
    }
}

/*
Recommended Solution: 
pragma solidity >=0.5.0 <0.9.0;

contract Game{
    address[] public players;
    
    function start() public{
        players.push(msg.sender); // directly adds msg sender 
    }
}

*/