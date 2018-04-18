import Data.Monoid
import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util

srcDir = "src"

-- | Exec the asciidoc command to produce html or pdf
callCmd prg out = do
  -- find back the adoc source file by dropping the `out` prefix and the extension directory
  let  srcfile = srcDir </> (out -<.> "adoc")
  -- require the source file so the rule is only fired when the source changes
  need [srcfile]
  need =<< getDirectoryFiles "" ["src/**/*.adoc"]
  need [ srcDir </> "docinfo.html"]
  -- call asciidoctor with the -o flag to control the output generated file path
  cmd prg srcfile "-o" out

main :: IO ()
main = shakeArgs shakeOptions{shakeFiles="build/_shake"} $ do

  "notebook.html" %> callCmd "asciidoctor --trace"

  "notebook.pdf" %> callCmd "asciidoctor-pdf"

  "clean" ~> do
    removeFilesAfter "" ["notebook.html"]
    removeFilesAfter "" ["notebook.pdf"]

  "html" ~> need [ "notebook.html"]

  "pdf" ~> need [ "notebook.pdf"]
