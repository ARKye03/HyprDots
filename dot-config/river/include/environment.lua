-- How the fuck do I implement this?

local function SetEnvironmentVariable(key, value)
    os.execute(string.format("export %s=%s", key, value))
end

local envVars = {
    LIBVA_DRIVER_NAME = "nvidia",
    XDG_SESSION_TYPE = "wayland",
    GBM_BACKEND = "nvidia-drm",
    __GLX_VENDOR_LIBRARY_NAME = "nvidia",
    NVD_BACKEND = "direct",
    QT_QPA_PLATFORM = "wayland",
    WLR_RENDERER_ALLOW_SOFTWARE = "1",
    GDK_BACKEND = "wayland",
    WARP_ENABLE_WAYLAND = "1",
    ELECTRON_OZONE_PLATFORM_HINT = "wayland"
}

for key, value in pairs(envVars) do
    SetEnvironmentVariable(key, value)
end
