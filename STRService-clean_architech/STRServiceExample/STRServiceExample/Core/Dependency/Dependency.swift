//
//  Dependency.swift
//  STRServiceExample
//
//  Created by Anh Tran on 3/15/19.
//
import STRService

public protocol Dependency {
    func resolveWorker() -> AuthenticationWorkerType
    func resolveService() -> AuthenticationService
//    func resolveStore() -> HTTPService
//    func resolveCache() -> HTTPService
    
    //Dependency for Character
    func resolveWorker() -> CharacterWorkerType
    
    //Dependency for List Character
    func resolveWorker() -> CharactersWorkerType
    
    //Dependency for List Character
    func resolveWorker() -> HearthstoneCardsWorkerType
}
