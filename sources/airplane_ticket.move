module airline::tickets{
    use std::signer;



    struct Ticket has key{

    }
    
    struct Flight has key{

    }
    public entry fun init_airline(){}
    public entry fun create_flight(){}
    public entry fun buy_ticket(){}
}