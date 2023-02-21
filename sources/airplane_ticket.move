module airline::tickets{
    use std::signer;
    use aptos_std::table_with_length::{Self, TableWithLength};


    struct Ticket has key{
      
    }
    struct Flight has key{
        available_tickets: table_with_length::TableWithLength<Ticket>,
        first_class:u64,
        business_class:u64,
        economy_class:u64,
    }
    
    public entry fun init_airline(airline:&signer){
        let available_tickets = table_with_length::new<SeatIdentifier, ConcertTicket>();
        move_to<Flight>(airline, Flight { available_tickets, max_seats })
    }
    public entry fun create_flight(){}
    public entry fun buy_ticket(){}
}