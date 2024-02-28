// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;
import "./PriceConverter.sol";

error NotOwner();

contract FundMe{

    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable{
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;

    }

    function withdraw() public onlyOwner{
        
        for(uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        //reset the array to 0 objects
        funders = new address[](0);

        //actually withdrawing
        // you can use transfer method
        // payable(msg.sender).transfer(address(this).balance);

        // // you can use the send method which returns a bool if an error occurs
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "sending failed");

        //you can use call which returns a boolean and a bytes object for data returned
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "call failed");
    }
    
    modifier onlyOwner{
        // require(msg.sender == i_owner, "sender is not the owner");
        
        // _;

        if(msg.sender != owner){
            revert NotOwner();
        }

        _;

        // the _; tells the code to run last since its below
    }


    // if someone sends ETH without calling the fund function
    receive() external payable{
        fund();
    }

    callback() external payable{
        fund();
    }
}


