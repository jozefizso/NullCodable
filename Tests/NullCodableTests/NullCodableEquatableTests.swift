import XCTest
@testable import NullCodable

final class NullCodableEquatableTests: XCTestCase {

    func test_comparesWrappedValues() {
        XCTAssertEqual(
            NullCodable(wrappedValue: "value"),
            NullCodable(wrappedValue: "value")
        )
        XCTAssertEqual(
            NullCodable<String>(wrappedValue: nil),
            NullCodable<String>(wrappedValue: nil)
        )
        XCTAssertNotEqual(
            NullCodable(wrappedValue: "first"),
            NullCodable(wrappedValue: "second")
        )
        XCTAssertNotEqual(
            NullCodable<String>(wrappedValue: nil),
            NullCodable(wrappedValue: "value")
        )
    }

    static let allTests = [
        ("test_comparesWrappedValues", test_comparesWrappedValues),
    ]
}
