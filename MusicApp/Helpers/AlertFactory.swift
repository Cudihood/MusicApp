//
//  AlertFactory.swift
//  MusicApp
//
//  Created by Даниил Циркунов on 12.06.2023.
//

import UIKit

class AlertFactory {
    static func createAlert(title: String?, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
}
