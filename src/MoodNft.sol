//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    //errors
    error MoodNft__OnlyOwnerCanChangeMood();

    enum Mood {
        HAPPY,
        SAD
    }

    uint256 private s_tokenCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(string memory sadSvgImageUri, string memory happySvgImageUri) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_sadSvgImageUri = sadSvgImageUri;
        s_happySvgImageUri = happySvgImageUri;
    }

    function mintNFT() public {
        uint256 newItemId = s_tokenCounter;
        _safeMint(msg.sender, newItemId);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenID) public {
        //only owner can change mood
        //isOwner has been change to is authorized
        if (!_isAuthorized(msg.sender, msg.sender, tokenID)) {
            revert MoodNft__OnlyOwnerCanChangeMood();
        }
        if (s_tokenIdToMood[tokenID] == Mood.HAPPY) {
            s_tokenIdToMood[tokenID] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenID] = Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenID) public view override returns (string memory) {
        string memory imageUri;
        if (s_tokenIdToMood[tokenID] == Mood.HAPPY) {
            imageUri = s_happySvgImageUri;
        } else {
            imageUri = s_sadSvgImageUri;
        }
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name": "',
                            name(),
                            '","description":"An NFT that reflects the owner mood", "attributes":[{"trait_type": "moodiness", "value": 100}], "image": "',
                            imageUri,
                            '"}'
                        )
                    )
                )
            )
        );
        // name {"name": "Mood NFT"}
    }
    //Getter Functions

    function getMoodStatus() external view returns (Mood) {
        return s_tokenIdToMood[0];
    }
}
