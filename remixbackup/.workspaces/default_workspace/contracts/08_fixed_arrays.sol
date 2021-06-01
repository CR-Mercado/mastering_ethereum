//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;

contract FixedSizeArrays {  // a fixed array has elements of the same type 

    // defaults to [0,0,0] 
    uint[3] public numbers = [1,2,3]; // 3 public integers. reminder: getter functions automatically created for public state variables. 
    
    
    // each of these are special types of array that holds bytes directly - from 1 byte (0x00) to up to 32 bytes (0x00...00) with 64 0s after 0x   
    bytes1 public b1;  // 1 byte
    bytes2 public b2;  // 2 bytes
    bytes3 public b3;  // 3 bytes
    // bytes32 public b32; // 32 bytes
    
    
    // change index'th value 
    // because array is fixed, doing setElement(3, 9) reverts and fails to create a 4th element 
    function setElement(uint index, uint value) public { 
        numbers[index] = value;
    } 
    
    // return length of array 
    function getLength() public view returns(uint){ // public function, only views, doesn't write to chain, returns an unsigned integer
     return numbers.length;   // length is an intrinsic method of arrays.
    }

    function setBytesArray() public {
    b1 = 'a'; // (0x61)
    b2 = 'ab'; // (0x6162) // Hx ASCII codes 
    b3 = 'abc'; // (0x616263)
    // b3 = 'z';  // would be (0x7a0000)  notice the padding of 0s 
    // b3[0] = 'a'; // fails, you cant change byt
    }
    
    function getNumbers(uint index) public view returns(uint){ 
        return numbers[index];
    }

}

