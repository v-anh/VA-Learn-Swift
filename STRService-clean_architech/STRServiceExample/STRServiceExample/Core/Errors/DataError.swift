//
//  DataError.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/18/19.
//

enum DataError: Error {
    case nonExistent
    case unauthorized
    case noInternet
    case parseFailure(Error?)
    case databaseFailure(Error?)
    case cacheFailure(Error?)
    case networkFailure(Error?)
    case unknownReason(Error?)
}
