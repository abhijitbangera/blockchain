// abhicoins ico
pragma solidity ^0.4.11;

contract abhicoins_ico {
    // Introducing max num of abhicoins
    uint public max_abhicoins = 1000000;

    // Introducing USD to abhicoins conversion rate
    uint public usd_to_abhicoins = 1000;

    // Introducing total number of abhicoins that have been bought by the investors
    uint public total_abhicoins_bought = 0;

    // Mapping from the investor address to its equity in abhicoins and USD
    mapping(address => uint) equity_abhicoins;
    mapping(address => uint) equity_usd;

    // checking if an investor can buy abhicoins
    modifier can_buy_abhicoins(uint usd_invested) {
        require(usd_to_abhicoins * usd_invested + usd_to_abhicoins <= max_abhicoins);
        _;
    }

    // getting the equity in abhicoins of an investor
    function equity_in_abhicoins(address investor) external constant returns (uint) {
        return equity_abhicoins[investor];
    }

    // getting the equity in USD of an investor
    function equity_in_usd(address investor) external constant returns (uint) {
        return equity_usd[investor];
    }

    // buying abhicoins
    function buy_abhicoins(address investor, uint usd_invested) external  
    can_buy_abhicoins(usd_invested) {
        uint abhicoins_bought = usd_invested * usd_to_abhicoins;
        equity_abhicoins[investor] += abhicoins_bought;
        equity_usd[investor] = equity_abhicoins[investor] / 1000;
        total_abhicoins_bought += abhicoins_bought;
    }

    // selling abhicoins
    function sell_abhicoins(address investor, uint abhicoins_sold) external {
        equity_abhicoins[investor] -= abhicoins_sold;
        equity_usd[investor] = equity_abhicoins[investor] / 1000;
        total_abhicoins_bought -= abhicoins_sold;
    }

}