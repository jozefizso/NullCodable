import XCTest
@testable import NullCodable

final class NullCodableJSONEncoderTests: XCTestCase {

    func test_encodesNilAsJSONNull() throws {
        let value = NullCodable<String>(wrappedValue: nil)

        let data = try JSONEncoder().encode(value)

        XCTAssertEqual(String(decoding: data, as: UTF8.self), "null")
    }

    func test_encodesWrappedValue() throws {
        let value = NullCodable(wrappedValue: 42)

        let data = try JSONEncoder().encode(value)

        XCTAssertEqual(String(decoding: data, as: UTF8.self), "42")
    }

    static let allTests = [
        ("test_encodesNilAsJSONNull", test_encodesNilAsJSONNull),
        ("test_encodesWrappedValue", test_encodesWrappedValue),
    ]
}
