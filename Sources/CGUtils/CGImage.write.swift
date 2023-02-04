import Foundation
import CoreGraphics
import AVFoundation

extension CGImage {

  public func write(format: ImageFormat, to url: URL) throws {
    switch format {
    case .heic, .png:
      let uti = format.uti
      guard let dest = CGImageDestinationCreateWithURL(url as CFURL, uti as CFString as CFString, 1, nil)
      else {
        throw ExportErrors.creatingDestination
      }

      CGImageDestinationAddImage(dest, self, [
        kCGImageDestinationLossyCompressionQuality: 1.0,
      ] as CFDictionary)

      if CGImageDestinationFinalize(dest) == false {
        throw ExportErrors.failureWritingImage
      }
    }
  }

  public enum ExportErrors: Error {
    case creatingDestination
    case failureWritingImage
  }
}

