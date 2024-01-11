# Event-Organization Smart Contract Documentation

## Overview
The Event-Organization Smart Contract is a decentralized application (DApp) implemented in Solidity, a programming language specifically designed for developing smart contracts on the Ethereum blockchain. This contract facilitates the creation and management of events, allowing users to organize and participate in events with a ticketing system.

## Contract Structure
### EventContract
- **Struct Event**: Defines the structure of an event, including details such as organizer address, event name, date, ticket price, total tickets, and remaining tickets.
- **Mappings**: 
  - `mapping(uint => Event) public events`: Maps event IDs to their corresponding Event structs.
  - `mapping(address => mapping (uint => uint)) public tickets`: Maps user addresses to their purchased ticket quantities for specific events.
- **State Variable**: 
  - `uint public nextId`: Stores the ID for the next event to be created.

## Functions

### `createEvent`
- **Description**: Creates a new event with specified parameters.
- **Parameters**:
  - `string memory eventName`: Name of the event.
  - `uint date`: Date and time of the event.
  - `uint ticketPrice`: Price of each event ticket.
  - `uint totalTickets`: Total available tickets for the event.
- **Modifiers**:
  - Requires that the event date is in the future.
  - Requires a valid number of total tickets.
  - Requires a minimum length for the event name.
- **Effects**:
  - Creates a new event with the specified details.

### `buyTickets`
- **Description**: Allows users to purchase tickets for a specific event.
- **Parameters**:
  - `uint id`: ID of the event for which tickets are being purchased.
  - `uint quantity`: Quantity of tickets to be purchased.
- **Modifiers**:
  - Requires that the event exists.
  - Requires that the event date is in the future.
  - Requires the correct amount of Ether to be sent.
  - Requires available tickets for the requested quantity.
- **Effects**:
  - Reduces the remaining tickets for the event.
  - Records the purchased tickets for the buyer.

### `transferTickets`
- **Description**: Allows users to transfer purchased tickets to another address.
- **Parameters**:
  - `uint eventId`: ID of the event for which tickets are being transferred.
  - `uint quantity`: Quantity of tickets to be transferred.
  - `address to`: Address to which tickets are being transferred.
- **Modifiers**:
  - Requires that the event exists.
  - Requires that the event date is in the future.
  - Requires the sender to have enough tickets for the transfer.
- **Effects**:
  - Reduces the sender's ticket quantity.
  - Increases the receiver's ticket quantity.

## Usage
1. **Event Creation**: Use the `createEvent` function to create a new event by specifying the event name, date, ticket price, and total tickets.

```solidity
createEvent("Blockchain Conference", 1672531199, 2 ether, 1000);
```

2. **Ticket Purchase**: Users can buy tickets for an event using the `buyTickets` function. Ensure the correct quantity and Ether value are provided.

```solidity
buyTickets(0, 3);
```

3. **Ticket Transfer**: Users can transfer their purchased tickets to another address using the `transferTickets` function.

```solidity
transferTickets(0, 2, 0xAddress);
```

## Considerations
- **Future Enhancements**: The contract can be enhanced to include features such as event cancellation, refund mechanisms, and event details retrieval.
- **Security**: Considerations should be made to enhance the security of the contract, such as implementing access control and secure Ether handling.

## Conclusion
The Event-Organization Smart Contract provides a decentralized and transparent solution for managing events and ticketing on the Ethereum blockchain. Users can create events, purchase tickets, and transfer tickets seamlessly while ensuring the integrity and security of the entire process.
