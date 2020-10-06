pragma solidity >=0.4.22 <0.7.0;

contract Storage {
    uint storedData;
    function set (uint x) public {
        storedData = x;
    }
    
    function get() view public returns (uint) {
        return storedData;
    }
    
    function increment(uint n) public {
        storedData = storedData + n;
    }
    
    function decrement(uint n) public {
        storedData = storedData - n;
    }
}