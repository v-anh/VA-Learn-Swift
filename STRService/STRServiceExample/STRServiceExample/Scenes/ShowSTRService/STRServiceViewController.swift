import UIKit
import STRService
import OHHTTPStubs
import netfox
import PromiseKit

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
    }
    
    func testRefreshToken() {
    }
    
    @IBAction func abtnUsers(_ sender: Any) {
        testLoginService()
    }
    
    @IBAction func btnRefreshToken(_ sender: Any) {
        testRefreshToken()
    }
    
    @IBAction func showNetFox(_ sender: Any) {
        NFX.sharedInstance().show()
    }
    
    @IBAction func btnGetAllCountries(_ sender: Any) {
        STRServiceCountries().execute().done { (result: [STRServiceCountriesModel]) in
            UIAlertController.showMessageWithOKButton(message: "Done", viewController: self)
            }.catch { (error) in
                
        }
    }
    
    @IBAction func btnUrbanDictionaryTest(_ sender: Any) {
        STRServiceUrbanDictionary().execute().done { (result: STRServiceUrbanDictionaryModel) in
            print(result)
            }.catch { (error) in
               print(error)
        }
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

extension UIAlertController {
    class func showMessageWithOKButton(message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}
