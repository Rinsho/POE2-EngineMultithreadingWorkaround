
write-host "Searching for POE processes..."
# Set target affinity to CPU#2-<max>, disallowing engine multithreading access to CPU#0-1
$logical_core_count = get-ciminstance -classname 'Win32_Processor' | select -expandproperty 'NumberOfLogicalProcessors'
$target_affinity = [Math]::Pow(2, $logical_core_count) - 1 - 1 - 2

get-process -name "PathOfExile*" |
    ? { $_.ProcessorAffinity +0 -gt $target_affinity } |
    % {
        write-host "Setting CPU#2-$($logical_core_count - 1) affinity (${target_affinity}) for: 'Name=$($_.ProcessName); Title=$($_.MainWindowTitle)'"
        $_.ProcessorAffinity = [int] $target_affinity
    }

write-host "Done! You can close this now."
