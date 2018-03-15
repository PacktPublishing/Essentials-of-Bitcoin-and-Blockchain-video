pragma solidity ^0.4.17;

contract VotingCycle {
    struct VoterCitizen {
        uint weight;
        bool voted;
        uint8 vote;
        //address delegate;
    }
    
    struct Proposal {
        uint totalVotes;
    }
    
    address chairPerson;
    mapping(address => VoterCitizen) citizens;
    Proposal[] proposals;
    
    function VotingCycle(uint8 _numProposals) public {
        chairPerson = msg.sender;
        citizens[chairPerson].weight = 1;
        proposals.length = _numProposals;
    }
    
    function allocateBallot(address _votingCitizen) public {
        require(msg.sender == chairPerson);
        citizens[_votingCitizen].weight = 1;
        //
    }
    
    function registerVote(uint8 _toProposal) public {
        VoterCitizen storage currentVoter = citizens[msg.sender];
        require(currentVoter.voted == false && _toProposal < proposals.length);
        currentVoter.voted = true;
        currentVoter.vote = _toProposal;
        proposals[_toProposal].totalVotes += currentVoter.weight;
    }
    
    function getVotingResults() public view returns (uint8 _finalWonProposal) {
        uint256 wonVoteCount = 0;
        for (uint8 tmpProp = 0; tmpProp < proposals.length; tmpProp++) {
            if (proposals[tmpProp].totalVotes > wonVoteCount) {
                wonVoteCount = proposals[tmpProp].totalVotes;
                _finalWonProposal = tmpProp;
            }
        }
    }
}