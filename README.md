# Murmur3

Murmur3H1 hash function used by cassandra

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  murmur3:
    github: kuende/murmur3
```

## Usage


```crystal
require "murmur3"

Murmur3.h1("hello, world".bytes)

# Or as string

Murmur3.h1("hello, world")
```

## Contributing

1. Fork it ( https://github.com/kuende/murmur3/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [@teodor-pripoae](https://github.com/teodor-pripoae) Teodor Pripoae - creator, maintainer
