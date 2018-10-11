import MixboxIpc
import MixboxIpcCommon

final class PercentageOfVisibleAreaIpcMethodHandler: IpcMethodHandler {
    let method = PercentageOfVisibleAreaIpcMethod()
    
    func handle(
        arguments: PercentageOfVisibleAreaIpcMethod.Arguments,
        completion: @escaping (CGFloat?) -> ())
    {
        guard let view = AccessibilityUniqueObjectMap.shared.locate(uniqueIdentifier: arguments.viewId) as? UIView else {
            completion(nil)
            return
        }
        
        DispatchQueue.main.async {
            completion(
                view.percentageOfVisibleArea(
                    blendingThreshold: arguments.blendingThreshold
                )
            )
        }
    }
}
