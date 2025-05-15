// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.23;

import "lib/forge-std/src/Script.sol";
import {DeployInitHelper} from "./DeployInitHelper.sol";
import {DeployFactory} from "src/test/DeployFactory.sol";
import {Storage} from "src/Storage.sol";
import {ECDSAValidator} from "src/validator/ECDSAValidator.sol";
import {WalletCore} from "src/WalletCore.sol";

/// @title DeployInit
/// @notice A script for deploying, initializing, and setting the access controls
contract DeployInit is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("DEPLOYER_PRIVATE_KEY"));

        address deployOwner = vm.addr(vm.envUint("DEPLOYER_PRIVATE_KEY"));
        console.log("Deploy owner: %s", deployOwner);

        DeployFactory deployFactory = DeployFactory(
            vm.envAddress("DEPLOY_FACTORY_ADDRESS")
        );
        bytes32 deployFactorySalt = vm.envBytes32("DEPLOY_FACTORY_SALT");
        console.log("Deploy factory address: %s", address(deployFactory));
        console.log("Deploy factory salt:");
        console.logBytes32(deployFactorySalt);

        string memory walletCoreName = "wallet-core";
        string memory walletCoreVersion = "1.0.0";
        console.log("WalletCore name: %s", walletCoreName);
        console.log("WalletCore version: %s", walletCoreVersion);

        address storage_;
        address ecdsaValidator_;
        address walletCore_;

        (storage_, ecdsaValidator_, walletCore_) = DeployInitHelper
            .deployContracts(
                deployFactory,
                deployFactorySalt,
                walletCoreName,
                walletCoreVersion
            );

        console.log("WalletCore address: %s", walletCore_);
        console.log("Storage address: %s", storage_);
        console.log("ECDSAValidator address: %s", ecdsaValidator_);
        console.log("Completed DeployInit script");
        vm.stopBroadcast();
    }
}
