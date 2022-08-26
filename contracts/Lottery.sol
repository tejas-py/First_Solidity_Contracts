// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Lottery{
    address public manager;
    address payable[] public participants;

    constructor(){
       manager = msg.sender; // the person who deploys the smart contract becomes the manager of the smart contract
    }

    // this functions check if the owner is calling the smart contract
    modifier OnlyOwner(){
        require(manager == msg.sender, "Only owner can call this funciton.");
        _;
    }

    // receives the payment by the participants only 2 ether
    function Participate() public payable{
        participants.push(payable(msg.sender)); 
        require(msg.value ==  1000000000000000000 wei, "You can only send 0.02 Ethers");
        require(manager != msg.sender, "Manager cannot participate in the Lottery");
    }

    // check the balance of the smart contract only by manager
    function getBalance() public view returns(uint Balance){
        Balance = address(this).balance;
    }

    // generate a random number which will be smaller than the lenght of participants
    function keccak_random() internal view returns(uint index){
        uint random_number =  uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, participants.length))); // only to produce a random number
        index = random_number % participants.length;
    }

    // select a random winner for the lottery, transfer the price and clear the participation list
    function SelectWinner() public OnlyOwner returns(address) {
        
        require(participants.length >= 3);
        address payable winner = participants[keccak_random()];
        winner.transfer(getBalance());
        participants = new address payable[](0);


        return winner;
    }
}