//
//  Dependency.swift
//  STRServiceExample
//
//  Created by Anh Tran on 3/15/19.
//


public protocol Dependency {
    func resoveService() -> HTTPService
    func resolveWorker() -> AuthenticationWorkerType
    func resolveService() -> AuthenticationService
    func resolveStore() -> HTTPService
    func resolveCache() -> HTTPService
    
    func resolveWorker() -> CharacterWorkerType
    
    func resolveService() -> CharacterService
}
