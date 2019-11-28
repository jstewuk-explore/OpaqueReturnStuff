import XCTest
@testable import OpaqueReturnStuff


@available(OSX 10.15.0, *)
final class OpaqueReturnStuffTests: XCTestCase {

    func testCanDoShapes() {
        var sut = OpaqueReturnStuff()
        let trapezoid = sut.makeTrapezoid()
        print(trapezoid.draw())
    }
    
    func testCanReturnOpaqueType() {
        var sut = OpaqueReturnStuff()
        let smallTriangle = sut.Triangle(size: 3)
        let opaqueJoinedTriangles = join(smallTriangle, flip(smallTriangle))
        print(opaqueJoinedTriangles.draw())
    }
    
//    func testInvalidFlipFails() {
//        let smallTriangle = Triangle(size: 3)
//        let flippedTriangle = invalidFlip(smallTriangle)
//        print(flippedTriangle.draw())
//    }
    
    func testCanSetOpaqueProperty() {
        var sut = OpaqueReturnStuff()
        let smallTriangle = sut.Triangle(size: 3)
        let opaqueShape = flip(smallTriangle)
        print(opaqueShape)
    }
}
