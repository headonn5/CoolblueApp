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
        guard let image = UIImage(systemName: "star.circle.fill")?.withTintColor(.systemGreen),
              let font = UIFont(name: "HelveticaNeue", size: 14.0) else {
                  return NSAttributedString()
        }
        
        filledStar.image = image.withConfiguration(imageConfig)
        filledStar.bounds = CGRect(x: 0.0, y: (font.capHeight - image.size.height)/2, width: image.size.width, height: image.size.height)
        
        let attributedString = NSMutableAttributedString(attachment: filledStar)
        let descriptionString = " \(product.reviewInformation.reviewSummary.reviewAverage) (\(product.reviewInformation.reviewSummary.reviewCount) reviews)"
        attributedString.append(NSAttributedString(string: descriptionString))
        return attributedString
    }

    var formattedUSPs: NSAttributedString {
        let bulletPoint = NSTextAttachment()
        let imageConfig = UIImage.SymbolConfiguration(scale: .small)
        guard let image = UIImage(systemName: "checkmark.circle")?.withTintColor(.systemGray),
              let font = UIFont(name: "HelveticaNeue", size: 14.0) else {
                  return NSAttributedString()
        }
        
        bulletPoint.image = image.withConfiguration(imageConfig)
        bulletPoint.bounds = CGRect(x: 0.0, y: (font.capHeight - image.size.height)/2, width: image.size.width, height: image.size.height)
        
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
