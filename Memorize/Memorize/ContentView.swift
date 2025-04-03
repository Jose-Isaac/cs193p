//
//  ContentView.swift
//  Memorize
//
//  Created by Jose Isaac Barreiro Campos on 04/03/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gameViewModel: EmojiMomoryGame
    
    var body: some View {
        VStack {
            TopBarView(
                titleName: gameViewModel.activeTheme.name,
                score: gameViewModel.score
            )
            Divider()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))], spacing: 10) {
                    ForEach(gameViewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                gameViewModel.choose(card)
                            }
                    }
                }
                .foregroundStyle(
                    gameViewModel.cardColor
                )
            }
            BottomBarView(createNewGame: gameViewModel.setNewTheme)
        }
        .padding(.horizontal)
    }
}

struct TopBarView: View {
    let titleName: String
    let score: Int
    
    var body: some View {
        HStack {
            Text("Memorize")
                .font(.headline)
            Text("\(titleName)")
                .font(.subheadline)
            Spacer()
            ScoreBarView(score: score)
        }
        .padding(.horizontal)
    }
}

struct BottomBarView: View {
    var createNewGame: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            NewGameBottomView(createNewGame: createNewGame)
        }.padding()
    }
}

struct NewGameBottomView: View {
    var createNewGame: () -> Void
    
    var body: some View {
        Button(action: createNewGame) {
            ZStack {
                Circle()
                    .frame(width: 80, height: 80)
                    .shadow(color: .blue, radius: 5)
                
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
    }
}

struct ScoreBarView: View {
    let score: Int
    
    var body: some View {
        HStack {
            Spacer()
            Text("Score: \(score)")
                .fontDesign(.monospaced)
                .bold()
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: card.isFaceUp ? 15 : 20)
            
            if card.isFaceUp {
                shape
                    .fill(.white)
                    .strokeBorder(lineWidth: 3)
                    .foregroundColor(card.isMatched ? .red : .gray)
                
                Text(card.content)
                    .font(.largeTitle)
            } else {
                shape
            }
        }
    }
}

//#Preview {
//    ContentView().preferredColorScheme(.dark)
//    ContentView().preferredColorScheme(.light)
//}

struct Memorize_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMomoryGame()
        ContentView(gameViewModel: game)
            .preferredColorScheme(.dark)
        ContentView(gameViewModel: game)
            .preferredColorScheme(.light)
    }
}
