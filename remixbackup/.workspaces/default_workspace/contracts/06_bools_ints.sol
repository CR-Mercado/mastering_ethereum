//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;

contract Property {
    
    // 1. Boolean type 
    bool public sold; // public boolean variable sold, default FALSE - getter function automatic when public
    
    // 2. Integer type -  a little complicated, as you have to specify int as signed (+/-) or unsigned and also 
    // specify it's memory allocation (8 bits versus 256 bits) 
    
    uint8 public x = 255; // unsigned Integer of 8 bits, stores a max number of 255. 
    // uint8 public x = 256; // memory overflow error. 
    int8 public y = -10; 
}