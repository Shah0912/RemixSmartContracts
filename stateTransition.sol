pragma solidity >=0.4.22 <0.7.0;

contract stateTransition {
    enum Stage {Init, Reg, Vote, Done}
    Stage public stage;
    uint startTime;
    uint public timeNow;
    constructor () public {
        stage = Stage.Init;
        startTime = now;
    }
    
    function advancedState() public {
        timeNow = now;
        if(timeNow > (startTime + 10 seconds)) {
            startTime = timeNow;
            if(stage == Stage.Init) {stage = Stage.Reg; return;}
            if(stage == Stage.Reg) {stage = Stage.Vote; return;}
            if(stage == Stage.Vote) {stage = Stage.Done; return;}
            return;
        }
            
    }
}