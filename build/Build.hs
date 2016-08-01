import Data.Monoid
import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util

buildDir = "out"
srcDir = "src"

-- | Add the extension as a directory to better organize output
-- "out/test.html" -> "out/html/test.html"
addExtensionDir :: FilePath -> FilePath
addExtensionDir fp  = takeDirectory fp </> (drop 1 . takeExtension) fp </> takeFileName fp

dropExtensionDir :: FilePath -> FilePath
dropExtensionDir fp =
  let (fp', fn) = splitFileName fp
  in
  (takeDirectory . dropTrailingPathSeparator) fp' </> fn

-- | Exec the asciidoc command to produce html or pdf
callCmd prg out = do
  -- find back the adoc source file by dropping the `out` prefix and the extension directory 
  let  srcfile = srcDir </> (dropDirectory1 . dropExtensionDir)  (out -<.> "adoc")
  -- require the source file so the rule is only fired when the source changes
  need [srcfile]
  -- call asciidoctor with the -o flag to control the output generated file path
  cmd prg srcfile "-o" out

main :: IO ()
main = shakeArgs shakeOptions{shakeFiles="build/_shake"} $ do

  buildDir <> "/**/*.html" %> callCmd "asciidoctor"

  buildDir <> "/**/*.pdf" %> callCmd "asciidoctor-pdf"

  "clean" ~> do
    putNormal ("Cleaning files in " <> buildDir)
    removeFilesAfter buildDir ["/**/*.html"]
    removeFilesAfter buildDir ["/**/*.pdf"]

  "html" ~> do
    is <- getDirectoryFiles srcDir ["/**/*.adoc"]
    -- require the exact wanted output
    need [ buildDir </> addExtensionDir (i -<.> "html") | i <- is ]

  "pdf" ~> do
    is <- getDirectoryFiles srcDir ["/**/*.adoc"]
    -- require the exact wanted output
    need [ buildDir </> addExtensionDir (i -<.> "pdf") | i <- is ]
