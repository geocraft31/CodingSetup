$vscodeUrl = "https://update.code.visualstudio.com/latest/win32-x64-user/stable"

$downloadPath = "$env:USERPROFILE\Downloads\VSCodeSetup.exe"

Invoke-WebRequest -Uri $vscodeUrl -OutFile $downloadPath

Start-Process -Wait -FilePath $downloadPath

$extensionIds = @(
    "akamud.vscode-theme-onedark",
    "esbenp.prettier-vscode",
    "formulahendry.code-runner",
    "gruntfuggly.todo-tree",
    "james-yu.latex-workshop",
    "ms-python.debugpy",
    "ms-python.python",
    "ms-python.vscode-pylance",
    "ms-toolsai.jupyter",
    "ms-toolsai.jupyter-keymap",
    "ms-toolsai.jupyter-renderers",
    "ms-toolsai.vscode-jupyter-cell-tags,"
    "ms-toolsai.vscode-jupyter-slideshow",
    "ms-vscode.cmake-tools",
    "ms-vscode.cpptools",
    "ms-vscode.cpptools-extension-pack",
    "ms-vscode.cpptools-themes",
    "ms-vscode.powershell",
    "pkief.material-icon-theme",
    "ritwickdey.liveserver",
    "tinkertrain.theme-panda",
    "tomoki1207.pdf",
    "twxs.cmake",
    "usernamehw.errorlens",
    "visualstudioexptteam.intellicode-api-usage-examples",
    "visualstudioexptteam.vscodeintellicode"
)

foreach ($extensionId in $extensionIds) {
    code --install-extension $extensionId
}

