<#
.SYNOPSIS
This script sets up and runs the Docker-based application.

.DESCRIPTION
The script checks for Docker, clones the project from GitHub, and starts the application using Docker Compose.
#>

# Parameters
$repoUrl = "https://github.com/HannesHuber/HHP.git"
$localRepoPath = "C:\HHP_WkSoftware"

# Clone the project
git clone $repoUrl $localRepoPath 2>&1
if ($LASTEXITCODE -ne 0) { 
    Write-Host "Failed to clone the repository. Please check the URL and your internet connection."
    Read-Host -Prompt "Press Enter to exit"  # Wait for user input
    exit
}

# Navigate to the project directory and start Docker Compose
Set-Location -Path $localRepoPath
docker-compose up -d 2>&1

# Wait for containers to start
Start-Sleep -Seconds 10

# Check if application is running
$containers = docker-compose ps
if ($containers -match "Up") {
    Write-Host "Application is running successfully."
    Write-Host "You can access your application at http://localhost"
    Write-Host "phpMyAdmin is available at http://localhost:8080"
} else {
    Write-Host "There was a problem starting the application. Please check the Docker logs."
    Read-Host -Prompt "Press Enter to continue"  # Wait for user input
}

# Shutting down the Docker containers
docker-compose down 2>&1
Write-Host "Docker containers have been shut down."

# Providing instructions to the user
Write-Host "To start the Docker containers, please open the Docker Desktop application."
Write-Host "Navigate to the 'Containers / Apps' tab, find your application, and click 'Start'."

Read-Host -Prompt "Press Enter to exit"  # Wait for user input

