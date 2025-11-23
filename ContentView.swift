import SwiftUI

struct ContentView: View {
    @State var search = ""
    var body: some View {
        VStack {
            Text("Добавить в друзья")
                .foregroundStyle(.white)//#A6AAAB
            TextField(text: $search) {
                Text("Поиск по ID")
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
            }
            .background(.black)
            .border(.searchTextFieldBorder, width: 2)
            HStack(spacing: 0) {
                SearchButton()
                Spacer()
                SearchButton()
            }
        }
        .padding(40)
        .background(Color.gray)//#282D2F
    }
}

#Preview {
    ContentView()
}
