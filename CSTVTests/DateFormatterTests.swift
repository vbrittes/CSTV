//
//  DateFormatterTests.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 08/03/25.
//

import XCTest
@testable import CSTV

final class DateFormatterHelperTests: XCTestCase {
    
    var sut: DateFormatHelper!
    let baseDate = DateFormatHelper.baseDate
    
    override func setUp() {
        sut = DateFormatHelper(now: DateFormatHelper.baseDate)
    }
    
    func testInvalidString() {
        let result = sut.format(dateString: "xxx")
        
        XCTAssertNil(result)
    }
    
    func testToday() {
        let oneSecAhead = Calendar.current.date(byAdding: .second, value: 1, to: baseDate)!
        let result = sut.format(date: oneSecAhead)
        
        XCTAssertEqual(result, "Hoje, 14:15")
    }
    
    func testSameWeek() {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: baseDate)!
        let result = sut.format(date: tomorrow)
        
        XCTAssertTrue(result == "Sun, 14:15" || result == "Dom, 14:15", result)
    }
    
    func testFarFuture() {
        let farFuture = Calendar.current.date(byAdding: .day, value: 8, to: baseDate)!
        let result = sut.format(date: farFuture)
        
        XCTAssertEqual(result, "16.03, 14:15")
    }
}

extension DateFormatHelper {
    static var baseDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = formatter.date(from: "2025-03-08 14:15:16")!
        
        return date
    }
}
