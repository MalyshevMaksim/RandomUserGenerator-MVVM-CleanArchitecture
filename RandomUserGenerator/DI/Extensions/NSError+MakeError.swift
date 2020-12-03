//
//  NSError+MakeError.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 12/1/20.
//

import Foundation

extension NSError {
    static public func makeError(withMessage message: String) -> NSError {
        return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
