pragma solidity >= 0.4.22 <0.7.0;

contract Ballot {
    
    struct voter {
        bool voted;
        uint weight;
        uint8 vote;
    }
    
    struct Proposal {
        uint voteCount;
    }
    
    //Stages of voting process
    
    enum Stage {Init, Reg, Vote, Done}
    
    Stage public stage = Stage.Init;
    
    
    //Chairperson
    address chairPerson;
    
    //Map address to respective voters
    mapping(address => voter) voters;
    
    //Array of Proposals
    Proposal [] public proposals;
    
    //Current Stage
    uint StartTime;
    
    //Constructor for the Smart contract
    /*
        *Define chairPerson
        *Define number of proposals
        *Register chairPerson
        *Initialization complete GO TO REG
    */
    
    constructor (uint8 _numProposals) public {
        chairPerson = msg.sender;
        voters[chairPerson].weight = 2;
        for(int i = 0;i<_numProposals;i++) {
            Proposal memory t;
            t.voteCount = 0;
            proposals.push(t);
        }
        stage = Stage.Reg;
        StartTime = now;
    }
    
    // Register voters
    function register(address v) public {
        //Registration isn't open
        if(stage != Stage.Reg) {
            return;
        }
        
        if(msg.sender != chairPerson || voters[v].voted) {
            return;
        }
        
        //Register the voter
        voters[v].weight = 1;
        voters[v].voted = false;
        
        //Time for registration is over
        if(now > (StartTime + 10  seconds)) {
            stage = Stage.Vote;
            StartTime = now;
        }
    }
    
    function vote(uint8 p) public {
        
        if(stage != Stage.Vote) {
            return;
        }
        
        voter storage v = voters[msg.sender];
        
        if(v.voted) {
            return;
        }
        proposals[p].voteCount+=v.weight;
        v.vote = p;
        v.voted = true;
        
        if(now > (StartTime + 10 seconds)) {
            stage = Stage.Done;
            StartTime = now;
        }
    }
    
    function winningProposal() public view returns(uint8 _winningProposal) {
        if(stage != Stage.Done) {
            return;
        }
        uint winningVote = 0;
        for(uint8 i = 0;i<proposals.length;i++) {
            if(proposals[i].voteCount > winningVote) {
                _winningProposal = i;
                winningVote = proposals[i].voteCount;
            }
        }
    }
    
}