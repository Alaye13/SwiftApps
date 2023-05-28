import SwiftUI
// Tic Tac toe APP
struct ContentView: View {
    
    @State private var board = [0,0,0,0,0,0,0,0,0]
    @State private var player1Turn = true
    @State private var message = "Player 1's Turn"
    
    let winningCombinations = [
        [0,1,2],[3,4,5],[6,7,8],
        [0,3,6],[1,4,7],[2,5,8],
        [0,4,8],[2,4,6]
    ]
    
    var body: some View {
        VStack {
            Text(message)
                .font(.headline)
                .padding(.bottom, 30)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 5) {
                ForEach(0..<9) { index in
                    Button(action: {
                        boardButtonPressed(index)
                    }) {
                        Text(getButtonTitle(index))
                            .font(.system(size: getButtonFontSize(getButtonTitle(index))))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                    }
                    .disabled(board[index] != 0)
                }
            }
            .padding()
            
            Button(action: {
                resetButtonPressed()
            }) {
                Text("Reset")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
    
    private func boardButtonPressed(_ index: Int) {
        if player1Turn {
            board[index] = 1
            message = "Player 2's Turn"
        } else {
            board[index] = 2
            message = "Player 1's Turn"
        }
        
        if checkForWin() {
            message = player1Turn ? "Player 1 Wins!" : "Player 2 Wins!"
            disableBoard()
        } else if checkForTie() {
            message = "It's a tie!"
            disableBoard()
        } else {
            player1Turn.toggle()
        }
    }
    
    private func resetButtonPressed() {
        board = [0,0,0,0,0,0,0,0,0]
        player1Turn = true
        message = "Player 1's Turn"
    }
    
    private func getButtonTitle(_ index: Int) -> String {
        switch board[index] {
        case 1:
            return "X"
        case 2:
            return "O"
        default:
            return " "
        }
    }
    
    private func getButtonFontSize(_ title: String) -> CGFloat {
        switch title {
        case "X", "O":
            return 120
        default:
            return 120
        }
    }
    
    private func checkForWin() -> Bool {
        for combination in winningCombinations {
            if board[combination[0]] != 0 && board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]] {
                return true
            }
        }
        return false
    }
    
    private func checkForTie() -> Bool {
        for cell in board {
            if cell == 0 {
                return false
            }
        }
        return true
    }
    private func disableBoard() {
        for index in 0..<board.count {
            board[index] = -1
        }
    }
    
}
