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
        uint vote;   // index of the voted proposal
        uint groupId; 
    }

    struct Proposal {
        uint groupId;
        bytes32 name;
        uint voteCount;
        uint256 start;
        uint256 end;
    }

    struct Ballot {
        Proposal[] proposal;
        uint256 start;
        uint256 end;
    }

    //Members
    mapping(address=>Member) public members;

    //Votes
    mapping(address=>Vote) public votes;

    //Proposals, remove
    //Proposal[] public proposals;

    Ballot[] public ballots;

    /// Create a new ballot to choose one of `proposalNames`.
    function AddBallot(uint groupId, bytes32[] proposalNames, uint256 _start, uint256 _end) {
        //Only contract owner can excute
        if (msg.sender == owner) {

            Proposal[] proposals;

            for (uint i = 0; i < proposalNames.length; i++) {
                proposals.push(Proposal({
                    groupId: groupId,
                    name: proposalNames[i],
                    voteCount: 0,
                    start: start,
                    end: end
                }));
            }

            Ballot ballot {
                proposals: proposal,
                start: _start,
                end: _end
            };

            ballots.push(option);

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
    function vote(uint ballotIndex, uint proposalIndex) 
    {
        //Check to see if member is registered
        if (member[msg.sender].length != 0])
        {
            if (ballots[ballotIndex].length != 0)
            {
                Ballot ballot = ballots[ballotIndex];

                if (ballot.start > now && ballot.end < now)
                {
                    Member sender = members[msg.sender];

                    //need to assert not voted.
                    require(!sender.voted);

                    sender.voted = true;
                    sender.vote = proposal;
                    sender.groupId = groupId;
                    
                    ballot.proposals[proposalIndex].voteCount += sender.weight;
                }
            }
        }
    }

    function addWeight(address delegate, uint weight)
    {
        //Only contract owner can excute
        if (msg.sender == owner) {
            Member member = members[msg.sender];
            member.weight += weight;
        }
    } 

    function removeWeight()
    {
        //Only contract owner can excute
        if (msg.sender == owner) {
            Voter member = voters[msg.sender];
            member.weight -= weight;
        }
    }

    function addMembers(address member, uint weight) {
        //Only contract owner can excute
        if (msg.sender == owner) {
            Voter newMember = Voter(member, weight);
            voters[member] = newMember;
        }
    }

    function removeMember(address member) {

    }
}