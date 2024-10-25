Import Console From "lib/web/console.bas"

' You can change the log level to affect which messages
' will be displayed. The available log levels are:
' NONE, FATAL, ERROR, WARN, INFO, DEBUG, TRACE, ALL
Console.LogLevel Console.DEBUG

Console.Log "This is an info message."
Console.Log "This is a trace message, it will be ignored.", Console.TRACE
DoStuff

Console.Echo "And thus concludes the exhilarating demonstration of the QBJS Console library."


Sub DoStuff
    Console.Log "Before Doing Stuff", Console.DEBUG
    Print "foo"
    uh oh here is an error line
    Exit Sub
    Console.Log "wonder why we never get here?", Console.Debug
End Sub