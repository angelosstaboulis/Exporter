//
//  ExportDocument.swift
//  Exporter
//
//  Created by Angelos Staboulis on 17/7/24.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers
struct ExportDocument: FileDocument {
    
    static var readableContentTypes: [UTType] { [.image] }

    var image: UIImage

    init(image: UIImage) {
        self.image = image
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let imageData = UIImage(data: data)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        image =  imageData
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: image.pngData() ?? Data())
    }
    
}
