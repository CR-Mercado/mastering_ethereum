 //SPDX-License-Identifier: GPL-3.0
 pragma solidity ^0.8.0; 
 
contract Auction { 
  address public auctionOwner; 
  
  // The EOA that calls the Auction derived contract will be owner of that specific auction contract 
  constructor(address eoa) { 
    auctionOwner = eoa;   
  } 
    
}

contract Creator { 
  address public creatorOwner; 
  Auction[] public deployedAuctions; 
  
  constructor(){ 
   creatorOwner = msg.sender; // owner of the creator contract is the original deployer (i.e. Auction Administrator)   
  }
  
  function createAuction() public { 
    Auction new_auction_address = new Auction(msg.sender); // pass caller to Auction constructor as eoa
    deployedAuctions.push(new_auction_address); 
  } 
    
} 