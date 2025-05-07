// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.23;

import {Storage} from "src/Storage.sol";
import {WalletCore} from "src/WalletCore.sol";
import {ECDSAValidator} from "src/validator/ECDSAValidator.sol";
import {DeployFactory} from "src/test/DeployFactory.sol";
import "lib/forge-std/src/Test.sol";
import {Create2} from "@openzeppelin/contracts/utils/Create2.sol";

library DeployInitHelper {
    function deployWalletCore(
        DeployFactory deployFactory,
        bytes32 deployFactorySalt,
        string memory walletCoreName,
        string memory walletCoreVersion,
        address storageAddr
    ) public returns (address payable) {
        return
            _deployIfNeeded(
                deployFactory,
                abi.encodePacked(
                    type(WalletCore).creationCode,
                    abi.encode(storageAddr, walletCoreName, walletCoreVersion) // constructor args
                ),
                deployFactorySalt
            );
    }

    function deployStorage(
        DeployFactory deployFactory,
        bytes32 deployFactorySalt
    ) public returns (address payable) {
        return
            _deployIfNeeded(
                deployFactory,
                type(Storage).creationCode,
                deployFactorySalt
            );
    }

    function deployEcdsaValidator(
        DeployFactory deployFactory,
        bytes32 deployFactorySalt
    ) public returns (address payable) {
        return
            _deployIfNeeded(
                deployFactory,
                type(ECDSAValidator).creationCode,
                deployFactorySalt
            );
    }

    function _deployIfNeeded(
        DeployFactory deployFactory,
        bytes memory bytecode,
        bytes32 salt
    ) internal returns (address payable) {
        address derivedAddress = Create2.computeAddress(
            salt,
            keccak256(bytecode),
            address(deployFactory)
        );
        uint256 codeSize = derivedAddress.code.length;

        if (codeSize > 0) {
            console.log("Skipping deployment for: %s", derivedAddress);
            return payable(derivedAddress);
        }
        return deployFactory.deploy(bytecode, salt);
    }
}
