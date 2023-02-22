module airline::tickets{
    use std::signer;
     use std::string::{Self,String};
    use aptos_std::table_with_length::{Self, TableWithLength};
     use std::vector;
    const ENO_VENUE: u64 = 0;
    const ENO_TICKETS: u64 = 1;
    const ENO_ENVELOPE: u64 = 2;
    const EINVALID_TICKET_COUNT: u64 = 3;
    const EINVALID_TICKET: u64 = 4;
    const EINVALID_PRICE: u64 = 5;
    const EMAX_SEATS: u64 = 6;
    const EINVALID_BALANCE: u64 = 7;
    

    struct Ticket has key, store,copy, drop{
       identifier: AirplaneSeat,
       ticket_code: string::String,
        price: u64,
    }
    struct AirplaneSeat  has store, copy, drop{
        seat:string::String,
        seat_number: u64
    }
    struct Flight has key{
        available_tickets: table_with_length::TableWithLength<AirplaneSeat,Ticket>,
        max_seats: u64
    }
    struct TicketEnvelope has key {
        tickets: vector<Ticket>
    }
    public fun to_string(value:u64):String{
    if (value==0){
        return string::utf8(b"0")
    };
    let buffer= vector::empty<u8>();
    while (value!=0){
        vector::push_back(&mut buffer,((48+value %10) as u8));
        value = value/10;
    };
    vector::reverse(&mut buffer);
    string::utf8(buffer)
}
    public entry fun init_airline(airline_addr:&signer,max_seats:u64){
        let available_tickets = table_with_length::new<AirplaneSeat,Ticket>();
        move_to<Flight>(airline_addr, Flight { available_tickets, max_seats})
    }

      public fun available_ticket_count(airline_addr: address): u64 acquires Flight {
        let airline = borrow_global<Flight>(airline_addr);
        table_with_length::length<AirplaneSeat, Ticket>(&airline.available_tickets)
    }
    public entry fun create_flight(airline_addr:&signer,seat: vector<u8>,  seat_number: u64, ticket_code: vector<u8>,price: u64) acquires Flight{
        let airline_addr = signer::address_of(airline_addr);
        assert!(exists<Flight>(airline_addr), ENO_VENUE);
        let current_seat_count = available_ticket_count(airline_addr);
        let airline = borrow_global_mut<Flight>(airline_addr);
        assert!(current_seat_count < airline.max_seats, EMAX_SEATS);
        let num = 1;
        while(num <=  airline.max_seats){
        let test= string::utf8(b"A");
        string::append(&mut test,to_string(num));
        let identifier = AirplaneSeat { seat: test, seat_number };
        let tickets = Ticket { identifier, ticket_code: string::utf8(ticket_code), price} ;
        num = num+1;
        table_with_length::add(&mut airline.available_tickets,identifier, tickets)
        }
    }
    public entry fun buy_ticket(){}


   #[test(venue_owner = @0x111, buyer = @0x222, x=@airline)]
   fun test_create_flight(){}
}


