# 2025-02-28 ZK Circuits workshop: Noir

# Intro

Noir is a high level programming language to write zk circuits.

Features:
- Syntax based on Rust
- Backend independent
    - Can work with different proof systems
    - Noir compiles to an intermediate representation called ACIR
    - A backend takes ACIR and generates the proof system-dependent arithmetization

# Hands on

https://noir-lang.org/docs/getting_started/quick_start

## Install

```
curl -L https://raw.githubusercontent.com/noir-lang/noirup/refs/heads/main/install | bash
noirup
curl -L https://raw.githubusercontent.com/AztecProtocol/aztec-packages/refs/heads/master/barretenberg/bbup/install | bash
bbup
```

## Quickstart

Follow all the steps to create a new Noir project and show the proving / verifying flow with the barretenberg library.

Barretenberg is an implementation of a Proof System and zk circuit framework based on Plonk with support for different configurations and extensions.  It uses elliptic curve based commitment schemes.

```
nargo new hello_world
cd hello_world
nargo check
# Edit Prover.toml
nargo execute
bb prove -b ./target/hello_world.json -w ./target/hello_world.gz -o ./target/proof
bb write_vk -b ./target/hello_world.json -o ./target/vk
bb verify -k ./target/vk -p ./target/proof
```

## The language

Details on the language are documented here https://noir-lang.org/docs/

Any Rust developer should feel familiar with Noir because it uses a very similar Syntax and semantics.  But remember that Noir is a language to write zk circuits, so there will be some limitations.

Noir offers different data types that already exist in Rust.

Noir doesn't distinguish between circuit constants and witness in the types; instead it allows the developer to write generic code that will materialize into constants or witness depending on its usage.
- If I call a function with an input literal, the output can be used as a constant in a constraint.
- If I call a function with a private input, the output will be constrained from that input.

Example
```
fn sum(x: u32, y: u32, z: u32) -> u32 {
    x + y + z
}

fn main(x: pub u32, y: pub u32, z: pub u32) {
    let a = sum(1, 2, 3);
    let b = sum(x, y, z);
    assert(a == b);
}
```

The generated circuit will look like this:
```
6 - (x + y + z) = 0
```

Noir supports many regular Rust constructions like:
- control flow
    - for
    - loop
        - with break/continue
    - if/else
- function calls
- variabe reference
- limited form of generics
    - including traits
- closures

Noir also includes some constructions that don't exist in Rust
- assert: explicit constraint creation.  The proof won't pass if the assert isn't satisfied.  This is different than the Rust assert which causes a panic: a Noir circuit with an unsatisfied assert can't be verified, whereas a Rust progra with a failing will terminate.
- unconstrained functions: the nature of Noir is that all code that processes witnesses generates constraints along the way.  But some times verifying the correctness of a solution is cheaper than executing the steps to generate the solution.  For this reason Noir allows calculating witness values without generating constraints.
    - Example: sorting a vector is `O(n log n)`, but verifying that a vector is sorted is `O(n)`.  We can generate an unconstrained copy of the sorted vector and verify with constraints that it's sorted.  Let's see the actual code! https://github.com/noir-lang/noir/blob/899e8c8ac00e091d71c7045e90bc37b8b65c6524/noir_stdlib/src/array/mod.nr#L186
- Compile-time Code & Metaprogramming: This is left as an exercise for the reader

## Exercise

Let's build a sudoku verifier in Noir!

1. Review the pure rust implementation of a sudoku verifier `./sudoku_rs/src/main.rs`
    - Try to understand why it works
2. In the Noir implementation, complete the function `permutation_one_to_n`
    - On success, the tests that start with `test_permutation_one_to_n` should pass
        - `nargo test test_permutation_one_to_n`
3. In the Noir implementation, complete the function `verify` 
    - On success, the tests that start with `test_verify` should pass
        - `nargo test test_verify`
4. Optional: Measure the proving time and rewrite the circuit in a more efficient way

