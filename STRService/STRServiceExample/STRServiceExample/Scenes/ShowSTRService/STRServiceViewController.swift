import UIKit
import STRService
import netfox

class STRServiceViewController: UIViewController, HasDependencies {
    
    private lazy var authenticationWorker: AuthenticationWorkerType = dependencies.resolveWorker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
}

extension UIAlertController {
    class func showMessageWithOKButton(message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}
