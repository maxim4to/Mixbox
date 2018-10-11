import MixboxIpc

public final class PercentageOfVisibleAreaIpcMethod: IpcMethod {
    public final class _Arguments: Codable {
        public let viewId: String
        public let blendingThreshold: CGFloat
        
        public init(
            viewId: String,
            blendingThreshold: CGFloat)
        {
            self.viewId = viewId
            self.blendingThreshold = blendingThreshold
        }
    }
    
    public typealias Arguments = _Arguments
    public typealias ReturnValue = CGFloat?
    
    public init() {
    }
}
