//
//  ContentView.swift
//  NasaAPOP
//
//  Created by Admin on 20.02.2022.
//
//

import SwiftUI

struct ContentView: View {

    @StateObject var viewModel = ViewModel()

    var body: some View {
        if let image = viewModel.image {
            Image(uiImage: image)
        }

        VStack{
            if let photo = viewModel.photo {
                Text(photo.title)
                Text(viewModel.getDate(from: photo.date))
                if let copyright = photo.copyright {
                    Text(copyright)
                }
                Text(photo.explanation)
                //Text(photo.mediaType)
            } else {
                ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
            }
        }
                .padding()
                .onAppear{
                    viewModel.fetchAPOD()
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
