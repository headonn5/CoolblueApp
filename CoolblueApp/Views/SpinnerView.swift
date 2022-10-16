//
//  SpinnerView.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import UIKit

struct SpinnerView {
    private static var spinner: UIActivityIndicatorView?
    
    static func showSpinner(on view: UIView) {
        DispatchQueue.main.async {
            // If spinner is nil, create one on the key window
            if spinner == nil, let window = view.window?.windowScene?.keyWindow {
                let spinner = UIActivityIndicatorView(frame: UIScreen.main.bounds)
                window.addSubview(spinner)
                self.spinner = spinner
            }
            spinner?.startAnimating()
        }
    }
    
    static func hideSpinner() {
        DispatchQueue.main.async {
            if spinner != nil {
                spinner?.stopAnimating()
                spinner?.removeFromSuperview()
                spinner = nil
            }
        }
    }
}
