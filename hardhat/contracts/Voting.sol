//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Voting {
    address public right_assigner;

    struct Voter {
        bool hasRight;
        bool voted;
        uint voteCandidate;
    }
    mapping(address => Voter) public voters;

    struct Candidate {
        bytes32 name;
        uint256 voteCount;
    }
    Candidate[] public candidates;

    constructor(bytes32[] memory candidatesNames) {
        right_assigner = msg.sender;
        voters[right_assigner].hasRight = true;

        for(uint256 i = 0; i < candidatesNames.length; i++){
            candidates.push(Candidate({
                name: candidatesNames[i],
                voteCount: 0
            }));
        }
    }

    function assignRight(address voter) public {
        require(right_assigner == msg.sender, "You are not authorised to assign vote right!");
        require(voters[voter].voted != true, "You just have 1 vote!");
        require(voters[voter].hasRight != true, "You don't have the right to vote");
        voters[voter].hasRight = true;
    }
    
    function vote(uint256 voting) public {
        require(voters[msg.sender].hasRight == true, "You don't have the right to vote!");
        require(voters[msg.sender].voted != true, "You just have 1 vote!");
        voters[msg.sender].voted = true;
        voters[msg.sender].voteCandidate = voting;

        candidates[voting].voteCount += 1;
    }

    
    //uint higherguys = 0;
    function winner() public view returns(uint higherguys_) {
        require(msg.sender == right_assigner, "Votes haven't been announced!");

        uint256 highestVotes = 0;
        for(uint256 j = 0; j < candidates.length; j++ ){
            if(candidates[j].voteCount > highestVotes){
                highestVotes = candidates[j].voteCount;
                higherguys_ = j;
            }
        }
    }

    function announceWinner() view public returns(bytes32 winnername_) {
        winnername_ = candidates[winner()].name;
    }
}