//
//  UITableView+Extensions.swift
//  UpcomingMovies
//
//  Created by Glauco Dantas Beserra on 25/03/19.
//  Copyright © 2019 Glauco Dantas Beserra. All rights reserved.
//

import UIKit

extension UITableView {
    
    func deselectSelectedRow(animated: Bool){
        if let indexPathForSelectedRow = self.indexPathForSelectedRow{
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }
    
}
