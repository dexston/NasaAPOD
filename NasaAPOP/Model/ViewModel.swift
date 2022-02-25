//
// Created by Admin on 21.02.2022.
//

import Foundation
import UIKit

class ViewModel: ObservableObject {

    @Published var date = Date() {
        didSet {
            fetchAPOD()
        }
    }
    @Published var photo: Photo?
    @Published var image: UIImage?
    @Published var showExplanation = false
    @Published var showDatePicker = false

    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 1995, month: 6, day: 16)
        return calendar.date(from: startComponents)! ... Date()
    }()


    private let networkManager = NetworkManager()

    func fetchAPOD() {
        networkManager.fetchData(for: date) { [weak self] photo in
            self?.photo = photo
            self?.networkManager.fetchImage(from: photo.url) { [weak self] image in
                self?.image = image
            }
        }
    }
}