# SmsAero

[![Gem Version][gem-badger]][gem]
[![Build Status][travis-badger]][travis]
[![Dependency Status][gemnasium-badger]][gemnasium]
[![Code Climate][codeclimate-badger]][codeclimate]

HTTP(s) client to [SMS Aero service API][sms-aero]
written on top of [evil-client][evil-client] "framework".

<a href="https://evilmartians.com/">
<img src="https://evilmartians.com/badges/sponsored-by-evil-martians.svg" alt="Sponsored by Evil Martians" width="236" height="54"></a>

## Synopsis

See [operation specs][specs] for more verbose examples.

[specs]: https://github.com/nepalez/sms_aero/tree/master/spec/sms_aero/operations

Initialize a client with user and password:

```ruby
client = SmsAero.new user: "joe",        # required
                     password: "foobar", # required
                     testsend: true      # optional - to send test SMS
```

Then send requests:

```ruby
answer = client.send_sms text: "Hello!",
                         to:   "+7 (909) 382-84-45",
                         date: "2100/01/12", # Date, Time, DateTime are accepted as well
                         type: 3 # see API docs for details

answer.result   # => "accepted"
answer.id       # => "38293"
answer.success? # => true (checks whether an id has been returned)
```

```ruby
answer = client.check_status id: "38293"
answer.result # => "pending"
```

```ruby
answer = client.send_sms text:  "Hello!",
                         group: "customers",
                         date:  Date.new("2100/01/12"),
                         type:  1

answer.result   # => "accepted"
answer.id       # => "894924"
answer.success? # => true (checks whether an id has been returned)
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

```ruby
# checking existance & availability of phone number
answer = client.hlr phone: "+7 (999) 123-4567"
answer.result   # => "accepted"
id = answer.id  # => "12345", id of request

answer = client.hlr_status id
answer.result   # => "accepted"
answer.status   # => any of :available, :unavailable or :nonexistent
```

[sms-aero]: https://smsaero.ru/api/description/
[codeclimate-badger]: https://img.shields.io/codeclimate/github/nepalez/sms_aero.svg?style=flat
[codeclimate]: https://codeclimate.com/github/nepalez/sms_aero
[gem-badger]: https://img.shields.io/gem/v/sms_aero.svg?style=flat
[gem]: https://rubygems.org/gems/sms_aero
[gemnasium-badger]: https://img.shields.io/gemnasium/nepalez/sms_aero.svg?style=flat
[gemnasium]: https://gemnasium.com/nepalez/sms_aero
[travis-badger]: https://img.shields.io/travis/nepalez/sms_aero/master.svg?style=flat
[travis]: https://travis-ci.org/nepalez/sms_aero
[evil-client]: https://github.com/evilmartians/evil-client
