if (!(Test-Path -Path ".\build")) {
    New-Item -ItemType Directory -Path ".\build"
}

cd .\build
cmake .. -G "Ninja Multi-Config"
cmake --build . --config Debug --parallel
cmake --build . --config Release --parallel
cd ..

Write-Host "=============================" -ForegroundColor Green
Write-Host "       Build finished        " -ForegroundColor Green
Write-Host "=============================" -ForegroundColor Green
