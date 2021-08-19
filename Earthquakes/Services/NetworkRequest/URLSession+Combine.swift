import Foundation
import Combine

extension URLSession {
    enum Error: Swift.Error {
        case networking(URLError)
        case decoding(Swift.Error)
    }

    func publisher(for request: NetworkRequest<Data>) -> AnyPublisher<Data, Swift.Error> {
        dataTaskPublisher(for: request.urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .mapError(Error.networking)
            .map(\.data)
            .eraseToAnyPublisher()
    }

    func publisher<T: Decodable>(for request: NetworkRequest<T>,
                                 using decoder: JSONDecoder = .init()) -> AnyPublisher<T, Swift.Error> {
        dataTaskPublisher(for: request.urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .mapError(Error.networking)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .mapError(Error.decoding)
            .eraseToAnyPublisher()
    }
}
