function Rivertile()
    local rivertile = {
        view_padding = 4,
        outer_padding = 2,
        main_location = "left",
        main_count = 1,
        main_ratio = 0.6
    }
    os.execute(
        "rivertile -view-padding "
        .. rivertile.view_padding
        .. " -outer-padding "
        .. rivertile.outer_padding
        .. " -main-location "
        .. rivertile.main_location
        .. " -main-count "
        .. rivertile.main_count
        .. " -main-ratio "
        .. rivertile.main_ratio
        .. " &"
    )
end

return Rivertile
