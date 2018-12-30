# Inspiration

Attempt to transpile Ruby to Lua.
Having the object model, but not the same standard library.
Would like to relu on `luajit` for the FFI interface.

# Lua Interoperability

Interacting with underlying lua features can be done at the standard library level.
This behaviour will be similar to [Elixir to Erlang](https://elixirschool.com/en/lessons/advanced/erlang).

## Method invocation

The standard library can be referenced using a symbol and the appropriate method.
If the arguments being passed in are mapped to similar types in the language, it should Just Work™.
For example, a Ruby `String` should map to the golang `string`.

```ruby
:lua.print("Hello, World!")
```

Hopefully this enables light calling to lua functions, so some of the compiler can be self hosted.
