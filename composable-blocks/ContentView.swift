import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: StoreOf<MainReducer>

    var body: some View {
        WithViewStore(store) { store in
            // we can define here what do we want to observe
            // in this case we observe everything
            store
        } content: { viewStore in
            VStack {
                Text("CounterView with CounterReducer")
                    .font(Font.headline)
                    .padding()

                VStack {
                    Text("Value is changed in the main reducer")
                    Text("But style and text are changed in the child reducer")

                    CouterView(store: store.scope(state: \.counterState, action: MainReducer.Action.counterAction))

                    Button {
                        viewStore.send(.randomClick)
                    } label: {
                        Text("Randomise Counter")
                    }
                    .padding()
                }
            }
        }
    }
}

struct CouterView: View {
    let store: StoreOf<CounterReducer>

    var body: some View {
        WithViewStore(store) { store in
            // we can define here what do we want to observe
            // in this case we observe everything
            store
        } content: { viewStore in
            VStack {
                Text("Counter")
                    .padding()
                    .foregroundColor(Color.orange)
                Text("\(viewStore.value)")
                    .foregroundColor(.orange)
                HStack {
                    Button {
                        viewStore.send(.decrement)
                    } label: {
                        Image(systemName: "minus")
                            .frame(width: 38, height: 35)
                    }
                    .buttonStyle(.borderless)
                    .foregroundColor(.orange)

                    Button {
                        viewStore.send(.increment)
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 38, height: 35)
                    }
                    .buttonStyle(.borderless)
                    .foregroundColor(.orange)
                }
            }
            .background(Color(hex: viewStore.color))
        }

    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(initialState: MainReducer.State(counterState: CounterReducer.State()),
                                 reducer: MainReducer()))
    }
}
