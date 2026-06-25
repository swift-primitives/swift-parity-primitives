# Parity Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

`Parity` — the two-element even/odd classification of integers, modelling the Z₂ group under addition and the parity of products, with zero platform dependencies.

---

## Quick Start

`Parity` is the equivalence class of an integer under modulo 2: `.even` or `.odd`. Rather than recomputing `value % 2` at every site and threading a bare `Bool` whose meaning is ambiguous, you capture the classification once in a named type that knows its own algebra — addition (even + even = even, odd + odd = even) and multiplication (odd × odd = odd, else even) — so parity-tracking algorithms read in the vocabulary of the mathematics.

```swift
import Parity_Primitives

// Classify integers.
let a = Parity(42)   // even
let b = Parity(7)    // odd

// The Z₂ group: parity of a sum, without touching the operands' values.
print(a.adding(b))        // odd   (even + odd = odd)
print(b.adding(b))        // even  (odd + odd = even)

// Parity of a product.
print(b.multiplying(b))   // odd   (odd × odd = odd)
print(a.multiplying(b))   // even  (even × anything = even)

// The opposite parity, by method or prefix operator.
print(a.opposite)         // odd
print(!b)                 // even
```

`Parity` is `Hashable`, `Sendable`, `CaseIterable`, and `Codable` (outside Embedded). Because it is a closed two-case enum, a `switch` over it is exhaustive without a `default`.

To carry a payload alongside its parity, `Parity.Value` pairs the two:

```swift
import Pair_Primitives
import Parity_Primitives

// Parity.Value<Payload> is Pair<Parity, Payload>.
let tagged: Parity.Value<Int> = Pair(.even, 4)
print(tagged.first)    // even
print(tagged.second)   // 4
```

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-parity-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Parity Primitives", package: "swift-parity-primitives"),
    ]
)
```

---

## Architecture

Two library products. Depends only on the `Pair` primitive, which it re-exports.

| Product | Target | Purpose |
|---------|--------|---------|
| `Parity Primitives` | `Sources/Parity Primitives/` | The `Parity` enum (`.even` / `.odd`), its `BinaryInteger` classification init, the Z₂ `adding` / `multiplying` / `opposite` algebra and prefix `!`, and the `Parity.Value<Payload>` pairing typealias. Re-exports `Pair Primitives`. |
| `Parity Primitives Test Support` | `Tests/Support/` | Re-exports the main target for test consumers. |

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
