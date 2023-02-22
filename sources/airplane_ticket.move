module airline::tickets{
    use std::signer;
    use std::string;
    use aptos_std::table_with_length::{Self, TableWithLength};


    struct Ticket has key, store,copy, drop{
       ticket_code: string::String,
    }
    struct AirplaneSeat  has store, copy, drop{
        seat:string::String,
        seat_number: u64
    }
    struct Flight has key{
        available_tickets: table_with_length::TableWithLength<AirplaneSeat,Ticket>,
        first_class:u64,
        business_class:u64,
        economy_class:u64,
    }
    struct TicketEnvelope has key {
        tickets: vector<Ticket>
    }

    public entry fun init_airline(airline_addr:&signer){
        let available_tickets = table_with_length::new<AirplaneSeat,Ticket>();
        move_to<Flight>(airline_addr, Flight { available_tickets, first_class:4 ,business_class:8,economy_class:16})
    }
    public entry fun create_flight(airline_addr:&signer){
       let airline_owner_addr= signer::address_of(airline_addr);

    }
    public entry fun buy_ticket(){}
}