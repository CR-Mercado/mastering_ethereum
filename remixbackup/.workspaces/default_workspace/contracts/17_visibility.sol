//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;

/*
4 Types of visibility (for variables & functions): 
- Public: function part of contract interface. Can be called by itself and other contracts/EOA accounts. 
    DEFAULT for functions 
    Getter f() automatically created
- Private: only available in the contract they're defined in (not in other derived or underived contracts); a subset of Internal.
    NEEDS Getter f() to be accessed within current contract
- Internal: acessible within contract defined in and derived contracts. 
    DEFAULT for state variables. 
- External: function part of contract interface. Can be accessed ONLY by other contracts/EOA accounts. Automatically Public. 
    NOT AVAILABLE for state variables
*/

contract A { 
    int public x = 10;  // available to all, getter automatically made 
    int y = 20;  // available only within this contract (and any derived contracts)
 
 
 // makes internal y available to those who call this getter 
 function getY() public view returns(int) { 
  return y;   
 }
 
 // this function is useless since x gets a getter by default, but just for show 
 // the function is also not visible because it is private 
 function getX() private view returns (int) { 
   return x;   
 } 
 
 // you can expose a private function just like a private variable, call it from within the contract 
 // via a public function 
 
 function get_getX() public view returns(int) { 
   return getX(); // runs getX() then spits it publicly   
 } 


// getting fancy. Make a DERIVED contract and access the internal function in original contract A 

function getX_internal() internal view returns(int){ 
    return get_getX(); 
}

// 
function getX_external() external view returns(int){
return x; // more gas efficient than public functions!
    
}

function get_getXexternal() public pure returns (int){ 
    int b;
    //return getX_external(); // fails because getX_external() is external, not available within itself 
    return b;
}


} // A 

// DERIVED contract
contract B is A { 
    int public derived_x = getX_internal();
    // int public attempt_at_private = getX(); // FAILS - getX() is private, not visible in derived contracts 
} 

// contract that deploys another contract 
contract C { 
  A public contract_a = new A(); // contract_a is a class A-contract holding a new contract A; 
  int public xx = contract_a.getX_external(); 
 // int public y = contract_a.getX(); // fails because getX() is private
 // int public yy = contract_a.getX_internal(); // fails because it is internal  
} 




