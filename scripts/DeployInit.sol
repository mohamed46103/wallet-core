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

        storage_ = vm.envOr("STORAGE_ADDRESS", address(0));
        if (storage_ == address(0)) {
            storage_ = DeployInitHelper.deployStorage(
                deployFactory,
                deployFactorySalt
            );
        } else {
            console.log("Skipped STORAGE_ADDRESS deployment...");
        }

        ecdsaValidator_ = vm.envOr("ECDSA_VALIDATOR_ADDRESS", address(0));
        if (ecdsaValidator_ == address(0)) {
            ecdsaValidator_ = DeployInitHelper.deployEcdsaValidator(
                deployFactory,
                deployFactorySalt
            );
        } else {
            console.log("Skipped ECDSA_VALIDATOR_ADDRESS deployment...");
        }

        walletCore_ = DeployInitHelper.deployWalletCore(
            deployFactory,
            deployFactorySalt,
            walletCoreName,
            walletCoreVersion,
            storage_
        );

        console.log("WalletCore address: %s", address(walletCore_));
        console.log("Storage address: %s", address(storage_));
        console.log("ECDSAValidator address: %s", address(ecdsaValidator_));
        console.log("Completed DeployInit script");
        vm.stopBroadcast();
    }
}
