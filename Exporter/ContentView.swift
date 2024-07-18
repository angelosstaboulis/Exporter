//
//  ContentView.swift
//  Exporter
//
//  Created by Angelos Staboulis on 17/7/24.
//

import SwiftUI
import PDFKit
struct ContentView: View {
    @State var source:String
    @State var destination:String
    @State private var img1 = Data()
    @State var showExporter:Bool
    @State var target : UIImage
    @State var export:ExportDocument
    @State var fileName = ""
    var body: some View {
        NavigationView{
            VStack {
                Text("Enter your source URL").frame(width:300,height:45,alignment: .leading)
                TextField("Enter your source URL", text: $source).frame(width:300,height:45,alignment: .leading)
                Text("Enter your destination URL").frame(width:300,height:45,alignment: .leading)
                TextField("Enter your destination URL", text: $destination).frame(width:300,height:45,alignment: .leading)
                Button(action: {
                    showExporter.toggle()
                    Task{
                        guard let urlMain = URL(string: source) else{
                            return
                        }
                        let data = try Data(contentsOf: urlMain)
                        guard let imageData = UIImage(data: data) else{
                            return
                        }
                        self.target = imageData
                        export = ExportDocument(image: self.target)
                    }
                }, label: {
                    Text("Export File")
                }).fileExporter(isPresented: $showExporter, document:export, contentType: .content,defaultFilename: destination, onCompletion: { (result) in
                    if case .success = result {
                        print("Success")
                    } else {
                        print("Failure")
                    }
                })
                Spacer()
            }.navigationTitle("Exporter")
            .navigationBarTitleDisplayMode(.inline)
        }.colorScheme(.light)
        .padding()
    }
}

#Preview {
    ContentView(source: "", destination:"", showExporter: false, target: .init(), export: .init(image: .init()))
}
