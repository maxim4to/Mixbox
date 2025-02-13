import Dip
import Tasks
import Destinations
import CiFoundation
import SingletonHell

public final class TeamcityBuildDi: CommonDi {
    override public init() {}
    
    override public func registerAll(container: DependencyContainer) {
        super.registerAll(container: container)
        
        container.register(type: LocalTaskExecutor.self) {
            TeamcityLocalTaskExecutor()
        }
    }
}
