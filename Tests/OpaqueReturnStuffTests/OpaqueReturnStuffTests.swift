import XCTest
@testable import OpaqueReturnStuff

final class OpaqueReturnStuffTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(OpaqueReturnStuff().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
