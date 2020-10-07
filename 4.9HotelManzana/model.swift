//
//  model.swift
//  4.9HotelManzana
//
//  Created by Sophie Kim on 2020/09/25.
//

import Foundation

struct Registration {
    var firstName: String = ""
    var lastName: String = ""
    var emailAddress: String = ""
    
    var checkInDate: Date = Date()
    var checkOutDate: Date = Date()
    var numberOfAdults: Int = .zero
    var numberOfChildren: Int = .zero
    
    var roomType: RoomType?
    var wifi: Bool = false
    
    var numberOfNights: Int = .zero
    var roomTypeCharges: Int = .zero
    var wifiCharges: Int = .zero
    var totalCharges: Int = .zero
}

extension Registration: CustomStringConvertible {
    var description: String {
        return """
            firstName: \(firstName)
            lastName: \(lastName)
            emailAddress: \(emailAddress)
            checkInDate: \(checkInDate)
            checkOutDate: \(checkOutDate)
            numberOfAdults: \(numberOfAdults)
            numberOfChildren: \(numberOfChildren)
            roomType: \(roomType)
            wifi: \(wifi)
            numberOfNights: \(numberOfNights)
            """
    }
}

extension Registration {
    var isValid: Bool {
        if firstName.isEmpty || lastName.isEmpty || emailAddress.isEmpty || numberOfAdults+numberOfChildren == 0 || roomType == nil || numberOfNights == 0 {
            return false
        } else {
            return true
        }
    }
}

struct RoomType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    static var all: [RoomType] {
        return [
            RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
            RoomType(id: 1, name: "One King", shortName: "K", price: 209),
            RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309)
        ]
    }
}

func ==(lhs: RoomType, rhs: RoomType) -> Bool {
    return lhs.id == rhs.id
}
