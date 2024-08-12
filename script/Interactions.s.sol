// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "src/BasicNft.sol";
import {MoodNft} from "src/MoodNft.sol";

contract MintBasicNft is Script {
    string public constant FUTURISTIC_BILLU = "ipfs://QmYfxGvpTWZQqEvDW8in7dCgo5d7MjmudTYnNRjesPa9Bx";

    function run() external {
        // error in devops tools
        // address mostRecentlyDeployed =  DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        address mostRecentlyDeployed = 0xf6292628c6fFf527CBDeb0081179C06d9B8cb1B5;
        // require(mostRecentlyDeployed != address(0), "Deployment not found.");

        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNFT(FUTURISTIC_BILLU);
        vm.stopBroadcast();
    }
}

contract MintMoodNft is Script {
    function run() external {
        // error in devops tools
        // address mostRecentlyDeployed =  DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        address mostRecentlyDeployed = 0x408862F8B0ccBFd6903F7A87121D18B337AFFF5B;
        // require(mostRecentlyDeployed != address(0), "Deployment not found.");

        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        MoodNft(contractAddress).mintNFT();
        vm.stopBroadcast();
    }
}
//dad
