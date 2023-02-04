import Foundation
import CoreGraphics
import AVFoundation

extension CGImage {

  static func open(url: URL) -> CGImage? {
    guard
      let source = CGImageSourceCreateWithURL(url as CFURL, nil),
      let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {

      return nil
    }
    return image
  }
}