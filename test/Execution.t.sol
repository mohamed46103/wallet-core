// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.23;

import "./Base.t.sol";
import "src/lib/Errors.sol";

contract ExecutionTest is Base {
    function setUp() public override {
        super.setUp();
    }

    function test_executeFromSelf_succeeds_for_owner() public {
        vm.prank(_alice);
        Call[] memory calls = _construct_calls_data();
        IWalletCore(_alice).executeFromSelf(calls);
    }

    function test_executeFromSelf_reverts_for_non_owner() public {
        vm.prank(_bob);
        Call[] memory calls = _construct_calls_data();
        vm.expectRevert(abi.encodeWithSelector(Errors.NotFromSelf.selector));
        IWalletCore(_alice).executeFromSelf(calls);
    }

    function test_execute_reverts_on_failed_call() public {
        vm.prank(_alice);
        Call[] memory calls = new Call[](2);
        calls[0] = Call({target: _bob, value: 1 ether, data: ""});
        calls[1] = Call({target: _bob, value: 1000 ether, data: ""}); // will fail
        vm.expectRevert(
            abi.encodeWithSelector(Errors.CallFailed.selector, 1, "")
        );
        IWalletCore(_alice).executeFromSelf(calls);
    }
}
