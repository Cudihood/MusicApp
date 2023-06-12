//
//  AlertFactory.swift
//  MusicApp
//
//  Created by Даниил Циркунов on 12.06.2023.
//

import UIKit

protocol AlertFactoryProtocol
{
    func createAlert(title: String, message: String) -> UIAlertController
}

class DefaultAlertFactory: AlertFactoryProtocol
{
    func createAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
}

class ErrorAlert: DefaultAlertFactory
{
    override func createAlert(title: String, message: String) -> UIAlertController {
        let alert = super.createAlert(title: title, message: message)
        // Дополнительная конфигурация алерта для ошибок
        alert.title = "Ошибка"
        alert.message = "Произошла ошибка: \(message)"
        alert.addAction(UIAlertAction(title: "Повторить", style: .default, handler: { _ in
            // Обработка нажатия кнопки "Повторить"
            // ...
        }))
        return alert
    }
}
