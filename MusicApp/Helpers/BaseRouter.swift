//
//  BaseRouter.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 01.06.2023.
//

import UIKit

class BaseRouter: NSObject {
    weak var viewController: UIViewController?
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
        super.init()
    }
}
