pragma solidity ^0.4.11;

contract SingleVote {

    uint256 public totalSupply;
    address public owner;
    string public standard = '';
    string public name = 'AI Coin';

    function SingleVote(bytes32[] proposalNames, uint256 _start, uint256 _end)
    {
        owner = msg.sender;
        totalSupply = 100000;

        balances[msg.sender] = totalSupply;

        //require(msg.sender == owner);

        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                start: _start,
                end: _end,
                voteCount: 0
            }));
        }
    }

    function transfer(address _to, uint256 _value) returns (bool success) {
        if (_to == 0x0) throw;
        if (balances[msg.sender] >= _value && _value > 0) 
        {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        } 
        else 
        { 
            return false; 
        }
    }

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

    //Create a new ballot to choose one of `proposalNames`.
    //Not used
    function AddBallot(bytes32[] proposalNames, uint256 _start, uint256 _end) {
        //Only contract owner can excute
        //if (msg.sender == owner) {
            require(msg.sender == owner);
            for (uint i = 0; i < proposalNames.length; i++) {
                proposals.push(Proposal({
                    name: proposalNames[i],
                    start: _start,
                    end: _end,
                    voteCount: 0
                }));
            }
        //}
    }
    
    //vote on the proposal index
    function Vote(uint proposalIndex) 
    {
        bool alreadyVoted = voted[msg.sender];
        if (alreadyVoted == false) {

            Proposal proposal = proposals[proposalIndex];

            uint256 weight = balanceOf(msg.sender);
            proposal.voteCount += weight;
        }
    }

    //Votes
    mapping (address => bool) public voted;

    //Proposal options
    Proposal[] public proposals;
}