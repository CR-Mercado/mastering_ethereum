// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.2;

contract Property {  
    // 3 state variables: property_image_URL, price, owner
    string public property_image_URL;
    uint private price;  
    address public owner;  
    
    //initialize state variables of contract - run once per contract instance
    constructor(){ 
        price = 0;
        owner = msg.sender;
        property_image_URL = "www.google.com/image/image.jpg";
    } 
    
    // Function Modifier 
    
    // modifies functions when applied 
    modifier onlyOwner(){ 
        require(msg.sender == owner);
       _;
    }
    
    // 2 setter functions 
        // notice that onlyOwner is modified to check that the msg.sender is the owner 
    function changeOwner(address _owner) public onlyOwner { 
        owner = _owner;
    }
    
    function setPrice(uint _price) public { 
        price = _price;
    } 
    
    // a getter function 
    // natspec version for documentation: 
    /// @notice Returns the price of Property 
    function getPrice() view public returns (uint){
        return(price);
    } 
    
    // Event 
    // enable logging 
    event OwnerChanged(address owner); 
    
    }