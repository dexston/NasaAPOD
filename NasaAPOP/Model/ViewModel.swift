//
// Created by Admin on 21.02.2022.
//

import Foundation

class ViewModel: ObservableObject {

    @Published var photo: Photo?

    private var networkManager = NetworkManager()

    func fetchAPOD() {
        networkManager.fetchData { photo in
            self.photo = photo
        }
    }


}