import Foundation
import XCTest
@testable import NullCodable

final class NullCodableComplexStructTests: XCTestCase {

    private struct Address: Codable, Equatable {
        let street: String
        let city: String
        let country: String
    }

    private struct LineItem: Codable, Equatable {
        let name: String
        let quantity: Int
        let price: Decimal
    }

    private struct Customer: Codable, Equatable {
        let name: String
        @NullCodable var email: String?
        let address: Address
    }

    private struct Order: Codable, Equatable {
        let id: String
        let customer: Customer
        let items: [LineItem]
        @NullCodable var notes: [String]?
        @NullCodable var discount: Decimal?
    }

    func test_encodesComplexStructToJSON() throws {
        let order = Order(
            id: "order-123",
            customer: Customer(
                name: "Ada Lovelace",
                email: nil,
                address: Address(
                    street: "1 Analytical Engine Way",
                    city: "London",
                    country: "United Kingdom"
                )
            ),
            items: [
                LineItem(name: "Notebook", quantity: 2, price: 12.50),
                LineItem(name: "Pen", quantity: 1, price: 3.25),
            ],
            notes: nil,
            discount: 5
        )

        let data = try JSONEncoder().encode(order)
        let actual = try XCTUnwrap(JSONSerialization.jsonObject(with: data) as? NSDictionary)
        let expected = try XCTUnwrap(JSONSerialization.jsonObject(with: Data("""
        {
          "id": "order-123",
          "customer": {
            "name": "Ada Lovelace",
            "email": null,
            "address": {
              "street": "1 Analytical Engine Way",
              "city": "London",
              "country": "United Kingdom"
            }
          },
          "items": [
            { "name": "Notebook", "quantity": 2, "price": 12.5 },
            { "name": "Pen", "quantity": 1, "price": 3.25 }
          ],
          "notes": null,
          "discount": 5
        }
        """.utf8)) as? NSDictionary)

        XCTAssertTrue(actual.isEqual(expected))
    }

    func test_decodesComplexStructFromJSON() throws {
        let json = """
        {
          "id": "order-123",
          "customer": {
            "name": "Ada Lovelace",
            "email": "ada@example.com",
            "address": {
              "street": "1 Analytical Engine Way",
              "city": "London",
              "country": "United Kingdom"
            }
          },
          "items": [
            { "name": "Notebook", "quantity": 2, "price": 12.5 },
            { "name": "Pen", "quantity": 1, "price": 3.25 }
          ],
          "notes": ["Gift wrap"],
          "discount": null
        }
        """

        let order = try JSONDecoder().decode(Order.self, from: Data(json.utf8))

        XCTAssertEqual(order.id, "order-123")
        XCTAssertEqual(order.customer.name, "Ada Lovelace")
        XCTAssertEqual(order.customer.email, "ada@example.com")
        XCTAssertEqual(order.customer.address.city, "London")
        XCTAssertEqual(order.items, [
            LineItem(name: "Notebook", quantity: 2, price: 12.5),
            LineItem(name: "Pen", quantity: 1, price: 3.25),
        ])
        XCTAssertEqual(order.notes, ["Gift wrap"])
        XCTAssertNil(order.discount)
    }

    static let allTests = [
        ("test_encodesComplexStructToJSON", test_encodesComplexStructToJSON),
        ("test_decodesComplexStructFromJSON", test_decodesComplexStructFromJSON),
    ]
}
