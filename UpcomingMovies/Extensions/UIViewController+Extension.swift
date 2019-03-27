//
//  UIViewController+Extension.swift
//  UpcomingMovies
//
//  Created by Glauco Dantas Beserra on 26/03/19.
//  Copyright © 2019 Glauco Dantas Beserra. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(with title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
}
