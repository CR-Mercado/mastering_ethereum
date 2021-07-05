 //SPDX-License-Identifier: GPL-3.0
 pragma solidity ^0.8.0; 
 
 /*
 An auction 
 */
 
 contract Auction { 
     
     address payable public owner; // publicly visible owner of the auction who gets paid 
     uint public startBlock; 
     uint public endBlock; // because block.timestamp can be spoofed by miners it is not best practice to use in this setting
     string public ipfsHash; // because state variables are expensive, its cheaper to use a separate storage solution like 
                             // interplanetary file system (IPFS) and then just store the hash in the contract 
     
     enum State {Started, Running, Ended, Canceled} // enumerate class State with 4 possible values - no semicolon
     State public auctionState;  // auctionState is a public State 
     
     uint public highestBindingBid; // selling price of item; public number 
     address payable public highestBidder; // public address of winner- payable in case the auction is canceled 
                                           // or higher bid comes in to return their money 
     
     
     mapping(address => uint) public bids; // store bids using address of bidder 
     
     uint bidIncrement; // ebay style auction 
     
     constructor(){ 
      owner = payable(msg.sender); //  owner is contract deployer recorded as payable
      auctionState = State.Running; // initiate auction upon deployment 
      startBlock = block.number;  // ETH blocks occur roughly every 15 seconds, safer to use that than to rely on miners who may spoof 
      endBlock = startBlock + 40320; // roughly 40,000 blocks per week    
      ipfsHash = ""; // initiate as empty string 
      bidIncrement = 100; // denominated in wei 
     }
     
     
     
     
 } 