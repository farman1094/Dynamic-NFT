pragma solidity ^0.8.18;

import {MoodNft} from "src/MoodNft.sol";
import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "script/DeployMoodNft.s.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft public deployer;
    MoodNft public moodNft;
    string public sadSvg;
    address public user = address(0x0);

    function setUp() public {
        deployer = new DeployMoodNft();
        (moodNft, sadSvg) = deployer.run();
        testToConfirmTheURI(sadSvg);
    }

    function testToConfirmTheURI(string memory _sadSvg) public view {
        string memory actual = deployer.svgToImageURI(_sadSvg);
        console.log("actual", actual);
        // assert(keccak256(abi.encodePacked(actual)) == keccak256(abi.encodePacked(expected)));
    }
}
