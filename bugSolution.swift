enum NetworkError: Error {
    case badServerResponse
    case networkError(Error)
    case timeout
}

func fetchData() async throws -> Data {
    let url = URL(string: "https://api.example.com/data")!
    let (data, response) = try await withThrowingTaskGroup(of: (Data, URLResponse).self) { group in
        group.addTask { 
            try await URLSession.shared.data(from: url)
        }

        let result = await group.next()
        switch result {
        case .success(let dataResponse): return dataResponse
        case .failure(let error): throw NetworkError.networkError(error)
        }
    }

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw NetworkError.badServerResponse
    }

    return data
}

Task { 
    do {
        let data = try await fetchData()
        // Process the data
    } catch let error as NetworkError {
        switch error {
        case .badServerResponse: print("Bad server response")
        case .networkError(let underlyingError): print("Network error: \(underlyingError)")
        case .timeout: print("Request timed out")
        }
        // Retry logic could go here
    } catch {
        print("Unknown error: \(error)")
    }
}