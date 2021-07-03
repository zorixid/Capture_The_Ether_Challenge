pragma solidity ^0.4.21;

contract GuessTheRandomNumberChallenge {
    uint8 answer;
    uint256 public blockNumber = block.number;
    bytes32 public blockHash;
    uint256 currentTimestamp = now;

    function blockNumber() public view returns (uint256) {
        blockNumber = block.number;
        return blockNumber;
    }

    function getAnswerFromBlock(uint256 _blockHash, uint256 _timeStamp)
        public
        view
        returns (uint8)
    {
        // answer = uint8(keccak256(_val, now));
        answer = uint8(keccak256(_blockHash, _timeStamp));
        return answer;
    }

    function blockHash() public view returns (bytes32) {
        blockHash = block.blockhash(block.number - 1);
        return blockHash;
    }

    function timestamp() public view returns (uint256) {
        currentTimestamp = now;
        return currentTimestamp;
    }
}
