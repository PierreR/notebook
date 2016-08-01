import Data.Monoid
import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util

buildDir = "out"
srcDir = "src"

addExtensionDir :: FilePath -> FilePath
addExtensionDir fp  = takeDirectory fp </> (drop 1 . takeExtension) fp </> takeFileName fp

dropExtensionDir :: FilePath -> FilePath
dropExtensionDir fp =
  let (fp', fn) = splitFileName fp
  in
  (takeDirectory . dropTrailingPathSeparator) fp' </> fn


callCmd execmd out = do
    let  doc = srcDir </> (dropDirectory1 . dropExtensionDir)  (out -<.> "adoc")
    need [doc]
    cmd execmd doc "-o" out

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
    need [ buildDir </> addExtensionDir (i -<.> "html") | i <- is ]

  "pdf" ~> do
    is <- getDirectoryFiles srcDir ["/**/*.adoc"]
    need [ buildDir </> addExtensionDir (i-<.> "pdf") | i <- is ]
