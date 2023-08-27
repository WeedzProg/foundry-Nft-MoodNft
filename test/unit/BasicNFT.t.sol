//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {BasicNFT} from "../../src/BasicNFT.sol";
import {DeployBasicNFT} from "../../script/DeployBasicNFT.s.sol";

contract BasicNFTTest is Test {
    BasicNFT public basicNFT;
    address private USER = makeAddr("user");

    function setUp() public {
        DeployBasicNFT deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    function testNameIsCorrect() public {
        string memory expectedName = "BasicNFT";
        string memory actualName = basicNFT.name();

        bytes memory encodeExpected = abi.encodePacked(expectedName);
        bytes memory encodeActual = abi.encodePacked(actualName);

        bytes32 expectedHash = keccak256(encodeExpected);
        bytes32 actualHash = keccak256(encodeActual);

        assertEq(expectedHash, actualHash);
    }

    function testCanMintAndHaveABalance() public {
        string
            memory nftToMint = "https://ipfs.io/ipfs/QmVgSy6srMb5irWZZy44hettZHcd9m3x7Wea3hi9JZsBVb?filename=puppy.json";
        vm.prank(USER);
        vm.deal(USER, 100 ether);
        basicNFT.mintNFT(nftToMint);
        assertEq(basicNFT.balanceOf(USER), 1);

        assert(
            keccak256(abi.encodePacked(basicNFT.tokenURI(0))) ==
                keccak256(abi.encodePacked(nftToMint))
        );
    }
}
