#!/bin/bash
set -euo pipefail

# Аргументы: $1 = путь к dist/, $2 = blue|green
SOURCE_DIR="$1"
TARGET_ENV="$2"

if [[ "$TARGET_ENV" != "blue" && "$TARGET_ENV" != "green" ]]; then
    echo "Ошибка: окружение должно быть blue или green"
    exit 1
fi

TARGET_DIR="/var/www/${TARGET_ENV}"

echo "→ Деплой в ${TARGET_ENV} (${TARGET_DIR})"

# Чистим и копируем новую версию
rm -rf "${TARGET_DIR}"
mkdir -p "${TARGET_DIR}"
cp -r "${SOURCE_DIR}"/* "${TARGET_DIR}/"

echo "✓ Файлы скопированы в ${TARGET_DIR}"
ls -la "${TARGET_DIR}"

# Run PowerShell: https://docs.microsoft.com/en-us/powershell/scripting/windows-powershell/starting-windows-powershell?view=powershell-7#with-administrative-privileges-run-as-administrator
# Create a folder somewhere on your system, for example: C:\GitLab-Runner
New-Item -Path 'C:\GitLab-Runner' -ItemType Directory

# Change to the folder
cd 'C:\GitLab-Runner'

# Download binary
Invoke-WebRequest -Uri "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-windows-amd64.exe" -OutFile "gitlab-runner.exe"

# Register the runner (steps below), then run
.\gitlab-runner.exe install
.\gitlab-runner.exe start