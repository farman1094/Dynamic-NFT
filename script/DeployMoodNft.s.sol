//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {MoodNft} from "src/MoodNft.sol";
import {Script, console} from "forge-std/script.sol";
import {Base64} from "@openzeppelin/contracts/utils/BASE64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft, string memory) {
        string memory sadSvg = vm.readFile("./img/dynamicNFT/sad.svg");
        string memory happySvg = vm.readFile("./img/dynamicNFT/Smile.svg");

        vm.startBroadcast();
        MoodNft nft = new MoodNft(svgToImageURI(sadSvg), svgToImageURI(happySvg));
        vm.stopBroadcast();
        return (nft, sadSvg);
    }

    function svgToImageURI(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory base64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
        return string(abi.encodePacked(baseURL, base64Encoded));
    }
}
