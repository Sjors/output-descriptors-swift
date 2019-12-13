//
//  OutputDescriptor.swift
//  OutputDescriptor
//
//  Created by Sjors Provoost on 13/12/2019.
//  Copyright © 2019 Sjors Provoost. Distributed under the MIT software
//  license, see the accompanying file LICENSE.md

import Foundation

public struct OutputDescriptor {
    enum ParseError: Error {
        case tooShort
    }
    
    let descriptor: String
    
    public init (_ descriptor: String) throws {
        guard descriptor.count != 0 else {
            throw ParseError.tooShort
        }
        self.descriptor = descriptor
    }

}
