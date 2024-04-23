import Foundation

class NetworkClient {
    func getItems(completion: @escaping (Result<[Item], Error>) -> Void) {
        let urlString = "https://my-json-server.typicode.com/sumup-challenges/mobile-coding-challenge-data/items/"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -2, userInfo: nil)))
                return
            }
            
            do {
                let items = try JSONDecoder().decode([Item].self, from: data)
                completion(.success(items))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
