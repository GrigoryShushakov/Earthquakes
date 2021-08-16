import Foundation

enum NetworkMethod: Equatable {
    case get([URLQueryItem])
    case put(Data?)
    case post(Data?)

    var name: String {
        switch self {
        case .get: return "GET"
        case .put: return "PUT"
        case .post: return "POST"
        }
    }
}
