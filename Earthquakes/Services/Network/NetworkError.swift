import Foundation

enum NetworkError: LocalizedError {
    case urlError(reason: String)
    case decodingError(reason: String)
    case unknown
}
