//
//  ExtendedKey.swift
//  ExtendedKey
//
//  Created by Sjors Provoost on 27/11/2020.
//  Copyright © 2020 Sjors Provoost. Distributed under the MIT software
//  license, see the accompanying file LICENSE.md

import Foundation

// TODO: use HDKey from https://github.com/blockchain/libwally-swift
public struct ExtendedKey {
    enum ParseError: Error {
        case invalid
    }
    
    public let fingerprint: String
    public let origin: String
    public let xpub: String
    public let derivation: String
    
    public init(_ key: String) throws {
        guard key.hasPrefix("[") else { throw ParseError.invalid }
        let originEndIndex = key.firstIndex(of: "]")
        guard originEndIndex != nil else { throw ParseError.invalid  }
        let originFull = key[...originEndIndex!]
        let originComponents = originFull.dropFirst().dropLast().components(separatedBy: "/")
        guard originComponents.count > 0 else { throw ParseError.invalid  }
        guard originComponents.first!.count == 8 else { throw ParseError.invalid  }
        self.fingerprint = String(originComponents.first!)
        // TODO: sanity check each component
        self.origin = "m/" + originComponents.dropFirst().joined(separator: "/")
        let suffixComponents = key[(originEndIndex!)...].dropFirst().split(separator: "/")
        guard suffixComponents.count > 0 else { throw ParseError.invalid  }
        self.xpub = String(suffixComponents.first!)
        self.derivation = suffixComponents.dropFirst().joined(separator: "/")
    }
}
