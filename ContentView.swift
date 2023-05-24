import SwiftUI

struct ContentView: View {
    @State private var coinResult = "Heads"
    @State private var flipsHistory: [String] = []
    
    var body: some View {
        VStack {
            Text(coinResult)
                .font(.system(size: 50))
                .foregroundColor(coinResult == "Heads" ? .green : .red)
                .padding()
            
            Button(action: {
                self.flipCoin()
            }) {
                Image(systemName: coinResult == "Heads" ? "circle.fill" : "circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                
                Text("Flip")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.leading, 10)
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Flips History:")
                    .font(.headline)
                
                ForEach(flipsHistory.reversed(), id: \.self) { flip in
                    Text(flip)
                }
            }
            .padding()
        }
    }
    
    func flipCoin() {
        let randomResult = Int.random(in: 0...1)
        coinResult = randomResult == 0 ? "Heads" : "Tails"
        
        if flipsHistory.count >= 10 {
            flipsHistory = Array(flipsHistory.suffix(9))
        }
        
        flipsHistory.append(coinResult)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

