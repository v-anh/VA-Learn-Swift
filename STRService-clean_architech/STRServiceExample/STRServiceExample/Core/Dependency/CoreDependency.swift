//
//  CoreDependency.swift
//  STRServiceExample
//
//  Created by Anh Tran on 3/15/19.
//

open class CoreDependency:Dependency{
    public func resolveWorker() -> CharacterWorkerType {
        return CharacterWorker(service: resolveService())
    }
    
    public func resolveService() -> CharacterService {
        return CharacterService()
    }
    
    //need update
    public func resolveStore() -> HTTPService {
        return HTTPService()
    }
    
    //need update
    public func resolveCache() -> HTTPService {
        return HTTPService()
    }
    
    init() {
    }
    
    public func resoveService() -> HTTPService {
        return HTTPService()
    }
    
    public func resolveWorker() -> AuthenticationWorkerType {
        return AuthenticationWorker(service: resolveService())
    }
    
    public func resolveService() -> AuthenticationService {
        return AuthenticationNetworkService(httpService: resoveService())
    }
}
