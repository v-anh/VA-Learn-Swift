//
//  AuthenticationInterface.swift
//  STRServiceExample
//
//  Created by Anh Tran on 3/15/19.
//
public protocol AuthenticationService {
    var isAuthorized:Bool {get}
    func signup(with request: Any, completion: @escaping () -> Void)
    func login(with request: Any, completion: @escaping () -> Void)
    func logout()
}

public protocol AuthenticationWorkerType:AuthenticationService{
    
}
