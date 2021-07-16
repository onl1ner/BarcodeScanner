//
//  GoogleResponse.swift
//  BarcodeScanner
//
//  Created by onl1ner onl1ner on 04.09.2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import Foundation

struct GoogleResponse : Decodable {
    let items : [GoogleItems]
}

struct GoogleItems : Decodable {
    let link : String
}
