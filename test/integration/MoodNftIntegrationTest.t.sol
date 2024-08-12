//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {MoodNft} from "src/MoodNft.sol";
import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "script/DeployMoodNft.s.sol";

contract MoodNftIntegrationTest is Test {
    DeployMoodNft public deployer;
    MoodNft public moodNft;
    address public user = makeAddr("user");

    function setUp() public {
        deployer = new DeployMoodNft();
        (moodNft,) = deployer.run();
    }

    modifier minted() {
        vm.prank(user);
        moodNft.mintNFT();
        _;
    }

    function testTokenURIReturningCorrectUri() public minted {
        string memory imageUri = moodNft.tokenURI(0);
        if (bytes(imageUri).length == 0) {
            revert("String is empty");
        }
        // The string is not empty
    }
    // console.log(moodNft.tokenURI(0));
    // assert(keccak256(abi.encodePacked(actual)) == keccak256(abi.encodePacked(expected)));

    function testFlipTokenToSad() public minted {
        // arranage
        vm.prank(user);
        console.log(uint256(moodNft.getMoodStatus())); //happy
        //act
        string memory expected =
            "data:application/json;base64,eyJuYW1lIjogIk1vb2QgTkZUIiwiZGVzY3JpcHRpb24iOiJBbiBORlQgdGhhdCByZWZsZWN0cyB0aGUgb3duZXIgbW9vZCIsICJhdHRyaWJ1dGVzIjpbeyJ0cmFpdF90eXBlIjogIm1vb2RpbmVzcyIsICJ2YWx1ZSI6IDEwMH1dLCAiaW1hZ2UiOiAiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQRDk0Yld3Z2RtVnljMmx2YmowaU1TNHdJaUJ6ZEdGdVpHRnNiMjVsUFNKdWJ5SS9QZzBLUEhOMlp5QjNhV1IwYUQwaU1UQXlOSEI0SWlCb1pXbG5hSFE5SWpFd01qUndlQ0lnZG1sbGQwSnZlRDBpTUNBd0lERXdNalFnTVRBeU5DSWdlRzFzYm5NOUltaDBkSEE2THk5M2QzY3Vkek11YjNKbkx6SXdNREF2YzNabklqNE5DaUFnUEhCaGRHZ2dabWxzYkQwaUl6TXpNeUlnWkQwaVRUVXhNaUEyTkVNeU5qUXVOaUEyTkNBMk5DQXlOalF1TmlBMk5DQTFNVEp6TWpBd0xqWWdORFE0SURRME9DQTBORGdnTkRRNExUSXdNQzQySURRME9DMDBORGhUTnpVNUxqUWdOalFnTlRFeUlEWTBlbTB3SURneU1HTXRNakExTGpRZ01DMHpOekl0TVRZMkxqWXRNemN5TFRNM01uTXhOall1Tmkwek56SWdNemN5TFRNM01pQXpOeklnTVRZMkxqWWdNemN5SURNM01pMHhOall1TmlBek56SXRNemN5SURNM01ub2lMejROQ2lBZ1BIQmhkR2dnWm1sc2JEMGlJMFUyUlRaRk5pSWdaRDBpVFRVeE1pQXhOREJqTFRJd05TNDBJREF0TXpjeUlERTJOaTQyTFRNM01pQXpOekp6TVRZMkxqWWdNemN5SURNM01pQXpOeklnTXpjeUxURTJOaTQySURNM01pMHpOekl0TVRZMkxqWXRNemN5TFRNM01pMHpOeko2VFRJNE9DQTBNakZoTkRndU1ERWdORGd1TURFZ01DQXdJREVnT1RZZ01DQTBPQzR3TVNBME9DNHdNU0F3SURBZ01TMDVOaUF3ZW0wek56WWdNamN5YUMwME9DNHhZeTAwTGpJZ01DMDNMamd0TXk0eUxUZ3VNUzAzTGpSRE5qQTBJRFl6Tmk0eElEVTJNaTQxSURVNU55QTFNVElnTlRrM2N5MDVNaTR4SURNNUxqRXRPVFV1T0NBNE9DNDJZeTB1TXlBMExqSXRNeTQ1SURjdU5DMDRMakVnTnk0MFNETTJNR0U0SURnZ01DQXdJREV0T0MwNExqUmpOQzQwTFRnMExqTWdOelF1TlMweE5URXVOaUF4TmpBdE1UVXhMalp6TVRVMUxqWWdOamN1TXlBeE5qQWdNVFV4TGpaaE9DQTRJREFnTUNBeExUZ2dPQzQwZW0weU5DMHlNalJoTkRndU1ERWdORGd1TURFZ01DQXdJREVnTUMwNU5pQTBPQzR3TVNBME9DNHdNU0F3SURBZ01TQXdJRGsyZWlJdlBnMEtJQ0E4Y0dGMGFDQm1hV3hzUFNJak16TXpJaUJrUFNKTk1qZzRJRFF5TVdFME9DQTBPQ0F3SURFZ01DQTVOaUF3SURRNElEUTRJREFnTVNBd0xUazJJREI2YlRJeU5DQXhNVEpqTFRnMUxqVWdNQzB4TlRVdU5pQTJOeTR6TFRFMk1DQXhOVEV1Tm1FNElEZ2dNQ0F3SURBZ09DQTRMalJvTkRndU1XTTBMaklnTUNBM0xqZ3RNeTR5SURndU1TMDNMalFnTXk0M0xUUTVMalVnTkRVdU15MDRPQzQySURrMUxqZ3RPRGd1Tm5NNU1pQXpPUzR4SURrMUxqZ2dPRGd1Tm1NdU15QTBMaklnTXk0NUlEY3VOQ0E0TGpFZ055NDBTRFkyTkdFNElEZ2dNQ0F3SURBZ09DMDRMalJETmpZM0xqWWdOakF3TGpNZ05UazNMalVnTlRNeklEVXhNaUExTXpONmJURXlPQzB4TVRKaE5EZ2dORGdnTUNBeElEQWdPVFlnTUNBME9DQTBPQ0F3SURFZ01DMDVOaUF3ZWlJdlBnMEtQQzl6ZG1jKyJ9";
        moodNft.flipMood(0); // conversion
        string memory actual = moodNft.tokenURI(0);

        //assert (sad)
        assert(keccak256(abi.encodePacked(actual)) == keccak256(abi.encodePacked(expected)));
        assert(uint256(moodNft.getMoodStatus()) == uint256(MoodNft.Mood.SAD));
    }
}

//0x408862F8B0ccBFd6903F7A87121D18B337AFFF5B address
