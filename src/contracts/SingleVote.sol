pragma solidity ^0.4.8;

contract SingleVote {

    address public owner;

    struct Member {
        address member;
        uint weight;
        bool voted;
        uint proposalIndex;
    }

    struct Proposal {
        bytes32 name;
        uint256 start;
        uint256 end;
        uint voteCount;
    }

    //Members
    mapping(address=>Member) public members;

    //Proposal options
    Proposal[] public proposals;

    /// Create a new ballot to choose one of `proposalNames`.
    function AddBallot(bytes32[] proposalNames, uint256 _start, uint256 _end) {
        //Only contract owner can excute
        if (msg.sender == owner) {
            for (uint i = 0; i < proposalNames.length; i++) {
                proposals.push(Proposal({
                    name: proposalNames[i],
                    start: _start,
                    end: _end,
                    voteCount: 0
                }));
            }
        }
    }
    
    //vote on the proposal index
    function vote(uint proposalIndex) 
    {
        //Check to see if member is registered
        //if (members[msg.sender].length != 0)
        //{
            Member sender = members[msg.sender];
            sender.voted = true;
            sender.proposalIndex = proposalIndex;

            Proposal proposal = proposals[proposalIndex];
            proposal.voteCount += sender.weight;
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

    function addMembers(address member, uint weight) {
        //Only contract owner can excute
        if (msg.sender == owner) {
            Member memory newMember = Member(member, weight, false, 0);
            members[member] = newMember;
        }
    }

    // function removeMember(address member) {

    // }
}