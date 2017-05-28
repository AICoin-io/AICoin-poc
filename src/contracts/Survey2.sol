pragma solidity ^0.4.8;

contract Survey {

    address owner;

    struct Question
    {
        bytes32 text;
        bytes32[] answerList; // list of answer keys so we can look them up
        uint voteCount; // number of accumulated votes
    }

    mapping(bytes32 => Question) questionStructs; // random access by question key
    bytes32[] questionList; // list of question keys so we can enumerate them

    //only owner
    function newQuestion(bytes32 questionKey, bytes32 text) returns(bool success)
    {
        if (msg.sender == owner)
        {
            // not checking for duplicates
            questionStructs[questionKey].text = text;
            questionList.push(questionKey);
            return true;
        }
        else
        {
            return false;
        }
    }

    function getQuestion(bytes32 questionKey) public constant returns(bytes32 wording, uint answerCount)
    {
        return(questionStructs[questionKey].text, questionStructs[questionKey].answerList.length);
    }

    // onlyOwner
    function addAnswer(bytes32 questionKey, bytes32 answerKey, bytes32 answerText) returns(bool success)
    {
        questionStructs[questionKey].answerList.push(answerKey);
        questionStructs[questionKey].answerStructs[answerKey].text = answerText;
        // answer vote will init to 0 without our help
        return true;
    }

    function getQuestionAnswer(bytes32 questionKey, bytes32 answerKey)
        public
        constant
        returns(bytes32 answerText, uint answerVoteCount)
    {
        return(
            questionStructs[questionKey].answerStructs[answerKey].text,
            questionStructs[questionKey].answerStructs[answerKey].voteCount);
    }

    function getQuestionCount()
        public
        constant
        returns(uint questionCount)
    {
        return questionList.length;
    }

    function getQuestionAtIndex(uint row)
        public
        constant
        returns(bytes32 questionkey)
    {
        return questionList[row];
    }

    function getQuestionAnswerCount(bytes32 questionKey)
        public
        constant
        returns(uint answerCount)
    {
        return(questionStructs[questionKey].answerList.length);
    }

    function getQuestionAnswerAtIndex(bytes32 questionKey, uint answerRow)
        public
        constant
        returns(bytes32 answerKey)
    {
        return(questionStructs[questionKey].answerList[answerRow]);
    }
}