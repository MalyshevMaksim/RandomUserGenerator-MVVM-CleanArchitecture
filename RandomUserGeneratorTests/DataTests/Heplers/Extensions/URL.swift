//
//  URL.swift
//  RandomUserGeneratorTests
//
//  Created by Малышев Максим Алексеевич on 12/3/20.
//

import Foundation

extension URL {
    static public var successUrl: URL? {
        return URL(string: "https://www.google.com")
    }
    
    static public var failureUrl: URL? {
        return URL(string: "")
    }
}
