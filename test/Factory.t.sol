// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.23;

import "./Base.t.sol";
import "src/lib/Errors.sol";
import {Storage} from "../src/Storage.sol";

contract FactoryTest is Base {
    function setUp() public override {
        super.setUp();
    }

    function test_double_deploy() external {
        bytes32 deployFactorySalt = vm.envBytes32("DEPLOY_FACTORY_SALT");
        (
            address _storageAddr,
            address _ecdsaValidatorAddr,
            address _walletCoreAddr
        ) = DeployInitHelper.deployContracts(
                deployFactory,
                deployFactorySalt,
                NAME,
                VERSION
            );

        assertEq(address(_storageAddr), address(_storageImpl));
        assertEq(address(_ecdsaValidatorAddr), address(_ecdsaValidatorImpl));
        assertEq(address(_walletCoreAddr), address(_walletCore));
    }
}
