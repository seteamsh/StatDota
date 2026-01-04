import SwiftUI

struct PlayerMatchesHeader: View {
    var body: some View {
        HStack(spacing: 10) {
            Text("Hero")
                .frame(width: 231, alignment: .leading)
                .padding(.leading, 5)
            Text("Result")
                .frame(width: 48, alignment: .leading)
            Text("Game Mode")
                .frame(width: 60, alignment: .leading)
            Text("Duration")
                .frame(width: 66, alignment: .leading)
            Text("K")
                .frame(width: 45, alignment: .leading)
            Text("D")
                .frame(width: 45, alignment: .leading)
            Text("A")
                .frame(width: 45, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 50)
        .border(.gray.opacity(0.3), width: 1)
    }
}

#Preview {
    PlayerMatchesHeader()
}
