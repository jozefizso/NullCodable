import XCTest
@testable import NullCodable

final class NullCodableSendableTests: XCTestCase {

    func test_conformsToSendableWhenWrappedValueIsSendable() {
        assertSendable(NullCodable(wrappedValue: "value"))
        assertSendable(NullCodable(wrappedValue: 42))
    }

    private func assertSendable<T: Sendable>(_ value: T) {
        _ = value
    }

    static let allTests = [
        ("test_conformsToSendableWhenWrappedValueIsSendable", test_conformsToSendableWhenWrappedValueIsSendable),
    ]
}
