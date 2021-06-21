
 /*
 - .1 ETH per lottery ticket
 - Lottery is managed by a smart contract that deploys/controls the lottery
 - if there are 3+ players, a random winner is selected
 - contract transfers entire balance to the winner's address 
 - lottery is reset 
 */
 
 
//SPDX-License-Identifier: GPL-3.0
 pragma solidity ^0.8.0; 
 
 contract Lottery { 
    address payable[] public players; // dynamic and public payable address array, players
    address payable private manager; // manager address that takes a small cut
     
     constructor() { 
         manager = payable(msg.sender); // contract deployer is manager
     }
     
     // the contract can receive ETH from external accounts; and when it does receive ETH
     // it adds a *payable* address to the players array
     receive() external payable { 
         
         // only accepted value is 0.01 ETH, here in wei
         require(msg.value == 1 ether);
         
         players.push( payable(msg.sender) ) ; 
     } 
     
     // check balance 
     // only the manager can see the balance 
     function getBalance() public view returns(uint){
        require(msg.sender == manager); 
      return address(this).balance;    
     } 
     
     // picking a winner with a TECHNICALLY HACKABLE  random number trick dont use in production!! 
     function badRandom() public view returns(uint){ 
         // use keccak256 hash on an enbi encoded byte
         // where the byte is the encoding of the block difficulty, timestamp, and # of players (each, somewhat random)
         return uint(
             keccak256( 
                 abi.encodePacked(block.difficulty, block.timestamp, players.length) ));
     } 
     
     // picks a winning address but doesn't alter the blockchain
     function pickWinner_test() public view returns(address){ 
         require(msg.sender == manager);
         require(players.length >= 3); 
         
         uint r = badRandom(); 
         address payable winner; 
         
         uint index = r % players.length; 
         winner = players[index];
         return winner;
     } 
     
     // picks a winning address AND sends them 90% of the contract balance.
     function pickWinner() public { 
         require(msg.sender == manager);
         require(players.length >= 3); 
         
         uint r = badRandom(); 
         address payable winner; 
         
         uint index = r % players.length; 
         winner = players[index];
         
         // Winner get's 90% of all funds. 
         uint amount = 9 * getBalance() / 10;
         uint leftover = getBalance() - amount; 
         require(getBalance() == amount + leftover);
         
         winner.transfer( amount );
         manager.transfer ( leftover ); 
     }
     
     
 } 
 
