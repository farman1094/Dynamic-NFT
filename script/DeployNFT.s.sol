//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {BasicNft} from "src/BasicNft.sol";
import {Script} from "forge-std/script.sol";

contract DeployNFT is Script {
    function run() external returns (BasicNft) {
        vm.startBroadcast();
        BasicNft nft = new BasicNft();
        vm.stopBroadcast();
        return nft;
    }
}
