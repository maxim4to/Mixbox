// Tracks when process is running.
// Can be used to stop tracking time of something when nothing is working.
//
// The alternative solution will be listening for SIGSTOP... you may think, but you would be wrong,
// because SIGSTOP can not be handled (as well as SIGKILL for example).
//
// So I made this. This can produce false positive results, because in case of high load on the machine
// process can wait a lot before it gets CPU time. So, for example, performance metrics can be spoiled a little
// if you remove time from them using this class. But I think it is better than tracking time spent in debugger
// as time spent on some workload.
//
public typealias ProcessInterruptionHandler = (_ interrupted: Date, _ resumed: Date) -> ()
public final class ProcessInterruptionDetector {
    private let queue = DispatchQueue(label: "ProcessInterruptionDetector", qos: .userInteractive)
    private var listening: Bool = false
    private let pollInterval: TimeInterval
    private let maximalDeviation: TimeInterval
    private let onInterruption: ProcessInterruptionHandler
    
    public init(
        // how often to perform check:
        pollInterval: TimeInterval = 1,
        // how much time process should not work to start tracking that it is not working:
        maximalDeviation: TimeInterval = 1,
        onInterruption: @escaping ProcessInterruptionHandler)
    {
        self.onInterruption = onInterruption
        self.pollInterval = pollInterval
        self.maximalDeviation = maximalDeviation
    }
    
    public func startListening() {
        if !listening {
            listening = true
            schedule()
        }
    }
    
    private func schedule() {
        if listening {
            let dateWhenClosureWasAddedToQueue = Date()
            
            queue.asyncAfter(deadline: .now() + pollInterval) { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                
                let currentDate = Date()
                let howMuchTimeItShouldHaveSpentIfProcessWasNotInterrupted = strongSelf.pollInterval
                let howMuchTimeItActuallySpent = currentDate.timeIntervalSince(dateWhenClosureWasAddedToQueue)
                
                let deviation = howMuchTimeItActuallySpent - howMuchTimeItShouldHaveSpentIfProcessWasNotInterrupted
                
                if deviation > strongSelf.maximalDeviation {
                    strongSelf.onInterruption(dateWhenClosureWasAddedToQueue, currentDate)
                }
                
                strongSelf.schedule()
            }
        }
    }
}
