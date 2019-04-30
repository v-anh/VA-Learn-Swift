//
//  CoreDependency.swift
//  STRServiceExample
//
//  Created by Anh Tran on 3/15/19.
//
import STRService

open class CoreDependency:Dependency{
    public func resolveWorker() -> HearthstoneCardsWorkerType {
        return HearthstoneCardsWorker(service: ListHearthstoneCardsService())
    }
    
    //need update
//    public func resolveStore() -> HTTPService {
//        return HTTPService()
//    }
    
    //need update
//    public func resolveCache() -> HTTPService {
//        return HTTPService()
//    }
    
    public func resoveService() -> HTTPService {
        return HTTPService()
    }
    
    public func resolveWorker() -> AuthenticationWorkerType {
        return AuthenticationWorker(service: resolveService())
    }
    
    public func resolveService() -> AuthenticationService {
        return AuthenticationNetworkService(httpService: resoveService())
    }
    
    //Dependency for Character
    public func resolveWorker() -> CharacterWorkerType {
        return CharacterWorker(service: CharacterService())
    }
    
    //Dependency for List Characters
    public func resolveWorker() -> CharactersWorkerType {
        return CharactersWorker(service: ListCharactersService())
    }
}
