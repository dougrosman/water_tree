// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Water.sol"; // Make sure to include the Water contract

contract Tree {
    Water waterContract; // Reference to Water contract

    struct Apple {
        uint256 x;
        uint256 y;
    }

    Apple[] public apples;
    mapping(address => uint256) public waterCount;

    constructor(address waterContractAddress) {
        waterContract = Water(waterContractAddress);
    }

    function waterTree() public {
        require(waterContract.waterBalance(msg.sender) > 0, "Not enough water");
        
        // Decrease user's water balance in Water contract
        waterContract.waterBalance(msg.sender) -= 1; // Update water balance
        
        waterCount[msg.sender] += 1;

        // Every 5 waterings, create an apple
        if (waterCount[msg.sender] % 5 == 0) {
            createApple();
        }
    }

    function createApple() internal {
        // Assuming fixed coordinates for simplicity, can be randomized or calculated
        uint256 x = apples.length * 10; // Example logic for x coordinate
        uint256 y = apples.length * 5;   // Example logic for y coordinate

        apples.push(Apple(x, y));
    }

    function getAppleCount() public view returns (uint256) {
        return apples.length;
    }

    function getAppleCoordinates(uint256 index) public view returns (uint256, uint256) {
        require(index < apples.length, "Apple does not exist");
        return (apples[index].x, apples[index].y);
    }
}
