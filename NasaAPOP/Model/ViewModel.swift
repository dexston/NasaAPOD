//
// Created by Admin on 21.02.2022.
//

import Foundation
import UIKit

@MainActor

class ViewModel: ObservableObject {

    @Published var date = Date() {
        willSet {
            image = nil
        }
        didSet {
            Task {
                await fetchAPOD()
            }
        }
    }
    @Published var photo: Photo?
    @Published var image: UIImage?
    @Published var showExplanation = false
    @Published var showDatePicker = false

    // The first APOD is dated 16.06.1995
    // https://github.com/nasa/apod-api#url-search-params--query-string-parameters
    var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 1995, month: 6, day: 16)
        return calendar.date(from: startComponents)! ... Date()
    }

    private let networkManager = NetworkManager()

    func fetchAPOD() async {
        photo = await networkManager.fetchData(for: date)
        if let url = photo?.url {
            image = await networkManager.fetchImage(from: url)
        }
    }
}