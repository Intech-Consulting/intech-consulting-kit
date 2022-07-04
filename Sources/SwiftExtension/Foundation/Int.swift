import Foundation

public extension Int {
    
    /// Request a random number in a range.
    ///
    /// - Parameter range: Specify boundries of random number.
    /// - Returns: A random number.
    static func random(in range: CountableClosedRange<Int> ) -> Int {
        // https://stackoverflow.com/a/26140302
        var offset = 0

        // Allow negative ranges
        if range.lowerBound < 0 {
            offset = abs(range.lowerBound)
        }

        let minimum = UInt32(range.lowerBound + offset)
        let maximum = UInt32(range.upperBound + offset)

        return Int(minimum + arc4random_uniform(maximum - minimum + 1)) - offset
    }
    
    /// Request a random number in a range.
    ///
    /// - Parameter range: Specify boundries of random number.
    /// - Returns: A random number.
    static func random(in range: CountableRange<Int>) -> Int {
        return random(in: range.lowerBound...range.upperBound - 1)
    }
}
