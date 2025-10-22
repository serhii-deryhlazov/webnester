<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebNester - System Metrics</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .header {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            font-weight: 300;
        }
        
        .header p {
            opacity: 0.8;
            font-size: 1.1rem;
        }
        
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            padding: 30px;
        }
        
        .metric-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            border-left: 4px solid #3498db;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .metric-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }
        
        .metric-card h3 {
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .metric-card pre {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            font-family: 'Courier New', monospace;
            font-size: 0.9rem;
            line-height: 1.4;
            overflow-x: auto;
            color: #2c3e50;
            border: 1px solid #e9ecef;
        }
        
        .icon {
            width: 24px;
            height: 24px;
            fill: currentColor;
        }
        
        .timestamp {
            text-align: center;
            padding: 20px;
            color: #7f8c8d;
            font-style: italic;
            border-top: 1px solid #ecf0f1;
        }
        
        @media (max-width: 768px) {
            .header h1 {
                font-size: 2rem;
            }
            
            .metrics-grid {
                grid-template-columns: 1fr;
                padding: 20px;
            }
            
            .metric-card {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚀 WebNester</h1>
            <p>Real-time System Metrics Dashboard</p>
        </div>
        
        <div class="metrics-grid">
            <div class="metric-card">
                <h3>
                    <svg class="icon" viewBox="0 0 24 24">
                        <path d="M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2Z"/>
                    </svg>
                    Hostname
                </h3>
                <pre><?php echo htmlspecialchars(gethostname()); ?></pre>
            </div>
            
            <div class="metric-card">
                <h3>
                    <svg class="icon" viewBox="0 0 24 24">
                        <path d="M12,20A8,8 0 0,0 20,12A8,8 0 0,0 12,4A8,8 0 0,0 4,12A8,8 0 0,0 12,20M12,2A10,10 0 0,1 22,12A10,10 0 0,1 12,22C6.47,22 2,17.5 2,12A10,10 0 0,1 12,2Z"/>
                    </svg>
                    System Uptime
                </h3>
                <pre><?php echo htmlspecialchars(shell_exec("uptime")); ?></pre>
            </div>
            
            <div class="metric-card">
                <h3>
                    <svg class="icon" viewBox="0 0 24 24">
                        <path d="M17,10.5V7A1,1 0 0,0 16,6H4A1,1 0 0,0 3,7V17A1,1 0 0,0 4,18H16A1,1 0 0,0 17,17V13.5L21,17.5V6.5L17,10.5Z"/>
                    </svg>
                    Memory Usage
                </h3>
                <pre><?php echo htmlspecialchars(shell_exec("free -h")); ?></pre>
            </div>
            
            <div class="metric-card">
                <h3>
                    <svg class="icon" viewBox="0 0 24 24">
                        <path d="M6,2C4.89,2 4,2.89 4,4V20A2,2 0 0,0 6,22H18A2,2 0 0,0 20,20V8L14,2H6Z"/>
                    </svg>
                    Disk Usage
                </h3>
                <pre><?php echo htmlspecialchars(shell_exec("df -h")); ?></pre>
            </div>
            
            <div class="metric-card">
                <h3>
                    <svg class="icon" viewBox="0 0 24 24">
                        <path d="M13,2.05V5.08C16.39,5.57 19,8.47 19,12C19,12.9 18.82,13.75 18.5,14.54L21.12,16.07C21.68,14.83 22,13.45 22,12C22,6.82 18.05,2.55 13,2.05M12,19C8.13,19 5,15.87 5,12C5,8.47 7.61,5.57 11,5.08V2.05C5.94,2.55 2,6.81 2,12C2,17.52 6.47,22 12,22C13.45,22 14.83,21.68 16.07,21.12L14.54,18.5C13.75,18.82 12.9,19 12,19Z"/>
                    </svg>
                    CPU Load
                </h3>
                <pre><?php echo htmlspecialchars(shell_exec("top -b -n1 | grep 'Cpu(s)'")); ?></pre>
            </div>
            
            <div class="metric-card">
                <h3>
                    <svg class="icon" viewBox="0 0 24 24">
                        <path d="M19,3H5C3.89,3 3,3.89 3,5V19A2,2 0 0,0 5,21H19A2,2 0 0,0 21,19V5C21,3.89 20.1,3 19,3M19,5V19H5V5H19Z"/>
                    </svg>
                    Server Info
                </h3>
                <pre><?php 
                    echo "PHP Version: " . PHP_VERSION . "\n";
                    echo "Server Software: " . $_SERVER['SERVER_SOFTWARE'] . "\n";
                    echo "Document Root: " . $_SERVER['DOCUMENT_ROOT'] . "\n";
                    echo "Server Time: " . date('Y-m-d H:i:s T');
                ?></pre>
            </div>
        </div>
        
        <div class="timestamp">
            Last updated: <?php echo date('Y-m-d H:i:s T'); ?>
        </div>
    </div>
</body>
</html>
