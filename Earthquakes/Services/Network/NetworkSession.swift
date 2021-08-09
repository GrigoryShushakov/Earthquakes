import Combine
import Foundation

struct NetworkSession: NetworkService {
    func request<T>(with builder: RequestBuilder) -> AnyPublisher<T, NetworkError> where T: Decodable {
        let decoder = JSONDecoder()
        
        return URLSession.shared
            .dataTaskPublisher(for: builder.urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .mapError { error in .urlError(reason: error.localizedDescription) }
            .flatMap { data, response -> AnyPublisher<T, NetworkError> in
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                    
                    return Just(data)
                        .decode(type: T.self, decoder: decoder)
                        .mapError { error in .decodingError(reason: error.localizedDescription) }
                        .eraseToAnyPublisher()
                    } else {
                        return Fail(error: .urlError(reason: "HTTP error status code: \(response.statusCode)"))
                            .eraseToAnyPublisher()
                    }
                }
                return Fail(error: .unknown)
                        .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
