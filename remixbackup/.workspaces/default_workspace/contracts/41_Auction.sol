 //SPDX-License-Identifier: GPL-3.0
 pragma solidity ^0.8.0; 
 
 /*
 An auction 
 */
 
 contract Auction { 
     
     // Variables 
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
     
     
     // Mix of modifier and intrinsic requirements for placing a bid
     modifier notOwner() { 
       require(msg.sender != owner, "Owner cannot bid up the price!");
       _; 
     } 
     
     modifier afterStart() { 
         require(block.number > startBlock, "Auction hasn't started");
         _;
     } 
     
     modifier beforeEnd() { 
         require(block.number < endBlock, "Auction is over!");
         _;
     } 
     
     // only owner can cancel an auction 
     modifier onlyOwner() { 
         require(msg.sender == owner);
         _; 
     } 
     
     // helper function
     function min(uint a, uint b) pure internal returns(uint){ 
     if(a <= b){ 
      return a;   
         } else { 
      return b;   
        }
     } 
     
     
     function placeBid() public payable notOwner afterStart beforeEnd { 
         
       require(auctionState == State.Running, "Auction is not running"); // auction must be running; 
       require(msg.value >= bidIncrement, "Must add at least 1 bid increment to your bid"); // minimum send for adding to your past bids 
         
         uint currentBid = bids[msg.sender] + msg.value; // bidder adds to their bid when they place a bid  
       
       require(currentBid > highestBindingBid, "your addition doesn't beat the current highest binded bid");
       
       bids[msg.sender] = currentBid; // update bidder's total amount bid. 
       
       // if the current bid is valid but not above the current highest bidder's reserve, raise the highest bidder's binded reserve 
       // i.e. If I put 1000 and you bid 500, I'm only bound for 500 + bidIncrement when I win. 
       // until the time runs out, you can add to your 500, until you beat my reserve.
       
       if(currentBid <= bids[highestBidder]){ 
         highestBindingBid = min(currentBid + bidIncrement, bids[highestBidder]);  
       } else { 
         highestBindingBid = min(currentBid, bids[highestBidder] + bidIncrement); 
         highestBidder = payable(msg.sender);
       } 
       
    
     } 
     
     function cancelAuction() public onlyOwner { 
       auctionState = State.Canceled;  
     } 
     
     
     
     
 } 