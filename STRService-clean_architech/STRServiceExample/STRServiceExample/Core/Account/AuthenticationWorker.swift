//
//  AuthenticationWorker.swift
//  STRServiceExample
//
//  Created by Anh Tran on 3/15/19.
//


public struct AuthenticationWorker:AuthenticationWorkerType {
    private var service: AuthenticationService
    init(service:AuthenticationService) {
        self.service = service
    }
}

public extension AuthenticationWorker {
    var isAuthorized:Bool{
        return service.isAuthorized
    }
    
    func signup(with request: Any, completion: @escaping () -> Void) {
        service.signup(with: request, completion: completion)
    }
    
    func login(with request: Any, completion: @escaping () -> Void) {
        service.login(with: request, completion: completion)
    }
    
    func logout() {
        service.logout()
    }
}
