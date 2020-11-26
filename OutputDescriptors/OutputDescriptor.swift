//
//  OutputDescriptor.swift
//  OutputDescriptor
//
//  Created by Sjors Provoost on 13/12/2019.
//  Copyright © 2019 Sjors Provoost. Distributed under the MIT software
//  license, see the accompanying file LICENSE.md
//
//  Checksum code based on: https://github.com/bitcoin/bitcoin/blob/v0.19.0.1/test/functional/test_framework/descriptors.py

import Foundation

public struct OutputDescriptor {
    let INPUT_CHARSET = "0123456789()[],'/*abcdefgh@:$%{}IJKLMNOPQRSTUVWXYZ&+-.;<=>?!^_|~ijklmnopqrstuvwxyzABCDEFGH`#\"\\ "
    let CHECKSUM_CHARSET = "qpzry9x8gf2tvdw0s3jn54khce6mua7l"
    let GENERATOR = [0xf5dee51989, 0xa9fdca3312, 0x1bab10e32d, 0x3706b1677a, 0x644d626ffd]
    
    enum ParseError: Error {
        case tooShort
        case invalidCharacter
        case invalidChecksum
    }
    
    let descriptor: String
    
    public init (_ descriptor: String) throws {
        guard descriptor.count != 0 else {
            throw ParseError.tooShort
        }
        for c in descriptor {
            guard(INPUT_CHARSET.contains(c)) else {
                throw ParseError.invalidCharacter
            }
        }
        let maybeChecksum = descriptor.suffix(9)
        if maybeChecksum.prefix(1) == "#" {
            self.descriptor = String(descriptor.dropLast(9))
            print(self.descriptor)
            print(self.checksum)
            print(maybeChecksum.dropFirst())
            guard maybeChecksum.dropFirst() == self.checksum else {
                throw ParseError.invalidChecksum
            }
        } else {
            self.descriptor = descriptor
        }
    }

    // Internal function that computes the descriptor checksum
    func descsum_polymod(_ symbols: [Int]) -> Int {
        var chk: Int = 1
        for value in symbols {
            let top = chk >> 35
            chk = (chk & 0x7ffffffff) << 5 ^ value
            for i in (0...5) {
                chk ^= ((top >> i) & 1) != 0 ? GENERATOR[i] : 0
            }
        }
        return chk
    }
    
    // Internal function that does the character to symbol expansion
    func descsum_expand(_ s: String) -> [Int] {
        var groups: [Int] = []
        var symbols: [Int] = []
        for c in s {
            precondition(INPUT_CHARSET.contains(c))
            let index = INPUT_CHARSET.firstIndex(of: c)!
            let v: Int = INPUT_CHARSET.distance(from: INPUT_CHARSET.startIndex, to: index)
            symbols.append(v & 31)
            groups.append(v >> 5)
            if groups.count == 3 {
                symbols.append(groups[0] * 9 + groups[1] * 3 + groups[2])
                groups = []
            }
        }
        if groups.count == 1 {
            symbols.append(groups[0])
        } else if groups.count == 2 {
            symbols.append(groups[0] * 3 + groups[1])
        }
        return symbols
    }

    public var checksum: String {
        let symbols = descsum_expand(self.descriptor) + [0, 0, 0, 0, 0, 0, 0, 0]
        let checksum = descsum_polymod(symbols) ^ 1
        
        var result = ""
        for i in 0..<8 {
            let offset = (checksum >> (5 * (7 - i))) & 31
            let checksumChar = CHECKSUM_CHARSET[CHECKSUM_CHARSET.index(CHECKSUM_CHARSET.startIndex, offsetBy: offset)]
            result += String(checksumChar)
        }
        
        return result
    }

}
