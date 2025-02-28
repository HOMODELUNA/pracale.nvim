---@class Pracale
---@field config PracaleConfig
---@field palette PracalePalette
local Pracale = {}

---@alias Contrast "hard" | "soft" | ""

---@class ItalicConfig
---@field strings boolean
---@field comments boolean
---@field operators boolean
---@field folds boolean
---@field emphasis boolean

---@class HighlightDefinition
---@field fg string?
---@field bg string?
---@field sp string?
---@field blend integer?
---@field bold boolean?
---@field standout boolean?
---@field underline boolean?
---@field undercurl boolean?
---@field underdouble boolean?
---@field underdotted boolean?
---@field strikethrough boolean?
---@field italic boolean?
---@field reverse boolean?
---@field nocombine boolean?

---@class PracaleConfig
---@field terminal_colors boolean?
---@field undercurl boolean?
---@field underline boolean?
---@field bold boolean?
---@field italic ItalicConfig?
---@field strikethrough boolean?
---@field contrast Contrast?
---@field invert_selection boolean?
---@field invert_signs boolean?
---@field invert_tabline boolean?
---@field invert_intend_guides boolean?
---@field inverse boolean?
---@field overrides table<string, HighlightDefinition>?
---@field palette_overrides table<string, string>?
Pracale.config = {
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
                strings = true,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,
        contrast = "",
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
}

-- main pracale color palette
---@class PracalePalette
Pracale.palette = {
        dark0 = "#000000",
        dark1 = "#3c3836",
        dark2 = "#504945",
        dark3 = "#665c54",
        dark4 = "#7c6f64",
        light0_hard = "#f9f5d7",
        light0 = "#d0ffd0",
        light0_soft = "#f2e5bc",
        light1 = "#ebdbb2",
        light2 = "#d5c4a1",
        light3 = "#bdae93",
        light4 = "#a89984",
        red = "#ff0000",
        bright_red = "#ff9090",

        green = "#00ff00",
        bright_green = "#b8ff26",

        yellow = "#fabd2f",
        bright_yellow = "#f8d86a",

        blue = "#349de4",
        bright_blue = "#b7cbef",
        pure_blue = "#a6f0b0",

        purple = "#d3869b",
        bright_purple = "#d3869b",

        aqua = "#8ec07c",
        bright_aqua = "#8ec07c",

        orange = "#fe8019",
        bright_orange = "#fe8019",
        neutral_red = "#cc241d",
        neutral_green = "#98971a",
        neutral_yellow = "#d79921",
        neutral_blue = "#458588",
        neutral_purple = "#b16286",
        neutral_aqua = "#689d6a",
        neutral_orange = "#d65d0e",
        faded_red = "#9d0006",
        faded_green = "#79740e",
        faded_yellow = "#b57614",
        faded_blue = "#076678",
        faded_purple = "#8f3f71",
        faded_aqua = "#427b58",
        faded_orange = "#af3a03",
        dark_red_hard = "#792329",
        dark_red = "#722529",
        dark_red_soft = "#7b2c2f",
        light_red_hard = "#fc9690",
        light_red = "#fc9487",
        light_red_soft = "#f78b7f",
        dark_green_hard = "#5a633a",
        dark_green = "#62693e",
        dark_green_soft = "#686d43",
        light_green_hard = "#d3d6a5",
        light_green = "#d5d39b",
        light_green_soft = "#cecb94",
        dark_aqua_hard = "#3e4934",
        dark_aqua = "#49503b",
        dark_aqua_soft = "#525742",
        light_aqua_hard = "#e6e9c1",
        light_aqua = "#e8e5b5",
        light_aqua_soft = "#e1dbac",
        gray = "#928374",
        dirt_brown = '#a07070'
}

for i = 0, 4 do
        Pracale.palette["bg" .. i] = Pracale.palette["dark" .. i]
        Pracale.palette["fg" .. i] = Pracale.palette["light" .. i]
end
-- get a hex list of pracale colors based on current bg and constrast config
local function get_colors()
        local p = Pracale.palette
        local config = Pracale.config
        -- local dark = {
        --   bg0 = p.dark0,
        --   bg1 = p.dark1,
        --   bg2 = p.dark2,
        --   bg3 = p.dark3,
        --   bg4 = p.dark4,
        --   fg0 = p.light0,
        --   fg1 = p.light1,
        --   fg2 = p.light2,
        --   fg3 = p.light3,
        --   fg4 = p.light4,
        --   red = p.bright_red,
        --   green = p.bright_green,
        --   yellow = p.bright_yellow,
        --   blue = p.bright_blue,
        --   purple = p.bright_purple,
        --   aqua = p.bright_aqua,
        --   orange = p.bright_orange,
        --   neutral_red = p.neutral_red,
        --   neutral_green = p.neutral_green,
        --   neutral_yellow = p.neutral_yellow,
        --   neutral_blue = p.neutral_blue,
        --   neutral_purple = p.neutral_purple,
        --   neutral_aqua = p.neutral_aqua,
        --   dark_red = p.dark_red,
        --   dark_green = p.dark_green,
        --   dark_aqua = p.dark_aqua,
        --   gray = p.gray,
        -- }
        return p
end

local colors = Pracale.palette
local config = Pracale.config

if config.terminal_colors then
        local term_colors = {
                colors.bg0,
                colors.neutral_red,
                colors.neutral_green,
                colors.neutral_yellow,
                colors.neutral_blue,
                colors.neutral_purple,
                colors.neutral_aqua,
                colors.fg4,
                colors.gray,
                colors.red,
                colors.green,
                colors.yellow,
                colors.blue,
                colors.purple,
                colors.aqua,
                colors.fg1,
        }
        for index, value in ipairs(term_colors) do
                vim.g["terminal_color_" .. index - 1] = value
        end
end

local groups = {
}

local function with_prefix(pre)
        return function(tbl)
                for k, v in pairs(tbl) do
                        groups[pre .. k] = v
                end
        end
end

with_prefix("Pracale") {
        Fg0 = { fg = colors.light0 },
        Fg1 = { fg = colors.light1 },
        Fg2 = { fg = colors.light2 },
        Fg3 = { fg = colors.light3 },
        Fg4 = { fg = colors.light4 },
        Gray = { fg = colors.gray },
        Bg0 = { fg = colors.dark0 },
        Bg1 = { fg = colors.dark1 },
        Bg2 = { fg = colors.dark2 },
        Bg3 = { fg = colors.dark3 },
        Bg4 = { fg = colors.dark4 },
        Red = { fg = colors.bright_red },
        RedBold = { fg = colors.red, bold = config.bold },
        Green = { fg = colors.green },
        GreenBold = { fg = colors.green, bold = true },
        Yellow = { fg = colors.yellow },
        YellowBold = { fg = colors.yellow, bold = config.bold },
        Blue = { fg = colors.blue },
        PureBlue = { fg = colors.pure_blue },
        BlueBold = { fg = colors.blue, bold = config.bold },
        LightPurple = { fg = "#ff44ff" },
        Purple = { fg = colors.purple },
        PurpleBold = { fg = colors.purple, bold = config.bold },
        Aqua = { fg = colors.aqua },
        AquaBold = { fg = colors.aqua, bold = config.bold },
        Orange = { fg = colors.orange },
        OrangeBold = { fg = colors.orange, bold = config.bold },
        RedSign = config.transparent_mode and { fg = colors.red, reverse = config.invert_signs }
            or { fg = colors.red, bg = colors.bg1, reverse = config.invert_signs },
        GreenSign = config.transparent_mode and { fg = colors.green, reverse = config.invert_signs }
            or { fg = colors.green, bg = colors.bg1, reverse = config.invert_signs },
        YellowSign = config.transparent_mode and { fg = colors.yellow, reverse = config.invert_signs }
            or { fg = colors.yellow, bg = colors.bg1, reverse = config.invert_signs },
        BlueSign = config.transparent_mode and { fg = colors.blue, reverse = config.invert_signs }
            or { fg = colors.blue, bg = colors.bg1, reverse = config.invert_signs },
        PurpleSign = config.transparent_mode and { fg = colors.purple, reverse = config.invert_signs }
            or { fg = colors.purple, bg = colors.bg1, reverse = config.invert_signs },
        AquaSign = config.transparent_mode and { fg = colors.aqua, reverse = config.invert_signs }
            or { fg = colors.aqua, bg = colors.bg1, reverse = config.invert_signs },
        OrangeSign = config.transparent_mode and { fg = colors.orange, reverse = config.invert_signs }
            or { fg = colors.orange, bg = colors.bg1, reverse = config.invert_signs },
        RedUnderline = { undercurl = config.undercurl, sp = colors.red },
        GreenUnderline = { undercurl = config.undercurl, sp = colors.green },
        YellowUnderline = { undercurl = config.undercurl, sp = colors.yellow },
        BlueUnderline = { undercurl = config.undercurl, sp = colors.blue },
        PurpleUnderline = { undercurl = config.undercurl, sp = colors.purple },
        AquaUnderline = { undercurl = config.undercurl, sp = colors.aqua },
        OrangeUnderline = { undercurl = config.undercurl, sp = colors.orange },
}

with_prefix("") {
        Normal = config.transparent_mode and { fg = colors.fg1, bg = nil } or { fg = colors.fg1, bg = colors.bg0 },
        NormalFloat = config.transparent_mode and { fg = colors.fg1, bg = nil } or { fg = colors.fg1, bg = colors.bg1 },
        NormalNC = config.dim_inactive and { fg = colors.fg0, bg = colors.bg1 } or { link = "Normal" },
        CursorLine = { bg = colors.bg1 },
        CursorColumn = { link = "CursorLine" },
        TabLineFill = { fg = colors.bg4, bg = colors.bg1, reverse = config.invert_tabline },
        TabLineSel = { fg = colors.green, bg = colors.bg1, reverse = config.invert_tabline },
        TabLine = { link = "TabLineFill" },
        MatchParen = { bg = colors.bg3, bold = config.bold },
        Delimiter = { link= "Normal" },
        ColorColumn = { bg = colors.bg1 },
        Conceal = { fg = colors.blue },
        CursorLineNr = { fg = colors.yellow, bg = colors.bg1 },
        NonText = { link = "PracaleBg2" },
        SpecialKey = { link = "PracaleFg4" },
        Visual = { bg = colors.bg3, reverse = config.invert_selection },
        VisualNOS = { link = "Visual" },
        Search = { fg = colors.yellow, bg = colors.bg0, reverse = config.inverse },
        IncSearch = { fg = colors.orange, bg = colors.bg0, reverse = config.inverse },
        CurSearch = { link = "IncSearch" },
        QuickFixLine = { link = "PracalePurple" },
        Underlined = { fg = colors.blue, underline = config.underline },
        StatusLine = { fg = colors.bg2, bg = colors.fg1, reverse = config.inverse },
        StatusLineNC = { fg = colors.bg1, bg = colors.fg4, reverse = config.inverse },
        WinBar = { fg = colors.fg4, bg = colors.bg0 },
        WinBarNC = { fg = colors.fg3, bg = colors.bg1 },
        WinSeparator = config.transparent_mode and { fg = colors.bg3, bg = nil } or { fg = colors.bg3, bg = colors.bg0 },
        WildMenu = { fg = colors.blue, bg = colors.bg2, bold = config.bold },
        Directory = { link = "PracaleBlueBold" },
        Title = { link = "PracaleGreenBold" },
        ErrorMsg = { fg = colors.bg0, bg = colors.red, bold = config.bold },
        MoreMsg = { link = "PracaleYellowBold" },
        ModeMsg = { link = "PracaleYellowBold" },
        Question = { link = "PracaleOrangeBold" },
        WarningMsg = { link = "PracaleRedBold" },
        LineNr = { fg = colors.bg4 },
        SignColumn = config.transparent_mode and { bg = nil } or { bg = colors.bg1 },
        Folded = { fg = colors.gray, bg = colors.bg1, italic = config.italic.folds },
        FoldColumn = config.transparent_mode and { fg = colors.gray, bg = nil } or { fg = colors.gray, bg = colors.bg1 },
        Cursor = { reverse = config.inverse },
        vCursor = { link = "Cursor" },
        iCursor = { link = "Cursor" },
        lCursor = { link = "Cursor" },
        Special = { link = "PracaleLightPurple" },
        Comment = { fg = colors.dirt_brown, italic = config.italic.comments },
        Todo = { fg = colors.bg0, bg = colors.yellow, bold = config.bold, italic = config.italic.comments },
        Done = { fg = colors.orange, bold = config.bold, italic = config.italic.comments },
        Error = { fg = colors.red, bold = config.bold, reverse = config.inverse },
        Statement = { link = "PracaleRed" },
        Conditional = { link = "PracaleRed" },
        Repeat = { link = "PracaleRed" },
        Label = { link = "PracaleRed" },
        Exception = { link = "PracaleRed" },
        Operator = { fg = colors.orange, italic = config.italic.operators },
        Keyword = { link = "PracaleRed" },
        Identifier = { fg = "#c6e6e8" },
        Function = { fg = "#ee3f40", bold = true },
        BuiltinFunction = { fg = "#f03031", bold = true },

        PreProc = { link = "PracaleAqua" },
        Include = { link = "PracaleAqua" },
        Define = { link = "PracaleAqua" },
        Macro = { link = "PracaleAqua" },
        PreCondit = { link = "PracaleAqua" },

        Literal = { link = "PracaleLightPurple" },
        Constant = { link = "PracalePureBlue" },
        Character = { link = "PracaleOrange" },
        SpecialChar = { link = "PracaleYellow" },
        String = { link = "PracaleOrange" },
        Boolean = { link = "Literal" },
        Number = { link = "Literal" },
        Float = { link = "Literal" },
        Type = { fg = colors.bright_green },
        ModuleOrNamespace = { fg = "#f8d86a" },
        StorageClass = { fg = "#1a94bc" },
        Modifier = { fg = "#1a94bc" },
        Structure = { link = "PracaleAqua" },
        Typedef = { link = "Type" },

        Pmenu = { fg = colors.fg1, bg = colors.bg2 },
        PmenuSel = { fg = colors.bg2, bg = colors.blue, bold = config.bold },
        PmenuSbar = { bg = colors.bg2 },
        PmenuThumb = { bg = colors.bg4 },

        DiffDelete = { bg = colors.dark_red },
        DiffAdd = { bg = colors.dark_green },
        DiffChange = { bg = colors.dark_aqua },
        DiffText = { bg = colors.yellow, fg = colors.bg0 },

        SpellCap = { link = "PracaleBlueUnderline" },
        SpellBad = { link = "PracaleRedUnderline" },
        SpellLocal = { link = "PracaleAquaUnderline" },
        SpellRare = { link = "PracalePurpleUnderline" },
        Whitespace = { fg = colors.bg2 },

        DiagnosticError = { link = "PracaleRed" },
        DiagnosticSignError = { link = "PracaleRedSign" },
        DiagnosticUnderlineError = { link = "PracaleRedUnderline" },
        DiagnosticWarn = { link = "PracaleYellow" },
        DiagnosticSignWarn = { link = "PracaleYellowSign" },
        DiagnosticUnderlineWarn = { link = "PracaleYellowUnderline" },
        DiagnosticInfo = { link = "PracaleBlue" },
        DiagnosticSignInfo = { link = "PracaleBlueSign" },
        DiagnosticUnderlineInfo = { link = "PracaleBlueUnderline" },
        DiagnosticHint = { link = "PracaleAqua" },
        DiagnosticSignHint = { link = "PracaleAquaSign" },
        DiagnosticUnderlineHint = { link = "PracaleAquaUnderline" },
        DiagnosticFloatingError = { link = "PracaleRed" },
        DiagnosticFloatingWarn = { link = "PracaleOrange" },
        DiagnosticFloatingInfo = { link = "PracaleBlue" },
        DiagnosticFloatingHint = { link = "PracaleAqua" },
        DiagnosticVirtualTextError = { link = "PracaleRed" },
        DiagnosticVirtualTextWarn = { link = "PracaleYellow" },
        DiagnosticVirtualTextInfo = { link = "PracaleBlue" },
        DiagnosticVirtualTextHint = { link = "PracaleAqua" },
        DiagnosticOk = { link = "PracaleGreenSign" },

        LspReferenceRead = { link = "PracaleYellowBold" },
        LspReferenceText = { link = "PracaleYellowBold" },
        LspReferenceWrite = { link = "PracaleOrangeBold" },
        LspCodeLens = { link = "PracaleGray" },
        LspSignatureActiveParameter = { link = "Search" },

        gitcommitSelectedFile = { link = "PracaleGreen" },
        gitcommitDiscardedFile = { link = "PracaleRed" },
        GitSignsAdd = { link = "PracaleGreen" },
        GitSignsChange = { link = "PracaleAqua" },
        GitSignsDelete = { link = "PracaleRed" },
}
with_prefix("NvimTree") {
        Symlink = { fg = colors.neutral_aqua },
        RootFolder = { fg = colors.neutral_purple, bold = true },
        FolderIcon = { fg = colors.neutral_blue, bold = true },
        FileIcon = { fg = colors.light2 },
        ExecFile = { fg = colors.neutral_green, bold = true },
        OpenedFile = { fg = colors.bright_red, bold = true },
        SpecialFile = { fg = colors.neutral_yellow, bold = true, underline = true },
        ImageFile = { fg = colors.neutral_purple },
        IndentMarker = { fg = colors.dark3 },
        GitDirty = { fg = colors.neutral_yellow },
        GitStaged = { fg = colors.neutral_yellow },
        GitMerge = { fg = colors.neutral_purple },
        GitRenamed = { fg = colors.neutral_purple },
        GitNew = { fg = colors.neutral_yellow },
        GitDeleted = { fg = colors.neutral_red },
        WindowPicker = { bg = colors.aqua },
}
with_prefix("") {
        debugPC = { link = "DiffAdd" },
        debugBreakpoint = { link = "PracaleRedSign" },
        StartifyBracket = { link = "PracaleFg3" },
        StartifyFile = { link = "PracaleFg1" },
        StartifyNumber = { link = "PracaleBlue" },
        StartifyPath = { link = "PracaleGray" },
        StartifySlash = { link = "PracaleGray" },
        StartifySection = { link = "PracaleYellow" },
        StartifySpecial = { link = "PracaleBg2" },
        StartifyHeader = { link = "PracaleOrange" },
        StartifyFooter = { link = "PracaleBg2" },
        StartifyVar = { link = "StartifyPath" },
        StartifySelect = { link = "Title" },
        DirvishPathTail = { link = "PracaleAqua" },
        DirvishArg = { link = "PracaleYellow" },

}
with_prefix("") {
        netrwDir = { link = "PracaleAqua" },
        netrwClassify = { link = "PracaleAqua" },
        netrwLink = { link = "PracaleGray" },
        netrwSymLink = { link = "PracaleFg1" },
        netrwExe = { link = "PracaleYellow" },
        netrwComment = { link = "PracaleGray" },
        netrwList = { link = "PracaleBlue" },
        netrwHelpCmd = { link = "PracaleAqua" },
        netrwCmdSep = { link = "PracaleFg3" },
        netrwVersion = { link = "PracaleGreen" },

}
with_prefix("") {
        NERDTreeDir = { link = "PracaleAqua" },
        NERDTreeDirSlash = { link = "PracaleAqua" },
        NERDTreeOpenable = { link = "PracaleOrange" },
        NERDTreeClosable = { link = "PracaleOrange" },
        NERDTreeFile = { link = "PracaleFg1" },
        NERDTreeExecFile = { link = "PracaleYellow" },
        NERDTreeUp = { link = "PracaleGray" },
        NERDTreeCWD = { link = "PracaleGreen" },
        NERDTreeHelp = { link = "PracaleFg1" },
        NERDTreeToggleOn = { link = "PracaleGreen" },
        NERDTreeToggleOff = { link = "PracaleRed" },

}
with_prefix("") {
        CocErrorSign = { link = "PracaleRedSign" },
        CocWarningSign = { link = "PracaleOrangeSign" },
        CocInfoSign = { link = "PracaleBlueSign" },
        CocHintSign = { link = "PracaleAquaSign" },
        CocErrorFloat = { link = "PracaleRed" },
        CocWarningFloat = { link = "PracaleOrange" },
        CocInfoFloat = { link = "PracaleBlue" },
        CocHintFloat = { link = "PracaleAqua" },
        CocDiagnosticsError = { link = "PracaleRed" },
        CocDiagnosticsWarning = { link = "PracaleOrange" },
        CocDiagnosticsInfo = { link = "PracaleBlue" },
        CocDiagnosticsHint = { link = "PracaleAqua" },
        CocSelectedText = { link = "PracaleRed" },
        CocMenuSel = { link = "PmenuSel" },
        CocCodeLens = { link = "PracaleGray" },
        CocErrorHighlight = { link = "PracaleRedUnderline" },
        CocWarningHighlight = { link = "PracaleOrangeUnderline" },
        CocInfoHighlight = { link = "PracaleBlueUnderline" },
        CocHintHighlight = { link = "PracaleAquaUnderline" },

}
with_prefix("") {
        TelescopeNormal = { link = "PracaleFg1" },
        TelescopeSelection = { link = "PracaleOrangeBold" },
        TelescopeSelectionCaret = { link = "PracaleRed" },
        TelescopeMultiSelection = { link = "PracaleGray" },
        TelescopeBorder = { link = "TelescopeNormal" },
        TelescopePromptBorder = { link = "TelescopeNormal" },
        TelescopeResultsBorder = { link = "TelescopeNormal" },
        TelescopePreviewBorder = { link = "TelescopeNormal" },
        TelescopeMatching = { link = "PracaleBlue" },
        TelescopePromptPrefix = { link = "PracaleRed" },
        TelescopePrompt = { link = "TelescopeNormal" },

}
with_prefix("") {
        CmpItemAbbr = { link = "PracaleFg0" },
        CmpItemAbbrDeprecated = { link = "PracaleFg1" },
        CmpItemAbbrMatch = { link = "PracaleBlueBold" },
        CmpItemAbbrMatchFuzzy = { link = "PracaleBlueUnderline" },
        CmpItemMenu = { link = "PracaleGray" },
        CmpItemKindText = { link = "PracaleOrange" },
        CmpItemKindVariable = { link = "PracaleOrange" },
        CmpItemKindMethod = { link = "PracaleBlue" },
        CmpItemKindFunction = { link = "PracaleBlue" },
        CmpItemKindConstructor = { link = "PracaleYellow" },
        CmpItemKindUnit = { link = "PracaleBlue" },
        CmpItemKindField = { link = "PracaleBlue" },
        CmpItemKindClass = { link = "PracaleYellow" },
        CmpItemKindInterface = { link = "PracaleYellow" },
        CmpItemKindModule = { link = "PracaleBlue" },
        CmpItemKindProperty = { link = "PracaleBlue" },
        CmpItemKindValue = { link = "PracaleOrange" },
        CmpItemKindEnum = { link = "PracaleYellow" },
        CmpItemKindOperator = { link = "PracaleYellow" },
        CmpItemKindKeyword = { link = "PracalePurple" },
        CmpItemKindEvent = { link = "PracalePurple" },
        CmpItemKindReference = { link = "PracalePurple" },
        CmpItemKindColor = { link = "PracalePurple" },
        CmpItemKindSnippet = { link = "PracaleGreen" },
        CmpItemKindFile = { link = "PracaleBlue" },
        CmpItemKindFolder = { link = "PracaleBlue" },
        CmpItemKindEnumMember = { link = "PracaleAqua" },
        CmpItemKindConstant = { link = "PracaleOrange" },
        CmpItemKindStruct = { link = "PracaleYellow" },
        CmpItemKindTypeParameter = { link = "PracaleYellow" },
}
with_prefix("") {
        diffAdded = { link = "DiffAdd" },
        diffRemoved = { link = "DiffDelete" },
        diffChanged = { link = "DiffChange" },
        diffFile = { link = "PracaleOrange" },
        diffNewFile = { link = "PracaleYellow" },
        diffOldFile = { link = "PracaleOrange" },
        diffLine = { link = "PracaleBlue" },
        diffIndexLine = { link = "diffChanged" },
}
with_prefix("") {
        NavicIconsFile = { link = "PracaleBlue" },
        NavicIconsModule = { link = "PracaleOrange" },
        NavicIconsNamespace = { link = "PracaleBlue" },
        NavicIconsPackage = { link = "PracaleAqua" },
        NavicIconsClass = { link = "PracaleYellow" },
        NavicIconsMethod = { link = "PracaleBlue" },
        NavicIconsProperty = { link = "PracaleAqua" },
        NavicIconsField = { link = "PracalePurple" },
        NavicIconsConstructor = { link = "PracaleBlue" },
        NavicIconsEnum = { link = "PracalePurple" },
        NavicIconsInterface = { link = "PracaleGreen" },
        NavicIconsFunction = { link = "PracaleBlue" },
        NavicIconsVariable = { link = "PracalePurple" },
        NavicIconsConstant = { link = "PracaleOrange" },
        NavicIconsString = { link = "PracaleGreen" },
        NavicIconsNumber = { link = "PracaleOrange" },
        NavicIconsBoolean = { link = "PracaleOrange" },
        NavicIconsArray = { link = "PracaleOrange" },
        NavicIconsObject = { link = "PracaleOrange" },
        NavicIconsKey = { link = "PracaleAqua" },
        NavicIconsNull = { link = "PracaleOrange" },
        NavicIconsEnumMember = { link = "PracaleYellow" },
        NavicIconsStruct = { link = "PracalePurple" },
        NavicIconsEvent = { link = "PracaleYellow" },
        NavicIconsOperator = { link = "PracaleRed" },
        NavicIconsTypeParameter = { link = "PracaleRed" },
        NavicText = { link = "PracaleWhite" },
        NavicSeparator = { link = "PracaleWhite" },
}
with_prefix("") {
        htmlTag = { link = "PracaleAquaBold" },
        htmlEndTag = { link = "PracaleAquaBold" },
        htmlTagName = { link = "PracaleBlue" },
        htmlArg = { link = "PracaleOrange" },
        htmlTagN = { link = "PracaleFg1" },
        htmlSpecialTagName = { link = "PracaleBlue" },
        htmlLink = { fg = colors.fg4, underline = config.underline },
        htmlSpecialChar = { link = "PracaleRed" },
        htmlBold = { fg = colors.fg0, bg = colors.bg0, bold = config.bold },
        htmlBoldUnderline = { fg = colors.fg0, bg = colors.bg0, bold = config.bold, underline = config.underline },
        htmlBoldItalic = { fg = colors.fg0, bg = colors.bg0, bold = config.bold, italic = true },
        htmlBoldUnderlineItalic = {
                fg = colors.fg0,
                bg = colors.bg0,
                bold = config.bold,
                italic = true,
                underline = config.underline,
        },
        htmlUnderline = { fg = colors.fg0, bg = colors.bg0, underline = config.underline },
        htmlUnderlineItalic = {
                fg = colors.fg0,
                bg = colors.bg0,
                italic = true,
                underline = config.underline,
        },
        htmlItalic = { fg = colors.fg0, bg = colors.bg0, italic = true },
}
with_prefix("") {
        xmlTag = { link = "PracaleAquaBold" },
        xmlEndTag = { link = "PracaleAquaBold" },
        xmlTagName = { link = "PracaleBlue" },
        xmlEqual = { link = "PracaleBlue" },
        docbkKeyword = { link = "PracaleAquaBold" },
        xmlDocTypeDecl = { link = "PracaleGray" },
        xmlDocTypeKeyword = { link = "PracalePurple" },
        xmlCdataStart = { link = "PracaleGray" },
        xmlCdataCdata = { link = "PracalePurple" },
        dtdFunction = { link = "PracaleGray" },
        dtdTagName = { link = "PracalePurple" },
        xmlAttrib = { link = "PracaleOrange" },
        xmlProcessingDelim = { link = "PracaleGray" },
        dtdParamEntityPunct = { link = "PracaleGray" },
        dtdParamEntityDPunct = { link = "PracaleGray" },
        xmlAttribPunct = { link = "PracaleGray" },
        xmlEntity = { link = "PracaleRed" },
        xmlEntityPunct = { link = "PracaleRed" },
}
with_prefix("") {
        clojureKeyword = { link = "PracaleBlue" },
        clojureCond = { link = "PracaleOrange" },
        clojureSpecial = { link = "PracaleOrange" },
        clojureDefine = { link = "PracaleOrange" },
        clojureFunc = { link = "PracaleYellow" },
        clojureRepeat = { link = "PracaleYellow" },
        clojureCharacter = { link = "PracaleAqua" },
        clojureStringEscape = { link = "PracaleAqua" },
        clojureException = { link = "PracaleRed" },
        clojureRegexp = { link = "PracaleAqua" },
        clojureRegexpEscape = { link = "PracaleAqua" },
        clojureRegexpCharClass = { fg = colors.fg3, bold = config.bold },
        clojureRegexpMod = { link = "clojureRegexpCharClass" },
        clojureRegexpQuantifier = { link = "clojureRegexpCharClass" },
        clojureParen = { link = "PracaleFg3" },
        clojureAnonArg = { link = "PracaleYellow" },
        clojureVariable = { link = "PracaleBlue" },
        clojureMacro = { link = "PracaleOrange" },
        clojureMeta = { link = "PracaleYellow" },
        clojureDeref = { link = "PracaleYellow" },
        clojureQuote = { link = "PracaleYellow" },
        clojureUnquote = { link = "PracaleYellow" },
}
with_prefix("") {

        cOperator = { link = "PracalePurple" },
        cppOperator = { link = "PracalePurple" },
        cStructure = { link = "Keyword" },

}
with_prefix("") {
        pythonBuiltin = { link = "Type" },
        pythonBuiltinObj = { link = "Type" },
        pythonBuiltinFunc = { link = "PracaleOrange" },
        pythonFunction = { link = "Function" },
        pythonDecorator = { link = "PracaleRed" },
        pythonInclude = { link = "PracaleBlue" },
        pythonImport = { link = "PracaleBlue" },
        pythonRun = { link = "PracaleBlue" },
        pythonCoding = { link = "PracaleBlue" },
        pythonOperator = { link = "PracaleRed" },
        pythonException = { link = "PracaleLightPurple" },
        pythonExceptions = { link = "PracaleLightPurple" },
        pythonBoolean = { link = "Literal" },
        pythonDot = { link = "PracaleFg3" },
        pythonConditional = { link = "PracaleRed" },
        pythonRepeat = { link = "PracaleRed" },
        pythonDottedName = { link = "PracaleGreenBold" },

}
with_prefix("") {
        cssBraces = { link = "PracaleBlue" },
        cssFunctionName = { link = "PracaleYellow" },
        cssIdentifier = { link = "PracaleOrange" },
        cssClassName = { link = "PracaleGreen" },
        cssColor = { link = "PracaleBlue" },
        cssSelectorOp = { link = "PracaleBlue" },
        cssSelectorOp2 = { link = "PracaleBlue" },
        cssImportant = { link = "PracaleGreen" },
        cssVendor = { link = "PracaleFg1" },
        cssTextProp = { link = "PracaleAqua" },
        cssAnimationProp = { link = "PracaleAqua" },
        cssUIProp = { link = "PracaleYellow" },
        cssTransformProp = { link = "PracaleAqua" },
        cssTransitionProp = { link = "PracaleAqua" },
        cssPrintProp = { link = "PracaleAqua" },
        cssPositioningProp = { link = "PracaleYellow" },
        cssBoxProp = { link = "PracaleAqua" },
        cssFontDescriptorProp = { link = "PracaleAqua" },
        cssFlexibleBoxProp = { link = "PracaleAqua" },
        cssBorderOutlineProp = { link = "PracaleAqua" },
        cssBackgroundProp = { link = "PracaleAqua" },
        cssMarginProp = { link = "PracaleAqua" },
        cssListProp = { link = "PracaleAqua" },
        cssTableProp = { link = "PracaleAqua" },
        cssFontProp = { link = "PracaleAqua" },
        cssPaddingProp = { link = "PracaleAqua" },
        cssDimensionProp = { link = "PracaleAqua" },
        cssRenderProp = { link = "PracaleAqua" },
        cssColorProp = { link = "PracaleAqua" },
        cssGeneratedContentProp = { link = "PracaleAqua" },
}
with_prefix("") {
        javaScriptBraces = { link = "PracaleFg1" },
        javaScriptFunction = { link = "PracaleAqua" },
        javaScriptIdentifier = { link = "PracaleRed" },
        javaScriptMember = { link = "PracaleBlue" },
        javaScriptNumber = { link = "PracalePurple" },
        javaScriptNull = { link = "PracalePurple" },
        javaScriptParens = { link = "PracaleFg3" },

}
with_prefix("") {
        typescriptReserved = { link = "PracaleAqua" },
        typescriptLabel = { link = "PracaleAqua" },
        typescriptFuncKeyword = { link = "PracaleAqua" },
        typescriptIdentifier = { link = "PracaleOrange" },
        typescriptBraces = { link = "PracaleFg1" },
        typescriptEndColons = { link = "PracaleFg1" },
        typescriptDOMObjects = { link = "PracaleFg1" },
        typescriptAjaxMethods = { link = "PracaleFg1" },
        typescriptLogicSymbols = { link = "PracaleFg1" },
        typescriptDocSeeTag = { link = "Comment" },
        typescriptDocParam = { link = "Comment" },
        typescriptDocTags = { link = "vimCommentTitle" },
        typescriptGlobalObjects = { link = "PracaleFg1" },
        typescriptParens = { link = "PracaleFg3" },
        typescriptOpSymbols = { link = "PracaleFg3" },
        typescriptHtmlElemProperties = { link = "PracaleFg1" },
        typescriptNull = { link = "PracalePurple" },
        typescriptInterpolationDelimiter = { link = "PracaleAqua" },

}
with_prefix("") {
        purescriptModuleKeyword = { link = "PracaleAqua" },
        purescriptModuleName = { link = "PracaleFg1" },
        purescriptWhere = { link = "PracaleAqua" },
        purescriptDelimiter = { link = "PracaleFg4" },
        purescriptType = { link = "PracaleFg1" },
        purescriptImportKeyword = { link = "PracaleAqua" },
        purescriptHidingKeyword = { link = "PracaleAqua" },
        purescriptAsKeyword = { link = "PracaleAqua" },
        purescriptStructure = { link = "PracaleAqua" },
        purescriptOperator = { link = "PracaleBlue" },
        purescriptTypeVar = { link = "PracaleFg1" },
        purescriptConstructor = { link = "PracaleFg1" },
        purescriptFunction = { link = "PracaleFg1" },
        purescriptConditional = { link = "PracaleOrange" },
        purescriptBacktick = { link = "PracaleOrange" },
}
with_prefix("") {

        coffeeExtendedOp = { link = "PracaleFg3" },
        coffeeSpecialOp = { link = "PracaleFg3" },
        coffeeCurly = { link = "PracaleOrange" },
        coffeeParen = { link = "PracaleFg3" },
        coffeeBracket = { link = "PracaleOrange" },
}
with_prefix("") {
        rubyKeyword = { link = "Keyword" },
        rubyStringDelimiter = { link = "String" },
        rubyInterpolationDelimiter = { link = "PracaleAqua" },
        rubyDefinedOperator = { link = "rubyKeyword" },
}
with_prefix("") {

        objcTypeModifier = { link = "PracaleRed" },
        objcDirective = { link = "PracaleBlue" },
}
with_prefix("") {
        goDirective = { link = "PracaleAqua" },
        goConstants = { link = "PracalePurple" },
        goDeclaration = { link = "PracaleRed" },
        goDeclType = { link = "PracaleBlue" },
        goBuiltins = { link = "PracaleOrange" },
}
with_prefix("") {
        luaIn = { link = "PracaleRed" },
        luaFunction = { link = "PracaleAqua" },
        luaTable = { link = "PracaleOrange" },
}
with_prefix("") {
        moonSpecialOp = { link = "PracaleFg3" },
        moonExtendedOp = { link = "PracaleFg3" },
        moonFunction = { link = "PracaleFg3" },
        moonObject = { link = "PracaleYellow" },
}
with_prefix("") {
        javaAnnotation = { link = "PracaleBlue" },
        javaDocTags = { link = "PracaleAqua" },
        javaCommentTitle = { link = "vimCommentTitle" },
        javaParen = { link = "PracaleFg3" },
        javaParen1 = { link = "PracaleFg3" },
        javaParen2 = { link = "PracaleFg3" },
        javaParen3 = { link = "PracaleFg3" },
        javaParen4 = { link = "PracaleFg3" },
        javaParen5 = { link = "PracaleFg3" },
        javaOperator = { link = "PracaleOrange" },
        javaVarArg = { link = "PracaleGreen" },
}
with_prefix("") {
        elixirDocString = { link = "Comment" },
        elixirStringDelimiter = { link = "PracaleGreen" },
        elixirInterpolationDelimiter = { link = "PracaleAqua" },
        elixirModuleDeclaration = { link = "PracaleYellow" },
}
with_prefix("") {
        scalaNameDefinition = { link = "PracaleFg1" },
        scalaCaseFollowing = { link = "PracaleFg1" },
        scalaCapitalWord = { link = "PracaleFg1" },
        scalaTypeExtension = { link = "PracaleFg1" },
        scalaKeyword = { link = "PracaleRed" },
        scalaKeywordModifier = { link = "PracaleRed" },
        scalaSpecial = { link = "PracaleAqua" },
        scalaOperator = { link = "PracaleFg1" },
        scalaTypeDeclaration = { link = "PracaleYellow" },
        scalaTypeTypePostDeclaration = { link = "PracaleYellow" },
        scalaInstanceDeclaration = { link = "PracaleFg1" },
        scalaInterpolation = { link = "PracaleAqua" },
}
with_prefix("") {
        markdownItalic = { fg = colors.fg3, italic = true },
        markdownBold = { fg = colors.fg3, bold = config.bold },
        markdownBoldItalic = { fg = colors.fg3, bold = config.bold, italic = true },
        markdownH1 = { link = "PracaleGreenBold" },
        markdownH2 = { link = "PracaleGreenBold" },
        markdownH3 = { link = "PracaleYellowBold" },
        markdownH4 = { link = "PracaleYellowBold" },
        markdownH5 = { link = "PracaleYellow" },
        markdownH6 = { link = "PracaleYellow" },
        markdownCode = { link = "PracaleAqua" },
        markdownCodeBlock = { link = "PracaleAqua" },
        markdownCodeDelimiter = { link = "PracaleAqua" },
        markdownBlockquote = { link = "PracaleGray" },
        markdownListMarker = { link = "PracaleGray" },
        markdownOrderedListMarker = { link = "PracaleGray" },
        markdownRule = { link = "PracaleGray" },
        markdownHeadingRule = { link = "PracaleGray" },
        markdownUrlDelimiter = { link = "PracaleFg3" },
        markdownLinkDelimiter = { link = "PracaleFg3" },
        markdownLinkTextDelimiter = { link = "PracaleFg3" },
        markdownHeadingDelimiter = { link = "PracaleOrange" },
        markdownUrl = { link = "PracalePurple" },
        markdownUrlTitleDelimiter = { link = "PracaleGreen" },
        markdownLinkText = { fg = colors.gray, underline = config.underline },
        markdownIdDeclaration = { link = "markdownLinkText" },
}
with_prefix("") {
        haskellType = { link = "PracaleBlue" },
        haskellIdentifier = { link = "PracaleAqua" },
        haskellSeparator = { link = "PracaleFg4" },
        haskellDelimiter = { link = "PracaleOrange" },
        haskellOperators = { link = "PracalePurple" },
        haskellBacktick = { link = "PracaleOrange" },
        haskellStatement = { link = "PracalePurple" },
        haskellConditional = { link = "PracalePurple" },
        haskellLet = { link = "PracaleRed" },
        haskellDefault = { link = "PracaleRed" },
        haskellWhere = { link = "PracaleRed" },
        haskellBottom = { link = "PracaleRedBold" },
        haskellImportKeywords = { link = "PracalePurpleBold" },
        haskellDeclKeyword = { link = "PracaleOrange" },
        haskellDecl = { link = "PracaleOrange" },
        haskellDeriving = { link = "PracalePurple" },
        haskellAssocType = { link = "PracaleAqua" },
        haskellNumber = { link = "PracaleAqua" },
        haskellPragma = { link = "PracaleRedBold" },
        haskellTH = { link = "PracaleAquaBold" },
        haskellForeignKeywords = { link = "PracaleGreen" },
        haskellKeyword = { link = "PracaleRed" },
        haskellFloat = { link = "PracaleAqua" },
        haskellInfix = { link = "PracalePurple" },
        haskellQuote = { link = "PracaleGreenBold" },
        haskellShebang = { link = "PracaleYellowBold" },
        haskellLiquid = { link = "PracalePurpleBold" },
        haskellQuasiQuoted = { link = "PracaleBlueBold" },
        haskellRecursiveDo = { link = "PracalePurple" },
        haskellQuotedType = { link = "PracaleRed" },
        haskellPreProc = { link = "PracaleFg4" },
        haskellTypeRoles = { link = "PracaleRedBold" },
        haskellTypeForall = { link = "PracaleRed" },
        haskellPatternKeyword = { link = "PracaleBlue" },
}
with_prefix("") {
        jsonKeyword = { link = "PracaleGreen" },
        jsonQuote = { link = "PracaleGreen" },
        jsonBraces = { link = "PracaleFg1" },
        jsonString = { link = "PracaleFg1" },
}
with_prefix("") {
        mailQuoted1 = { link = "PracaleAqua" },
        mailQuoted2 = { link = "PracalePurple" },
        mailQuoted3 = { link = "PracaleYellow" },
        mailQuoted4 = { link = "PracaleGreen" },
        mailQuoted5 = { link = "PracaleRed" },
        mailQuoted6 = { link = "PracaleOrange" },
        mailSignature = { link = "Comment" },
}
with_prefix("") {
        csBraces = { link = "PracaleFg1" },
        csEndColon = { link = "PracaleFg1" },
        csLogicSymbols = { link = "PracaleFg1" },
        csParens = { link = "PracaleFg3" },
        csOpSymbols = { link = "PracaleFg3" },
        csInterpolationDelimiter = { link = "PracaleFg3" },
        csInterpolationAlignDel = { link = "PracaleAquaBold" },
        csInterpolationFormat = { link = "PracaleAqua" },
        csInterpolationFormatDel = { link = "PracaleAquaBold" },
}
with_prefix("") {
        rustSigil = { link = "PracaleOrange" },
        rustEscape = { link = "PracaleAqua" },
        rustStringContinuation = { link = "PracaleAqua" },
        rustEnum = { link = "PracaleAqua" },
        rustStructure = { link = "PracaleAqua" },
        rustModPathSep = { link = "PracaleFg2" },
        rustCommentLineDoc = { link = "Comment" },
        rustDefault = { link = "PracaleAqua" },
}
with_prefix("") {
        ocamlOperator = { link = "PracaleFg1" },
        ocamlKeyChar = { link = "PracaleOrange" },
        ocamlArrow = { link = "PracaleOrange" },
        ocamlInfixOpKeyword = { link = "PracaleRed" },
        ocamlConstructor = { link = "PracaleOrange" },
}
with_prefix("") {
        LspSagaCodeActionTitle = { link = "Title" },
        LspSagaCodeActionBorder = { link = "PracaleFg1" },
        LspSagaCodeActionContent = { fg = colors.green, bold = config.bold },
        LspSagaLspFinderBorder = { link = "PracaleFg1" },
        LspSagaAutoPreview = { link = "PracaleOrange" },
        TargetWord = { fg = colors.blue, bold = config.bold },
        FinderSeparator = { link = "PracaleAqua" },
        LspSagaDefPreviewBorder = { link = "PracaleBlue" },
        LspSagaHoverBorder = { link = "PracaleOrange" },
        LspSagaRenameBorder = { link = "PracaleBlue" },
        LspSagaDiagnosticSource = { link = "PracaleOrange" },
        LspSagaDiagnosticBorder = { link = "PracalePurple" },
        LspSagaDiagnosticHeader = { link = "PracaleGreen" },
        LspSagaSignatureHelpBorder = { link = "PracaleGreen" },
        SagaShadow = { link = "PracaleBg0" },


}
with_prefix("") {
        DashboardShortCut = { link = "PracaleOrange" },
        DashboardHeader = { link = "PracaleAqua" },
        DashboardCenter = { link = "PracaleYellow" },
        DashboardFooter = { fg = colors.purple, italic = true },

}
with_prefix("") {
        MasonHighlight = { link = "PracaleAqua" },
        MasonHighlightBlock = { fg = colors.bg0, bg = colors.blue },
        MasonHighlightBlockBold = { fg = colors.bg0, bg = colors.blue, bold = true },
        MasonHighlightSecondary = { fg = colors.yellow },
        MasonHighlightBlockSecondary = { fg = colors.bg0, bg = colors.yellow },
        MasonHighlightBlockBoldSecondary = { fg = colors.bg0, bg = colors.yellow, bold = true },
        MasonHeader = { link = "MasonHighlightBlockBoldSecondary" },
        MasonHeaderSecondary = { link = "MasonHighlightBlockBold" },
        MasonMuted = { fg = colors.fg4 },
        MasonMutedBlock = { fg = colors.bg0, bg = colors.fg4 },
        MasonMutedBlockBold = { fg = colors.bg0, bg = colors.fg4, bold = true },
}
with_prefix("") {
        LspInlayHint = { link = "comment" },
}
with_prefix("") {
        CarbonFile = { link = "PracaleFg1" },
        CarbonExe = { link = "PracaleYellow" },
        CarbonSymlink = { link = "PracaleAqua" },
        CarbonBrokenSymlink = { link = "PracaleRed" },
        CarbonIndicator = { link = "PracaleGray" },
        CarbonDanger = { link = "PracaleRed" },
        CarbonPending = { link = "PracaleYellow" },
}
with_prefix("") {

        NoiceCursor = { link = "TermCursor" },
}
with_prefix("") {
        NotifyDEBUGBorder = { link = "PracaleBlue" },
        NotifyDEBUGIcon = { link = "PracaleBlue" },
        NotifyDEBUGTitle = { link = "PracaleBlue" },
        NotifyERRORBorder = { link = "PracaleRed" },
        NotifyERRORIcon = { link = "PracaleRed" },
        NotifyERRORTitle = { link = "PracaleRed" },
        NotifyINFOBorder = { link = "PracaleAqua" },
        NotifyINFOIcon = { link = "PracaleAqua" },
        NotifyINFOTitle = { link = "PracaleAqua" },
        NotifyTRACEBorder = { link = "PracaleGreen" },
        NotifyTRACEIcon = { link = "PracaleGreen" },
        NotifyTRACETitle = { link = "PracaleGreen" },
        NotifyWARNBorder = { link = "PracaleYellow" },
        NotifyWARNIcon = { link = "PracaleYellow" },
        NotifyWARNTitle = { link = "PracaleYellow" },
}
with_prefix("") {
        IlluminatedWordText = { link = "LspReferenceText" },
        IlluminatedWordRead = { link = "LspReferenceRead" },
        IlluminatedWordWrite = { link = "LspReferenceWrite" },
}
with_prefix("") {
        TSRainbowRed = { fg = colors.red },
        TSRainbowOrange = { fg = colors.orange },
        TSRainbowYellow = { fg = colors.yellow },
        TSRainbowGreen = { fg = colors.green },
        TSRainbowBlue = { fg = colors.blue },
        TSRainbowViolet = { fg = colors.purple },
        TSRainbowCyan = { fg = colors.cyan },
}
with_prefix("") {

        DapBreakpointSymbol = { fg = colors.red, bg = colors.bg1 },
        DapStoppedSymbol = { fg = colors.green, bg = colors.bg1 },
        DapUIBreakpointsCurrentLine = { link = "PracaleYellow" },
        DapUIBreakpointsDisabledLine = { link = "PracaleGray" },
        DapUIBreakpointsInfo = { link = "PracaleAqua" },
        DapUIBreakpointsLine = { link = "PracaleYellow" },
        DapUIBreakpointsPath = { link = "PracaleBlue" },
        DapUICurrentFrameName = { link = "PracalePurple" },
        DapUIDecoration = { link = "PracalePurple" },
        DapUIEndofBuffer = { link = "PracaleBg2" },
        DapUIFloatBorder = { link = "PracaleAqua" },
        DapUILineNumber = { link = "PracaleYellow" },
        DapUIModifiedValue = { link = "PracaleRed" },
        DapUIPlayPause = { fg = colors.green, bg = colors.bg1 },
        DapUIRestart = { fg = colors.green, bg = colors.bg1 },
        DapUIScope = { link = "PracaleBlue" },
        DapUISource = { link = "PracaleFg1" },
        DapUIStepBack = { fg = colors.blue, bg = colors.bg1 },
        DapUIStepInto = { fg = colors.blue, bg = colors.bg1 },
        DapUIStepOut = { fg = colors.blue, bg = colors.bg1 },
        DapUIStepOver = { fg = colors.blue, bg = colors.bg1 },
        DapUIStop = { fg = colors.red, bg = colors.bg1 },
        DapUIStoppedThread = { link = "PracaleBlue" },
        DapUIThread = { link = "PracaleBlue" },
        DapUIType = { link = "PracaleOrange" },
        DapUIUnavailable = { link = "PracaleGray" },
        DapUIWatchesEmpty = { link = "PracaleGray" },
        DapUIWatchesError = { link = "PracaleRed" },
        DapUIWatchesValue = { link = "PracaleYellow" },
        DapUIWinSelect = { link = "PracaleYellow" },

}
with_prefix("") {
        NeogitDiffDelete = { link = "DiffDelete" },
        NeogitDiffAdd = { link = "DiffAdd" },
        NeogitHunkHeader = { link = "WinBar" },
        NeogitHunkHeaderHighlight = { link = "WinBarNC" },
}
with_prefix("") {
        DiffviewStatusModified = { link = "PracaleGreenBold" },
        DiffviewFilePanelInsertions = { link = "PracaleGreenBold" },
        DiffviewFilePanelDeletions = { link = "PracaleRedBold" },
}
with_prefix("") {
        ["@comment"] = { link = "Comment" },
        ["@none"] = { bg = "NONE", fg = "NONE" },
        ["@preproc"] = { link = "PreProc" },
        ["@define"] = { link = "Define" },
        ["@operator"] = { link = "Operator" },
        ["@punctuation.delimiter"] = { link = "Delimiter" },
        ["@punctuation.bracket"] = { link = "Normal" },
        ["@punctuation.special"] = { link = "Delimiter" },
        ["@string"] = { link = "String" },
        ["@string.regex"] = { link = "String" },
        ["@string.regexp"] = { link = "String" },
        ["@string.escape"] = { link = "SpecialChar" },
        ["@string.special"] = { link = "SpecialChar" },
        ["@string.special.path"] = { link = "Underlined" },
        ["@string.special.symbol"] = { link = "Identifier" },
        ["@string.special.url"] = { link = "Underlined" },
        ["@character"] = { link = "Character" },
        ["@character.special"] = { link = "SpecialChar" },
        ["@boolean"] = { link = "Boolean" },
        ["@number"] = { link = "Number" },
        ["@number.float"] = { link = "Float" },
        ["@float"] = { link = "Float" },
        ["@function"] = { link = "Function" },
        ["@function.builtin"] = { link = "BuiltinFunction" },
        ["@function.call"] = { link = "Function" },
        ["@function.macro"] = { link = "Macro" },
        ["@function.method"] = { link = "Function" },
        ["@method"] = { link = "Function" },
        ["@method.call"] = { link = "Function" },
        ["@constructor"] = { link = "Special" },
        ["@parameter"] = { link = "Identifier" },
        ["@keyword"] = { link = "Keyword" },
        ["@keyword.conditional"] = { link = "Conditional" },
        ["@keyword.debug"] = { link = "Debug" },
        ["@keyword.directive"] = { link = "PreProc" },
        ["@keyword.directive.define"] = { link = "Define" },
        ["@keyword.exception"] = { link = "Exception" },
        ["@keyword.function"] = { link = "Keyword" },
        ["@keyword.import"] = { link = "Include" },
        ["@keyword.modifier"] = { link = "Modifier" },
        ["@keyword.operator"] = { link = "PracaleRed" },
        ["@keyword.repeat"] = { link = "Repeat" },
        ["@keyword.return"] = { link = "Keyword" },
        ["@keyword.storage"] = { link = "StorageClass" },
        ["@conditional"] = { link = "Conditional" },
        ["@repeat"] = { link = "Repeat" },
        ["@debug"] = { link = "Debug" },
        ["@label"] = { link = "Label" },
        ["@include"] = { link = "Include" },
        ["@exception"] = { link = "Exception" },
        ["@type"] = { link = "Type" },
        ["@type.builtin"] = { link = "Type" },
        ["@type.definition"] = { link = "Type" },
        ["@type.qualifier"] = { link = "StorageClass" },
        ["@storageclass"] = { link = "StorageClass" },
        ["@attribute"] = { link = "PreProc" },
        ["@field"] = { link = "Identifier" },
        ["@property"] = { link = "Identifier" },
        ["@variable"] = { link = "Identifier" },
        ["@variable.builtin"] = { link = "Special" },
        ["@variable.member"] = { link = "Identifier" },
        ["@variable.parameter"] = { link = "Identifier" },
        ["@constant"] = { link = "Constant" },
        ["@constant.builtin"] = { link = "Special" },
        ["@constant.macro"] = { link = "Define" },
        ["@markup"] = { link = "PracaleFg1" },
        ["@markup.strong"] = { bold = config.bold },
        ["@markup.italic"] = { link = "@text.emphasis" },
        ["@markup.underline"] = { underline = config.underline },
        ["@markup.strikethrough"] = { strikethrough = config.strikethrough },
        ["@markup.heading"] = { link = "Title" },
        ["@markup.raw"] = { link = "String" },
        ["@markup.math"] = { link = "Special" },
        ["@markup.environment"] = { link = "Macro" },
        ["@markup.environment.name"] = { link = "Type" },
        ["@markup.link"] = { link = "Underlined" },
        ["@markup.link.label"] = { link = "SpecialChar" },
        ["@markup.list"] = { link = "Delimiter" },
        ["@markup.list.checked"] = { link = "PracaleGreen" },
        ["@markup.list.unchecked"] = { link = "PracaleGray" },
        ["@comment.todo"] = { link = "Todo" },
        ["@comment.note"] = { link = "SpecialComment" },
        ["@comment.warning"] = { link = "WarningMsg" },
        ["@comment.error"] = { link = "ErrorMsg" },
        ["@diff.plus"] = { link = "diffAdded" },
        ["@diff.minus"] = { link = "diffRemoved" },
        ["@diff.delta"] = { link = "diffChanged" },
        ["@module"] = { link = "ModuleOrNamespace" },
        ["@namespace"] = { link = "ModuleOrNamespace" },
        ["@symbol"] = { link = "Identifier" },
        ["@text"] = { link = "PracaleFg1" },
        ["@text.strong"] = { bold = config.bold },
        ["@text.emphasis"] = { italic = config.italic.emphasis },
        ["@text.underline"] = { underline = config.underline },
        ["@text.strike"] = { strikethrough = config.strikethrough },
        ["@text.title"] = { link = "Title" },
        ["@text.literal"] = { link = "String" },
        ["@text.uri"] = { link = "Underlined" },
        ["@text.math"] = { link = "Special" },
        ["@text.environment"] = { link = "Macro" },
        ["@text.environment.name"] = { link = "Type" },
        ["@text.reference"] = { link = "Constant" },
        ["@text.todo"] = { link = "Todo" },
        ["@text.todo.checked"] = { link = "PracaleGreen" },
        ["@text.todo.unchecked"] = { link = "PracaleGray" },
        ["@text.note"] = { link = "SpecialComment" },
        ["@text.note.comment"] = { fg = colors.purple, bold = config.bold },
        ["@text.warning"] = { link = "WarningMsg" },
        ["@text.danger"] = { link = "ErrorMsg" },
        ["@text.danger.comment"] = { fg = colors.fg0, bg = colors.red, bold = config.bold },
        ["@text.diff.add"] = { link = "diffAdded" },
        ["@text.diff.delete"] = { link = "diffRemoved" },
        ["@tag"] = { link = "Tag" },
        ["@tag.attribute"] = { link = "Identifier" },
        ["@tag.delimiter"] = { link = "Delimiter" },
        ["@punctuation"] = { link = "Delimiter" },
        ["@macro"] = { link = "Macro" },
        ["@structure"] = { link = "Structure" },
        ["@lsp.type.class"] = { link = "@type" },
        ["@lsp.type.comment"] = { link = "@comment" },
        ["@lsp.type.decorator"] = { link = "@macro" },
        ["@lsp.type.enum"] = { link = "@type" },
        ["@lsp.type.event"] = { link = "@type" },
        ["@lsp.type.enumMember"] = { link = "@constant" },
        ["@lsp.type.function"] = { link = "@function" },
        ["@lsp.type.interface"] = { link = "@constructor" },
        ["@lsp.type.keyword"] = { link = "@keyword" },
        ["@lsp.type.macro"] = { link = "@macro" },
        ["@lsp.type.method"] = { link = "@method" },
        ["@lsp.type.modifier"] = { link = "@modifier" },
        ["@lsp.type.namespace"] = { link = "@namespace" },
        ["@lsp.type.parameter"] = { link = "@parameter" },
        ["@lsp.type.property"] = { link = "@property" },
        ["@lsp.type.operator"] = { link = "@operator" },
        ["@lsp.type.struct"] = { link = "@type" },
        ["@lsp.type.regexp"] = { link = "@regexp" },
        ["@lsp.type.type"] = { link = "@type" },
        ["@lsp.type.typeParameter"] = { link = "@type.definition" },
        ["@lsp.type.variable"] = { link = "@variable" },
}


---@param config PracaleConfig?
Pracale.setup = function(config)
        Pracale.config = vim.tbl_deep_extend("force", Pracale.config, config or {})
end

--- main load function
Pracale.load = function()
        if vim.version().minor < 8 then
                vim.notify_once("pracale.nvim: you must use neovim 0.8 or higher")
                return
        end

        -- reset colors
        if vim.g.colors_name then
                vim.cmd.hi("clear")
        end
        vim.g.colors_name = "pracale"
        vim.o.termguicolors = true


        -- add highlights
        for group, settings in pairs(groups) do
                vim.api.nvim_set_hl(0, group, settings)
        end
end

return Pracale
