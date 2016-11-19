# SmsAero

HTTP(s) client to [SMS Aero service API][sms-aero].

[sms-aero]: https://smsaero.ru/api/description/

## Synopsis

See [operation specs][specs] for more verbose examples.

[specs]: https://github.com/nepalez/sms_aero/tree/master/spec/sms_aero/operations

Initialize a client with user and password:

```ruby
client = SmsAero.new user: "joe", password: "foobar"
```

Then send requests:

```ruby
answer = client.send_sms text: "Hello!",
                         to:   "+7 (909) 382-84-45",
                         date: "2100/01/12", # Date, Time, DateTime are accepted as well
                         type: 3 # see API docs for details

answer.result # => "accepted"
answer.id     # => "38293"
```

```ruby
answer = client.check_status id: "38293"
answer.result # => "pending"
```

```ruby
answer = client.send_to_group text:  "Hello!",
                              group: "customers",
                              date:  "2100/01/12",
                              type:  1

answer.result # => "accepted"
answer.id     # => "894924"
```

```ruby
answer = client.check_sending id: "894924"
answer.result # => "pending"
```

```ruby
answer = client.add_blacklist phone: "+7 (999) 123-45-67"
answer.result # => "accepted"
```

```ruby
answer = client.add_group group: "baz"
answer.result # => "accepted"
```

```ruby
answer = client.add_phone phone: "+7 (999) 123-45-67",
                          group: "customers",
                          fname: "John",
                          lname: "Paul",
                          lname: "Doe",
                          bday:  "1998/08/12",
                          param: "VIP"

answer.result # => "accepted"
```

```ruby
answer = client.check_balance
answer.result  # => "accepted"
answer.balance # => 1973.2
```

```ruby
answer = client.check_groups
answer.result   # => "accepted"
answer.channels # => ["customers", "employee"]
```

```ruby
answer = client.check_senders sign: "qux"
answer.result # => "accepted"
answer.result # => ["peter", "paul"]
```

```ruby
answer = client.check_sign sign: "qux"
answer.result # => "accepted"
answer.data   # => ["approved"]   
```

```ruby
answer = client.check_tariff
answer.result # => "accepted"
answer.tariff # => { direct: 10.3, digital: 3.89 }
```

```ruby
answer = client.delete_group group: "employee"
answer.result   # => "accepted"
```

```ruby
answer = client.delete_phone phone: "+7 (999) 123-4567",
                             group: "customers"

answer.result   # => "accepted"
```
