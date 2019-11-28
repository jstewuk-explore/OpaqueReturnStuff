
protocol Shape {
    func draw() -> String
}

@available(OSX 10.15.0, *)
struct OpaqueReturnStuff {
    
    // This can't be optional
    // Also not sure how we pass it in to an init.
    //  Property declares an opaque return type, but has no initializer expression from which to infer an underlying type
    var opaqueShape: some Shape
    
    
    // This doesn't work:
    //  Cannot assign value of type 'some Shape' (result of 'OpaqueReturnStuff.makeTrapezoid()') to type 'some Shape' (type of 'OpaqueReturnStuff.opaqueShape')
    init(shapeMaker: () -> some Shape) {
        opaqueShape = shapeMaker()
    }

    struct Triangle: Shape {
        var size: Int
        func draw() -> String {
            var result = [String]()
            for length in 1...size {
                result.append(String(repeating: "*", count: length))
            }
            return result.joined(separator: "\n")
        }
    }
    
    struct FlippedShape<T: Shape>: Shape {
        var shape: T
        func draw() -> String {
            let lines = shape.draw().split(separator: "\n")
            return lines.reversed().joined(separator: "\n")
        }
    }
    
    struct JoinedShape<T: Shape, U: Shape>: Shape {
        var top: T
        var bottom: U
        func draw() -> String {
            return top.draw() + "\n" + bottom.draw()
        }
    }
    
    struct Square: Shape {
        var size: Int
        func draw() -> String {
            let line = String(repeating: "*", count: size)
            let result = Array<String>(repeating: line, count: size)
            return result.joined(separator: "\n")
        }
    }
    
    static func makeTrapezoid() -> some Shape {
        let top = Triangle(size: 2)
        let middle = Square(size: 2)
        let bottom = FlippedShape(shape: top)
        let trapezoid = JoinedShape(
            top: top,
            bottom: JoinedShape(top: middle, bottom: bottom)
        )
        return trapezoid
    }
    
    // Opaque types
    func flip<T: Shape>(_ shape: T) -> some Shape {
        return FlippedShape(shape: shape)
    }
    
    func join<T: Shape, U: Shape>(_ top: T, _ bottom: U) -> some Shape {
        JoinedShape(top: top, bottom: bottom)
    }
    
    // Invalid flip, because returned types are not both 'some Shape'
//    func invalidFlip<T: Shape>(_ shape: T) -> some Shape {
//        if shape is Square {
//            return shape // Error: return types don't match
//        }
//        return FlippedShape(shape: shape) // Error: return types don't match
//    }
    
    // This doens't work either, can only use opaque types:
    //  "'some' types are only implemented for the declared type of properties and subscripts and the return type of functions"
//    func invalidFlip<T: Shape>(_ shape: T) -> some Shape {
//        if shape is some Shape {
//            return shape // Error: return types don't match
//        }
//        return FlippedShape(shape: shape) // Error: return types don't match
//    }
    
}
