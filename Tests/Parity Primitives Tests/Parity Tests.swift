// Parity Tests.swift

import Parity_Primitives_Test_Support
import Pair_Primitives
import Testing

@Suite
struct `Parity Tests` {
    @Suite struct Unit {}
}

// MARK: - Unit

extension `Parity Tests`.Unit {

    @Test
    func `Parity Value typealias resolves through Pair_Primitives`() {
        let value: Parity.Value<Int> = Pair(.even, 4)
        #expect(value.first == .even)
        #expect(value.second == 4)
    }
}
