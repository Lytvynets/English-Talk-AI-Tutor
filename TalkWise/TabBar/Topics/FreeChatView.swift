//
//  FreeConversationView.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 28.07.2025.
//

import SwiftUI
import AVFoundation
import Speech

struct FreeChatView: View {
    
    @EnvironmentObject var viewModel: AIChatViewModel
    
    //    @StateObject private var viewModel = AIChatViewModel()
    @Binding var savedWords: [String]
    
    
    var body: some View {
        CustomNavigationBar(title: "Free Conversation", imageName: "Vector4324234", customNavBarState: .withBackButton) {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(Array(viewModel.messagesHistory.enumerated()), id: \.offset) { index, message in
                            HStack {
                                if message["role"] == "user" {
                                    Spacer()
                                    Text(message["content"] ?? "nil")
                                        .font(.custom("Montserrat-SemiBold", size: AdaptiveFontSize.adaptive13))
                                        .foregroundStyle(.white)
                                        .padding()
                                        .background(Color(hex: "#313749"))
                                        .clipShape(
                                            RoundedCorner(radius: 25, corners: [.topLeft, .bottomRight, .bottomLeft])
                                        )
                                        .frame(maxWidth: 250, alignment: .trailing)
                                } else {
                                    VStack {
                                        if  viewModel.showTranslateWord {
                                            HStack {
                                                Text("\(viewModel.translateWord) - Тут переклад")
                                                Image("ic_round-save")
                                                    .padding(.horizontal, 7)
                                                Text("Save")
                                                Spacer()
                                            }
                                            .foregroundStyle(.white)
                                            .font(.custom("Montserrat-SemiBold", size: AdaptiveFontSize.adaptive13))
                                            .padding(.leading, 44)
                                        }
                                        
                                        HStack {
                                            
                                            HStack {
                                                VStack {
                                                    Image("gravity-ui_volume-fill")
                                                    Spacer()
                                                }
                                                .padding(.top, 5)
                                                
                                                WordTapView(text: message["content"] ?? "nil",
                                                            savedWords: $savedWords)
                                                
                                                
                                            }
                                            .padding()
                                            .background {
                                                LinearGradient(colors: [Color(Color(hex: "#2E64E3") ?? .blue), Color(Color(hex: "#38A9CF") ?? .blue)], startPoint: .leading, endPoint: .trailing)
                                            }
                                            .clipShape(
                                                RoundedCorner(radius: 25, corners: [.topLeft, .topRight, .bottomRight])
                                            )
                                            
                                        }
                                        .padding(.leading, 35)
                                        
                                        HStack {
                                            Image("launchicon")
                                                .resizable()
                                                .frame(width: 36, height: 36)
                                                .clipShape(.circle)
                                            HStack {
                                                Image("bi_translate")
                                                Text("Translate")
                                                    .foregroundStyle(.white)
                                                    .font(.custom("Montserrat-SemiBold", size: AdaptiveFontSize.adaptive13))
                                            }
                                            .padding(.top, 5)
                                            .padding(.bottom)
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
                .padding(.top, 120)
                .padding(.bottom, 75)
                
                
                VStack {
                    Spacer()
                    ZStack {
                        TextField("Write your message", text: $viewModel.transcribedText)
                            .padding()
                            .padding(.vertical, 5)
                            .background(Color(hex: "#232A3A"))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .padding()
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                viewModel.toggleRecording()
                            }) {
                                Image(viewModel.isRecording ? "icon-park-solid_voicee" : "icon-park-solid_voice")
                            }
                            
                            Button(action: {
                                viewModel.sendToOpenAI()
                            }) {
                                Image("ion_send")
                            }
                            .padding()
                        }
                        .padding(.trailing)
                    }
                }
                .padding(.bottom)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}


#Preview {
    @Previewable @State var savedWords: [String] = []
    FreeChatView(savedWords: $savedWords)
        .environmentObject(AIChatViewModel())
}

//struct WordTapView: View {
//
//    let text: String
//    @Binding var savedWords: [String]
//
//    var body: some View {
//        let words = text.split(separator: " ").map(String.init)
//
//        ForEach(Array(words.enumerated()), id: \.offset) { index, message in
//            Text(message)
//                .onTapGesture {
//                    savedWords.append(message)
//                    print("Saved word: \(message)")
//                }
//        }
//
//
//    }
//
//}


struct WordTapView: View {
    
    @EnvironmentObject var viewModel: AIChatViewModel
    let text: String
    @Binding var savedWords: [String]
    
    var body: some View {
        // Розбиваємо на слова
        let words = text.split(separator: " ").map(String.init)
        
        // Відображаємо слова
        // Ви можете зробити горизонтальний scroll або wrap з HStacks
        return VStack(alignment: .leading) {
            // Можна обернути в ScrollView(.horizontal), якщо потрібно
            Wrap(words, spacing: 1) { word in
                Text(verbatim: word)
                    .font(.custom("Montserrat-SemiBold", size: AdaptiveFontSize.adaptive13))
                    .foregroundStyle(.white)
                // .padding(1)
                //   .background(Color.blue.opacity(0.2))
                    .cornerRadius(6)
                    .onTapGesture {
                        withAnimation {
                            viewModel.showTranslateWord = true
                            viewModel.translateWord = "\(word)"
                        }
                        
                        //                        savedWords.append(word)
                        //                        print("Збережено: \(word)")
                    }
            }
        }
    }
}


struct Wrap<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let content: (Data.Element) -> Content
    
    init(_ data: Data, spacing: CGFloat = 8, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.spacing = spacing
        self.content = content
    }
    
    @State private var totalHeight = CGFloat.zero
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }
    
    private func generateContent(in geo: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(data, id: \.self) { item in
                content(item)
                    .padding(4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if abs(width - d.width) > geo.size.width {
                            width = 0
                            height -= (d.height + spacing)
                        }
                        let result = width
                        if item == data.last {
                            width = 0
                        } else {
                            width -= (d.width + spacing)
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        if item == data.last {
                            height = 0
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        GeometryReader { geo -> Color in
            DispatchQueue.main.async {
                binding.wrappedValue = geo.size.height
            }
            return Color.clear
        }
    }
}




//struct Wrap<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
//    let data: Data
//    let content: (Data.Element) -> Content
//
//    init(_ data: Data, id: KeyPath<Data.Element, Data.Element>, @ViewBuilder content: @escaping (Data.Element) -> Content) {
//        self.data = data
//        self.content = content
//    }
//
//    var body: some View {
//        var width = CGFloat.zero
//        var height = CGFloat.zero
//
//        return GeometryReader { geometry in
//            ZStack(alignment: .topLeading) {
//                ForEach(data, id: \.self) { item in
//                    content(item)
//                        .padding([.horizontal, .vertical], 4)
//                        .alignmentGuide(.leading, computeValue: { d in
//                            if (abs(width - d.width) > geometry.size.width) {
//                                width = 0
//                                height -= d.height
//                            }
//                            let result = width
//                            if item == data.last {
//                                width = 0 // останній
//                            } else {
//                                width -= d.width
//                            }
//                            return result
//                        })
//                        .alignmentGuide(.top, computeValue: { _ in
//                            let result = height
//                            if item == data.last {
//                                height = 0
//                            }
//                            return result
//                        })
//                }
//            }
//        }
//    }
//}



struct RoundedCorner: Shape {
    var radius: CGFloat = 16
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
