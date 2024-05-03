//
//  ContentView.swift
//  Agora-Vision
//
//  Created by Max Cobb on 11/6/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

internal struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) { self.build = build }
    var body: Content { build() }
}

struct ContentView: View {
    @State var channelName: String = ""
    @State var joiningChannel: Bool = false
    
    @State private var playerName = ""
    @State private var roomName = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Model3D(named: "Scene", bundle: realityKitContentBundle)
                    .padding(.bottom, 50)
                Form {
                    TextField("Enter your name", text: $playerName)
                    TextField("Room name", text: $roomName)
                    NavigationLink(destination: GameRoomView(playerName: playerName, roomName: roomName)) {
                        Text("Join Game")
                    }.disabled(playerName.isEmpty || roomName.isEmpty)
                }
                .navigationBarTitle("Werewolf Game Lobby")
            }.padding()
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
