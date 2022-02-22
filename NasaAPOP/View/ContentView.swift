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

        ZStack {
            if let photo = viewModel.photo,
               let image = viewModel.image {
                Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                VStack {
                    Text(photo.date, style: .date)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.black.opacity(0.3)))
                            .foregroundColor(.white)
                            .font(.body)
                    Spacer()
                    Text(photo.title)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.black.opacity(0.3)))
                            .foregroundColor(.white)
                            .font(.title)
                            .onTapGesture {
                                viewModel.showExplanation = !viewModel.showExplanation
                            }
                    if viewModel.showExplanation {
                        Text(photo.explanation)
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.black.opacity(0.3)))
                                .foregroundColor(.white)
                                .font(.body)
                                .multilineTextAlignment(.center)
                    }
                    if let copyright = photo.copyright {
                        Text("Copyright: \(copyright)")
                                .font(.caption)
                                .padding(5)
                                .background(RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.black.opacity(0.3)))
                                .foregroundColor(.white)
                                .cornerRadius(5)
                    }
                }
                        .frame(width: UIScreen.main.bounds.width * 0.9)
            } else {
                ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
            }
        }
                .onAppear {
                    viewModel.fetchAPOD()
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
