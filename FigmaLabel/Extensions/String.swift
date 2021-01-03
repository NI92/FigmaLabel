//
//  String.swift
//
//  Created by Nick Ignatenko on 2021-01-03.
//

import UIKit

extension String {
    
    func fullRange() -> NSRange {
        return NSRange(location: 0, length: count)
    }
    
    func rangeOfString(_ string: String) -> NSRange? {
        return rangesOfString(string).first
    }
    
    func rangesOfString(_ string: String) -> [NSRange] {
        let expression = try! NSRegularExpression(pattern: NSRegularExpression.escapedPattern(for: string), options: [])
        return expression.matches(in: self, options: [], range: fullRange()).map { $0.range }
    }
    
}
