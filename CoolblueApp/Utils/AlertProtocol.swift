//
//  AlertProtocol.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import UIKit

protocol AlertProtocol where Self: UIViewController {}

extension AlertProtocol {
    func showAlert(title: String,
                   message: String,
                   alertStyle: UIAlertController.Style = .alert,
                   completionHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        // Do not show alert on top of another alert
        if let vc = presentedViewController as? UIAlertController {
            vc.dismiss(animated: true) { [weak self] in
                self?.present(alert, animated: true, completion: completionHandler)
            }
        }
        else {
            present(alert, animated: true, completion: completionHandler)
        }
    }
}
