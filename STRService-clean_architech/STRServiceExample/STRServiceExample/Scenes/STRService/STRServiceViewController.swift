import UIKit
import STRService
import OHHTTPStubs
class STRServiceViewController: UIViewController, HasDependencies {
    
    private lazy var authenticationWorker: AuthenticationWorkerType = dependencies.resolveWorker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createStubForTest()
    }
    func testLoginService() {
        authenticationWorker.login(with: "bla") {
            print("blablabla")
        }
        
//        STRConfig.shared.config?.enableToken = true
//        LoginService().execute(onSuccess: { (data) in
//            print(data)
//            if let dataLogin = data as? User {
//
//                STRConfig.shared.setupRefreshToken(tokenConfig: RefreshTokenConfig(tokenFirstTime: dataLogin.token, tokenParameterKey: "token", requestTokenData: RequestData(path: "https://test.com/refreshToken")))
//            }
//
//        }) { (error) in
//            print(error)
//        }
    }
    
    func testRefreshToken() {
//        ProfileService().execute(onSuccess: { (data) in
//            print(data)
//        }) { (error) in
//            print(error)
//        }
    }
    
    @IBAction func abtnUsers(_ sender: Any) {
        testLoginService()
    }
    
    @IBAction func btnRefreshToken(_ sender: Any) {
        testRefreshToken()
    }
    
    func createStubForTest() {
        stub(condition: isPath("/login") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: ["id": 234,
                             "username": "NCHAI",
                             "token": "zaqwsxcde"
                    ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        stub(condition: isPath("/profile") ) { _ in
            if UserDefaults.standard.bool(forKey: "testRefreshToken") {
                UserDefaults.standard.set(false, forKey: "testRefreshToken")
                return OHHTTPStubsResponse(
                    jsonObject: ["fullname": "Ngo Chi Hai",
                                 "avatar": "https://image.com/avatar"
                    ],
                    statusCode: 200,
                    headers: [ "Content-Type": "application/json" ]
                )
            } else {
                UserDefaults.standard.set(true, forKey: "testRefreshToken")
                return OHHTTPStubsResponse(
                    jsonObject: ["fullname": "Ngo Chi Hai",
                                 "avatar": "https://image.com/avatar"
                    ],
                    statusCode: 460,
                    headers: [ "Content-Type": "application/json" ]
                )
            }
        }
        
        stub(condition: isPath("/refreshToken") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: ["token": "tghbnmghjjk"
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
    }
}

