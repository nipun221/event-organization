// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventContract {
    struct Event {
        address organizer;
        string eventName;
        uint date;
        uint ticketPrice;
        uint totalTickets;
        uint remainingTickets;
    } 

    mapping(uint=>Event) public events;
    mapping(address=>mapping (uint=>uint)) public tickets;
    uint public nextId;

    function createEvent(string memory eventName, uint date, uint ticketPrice, uint totalTickets) public {
        require(date>block.timestamp, "Please select a future date for your event!");
        require(totalTickets>10, "Select a valid number of tickets!");
        require(bytes(eventName).length>3, "Event name should have more than 3 characters!");
        events[nextId] = Event(msg.sender, eventName, date, ticketPrice, totalTickets, totalTickets);
        nextId++;
    }

    function buyTickets(uint id, uint quantity) public payable {
        require(events[id].date != 0, "This event does not exits!");
        require(events[id].date>block.timestamp, "Sorry! This event has ended!");
        Event storage _event = events[id];
        require(msg.value==(_event.ticketPrice*quantity), "Insufficient Ether!");
        require(_event.remainingTickets>=quantity, "Sorry! Tickets not available!");
        _event.remainingTickets-=quantity;
        tickets[msg.sender][id]+=quantity;
    }

    function transferTickets(uint eventId, uint quantity, address to) public {
        require(events[eventId].date != 0, "This event does not exits!");
        require(events[eventId].date>block.timestamp, "Sorry! This event has ended!");
        require(tickets[msg.sender][eventId]>=quantity, "You do not have enough tickets to transfer!");
        tickets[msg.sender][eventId]-=quantity;
        tickets[to][eventId]+=quantity;
    }
}