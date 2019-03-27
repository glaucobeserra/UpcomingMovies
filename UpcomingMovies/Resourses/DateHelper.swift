//
//  DateHelper.swift
//  UpcomingMovies
//
//  Created by Glauco Dantas Beserra on 25/03/19.
//  Copyright © 2019 Glauco Dantas Beserra. All rights reserved.
//

import Foundation

class DateHelper {
    
    static let shared = DateHelper()
    
    lazy var calendar: Calendar = {
        var cal = Calendar.current
        cal.locale = Locale.current
        cal.timeZone = TimeZone.current
        return cal
    }()
}


