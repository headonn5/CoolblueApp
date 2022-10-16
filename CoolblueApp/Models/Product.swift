//
//  File.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import Foundation

struct Product: Decodable {
    let productId : Int
    let productName : String
    let reviewInformation : ReviewInformation
    let USPs : [String]
    let availabilityState : Int
    let salesPriceIncVat : Double
    let productImage : String
    let coolbluesChoiceInformationTitle : String?
    let promoIcon : PromoIcon?
    let nextDayDelivery : Bool
    let listPriceIncVat: Int?
    let listPriceExVat: Double?
}
