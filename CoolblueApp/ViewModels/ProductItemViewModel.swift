//
//  ProductItemViewModel.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import Foundation
import UIKit

class ProductItemViewModel {
    let product: Product
    let imageService: ImageServiceProtocol
    
    var formattedReview: NSAttributedString {
        let filledStar = NSTextAttachment()
        let imageConfig = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "star.circle.fill")?.withTintColor(.systemGreen)
        filledStar.image = image?.withConfiguration(imageConfig)
        let attributedString = NSMutableAttributedString(attachment: filledStar)
        let descriptionString = " \(product.reviewInformation.reviewSummary.reviewAverage) (\(product.reviewInformation.reviewSummary.reviewCount)) reviews"
        attributedString.append(NSAttributedString(string: descriptionString))
        return attributedString
    }

    var formattedUSPs: NSAttributedString {
        let bulletPoint = NSTextAttachment()
        let imageConfig = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "checkmark.circle")?.withTintColor(.systemGray)
        bulletPoint.image = image?.withConfiguration(imageConfig)
        let attributedString = NSMutableAttributedString(string: "")
        for usp in product.USPs {
            attributedString.append(NSAttributedString(attachment: bulletPoint))
            attributedString.append(NSAttributedString(string: " \(usp)"))
            attributedString.append(NSAttributedString(string: "\n"))
        }
        return attributedString
    }

    var formattedPrice: String {
        return String(format: "$ %.2f", product.salesPriceIncVat)
    }
    
    var name: String {
        return product.productName
    }
    
    var imagePath: String {
        return product.productImage
    }
    
    init(product: Product, imageService: ImageServiceProtocol) {
        self.product = product
        self.imageService = imageService
    }
}
