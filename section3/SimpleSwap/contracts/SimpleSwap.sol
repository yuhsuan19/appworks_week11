// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { ISimpleSwap } from "./interface/ISimpleSwap.sol";
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SimpleSwap is ISimpleSwap, ERC20 {

    address private _tokenA;
    address private _tokenB;

    uint256 private _reserveA;
    uint256 private _reserveB;

    constructor(address tokenA, address tokenB) ERC20("SimpleSwap", "SimpleLP") {
        require(isERC20Contract(tokenA), "SimpleSwap: TOKENA_IS_NOT_CONTRACT");
        require(isERC20Contract(tokenB), "SimpleSwap: TOKENB_IS_NOT_CONTRACT");
        require((tokenA != tokenB), "SimpleSwap: TOKENA_TOKENB_IDENTICAL_ADDRESS");

        if (uint256(uint160(tokenA)) >= uint256(uint160(tokenB))) {
            _tokenA = tokenB;
            _tokenB = tokenA;
        } else {
            _tokenA = tokenA;
            _tokenB = tokenB;
        }
    }

    function swap(
        address tokenIn, 
        address tokenOut, 
        uint256 amountIn
    ) external override returns (uint256 amountOut) {

    }

    function addLiquidity(
        uint256 amountAIn,
        uint256 amountBIn
    ) external override returns (uint256 amountA, uint256 amountB, uint256 liquidity) {

    }

    function removeLiquidity(uint256 liquidity) external override returns (uint256 amountA, uint256 amountB) {

    }

    function getReserves() external view override returns (uint256 reserveA, uint256 reserveB) {
        return (_reserveA, reserveB);
    }

    function getTokenA() external view override returns (address tokenA) {
        return _tokenA;
    }

    function getTokenB() external view override returns (address tokenB) {
        return _tokenB;
    }

    function isERC20Contract(address _addr) private returns (bool) {
        uint size;
        assembly {
            size := extcodesize(_addr)
        }

        if (size <= 0) {
            return false;
        } else {
          (bool success,) = _addr.call(abi.encodeWithSignature("totalSupply()"));
          return success;
        }
    }
}
