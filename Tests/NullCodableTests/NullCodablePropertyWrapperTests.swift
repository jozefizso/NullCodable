import XCTest
@testable import NullCodable

final class NullCodablePropertyWrapperTests: XCTestCase {

    func test_defaultValueIsNil() {
        let value = NullCodable<String>(wrappedValue: nil)

        XCTAssertNil(value.wrappedValue)
    }

    func test_wrappedValueCanBeReadAndUpdated() {
        var value = NullCodable(wrappedValue: "before")

        XCTAssertEqual(value.wrappedValue, "before")

        value.wrappedValue = "after"

        XCTAssertEqual(value.wrappedValue, "after")
    }

    static let allTests = [
        ("test_defaultValueIsNil", test_defaultValueIsNil),
        ("test_wrappedValueCanBeReadAndUpdated", test_wrappedValueCanBeReadAndUpdated),
    ]
}
