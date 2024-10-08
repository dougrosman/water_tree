// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Water {
    mapping(address => uint256) public waterBalance;
    mapping(address => uint256) public lastRequestTime;
    uint256 public constant MAX_WATER_PER_DAY = 5;

    function getWater() public {
        require(canGetWater(msg.sender), "Daily limit reached");

        waterBalance[msg.sender] += 1;
        lastRequestTime[msg.sender] = block.timestamp;
    }

    function canGetWater(address user) public view returns (bool) {
        if (block.timestamp >= lastRequestTime[user] + 1 days) {
            return true; // Reset the count if the day has passed
        }
        return waterBalance[user] < MAX_WATER_PER_DAY;
    }
}
