pragma solidity >=0.4.22 <0.7.0;

contract Bidder {
    string public name;
    uint public bidAmt;
    bool public eligible;
    uint minBid = 100;
    
    
    function setname (string memory s) public{
        name = s;
    }
    
    function setBidAmount (uint t) public {
        bidAmt = t;
    }
    
    function determineEligibility() public {
        if(bidAmt > minBid)
            eligible = true;
        else 
            eligible = false;
    }
    
}