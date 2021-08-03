import Foundation

enum NetworkError: LocalizedError {
    case urlError(reason: String)
    case decodingError(reason: String)
    case unknown
    var localizedDescription: String {
        switch self {
        case .urlError(let reason):
            return reason
        case .decodingError(let reason):
            return reason
        default:
            return NSLocalizedString("Unknown error", comment: "")
        }
    }
}
