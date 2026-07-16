import XCTest
@testable import NullCodable

final class NullCodableJSONDecoderTests: XCTestCase {

    func test_decodesJSONNullAsNil() throws {
        let value = try JSONDecoder().decode(
            NullCodable<String>.self,
            from: Data("null".utf8)
        )

        XCTAssertNil(value.wrappedValue)
    }

    func test_decodesWrappedValue() throws {
        let value = try JSONDecoder().decode(
            NullCodable<Int>.self,
            from: Data("42".utf8)
        )

        XCTAssertEqual(value.wrappedValue, 42)
    }

    func test_decodesInvalidWrappedValueWithAnError() {
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                NullCodable<Int>.self,
                from: Data("\"not an integer\"".utf8)
            )
        ) { error in
            XCTAssertTrue(error is DecodingError)
        }
    }

    func test_supportsCollectionValues() throws {
        let value = NullCodable(wrappedValue: ["one", "two"])

        let data = try JSONEncoder().encode(value)
        let decoded = try JSONDecoder().decode(
            NullCodable<[String]>.self,
            from: data
        )

        XCTAssertEqual(decoded.wrappedValue, ["one", "two"])
    }

    static let allTests = [
        ("test_decodesJSONNullAsNil", test_decodesJSONNullAsNil),
        ("test_decodesWrappedValue", test_decodesWrappedValue),
        ("test_decodesInvalidWrappedValueWithAnError", test_decodesInvalidWrappedValueWithAnError),
        ("test_supportsCollectionValues", test_supportsCollectionValues),
    ]
}
