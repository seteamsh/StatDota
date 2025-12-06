import SwiftUI

struct ContentView: View {
    @State private var isPresentedSearch: Bool = false
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isPresentedSearch.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .padding()
                }
                .sheet(isPresented: $isPresentedSearch) {
                    SearchPlayerView()
                        .presentationDetents([.medium])
                        
                }
            }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
