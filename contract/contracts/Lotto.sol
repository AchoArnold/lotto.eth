//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Lotto {
    uint private lastBlock;
    uint private seed;

    constructor() payable {
        /*
         * Set the initial seed used for random number generation
         */
        seed = (block.timestamp + block.difficulty) % 100;
    }
    
    function play(uint[] memory numbers ) payable public {
        validateEntry(numbers);
    }
    
    function validateEntry(uint[] memory numbers) private pure {
        require(numbers.length == 6, "lotto must have only 6 numbers");
        
        // check range of numbers
        for (uint i=0; i<numbers.length; i++) {
            require(numbers[i] >= 1 && numbers[i] <= 50, "numbers must be between [1, 50] inclusive");
        }
        
        isUnique(numbers);
    }
    
    function isUnique(uint[] memory numbers) private pure {
        for (uint i=0; i<numbers.length; i++) {
            for (uint j=i+1; j<numbers.length; j++) {
                require(numbers[i] != numbers[j], "the input cannot have duplicate entries.");
            }
        }
    }

    function sort(uint[] memory data) private pure returns(uint[] memory) {
        quickSort(data, int(0), int(data.length - 1));
        return data;
    }

    function quickSort(uint[] memory arr, int left, int right) private pure{
        int i = left;
        int j = right;
        if(i==j) return;
        uint pivot = arr[uint(left + (right - left) / 2)];
        while (i <= j) {
            while (arr[uint(i)] < pivot) i++;
            while (pivot < arr[uint(j)]) j--;
            if (i <= j) {
                (arr[uint(i)], arr[uint(j)]) = (arr[uint(j)], arr[uint(i)]);
                i++;
                j--;
            }
        }
        if (left < j)
            quickSort(arr, left, j);
        if (i < right)
            quickSort(arr, i, right);
    }
}
