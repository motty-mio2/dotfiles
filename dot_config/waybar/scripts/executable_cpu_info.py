#!/usr/bin/env python3
import time
import json

def get_stats():
    with open('/proc/stat', 'r') as f:
        lines = f.readlines()
    stats = {}
    for line in lines:
        if line.startswith('cpu'):
            parts = line.split()
            name = parts[0]
            # user, nice, system, idle, iowait, irq, softirq, steal
            values = [int(x) for x in parts[1:9]]
            idle = values[3] + values[4]
            total = sum(values)
            stats[name] = (idle, total)
    return stats

def main():
    s1 = get_stats()
    time.sleep(1)
    s2 = get_stats()

    tooltip_parts = []
    total_usage = 0

    # Sort cores: cpu, cpu0, cpu1, ...
    cores = sorted(s2.keys(), key=lambda x: int(x[3:]) if x[3:].isdigit() else -1)

    for i, core in enumerate(cores):
        prev_idle, prev_total = s1[core]
        curr_idle, curr_total = s2[core]
        
        diff_idle = curr_idle - prev_idle
        diff_total = curr_total - prev_total
        
        usage = 100 * (1 - diff_idle / diff_total) if diff_total > 0 else 0
        
        if core == "cpu":
            total_usage = usage
        else:
            # Format: Core 0: 12.5%
            label = f"Core {core[3:]}:"
            tooltip_parts.append(f"{label:<8} {usage:>5.1f}%")

    # Arrange in 2 columns for the tooltip
    rows = []
    mid = (len(tooltip_parts) + 1) // 2
    for i in range(mid):
        left = tooltip_parts[i]
        right = tooltip_parts[i + mid] if i + mid < len(tooltip_parts) else ""
        rows.append(f"{left}\t{right}")

    data = {
        "text": f"{total_usage:.0f}% ",
        "tooltip": "CPU使用率詳細\n\n" + "\n".join(rows)
    }
    print(json.dumps(data))

if __name__ == "__main__":
    main()
