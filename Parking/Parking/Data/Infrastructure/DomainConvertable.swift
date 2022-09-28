//
//  DomainConvertable.swift
//  Parking
//
//  Created by Maxim Terpugov on 13.09.2022.
//


protocol DomainConvertable {
    associatedtype DomainEntity
    func parseToDomain() throws -> DomainEntity
}
