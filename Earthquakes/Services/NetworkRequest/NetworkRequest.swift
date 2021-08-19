import Foundation

struct NetworkRequest<NetworkResponse> {
    let baseUrl: URL
    let path: String
    let method: NetworkMethod
    var headers: [String: String] = [:]
}

extension NetworkRequest {
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: baseUrl)

        switch method {
        case .post(let data), .put(let data):
            request.httpBody = data
        case let .get(queryItems):
            let url = baseUrl.appendingPathComponent(path)
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            guard let url = components?.url else { preconditionFailure("Couldn't create a url from components...") }
            request = URLRequest(url: url)
        }

        request.allHTTPHeaderFields = headers
        request.httpMethod = method.name
        return request
    }
}
