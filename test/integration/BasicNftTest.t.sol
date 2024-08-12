//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {BasicNft} from "src/BasicNft.sol";
import {Test} from "forge-std/Test.sol";
import {DeployNFT} from "script/DeployNFT.s.sol";

contract BasicNftTest is Test {
    DeployNFT public deployer;
    BasicNft public nft;
    address public user = makeAddr("user");
    string public constant FUTURISTIC_BILLU =
        "https://bafybeif7oyb54yuxmx7rrivlvtzqwwtm3lnaiuev55y4gmigmmdbfri67i.ipfs.dweb.link/";

    function setUp() public {
        deployer = new DeployNFT();
        nft = deployer.run();
    }

    function testNameAndSymbol() external view {
        //strings are array of bytes
        //bytes arrays are not comparable
        // we can only compare permitive types and elimintary types
        //(like uint256, address, bool, bytes32, etc)

        // assertEq(nft.name(), "BilluGang");
        // assertEq(nft.symbol(), "BLG");

        // we can compare it by looping it through the string and comparing each character
        // OR we can compare hash of the strings
        string memory name = "BilluGang";
        bytes32 nameHash = keccak256(abi.encodePacked(name));
        bytes32 nftNameHash = keccak256(abi.encodePacked(nft.name()));

        string memory symbol = "BLG";
        bytes32 symbolHash = keccak256(abi.encodePacked(symbol));
        bytes32 nftsymbolHash = keccak256(abi.encodePacked(nft.symbol()));

        // assert(nameHash == nftNameHash);
        assertEq(symbolHash, nftsymbolHash);
        assertEq(nameHash, nftNameHash);
    }

    // function test_mintNFT() external {
    //     BasicNft nft = new BasicNft();
    //     nft.mintNFT("testURI");
    //     assertEq(nft.tokenURI(0), "testURI");
    // }
    function testCanMintAndHaveBalance() public {
        // act / arrang
        vm.prank(user);
        nft.mintNFT(FUTURISTIC_BILLU);

        // Assert
        assert(nft.balanceOf(user) == 1);
        assert(keccak256(abi.encodePacked(nft.tokenURI(0))) == keccak256(abi.encodePacked(FUTURISTIC_BILLU)));
    }
}
