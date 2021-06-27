
 /*
 - 1 ETH per lottery ticket - accepts but ignores smaller entrances; no benefit for oversends
 - Lottery is managed by a smart contract that deploys/controls the lottery
 - contract transfers 90% of the balance to the winner's address; 9% to the manager; 1% split among each unique entrant
 - lottery tracks the unique entrants for splitting a separate reward
 - lottery is then reset
 */
 
 //SPDX-License-Identifier: GPL-3.0
 pragma solidity ^0.8.0; 
 
  contract Lottery { 
    address payable[] public players; // dynamic and public payable address array, players
    address payable internal manager; // manager address that takes a small cut
    mapping (address => uint) check_entrants; // track amounts sent by entrants for recording unique entrants
    address payable[] internal unique_entrants; // dynamic, public, payable recording of unique entrants 
    address payable[] public previous_participants; 
     
     constructor() { 
         manager = payable(msg.sender); // contract deployer is manager only as a technicality
     }
     
     // the contract can receive ETH from external accounts; and when it does receive ETH
     // it adds a *payable* address to the players array for choosing a winner later
     // some terms & conditions apply.
     receive() external payable { 
         
         // don't even allow tiny spam sends.
         require(msg.value >= 0.001 ether);
         
         // Player only added if they add at least 1 ether
         // no benefit for adding more than 1.
         
         if( msg.value >= 1 ether ){
             
            players.push(payable(msg.sender));
            
            // if this is their first valid entrance, add them to unique entrants
            // otherwise they can enter as many times as they want, but it won't be included in the unique_entrants array
            if( check_entrants[msg.sender] == 0 ){ 
             unique_entrants.push(payable(msg.sender)); 
             check_entrants[msg.sender] = check_entrants[msg.sender] + msg.value;
            }
             
         } else { 
         // don't add people who don't pay the minimum fee; just take their money 
         }
         
     } 
     
     // check balance 
     // Anyone can see the balance 
     function getBalance() public view returns(uint){
      return address(this).balance;    
     } 
     
     // check number of entries 
     
     function getNumEntries() public view returns(uint){ 
       return players.length;  
     } 
     
     // check number of individuals 
     function getNumPlayers() public view returns(uint){ 
      return unique_entrants.length;   
     }
     
     
     // picking a winner with a TECHNICALLY HACKABLE random number trick dont use in production!! 
     function badRandom() public view returns(uint){ 
         // use keccak256 hash on an enbi encoded byte
         // where the byte is the encoding of the block difficulty, timestamp, and # of players (each, somewhat random)
         return uint(
             keccak256( 
                 abi.encodePacked(block.difficulty, block.timestamp, players.length) ));
     } 
     
     
     function saveLastParticipants() internal {
         previous_participants = unique_entrants; 
     }
     
     // picks a winning address AND sends them 90% of the contract balance.
     
     function pickWinner() public{
         
         require(msg.sender == manager, "you're not authorized to make call this function");
         
         // save unique entrants 
        saveLastParticipants();
         
         // this bad random needs an oracle for true randomness
         uint r = badRandom(); 
         
         // pick a winner!
         address payable winner; 
         uint index = r % players.length; 
         winner = players[index];
         
         // Winner get's 90% of all funds. 
         uint amount = 9 * getBalance() / 10;
         
         // 10% for manager + split
         uint leftover = getBalance() - amount;
         
         // calculate split 
         uint split = 1 * leftover / 10; 
         
         // 9% to manager 
         leftover = leftover - split; 
         
         
         require(getBalance() == amount + leftover + split, "Something went wrong with splitting the money");
         
         winner.transfer( amount );
         
         // manager gets 9% 
         manager.transfer( leftover ); 
         
         // unique participants get 1/N of 1% each regardless of # of entries
          uint share = 1 * split / unique_entrants.length;
          
         for(uint i = 0; i < unique_entrants.length; i++){
          unique_entrants[i].transfer(share);
         }
         
         // after everything is done, reset the lottery
         players = new address payable[](0);
         
         // wipe the check_entrants so that people are not permanently entrants in the lottery
         for(uint i = 0; i < unique_entrants.length; i++){ 
          check_entrants[ unique_entrants[i] ] = 0;    
         }
         
         // reset the unique_entrants too.
         unique_entrants = new address payable[](0); 
     }
     
     
 
     
     
 } 
 
