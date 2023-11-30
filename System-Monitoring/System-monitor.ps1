# System Monitoring

function Get-SystemMetrics {
    $cpuCounter = (Get-Counter '\Processor(_Total)\% Processor Time')
    $memoryCounter = (Get-Counter '\Memory\Available MBytes')
    $diskCounter = (Get-Counter '\PhysicalDisk(_Total)\Disk Reads/sec')

    $cpuUsage = if ($cpuCounter.CounterSamples.Count -gt 0) { $cpuCounter.CounterSamples[0].CookedValue } else { -1 }
    $memoryUsage = if ($memoryCounter.CounterSamples.Count -gt 0) { $memoryCounter.CounterSamples[0].CookedValue } else { -1 }
    $diskActivity = if ($diskCounter.CounterSamples.Count -gt 0) { $diskCounter.CounterSamples[0].CookedValue } else { -1 }

    return @{
    CPUUsage = $cpuUsage
    MemoryUsage = $memoryUsage
    DiskActivity = $diskActivity
}
}

function Show-SystemMetrics {
    $metrics = Get-SystemMetrics

    Write-Host "CPU Usage: $($metrics.CPUUsage)%"
    Write-Host "Memory Usage: $($metrics.MemoryUsage) MB"
    Write-Host "Disk Activity: $($metrics.DiskActivity) Reads/sec "
}


#monitor loop
while ($true) {
    Clear-Host
    Write-Host "System Monitoring - Press Ctrl+C to exit"
    Show-SystemMetrics
    Start-Sleep -Seconds 5
}

