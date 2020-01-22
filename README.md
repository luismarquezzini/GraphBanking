# Graphbanking

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Want to test? Please visit [`localhost:4000/api/graphiql`](http://localhost:4000/api/graphiql) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

What the API does:
   
   * Open an account with a starting value
   * Transfer from an "A account" to a "B account"
   * Show all bank accounts
   * Show all bank transactions
   * Get all info from one account, including all transactions           

How it works: 

Query

##### Query all accounts

```
accounts {
  id
  currentBalance
  transactions {
    id
    address
    amount
    insertedAt
  }
}
```

##### Get info from one account

```
account(id: id) {
  id
  currentBalance
  transactions {
    id
    address
    amount
    insertedAt
  }
}
```

##### Get all transactions

```
transactions {
  id
  address
  amount
  insertedAt
}
```

Mutations

##### Open an account

```
createAccount(balance: balance){
  id
  currentBalance
}
```

##### Transfer money

```
transferMoney(sender: <sender_uuid>, address: <receiver_uuid>, amount: amount){
  sender
  receiver
  amount
  msg
}
```


## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
