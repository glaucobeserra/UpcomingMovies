//
//  Result.swift
//  UpcomingMovies
//
//  Created by Glauco Dantas Beserra on 26/03/2019.
//  Copyright © 2019 Glauco Dantas Beserra. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
