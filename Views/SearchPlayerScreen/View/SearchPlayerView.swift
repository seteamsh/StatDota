import SwiftUI

struct SearchPlayerView: View {
    
    @StateObject var vm = SearchPlayerViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                Spacer()
                Text("Добавить в друзья")
                    .font(.title)
                    .foregroundStyle(.searchTextFieldAddFriend)
                
                if let profile = vm.profile {
                    NavigationLink {
                        ProfileView(vm: ProfileViewModel(profiile: profile))
                    } label: {
                        HStack {
                            Spacer()
                            AsyncImage(url: URL(string: profile.avatarmedium)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipped()
                                    .clipShape(.circle)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            Text(profile.personaname)
                                .foregroundStyle(.white)
                                .font(.title)
                            Spacer()
                        }
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
                        vm.loadProfile(id: Int(vm.searchID) ?? 0)
                    } label: {
                        SearchButton(text: "Поиск".uppercased())
                    }
                    
                    Spacer()
                    Button {
                        vm.searchID = ""
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
}

#Preview {
    SearchPlayerView()
}
