pragma solidity >=0.4.22 <0.7.0;

contract Ballot {
    struct voter {
        bool voted;
        uint weight;
        uint8 vote;
    }
    
    struct Proposal {
        uint voteCount;
    }
    
    address chairPerson;
    
    mapping(address => voter) voters;
    Proposal[] public proposals;
    
    constructor(uint8 _numProposals) public {
        chairPerson = msg.sender;
        voters[chairPerson].weight = 2;
        for(int i = 0;i<_numProposals;i++) {
            Proposal memory t;
            t.voteCount = 0;
            proposals.push(t);
        }
    }
    
    function register(address toVoter) public {
        if(msg.sender != chairPerson || voters[toVoter].voted)
            return;
        voters[toVoter].weight = 1;
        voters[toVoter].voted = false;
    }
    
    function vote(uint8 toProposal) public {
        voter storage sender = voters[msg.sender];
        if(sender.voted || toProposal > proposals.length)
            return;
        sender.voted = true;
        proposals[toProposal].voteCount += sender.weight;
    }
    
    function winningProposal() public view returns (uint8 _winningProposal){
        uint winningVote = 0;
        for(uint8 i = 0;i<proposals.length;i++) {
            if(proposals[i].voteCount > winningVote) {
                winningVote = proposals[i].voteCount;
                _winningProposal = i;
            }
        }
    }
    
}