import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    self.contentViewController = flutterViewController

    // Set spacious desktop window resolution to 1280x720 HD adventure screen
    let targetSize = NSSize(width: 1280, height: 720)
    if let screen = NSScreen.main {
      let screenRect = screen.visibleFrame
      let originX = screenRect.origin.x + (screenRect.width - targetSize.width) / 2
      let originY = screenRect.origin.y + (screenRect.height - targetSize.height) / 2
      self.setFrame(NSRect(x: originX, y: originY, width: targetSize.width, height: targetSize.height), display: true)
    }

    self.title = "Whiskers: Legend of the Celestial Blossom"
    self.minSize = NSSize(width: 960, height: 540)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
