# printing

(these functions are in an extension on the protocol Usart)

`public static func print(_ msg: StaticString)`
print a simple static string to the USART

`public static func print<T: BinaryInteger>(_ value: T,
    radix: UInt8 = 10,
    terminator: StaticString = "\n") `
simple integer number print

`public static func print<T: BinaryFloatingPoint>(_ value: T,
    forceFullPrint: Bool = false,
    terminator: StaticString = "\n")`
print floating point number (NOT WORKING YET)


Here's a simple hello world example...

```
import ATmega328P
import serial
import print

ATmega328P.Usart0.setupSerial()

ATmega328P.Usart0.print("Integer...")
ATmega328P.Usart0.print(42)
```