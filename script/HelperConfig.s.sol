// SPDX-License-Identifier:MIT

pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script {
    NetworkConfig public activeNetwork;

    string private constant nftToMint =
        "https://ipfs.io/ipfs/QmVgSy6srMb5irWZZy44hettZHcd9m3x7Wea3hi9JZsBVb?filename=puppy.json";

    uint256 chainId = block.chainid;
    struct NetworkConfig {
        uint256 deployerKey;
    }

    uint256 public constant ANVIL_KEY =
        0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    constructor() {
        if (chainId == 11155111) {
            activeNetwork = sepoliaNetwork();
        } else if (chainId == 80001) {
            activeNetwork = mumbaiNetwork();
        } else if (chainId == 1) {
            activeNetwork = ethMainnetFork();
        } else {
            activeNetwork = anvilNetwork();
        }
    }

    function anvilNetwork() public returns (NetworkConfig memory /*anvilEthUsd*/) {
        NetworkConfig memory anvilVRF = NetworkConfig({deployerKey: ANVIL_KEY});

        return anvilVRF;
    }

    function sepoliaNetwork() public returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaVRF = NetworkConfig({
            deployerKey: vm.envUint("PRIVATE_KEY_TESTNET")
        });

        return sepoliaVRF;
    }

    function mumbaiNetwork() public returns (NetworkConfig memory) {
        NetworkConfig memory mumbaiVRF = NetworkConfig({
            deployerKey: vm.envUint("PRIVATE_KEY_TESTNET")
        });

        return mumbaiVRF;
    }

    function ethMainnetFork() public returns (NetworkConfig memory) {
        NetworkConfig memory mainnetVRF = NetworkConfig({
            deployerKey: vm.envUint("PRIVATE_KEY_TESTNET")
        });

        return mainnetVRF;
    }
}
