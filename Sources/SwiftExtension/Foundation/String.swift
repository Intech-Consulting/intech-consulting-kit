import Foundation

public extension String {
    
    /// Create a new random string of given length.
	///
	/// - Parameter random: Number of characters in string.
	/// - Parameter prefix: Prepend to string.
    init(random: Int, prefix: String = "") {
        // https://github.com/SwifterSwift/SwifterSwift
		let base = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        
        self = random > 0
            ? (0..<random).reduce(prefix) { result, next in result + "\(base.random())" }
            : prefix
	}
}

public extension String {
    
    /// Check if string is valid email format.
    var isEmail: Bool {
        return match(IntechConsultingConstants.RegEx.EMAIL)
    }

	/// Check if string contains only numbers.
    var isNumber: Bool {
        return match(IntechConsultingConstants.RegEx.NUMBER)
    }

	/// Check if string contains only letters.
    var isAlpha: Bool {
        return match(IntechConsultingConstants.RegEx.ALPHA)
    }

	/// Check if string contains at least one letter and one number.
    var isAlphaNumeric: Bool {
        return match(IntechConsultingConstants.RegEx.ALPHANUMERIC)
    }

    /// String with no spaces or new lines in beginning and end.
    var trimmed: String {
        return trimmingCharacters(in: .whitespaces)
    }
}

// MARK: - Regular Expression
public extension String {

    /**
     Replaces a string using a regular expression pattern.
     
     - parameter value: the value of the string
     - parameter pattern: the regular expression value
     - parameter replacement: the value to replace with
     
     - returns: the value with the replaced string
     */
    func replace(regex: String, with replacement: String, caseSensitive: Bool = false) -> String {
        guard !isEmpty else { return self }
        
        // Determine options
        var options: CompareOptions = [.regularExpression]
        if !caseSensitive {
            options.insert(.caseInsensitive)
        }
        
        return replacingOccurrences(of: regex, with: replacement, options: options)
    }
    
    /// Matches a string using a regular expression pattern.
    ///
    /// - Parameters:
    ///   - pattern: the regular expression value
    ///   - caseSensitive: case-sensitive search
    /// - Returns: whether the regex matches in the string
    func match(_ pattern: String, caseSensitive: Bool = false) -> Bool {
        // Determine options
        var options: CompareOptions = [.regularExpression]
        if !caseSensitive {
            options.insert(.caseInsensitive)
        }
        
        return range(of: pattern, options: options) != nil
    }

}

public extension String {

    /// Truncated string (limited to a given number of characters).
	///
	/// - Parameters:
	///   - toLength: maximum number of characters before cutting.
	///   - trailing: string to add at the end of truncated string.
	/// - Returns: truncated string (this is an extr...).
    func truncated(_ length: Int, trailing: String = "...") -> String {
        guard 1..<count ~= length else { return self }
		return prefix(length) + trailing
	}


    /// Determines if the given value is contained in the string.
    ///
    /// - Parameter find: The value to search for.
    /// - Returns: True if the value exists in the string, false otherwise.
    func contains(_ find: String) -> Bool {
        return range(of: find) != nil
    }
    
    /// Injects a separator every nth characters.
    ///
    /// - Parameters:
    ///   - every: Number of characters to separate by.
    ///   - separator: The separator to inject.
    /// - Returns: The string with the injected separator.
    func separate(every: Int, with separator: String) -> String {
        guard !isEmpty, 1...count ~= every else { return self }
        
        //https://stackoverflow.com/a/47566321/235334
        return String(
            stride(from: 0, to: count, by: every)
                .map { Array(Array(self)[$0..<min($0 + every, count)]) }
                .joined(separator: separator)
        )
    }
}

// MARK: - Web utilities
public extension String {
	
	/// Readable string from a URL string.
	var urlDecoded: String {
		return removingPercentEncoding ?? self
	}
	
	/// URL escaped string.
	var urlEncoded: String {
		return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
	}
    
    /// Stripped out HTML to plain text.
    var htmlStripped: String {
        return replace(regex: "<[^>]+>", with: "")
    }
    
    /// Decode an HTML string
    var htmlDecoded: String {
        // http://stackoverflow.com/questions/25607247/how-do-i-decode-html-entities-in-swift
        guard !isEmpty else { return self }
        
        var position = startIndex
        var result = ""
        
        // Mapping from XML/HTML character entity reference to character
        // From http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
        let characterEntities: [String: Character] = [
            // XML predefined entities:
            "&quot;": "\"",
            "&amp;": "&",
            "&apos;": "'",
            "&lt;": "<",
            "&gt;": ">",
            
            // HTML character entity references:
            "&nbsp;": "\u{00a0}"
        ]
        
        // ===== Utility functions =====
        
        // Convert the number in the string to the corresponding
        // Unicode character, e.g.
        //    decodeNumeric("64", 10)   --> "@"
        //    decodeNumeric("20ac", 16) --> "€"
        func decodeNumeric(_ string: String, base : Int32) -> Character? {
            let code = UInt32(strtoul(string, nil, base))
            return Character(UnicodeScalar(code)!)
        }
        
        // Decode the HTML character entity to the corresponding
        // Unicode character, return `nil` for invalid input.
        //     decode("&#64;")    --> "@"
        //     decode("&#x20ac;") --> "€"
        //     decode("&lt;")     --> "<"
        //     decode("&foo;")    --> nil
        func decode(_ entity: String) -> Character? {
            return entity.hasPrefix("&#x") || entity.hasPrefix("&#X")
                ? decodeNumeric(entity[3...]!, base: 16)
                : entity.hasPrefix("&#")
                    ? decodeNumeric(entity[2...]!, base: 10)
                : characterEntities[entity]
        }
        
        // Find the next '&' and copy the characters preceding it to `result`:
        while let ampRange = range(of: "&", range: position..<endIndex) {
            result.append(String(self[position..<ampRange.lowerBound]))
            position = ampRange.lowerBound
            
            // Find the next ';' and copy everything from '&' to ';' into `entity`
            guard let semiRange = range(of: ";", range: position..<endIndex) else { break }
            
            let entity = self[position..<semiRange.upperBound]
            position = semiRange.upperBound
            
            if let decoded = decode(String(entity)) {
                // Replace by decoded character:
                result.append(decoded)
            } else {
                // Invalid entity, copy verbatim:
                result.append(String(entity))
            }
        }
        
        // Copy remaining characters to result
        result.append(String(self[position..<endIndex]))
        return result
    }
}

// MARK: - Subscript for ranges
// https://github.com/SwifterSwift/SwifterSwift
public extension String {
	
	/// Safely subscript string with index.
	///
	/// - Parameter i: index.
	subscript(i: Int) -> String? {
        guard 0..<count ~= i else { return nil }
        return String(self[index(startIndex, offsetBy: i)])
	}
	
	/// Safely subscript string within a half-open range.
	///
	/// - Parameter range: Half-open range.
	subscript(range: CountableRange<Int>) -> String? {
		guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex),
            let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex)
            else { return nil }
        
		return String(self[lowerIndex..<upperIndex])
	}
	
	/// Safely subscript string within a closed range.
	///
	/// - Parameter range: Closed range.
	subscript(range: ClosedRange<Int>) -> String? {
		guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex),
            let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex)
            else { return nil }
        
		return String(self[lowerIndex..<upperIndex])
	}
    
    /// Safely subscript string from the lower range to the end of the string.
    ///
    /// - Parameter range: A partial interval extending upward from a lower bound that forms a sequence of increasing values..
    subscript(range: CountablePartialRangeFrom<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex)
            else { return nil }
        
        return String(self[lowerIndex..<endIndex])
    }
}

public extension String {
    
    private static let numberFormatter = NumberFormatter()
    
    /// Returns a new string with removing all grouping separators using the current locale.
    private func removeGroupingSeparator() -> String {
        guard let groupingSeparator = Locale.current.groupingSeparator else { return self }
        return replacingOccurrences(of: groupingSeparator, with: "")
    }

    /// Returns an integer created by parsing a given string with locale consideration.
    var intValue: Int? {
        return String.numberFormatter.number(from: removeGroupingSeparator())?.intValue
    }

    /// Returns a double created by parsing a given string with locale consideration.
    var doubleValue: Double? {
        return String.numberFormatter.number(from: removeGroupingSeparator())?.doubleValue
    }

    /// Returns an float created by parsing a given string with locale consideration.
    var floatValue: Float? {
        return NumberFormatter().number(from: removeGroupingSeparator())?.floatValue
    }

    /// Returns an bool created by parsing a given string with locale consideration.
    var boolValue: Bool? {
        return String.numberFormatter.number(from: self)?.boolValue
    }
}

public extension String {
    
    /// Encode a string to Base64
    var base64Encoded: String {
        return Data(self.utf8).base64EncodedString()
    }
    
    /// Decode a string from Base64
    var base64Decoded: String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// URL safe encode a string to Base64
    var base64URLEncoded: String {
        return base64Encoded
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "=", with: "")
    }
}

public extension Substring {
    
    var string: String {
        return String(self)
    }
}

public extension Optional where Wrapped == String {

    /// A Boolean value indicating whether a string is `nil` or has no characters.
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
