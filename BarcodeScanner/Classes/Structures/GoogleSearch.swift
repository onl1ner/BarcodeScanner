//
//  GoogleSearch.swift
//  BarcodeScanner
//
//  Created by onl1ner onl1ner on 22/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import Foundation

struct GoogleImage : Codable{
    let contextLink : String
    let height : NSInteger
    let width : NSInteger
    let byteSize : NSInteger
    let thumbnailLink : String
    let thumbnailHeight : NSInteger
    let thumbnailWidth : NSInteger
}

struct GoogleItems : Codable{
    let kind : String
    let title : String
    let htmlTitle : String
    let link : String
    let displayLink : String
    let snippet : String
    let htmlSnippet : String
    let mime : String
    let fileFormat : String
    let image : GoogleImage?
}

struct GoogleURL : Codable{
    let type : String
    let template : String
}

struct GoogleRequest : Codable{
    let title : String
    let totalResults : String
    let searchTerms : String
    let count : NSInteger
    let startIndex : NSInteger
    let inputEncoding : String
    let outputEncoding : String
    let safe : String
    let cx : String
    let searchType : String
}

struct GoogleQueries : Codable{
    let request : [GoogleRequest]
    let nextPage : [GoogleRequest]
}

struct GoogleContext : Codable{
    let title : String
}

struct GoogleSearchInformation : Codable{
    let searchTime : Double
    let formattedSearchTime : String
    let totalResults : String
    let formattedTotalResults : String
}

struct GoogleResponse : Codable{
    let kind : String
    let url : GoogleURL
    let queries : GoogleQueries
    let context : GoogleContext
    let searchInformation : GoogleSearchInformation
    let items : [GoogleItems]
}
