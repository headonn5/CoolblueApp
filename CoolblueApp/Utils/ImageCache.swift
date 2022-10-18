//
//  ImageCache.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 19/10/22.
//

import Foundation

class ImageCache {
    private let nsCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    static let shared = ImageCache()
    
    subscript(urlString: String) -> Data? {
        get {
            nsCache.object(forKey: NSString(string: urlString)) as Data?
        }
        set {
            if let value = newValue {
                nsCache.setObject(value as NSData, forKey: NSString(string: urlString))
            }
        }
    }
}
