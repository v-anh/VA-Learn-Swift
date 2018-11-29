 
 Trước khi đọc tiếp về topic này bạn cần tìm hiểu trước những kiến thức này:
 
 - Swift Language (cái này thì chắc chắn rồi)
 - Protocol Object Programming - Đây là key của topic này sẽ focus vào protocol vs struct để tạo lớp network layer
 - URLSession, URLRequest - Ở đây mình không dùng ALamofire hoặc AFNetwork vì chủ yếu demo đơn giản nếu cần thì bạn có thể thay bằng các Third-Party trên
 - Generic Protocol


 Bắt đầu bằng một số Enum 
 
 public enum ConnError:Swift.Error {
    case invalidURL
    case noData
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

Request data

public struct RequestData {
    public let path:String
    public let method:HTTPMethod
    public let params:[String:Any?]?
    public let headers: [String: String]?
    
    init(path: String,
         method: HTTPMethod = .get,
         params: [String: Any?]? = nil,
         headers: [String: String]? = nil) {
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
    }
}


Phần chính của Network layer, ở đây sẽ sử dụng 'associatedtype' dùng để tạo Generic Type cho response và RequestData cho phần request

public protocol VAService {
    associatedtype ResponseType: Codable
    var data: RequestData { get }
}



Tạo 1 protocol NetworkDispatcher để tạo template cho việc request data
public protocol NetworkDispatcher {
    func dispatch(request:RequestData, onSuccess:@escaping (Data) -> Void,onError:@escaping (Error) -> Void)
}

Implement NetworkDispatcher ở đây mình sẽ dùng URLSession nên sẽ tạo 1 struct URLSessionNetworkDispatcher
public struct URLSessionNetworkDispatcher : NetworkDispatcher {
    
    public static let instance = URLSessionNetworkDispatcher()
    
    private init() {}
    
    public func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void) {
        guard let url = URL(string: request.path) else {
            onError(ConnError.invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        do {
            if let params = request.params {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
        } catch let error {
            onError(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                onError(error)
                return
            }
            
            guard let _data = data else {
                onError(ConnError.noData)
                return
            }
            
            onSuccess(_data)
            }.resume()
    }
}


Gom tất cả lại bằng extension Protocol
- NetworkDispatcher default sẽ là URLSessionNetworkDispatcher, nếu mình dùng Alamofire hoặc AFNetwork thì có thể tạo thêm một Implement khác của NetworkDispatcher ví dụ AlamofireNetworkDispatcher, đây là lý do tại sao mình tạo NetworkDispatcher là Protocol 
- onSuccess: Response Type đây là Generic đã tạo ở phần Response ở trên 
- onError: Error dùng để xuất lỗi 
- Dùng dispatcher gọi hàm dispatch để thực thi việc gọi request và nhận response 
- Dùng JSONDecoder để decode ResponseType từ data -> đây là lý do mình để ResponseType implement Codable
- DispatchQueue.main để đảm bảo threadsafe 

public extension VAService {
    public func execute(dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
                        onSuccess: @escaping (ResponseType) -> Void,
                        onError: @escaping (Error) -> Void) {
        dispatcher.dispatch(request: self.data, onSuccess: { (data) in
            do {
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    onSuccess(result)
                }
            } catch let error {
                DispatchQueue.main.async {
                    onError(error)
                }
            }
        }) { (error) in
            DispatchQueue.main.async {
                onError(error)
            }
        }
    }
}
 
	
Done,

Đây là cách sử dụng lơp Network 

1. Tạo một Struct như một Entity cho việc hứng data response 
2. Tạo một Struct kế thừa VAService, khai báo ResponseType là Struct vừa mới tạo 
3. Khởi tạo Struct kế thừa VAService và gọi execute() 

 
 
 Tìm hiểu thêm : https://medium.com/ios-os-x-development/minimal-networking-layer-from-scratch-in-swift-4-a151af786dc5
 
