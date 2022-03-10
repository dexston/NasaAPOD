//
//  MainView.swift
//  NasaAPOP
//
//  Created by Admin on 20.02.2022.
//
//

import SwiftUI

struct MainView: View {

    @StateObject var viewModel = MainViewModel()

    private struct GeneralTextModifiers: ViewModifier {
        var padding: CGFloat = 10
        var font: Font = .body

        func body(content: Content) -> some View {
            content
                    .padding(padding)
                    .background(RoundedRectangle(cornerRadius: padding)
                            .fill(Color.black.opacity(0.4)))
                    .foregroundColor(.white)
                    .font(font)
        }
    }

    private struct TextView: View {
        var text: String
        var padding: CGFloat = 10
        var font: Font = .body

        var body: some View {
            Text(text)
                    .modifier(GeneralTextModifiers(padding: padding, font: font))
        }
    }

    private struct PictureView: View {
        var photo: Photo
        var image: UIImage?

        init(of photo: Photo, with image: UIImage?) {
            self.photo = photo
            self.image = image
        }

        var body: some View {
            if photo.mediaType == .image {
                if let image = image {
                    Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                } else {
                    ProgressView()
                            .progressViewStyle(.circular)
                }
            } else if photo.mediaType == .video {
                Text("Video content not supported yet")
            } else if let msg = photo.msg {
                Text(msg)
            }
        }
    }

    var body: some View {

        ZStack {
            if let photo = viewModel.photo {
                PictureView(of: photo, with: viewModel.image)
                VStack {
                    Text(viewModel.date, style: .date)
                            .modifier(GeneralTextModifiers())
                            .onTapGesture {
                                withAnimation {
                                    viewModel.showDatePicker.toggle()
                                }
                            }
                    if viewModel.showDatePicker {
                        DatePicker("Date picker", selection: $viewModel.date, in: viewModel.dateRange, displayedComponents: [.date])
                                .datePickerStyle(.graphical)
                                .modifier(GeneralTextModifiers())
                                .colorScheme(.dark)
                                .transition(.move(edge: .top))
                                .labelsHidden()
                    }
                    Spacer()
                    if let title = photo.title {
                        TextView(text: title, font: .title)
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.showExplanation.toggle()
                                    }
                                }
                    }
                    if viewModel.showExplanation,
                       let explanation = photo.explanation {
                        TextView(text: explanation)
                                .multilineTextAlignment(.center)
                                .transition(.move(edge: .bottom))
                    }
                    if let copyright = photo.copyright {
                        TextView(text: "Copyright: \(copyright)", padding: 5, font: .caption)
                    }
                }
                        .frame(width: UIScreen.main.bounds.width * 0.9)
            } else {
                ProgressView()
                        .progressViewStyle(.circular)
            }
        }
                .task {
                    await viewModel.fetchAPOD()
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
