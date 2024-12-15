import HAL
import serial

extension Usart {
    public static func print(_ msg: StaticString) {
        write(msg)
    }

    @discardableResult
    public static func print<T: BinaryInteger>(_ value: T,
    radix: UInt8 = 10,
    terminator: StaticString = "\n") -> UInt8 {
        let maxRadix = 36 // '0'-'9' and 'A'-'Z', 35 in base 36 would be 'Z'
        let maxCharacters = 65 // max digits, 64 should be enough but just in case

        guard radix <= maxRadix, radix > 1 else {
            print("??")
            print(terminator)            
            return maxCharacters // not accurate, but an overestimate
        }

        var i: UInt8 = maxCharacters

        if T.isSigned, value < 0 {
            print("-")
            i -= 1
        }

        func printRemainder(_ v: T) {
            guard i > 0 else { return } // we are out of space

            let (quotient, remainder) = v.quotientAndRemainder(dividingBy: T(radix))

            if quotient > 0 {
                printRemainder(quotient)
            }

            i -= 1

            print(nybble: UInt8(truncatingIfNeeded: remainder))
        }
    
        printRemainder(value)
        
        print(terminator)

        return maxCharacters - i
    }

    @discardableResult
    public static func print<T: BinaryFloatingPoint>(_ value: T,
    forceFullPrint: Bool = false,
    terminator: StaticString = "\n")
     -> UInt8 {
        let maxCharacters = 65 // max digits, 64 should be enough but just in case
        let maxDigitsBeforePrintExponent: Int = 6

        if value == T.infinity {
            print("infinity")
            print(terminator)
            return maxCharacters
        }

        if value.isNaN {
            print("NaN")
            print(terminator)
            return maxCharacters
        }

        if value == T.signalingNaN {
            print("NaN*")
            print(terminator)
            return maxCharacters
        }

        if value == T.greatestFiniteMagnitude {
            print("max")
            print(terminator)
            return maxCharacters
        }

        if value == T.pi {
            print("pi")
            print(terminator)
            return maxCharacters
        }

        var i = maxCharacters
        
        print("floating point print not yet working")

//        if (value.exponent < maxDigitsBeforePrintExponent
//        && value.exponent > -maxDigitsBeforePrintExponent)
//        || forceFullPrint {
//
//            if value.sign == .minus {
//                print("-")
//                i -= 1
//            }
//
//            func printRemainder(_ v: T) {
//                guard i > 0 else { return } // we are out of space
//    
//                let remainder = v.remainder(dividingBy: 10.0)
//                let quotient = (v - remainder) / 10.0
//
//                if quotient > 0 {
//                    printRemainder(quotient)
//                }
//    
//                i -= 1
//    
//                print(nybble: UInt8(Int(remainder)))
//            }
//        
//            printRemainder(value)
//
//        } else {
//            i -= print(value.significand, forceFullPrint: true, terminator: "")
//            print("e")
//            i -= 1
//            print(value.exponent)
//        }

        print(terminator)

        return i
    }

    private static func print(nybble: UInt8) {
        let nybble = nybble & 0x0f
        if nybble > 9 {
            write(nybble+55)
        } else {
            write(nybble+48)
        }
    }
}
