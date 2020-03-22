//
//  BarcodeDB.swift
//  BarcodeScanner
//
//  Created by onl1ner onl1ner on 22/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import Foundation

struct Name : Codable{
    let status : NSInteger
    let names : Array<String>
}

struct Class : Codable{
    let status : NSInteger
    let `class` : Array<String>
}
