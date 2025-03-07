//
//  DateFormatHelper.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 07/03/25.
//

import Foundation

class DateFormatHelper {
    func format(dateString fromAPI: String?) -> String? {
        let formatter = API.dateFormatter
        
        guard let date = formatter.date(from: fromAPI ?? "") else {
            return nil
        }
        
        return format(date: date)
    }
    
    func format(date toUI: Date) -> String {
        return "\(formattedDay(for: toUI)), \(formattedHour(for: toUI))"
    }
    
    private func formattedDay(for date: Date) -> String {
        guard !Calendar.current.isDateInToday(date) else {
            return "Hoje"
        }
        
        if withinNextSevenDays(date: date) {
            let formatter = DateFormatter()
            formatter.dateFormat = "E"
            
            return formatter.string(from: date)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        
        return formatter.string(from: date)
    }
    
    private func withinNextSevenDays(date: Date) -> Bool {
        guard let sevenDaysFromNow = Calendar.current.date(byAdding: .day, value: 7, to: Date()) else {
            return false
        }
        
        let inSameDay = Calendar.current.isDate(date, inSameDayAs: sevenDaysFromNow)
        
        return date <= sevenDaysFromNow || inSameDay
    }
    
    private func formattedHour(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: date)
    }
}
