//
// Created by Admin on 20.02.2022.
//

import Foundation
import UIKit

class NetworkManager {

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    private let apiKey = "KhsyxIkSJ1yc5HGlhFxLoYRUeoc4j2u3s5KRiylg"

    private func makeURL(for date: Date) -> URL? {
        guard
            let baseURL = URL(string: "https://api.nasa.gov/planetary/apod"),
            var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        else { return nil }
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "date", value: dateFormatter.string(from: date))
        ]
        return urlComponents.url
    }

    func fetchData(for date: Date) async -> Photo? {
        guard let url = makeURL(for: date) else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try decoder.decode(Photo.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }

    func fetchImage(from url: URL) async -> UIImage? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            print(error)
            return nil
        }
    }
}
