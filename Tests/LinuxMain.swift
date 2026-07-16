import XCTest

import NullCodableTests

var tests = [XCTestCaseEntry]()
tests += NullCodableTests.allTests()
tests += NullCodablePropertyWrapperTests.allTests()
tests += NullCodableJSONEncoderTests.allTests()
tests += NullCodableJSONDecoderTests.allTests()
tests += NullCodableComplexStructTests.allTests()
tests += NullCodableEquatableTests.allTests()
tests += NullCodableSendableTests.allTests()
XCTMain(tests)
