//
//  SwiftUIView.swift
//  BucketBeanz
//
//  Created by Rebeca Chavez on 12/7/22.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State var items0: [String] = [
     "Visit Paris", "Visit London", "Visit Mumbai"
    ]
    
    @State var items1: [String] = [
        "Graduate College", "Get my License", "Receive Job Offer"
    ]
    var body: some View {
        NavigationView {
            List {
                Section(
                    header:
                        HStack {
                            Text("Travel")
                            Image(systemName: "flame.fill")
                        }
                        .font(.headline)
                        .foregroundColor(.orange)
                ) {
                    ForEach(items0, id: \.self) {items in Text(items.capitalized)
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.vertical)
                        }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                    .listRowBackground(Color.blue)
                }
                
                Section(header: Text("Lifestyle")) {
                    ForEach(items1, id: \.self) { items0 in
                        Text(items0.capitalized)
                    }
                }
            }
            .accentColor(.purple)
            //.listStyle(InsetGroupedListStyle())
            .navigationTitle("My BucketBeanz List")
            .navigationBarItems(
                leading: EditButton(), trailing: addButton)
        }
        .accentColor(.red)
        
    }
    
    var addButton: some View {
        Button("Add", action: {
            add()
        })
    }
    
    func delete(indexSet: IndexSet) {
        items0.remove(atOffsets: indexSet)
    }
    
    func move(indeces:IndexSet, newOffset: Int) {
        items0.move(fromOffsets: indeces, toOffset: newOffset)
    }
    
    func add() {
        items0.append("Visit San Francisco")
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
