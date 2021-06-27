//SPDX-License-Identifier: GPL-3.0
 
 
/*
Challenge #2

Consider the Lottery Smart Contract developed in the current section.

Change the contract so that the manager is automatically added to the lottery, without sending any ether.

*/ 
 
pragma solidity >=0.5.0 <0.9.0;

contract Lottery{
    
    // declaring the state variables
    address payable[] public players; //dynamic array of type address payable
    address public manager; 
    
    
    // declaring the constructor
    constructor(){
        // initializing the owner to the address that deploys the contract
        manager = msg.sender; 
        
        // course recommends solving this challenge by adding manager here in constructor
        // but players is reset after each round, the constructor is NOT reset later. 
        
    }
    
    // declaring the receive() function that is necessary to receive ETH
    receive () payable external{
        // each player sends exactly 0.1 ETH 
        require(msg.value == 0.1 ether);
        
        // manager added by default; here its added each round upon first entry
        if(players.length == 0){ 
            players.push( payable(manager) ); 
        }
        
        // appending the player to the players array
        players.push(payable(msg.sender));
    }
    
    // returning the contract's balance in wei
    function getBalance() public view returns(uint){
        // only the manager is allowed to call it
        require(msg.sender == manager);
        return address(this).balance;
    }
    
    // helper function that returns a big random integer
    function random() internal view returns(uint){
       return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }
    
    
    // selecting the winner
    function pickWinner() public{
        // only the manager can pick a winner if there are at least 3 players in the lottery
        require(msg.sender == manager);
        require (players.length >= 3);
        
        uint r = random();
        address payable winner;
        
        // computing a random index of the array
        uint index = r % players.length;
    
        winner = players[index]; // this is the winner
        
        // transferring the entire contract's balance to the winner
        winner.transfer(getBalance());
        
        // resetting the lottery for the next round
        players = new address payable[](0);
    }

}