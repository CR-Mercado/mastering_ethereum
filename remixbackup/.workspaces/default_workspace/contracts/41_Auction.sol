 //SPDX-License-Identifier: GPL-3.0
 pragma solidity ^0.8.0; 
 
 /*
 Decentralized deployment of Auctions 
 */
 
 
 contract auctionCreator { 
  address public creatorOwner;  // public state variable automatically has getter function 
  Auction[] public deployedAuctions; // public array automatically has getter function 
  
  constructor(){ 
   creatorOwner = msg.sender; // owner of the creator contract is the original deployer (i.e. Auction Contract Administrator, not new Auctioneer)   
  }
  
  function createAuction() public { 
    Auction new_auction_address = new Auction(msg.sender); // pass caller to Auction constructor as eoa; makes them owner of a their auction 
    deployedAuctions.push(new_auction_address); // track these auctions
  } 
    
} 
 
 contract Auction { 
     
     // Variables 
     address payable public owner; // publicly visible owner of the auction who gets paid by winner 
     uint public startBlock; // because block.timestamp can be spoofed by miners it is not best practice to use in this setting
     uint public endBlock;  // ( end block - start block ) * 15 seconds is a rough time calculator that can't be spoofed 
     string public ipfsHash; // because state variables are expensive, its cheaper to use a separate storage solution like 
                             // interplanetary file system (IPFS) and then just store the hash in the contract 
     enum State {Started, Running, Ended, Canceled} // enumerate class State with 4 possible values - no semicolon
     State public auctionState;  // auctionState is a public State 
     
     uint public highestBindingBid; // selling price of item; public number 
     address payable public highestBidder; // public address of winner- payable in case the auction is canceled 
                                           // or higher bid comes in to return their money
     mapping(address => uint) public bids; // store bids using address of bidder 
     uint bidIncrement; // ebay style auction 
     
     
     constructor(address eoa){  // see auction creator template 
      owner = payable(eoa); //  owner is contract creator recorded as payable
      auctionState = State.Running; // initiate auction upon deployment 
      startBlock = block.number;  // ETH blocks occur roughly every 15 seconds, safer to use that than to rely on miners who may spoof 
                // endBlock = startBlock + 40320; // roughly 40,000 blocks per week    
      endBlock = startBlock + 3; // for testing purposes only 3 blocks used  
      ipfsHash = ""; // initiate as empty string 
      bidIncrement = 1 ether; // denominated in ether for testing 
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
         require(msg.sender == owner, "You aren't the owner");
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
       
       // new bids are required to raise floor price; 
       // cumulative bidding below floor price is reverted 
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
     
     // never attempt to send eth automatically to users
     // best practice is to require them to claim their eth 
     // this is because of malicious fallback traps that can empty an insecure contract 
     function cancelAuction() public onlyOwner { 
       auctionState = State.Canceled;  
     } 
     
     // separate mechanism for claiming funds 
     function finalizeAuction() public { 
       require(auctionState == State.Canceled || block.number  > endBlock, "Auction isn't cancelled or finished"); // auction is cancelled OR ended naturally 
       require(msg.sender == owner || bids[msg.sender] > 0, "You didn't bid or aren't the owner."); // owner OR an auction participant can call this function 
       
       // prep to send money
       address payable recipient; 
       uint value; 
       
       // if cancelled, people can claim their funds back 
       if(auctionState == State.Canceled){ 
           recipient = payable(msg.sender); 
           value = bids[msg.sender]; 
           bids[msg.sender] = 0; // empty their account before sending anything.
           
       } else {  // if ended naturally
       
        // owner can get the highest bid 
           if(msg.sender == owner) { 
           recipient = owner; // note: owner already payable, does not need payable() wrapping.
           value = highestBindingBid;
           
           } else { 
        
        // highest bidder can get partial refund
            if(msg.sender == highestBidder){ 
                 recipient = highestBidder; 
        value = bids[highestBidder] - highestBindingBid;
        bids[msg.sender] = 0; // empty their account before sending anything.
       
        // any other bidder can get their balance 
            } else { 
           recipient = payable(msg.sender); 
           value = bids[msg.sender]; 
           bids[msg.sender] = 0; // empty their account before sending anything.
                } 
           }
       } 
       
       recipient.transfer(value); // should be protected since bids are emptied 
       auctionState = State.Ended; // End the auction - owner can change to cancelled if needed 
     } // finalizeAuction
     
     
     
     
     
     
 } 