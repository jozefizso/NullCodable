import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(NullCodableTests.allTests),
        testCase(NullCodablePropertyWrapperTests.allTests),
        testCase(NullCodableJSONEncoderTests.allTests),
        testCase(NullCodableJSONDecoderTests.allTests),
        testCase(NullCodableComplexStructTests.allTests),
        testCase(NullCodableEquatableTests.allTests),
        testCase(NullCodableSendableTests.allTests),
    ]
}
#endif
