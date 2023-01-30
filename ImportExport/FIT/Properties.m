FileFormatDump`AddFormat[
    "FIT",
    <|
        "Name"             -> "FIT",
        "FileNamePatterns" -> { "*.fit" },
        "MIMETypes"        -> { "APPLICATION/VND.ANT.FIT" },
        "BundleTest"       -> { },
        "TestOffset"       -> 0,
        "Flags"            -> { "HasStrongTest" },
        "FormatTest"       -> Repeated[ _, { 8 } ] ~~ ".FIT" ~~ ___
    |>
]