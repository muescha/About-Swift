//: [Previous](@previous)

//: # Operators

//: ## Ternary Conditional Operator
let condition1 = true
var value = condition1 ? 1 : 2
//: ## Remainder Operator
-9 % 2
//: ## Compound Assignment Operators
var a = 1.5
a += 10
a -= 6
a *= 2
a /= 2
//: ## Comparison Operators
1 == 1   // true because 1 is equal to 1
2 != 1   // true because 2 is not equal to 1
2 > 1    // true because 2 is greater than 1
1 < 2    // true because 1 is less than 2
1 >= 1   // true because 1 is greater than or equal to 1
2 <= 1   // false because 2 is not less than or equal to 1
/*:
 ## Logical Operators
 
 The Swift logical operators && and || are left-associative, meaning that compound expressions with multiple logical operators evaluate the leftmost subexpression first.
 */
!true
true && false
true || false
//: ## Bitwise Operator.
let initialBits: UInt8 = 0b0000_0000

//: * Bitwise NOT Operator.
let notBits = ~initialBits
//: * Bitwise AND Operator.
let andBits = initialBits & initialBits
//: * Bitwise OR Operator.
let orBits = initialBits | initialBits
//: * Bitwise XOR Operator.
let xorBits = initialBits ^ initialBits
//: ## Bitwise Left and Right Shift Operators

/*:
 ### Logical shift (Unsigned Integers)
 * Existing bits are moved to the left or right by the requested number of places.
 * Any bits that are moved beyond the bounds of the integer’s storage are discarded.
 * Zeros are inserted in the spaces left behind after the original bits are moved to the left or right.
 */
let shiftBits: UInt8 = 4   // 00000100 in binary
shiftBits << 1             // 00001000
shiftBits << 2             // 00010000
shiftBits >> 2             // 00000001
/*:
 ### Arithmetic shift (Signed Integers)
 * When you shift signed integers to the right, apply the same rules as for unsigned integers, but fill any  empty bits on the left with the sign bit, rather than with a zero.
 */
let shiftBitsSigned: Int8 = -4   // 11111100 in binary
shiftBitsSigned << 1             // 11111000
shiftBitsSigned << 2             // 11110000
shiftBitsSigned >> 2             // 11111111
/*:
 ## Overflow Operators
 */
UInt8.max
UInt8.min
Int8.min

UInt8.max &+ 1
UInt8.min &- 1
UInt8.max &* UInt8.max

Int8.min &- 1
/*:
 ## Operators Overload
 
 It is not possible to overload the default assignment operator (=). Only the compound assignment operators can be overloaded. Similarly, the ternary conditional operator (a ? b : c) cannot be overloaded.
 */
struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

var myVector = Vector2D(x: 1, y: 2) + Vector2D(x: 2, y: 4)
myVector.x
myVector.y

myVector += Vector2D(x: 1, y: 1)
myVector.x
myVector.y
//: Pattern matching
func ~=(pattern: String, value: Int) -> Bool {
    return pattern == "\(value)"
}

"1" ~= 1

let point = (1, 2)
switch point {
case ("0", "0"):
    print("(0, 0) is at the origin.")
default:
    print("The point is at (\(point.0), \(point.1)).")
}
/*:
 Prefix and Postfix Operators
 
 You implement a prefix or postfix unary operator by writing the prefix or postfix modifier before the func keyword when declaring the operator function.
 */
extension Vector2D {
    
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
    
    static prefix func ++ (vector: inout Vector2D) -> Vector2D {
        vector += Vector2D(x: 1.0, y: 1.0)
        return vector
    }
    
    static postfix func ++ (vector: inout Vector2D) -> Vector2D {
        let tmp = vector
        vector += Vector2D(x: 1.0, y: 1.0)
        return tmp
    }
}

var vector = Vector2D(x: 1, y: 1)
vector++
vector
/*: 
 ## Custom Operators
 New operators are declared at a global level using the operator keyword, and are marked with the **prefix**, **infix** or **postfix** modifiers.
 */
prefix operator +++

extension Vector2D {
    
    // It doubles the x and y values of a Vector2D instance
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
afterDoubling.x
afterDoubling.y

/*: 
 ### Precedence for Custom Infix Operators
 
 Custom infix operators each belong to a precedence group. A precedence group specifies an operator’s precedence relative to other infix operators, as well as the operator’s associativity.
 
 For a complete list of the operator precedence groups see [Swift Standard Library Operators.](https://developer.apple.com/reference/swift/1851035-swift_standard_library_operators)
 */

infix operator +-: AdditionPrecedence
extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}

let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
plusMinusVector.x
plusMinusVector.y
/*:
 - note:
 You do not specify a precedence when defining a prefix or postfix operator. However, if you apply both a prefix and a postfix operator to the same operand, the postfix operator is applied first.
 */

//: [Next](@next)
