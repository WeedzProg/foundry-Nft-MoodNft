// SPDX-License-Identifier:MIT

pragma solidity ^0.8.17;

import {Script, console} from "forge-std/Script.sol";
import {DeployBasicNFT} from "../script/DeployBasicNFT.s.sol";
import {DeployMoodNFT} from "../script/DeployMoodNFT.s.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {MoodNFT} from "../src/MoodNFT.sol";

//import {HelperConfig} from "./HelperConfig.s.sol";

contract MintNft is Script {
    address basicNFT = 0x7fdC673352cb7b8Efa1EB69A28DDe4FA2e1D0A8C;
    string public constant nftToMint =
        "https://ipfs.io/ipfs/QmVgSy6srMb5irWZZy44hettZHcd9m3x7Wea3hi9JZsBVb?filename=puppy.json";
    uint256 deployerKey;

    function run() external {
        address mostRecentlyDeployedBasicNft = basicNFT;
        // address mostRecentlyDeployedBasicNft = DevOpsTools.get_most_recent_deployment(
        //     "BasicNFT",
        //     block.chainid
        // );
        MintNftConfig(mostRecentlyDeployedBasicNft);
    }

    function MintNftConfig(address contractAddress) public {
        console.log("Minting BasicNft st-bernard on chainID: ", block.chainid);
        vm.startBroadcast();
        BasicNFT(contractAddress).mintNFT(nftToMint);
        vm.stopBroadcast();

        console.log("NFT URI %s : ", nftToMint);
    }
}

contract MintMoodNft is Script {
    address moodNFT = 0xd05690b47dC2D1e1743e40FbE7b615AFEE2a2cD6;

    function run() external {
        address mostRecentlyDeployedBasicNft = moodNFT;
        // address mostRecentlyDeployedBasicNft = DevOpsTools.get_most_recent_deployment(
        //     "BasicNFT",
        //     block.chainid
        // );
        //MintNftConfig(mostRecentlyDeployedBasicNft);
        FlipConfig(mostRecentlyDeployedBasicNft);
    }

    function MintNftConfig(address contractAddress) public {
        console.log("Minting Happy_svg on chainID: ", block.chainid);
        vm.startBroadcast();
        MoodNFT(contractAddress).mintNft();
        vm.stopBroadcast();

        console.log("NFT Minted ");
    }

    function FlipConfig(address contractAddress) public {
        console.log("Flipping Happy_svg to Sad_svg on chainID: ", block.chainid);
        vm.startBroadcast();
        MoodNFT(contractAddress).flipMood(0);
        vm.stopBroadcast();

        console.log("NFT Flipped ");
    }
}
