# airplane_ticket

```
aptos move run  --function-id default::tickets::init_airline --args u64:20
aptos move run  --function-id default::tickets::create_flight --args u64:1
aptos move run  --function-id default::tickets::buy_ticket --args address:"address" string:A1 u64:1 --type-args 0x1::aptos_coin::AptosCoin
```
