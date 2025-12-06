import SwiftUI

struct SearchPlayerView: View {
    @StateObject var vm = MainViewModel()
    var body: some View {
        VStack {
            Spacer()
            Text("Добавить в друзья")
                .font(.title)
                .foregroundStyle(.searchTextFieldAddFriend)//#A6AAAB
            
                if let player = vm.player {
                    Button {
                        
                    } label: {
                        HStack {
                            Spacer()
                            Text(player.personaname)
                                .foregroundStyle(.white)
                                .font(.title)
                            Spacer()
                        }
                        .frame(height: 60)
                        .border(.searchTextFieldBorder, width: 2)
                    }

                } else {
                    Text(vm.errorMessage)
                        .foregroundStyle(.white)
                }
                
                
            TextField(text: $vm.searchID) {
                Text("Поиск по ID")
                    .foregroundStyle(.searchPlacehoderForegroundStyle)
                
            }
            .frame(height: 60)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .foregroundStyle(.white)
            .font(.title2)
            .background(.black)
            .border(.searchTextFieldBorder, width: 2)
            HStack(spacing: 0) {
                Button {
                    vm.getPlayer(id: Int(vm.searchID) ?? 0)
                } label: {
                    SearchButton(text: "Поиск".uppercased())
                }

                Spacer()
                Button {
                    
                } label: {
                    SearchButton(text: "Отмена".uppercased())
                }

            }
            Spacer()
        }
        .padding(40)
        .background(
            .linearGradient(
                colors: [
                    .searchScreenBottonBackground,
                    .searchScreenMiddleBackground,
                    .searchScreenTopBackground
                ],
                startPoint: .bottom,
                endPoint: .top
            )
        )
    }
}

#Preview {
    SearchPlayerView()
}
