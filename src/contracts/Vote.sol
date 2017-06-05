pragma solidity ^0.4.8;

contract vote {

    address public owner;

    //Only members can vote
    struct Member {
        address member;
        uint weight;
    }

    //Vote
    struct Vote {
        address member; // person delegated to (member)
        uint voteIndex;   // index of the voted proposal
        uint ballotIndex; 
    }

    struct Proposal {
        uint ballotIndex;
        bytes32 name;
        uint voteCount;
        uint256 start;
        uint256 end;
    }

    struct Ballot {
        //mapping(uint => Proposal) proposals; // random access by question key and answer key
        //Proposal[] proposals;
        uint256 start;
        uint256 end;
        bytes32[] proposals;
    }

    //Members
    mapping(address=>Member) public members;

    //Votes
    mapping(address=>Vote) public votes;

    //Proposals, remove
    //Proposal[] public proposals;

    Ballot[] public ballots;


    /// Create a new ballot to choose one of `proposalNames`.
    function addBallot(bytes32[] proposalNames, uint256 _start, uint256 _end) 
    {
        //Only contract owner can excute
        if (msg.sender == owner) 
        {

            // Proposal[5] memory proposals;

            // for (uint i = 0; i < proposalNames.length; i++) {
            //     proposals.push(Proposal({
            //         groupId: groupId,
            //         name: proposalNames[i],
            //         voteCount: 0,
            //         start: _start,
            //         end: _end
            //     }));
            // }

            ballots.push(Ballot(_start, _end, proposalNames));

            // // For each of the provided proposal names,
            // // create a new proposal object and add it
            // // to the end of the array.
            // for (uint i = 0; i < proposalNames.length; i++) {
            //     proposals.push(Proposal({
            //         groupId: groupId;
            //         name: proposalNames[i],
            //         voteCount: 0,
            //         start: start,
            //         end: end
            //     }));
            // }
        }
    }
    
    //vote on the proposal index
    function submitVote(uint ballotIndex)  //, uint proposalIndex
    {
        //Check to see if member is registered
        // if (members[msg.sender] != address(0x0))
        // {
            // if (ballots[ballotIndex].length != 0)
            // {
                Ballot ballot = ballots[ballotIndex];

                if (ballot.start > now && ballot.end < now)
                {
                    
                    Member member = members[msg.sender];
                    ballot.vote += member.weight;
                    
                    //need to assert not voted.
                    //require(!sender.voted);

                    //sender.voted = true;
                    //sender.vote = proposalIndex;
                    //sender.groupId = ballotIndex;
                    
                    //ballot.proposals[proposalIndex].voteCount += sender.weight;
                }
            //}
        //}
    }

    function addWeight(address delegate, uint weight)
    {
        //Only contract owner can excute
        if (msg.sender == owner) {
            Member member = members[msg.sender];
            member.weight += weight;
        }
    } 

    function removeWeight(uint weight)
    {
        //Only contract owner can excute
        if (msg.sender == owner) {
            Member member = members[msg.sender];
            member.weight -= weight;
        }
    }

    function addMember(address publicKey, uint weight) 
    {
        //Check to see if not null
        if (msg.sender == owner) {
            members[publicKey] = Member(publicKey, weight);
        }
    }

    // function removeMember(address publicKey) 
    // {

    // }
}