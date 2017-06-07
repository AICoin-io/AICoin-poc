pragma solidity ^0.4.8;

contract SingleVote {

    uint256 public totalSupply;
    address public owner;

    function SingleVote()
    {
        owner = msg.sender;
        totalSupply = 100000;

        balances[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value) returns (bool success) {
        if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        } else { return false; }
    }

    // function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
    //     if (balances[_from] >= _value && _value > 0) {
    //         balances[_to] += _value;
    //         balances[_from] -= _value;
    //         Transfer(_from, _to, _value);
    //         return true;
    //     } else { return false; }
    // }

    function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner];
    }

    mapping (address => uint256) balances;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    //voting
    struct Proposal {
        bytes32 name;
        uint256 start;
        uint256 end;
        uint256 voteCount;
    }

    struct Member {
        address member;
        bool voted;
        //uint proposalIndex;
    }

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
    function Vote(uint proposalIndex) 
    {
        //Check to see if member is registered
        //if (members[msg.sender].length != 0)
        //{
            Member sender = members[msg.sender];
            sender.voted = true;

            Proposal proposal = proposals[proposalIndex];

            uint256 weight = balanceOf(msg.sender);
            proposal.voteCount += weight;
        //}
    }

    //Members
    mapping(address=>Member) public members;

    //Proposal options
    Proposal[] public proposals;
}