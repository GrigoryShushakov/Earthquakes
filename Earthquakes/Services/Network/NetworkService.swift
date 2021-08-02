import Foundation
import Combine

protocol NetworkService {
    func request<T: Decodable>(with builder: RequestBuilder) -> AnyPublisher<T, NetworkError>
}
