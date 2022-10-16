//
//  Products.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import Foundation

struct ProductsResponse: Decodable {
    let products : [Product]
    let currentPage : Int
    let pageSize : Int
    let totalResults : Int
    let pageCount : Int
}
