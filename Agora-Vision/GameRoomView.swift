import SwiftUI
import AgoraRtcKit

struct GameRoomView: View {
    var playerName: String
    var roomName: String
    @StateObject private var agoraManager = AgoraManager(appId: "6c1fbe1e399c4aea9eeb6ba94c000779", role: .audience) // Replace with your actual App ID

    var body: some View {
        VStack {
            Text("Room: \(roomName)")
                .font(.title)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 15) {
                    ForEach(Array(agoraManager.allUsers), id: \.self) { uid in
                        AgoraVideoCanvasView(manager: agoraManager, canvasId: .userId(uid))
                            .frame(maxWidth: 400, maxHeight: 400)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                        Text("playerName: \(uid)")
                            .font(.title)
                    }
                }
            }
        }
        .onAppear {
            agoraManager.joinChannel(roomName)
        }
        .onDisappear {
            agoraManager.leaveChannel()
        }
    }
}
