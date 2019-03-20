//
//  AuthenticationNetworkService.swift
//  STRServiceExample
//
//  Created by Anh Tran on 3/15/19.
//

public struct AuthenticationNetworkService:AuthenticationService{
    private let httpService :HTTPService
    
    init(httpService:HTTPService) {
        self.httpService = httpService
    }
}

public extension AuthenticationNetworkService {
    var isAuthorized:Bool{
        return true
    }
    
    func signup(with request: Any, completion: @escaping () -> Void) {
        print("AuthenticationNetworkService.signup")
        
        httpService.post(url: "", parameters: [:], headers: [:]) {
            completion()
        }
    }
    
    func login(with request: Any, completion: @escaping () -> Void) {
        print("AuthenticationNetworkService.signup")
        
        httpService.post(url: "", parameters: [:], headers: [:]) {
            completion()
        }
    }
    
    func logout() {
        
    }
}
