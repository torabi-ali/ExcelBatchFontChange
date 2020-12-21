Attribute VB_Name = "TorabiModule"
Sub ChangeFontInFolder()

Dim wb As Workbook
Dim ws As Worksheet
Dim myPath As String
Dim myFile As String
Dim myExtension As String
Dim FldrPicker As FileDialog

'Optimize Macro Speed
Application.ScreenUpdating = False
Application.EnableEvents = False
Application.Calculation = xlCalculationManual

'Retrieve Target Folder Path From User
Set FldrPicker = Application.FileDialog(msoFileDialogFolderPicker)

With FldrPicker
    .Title = "Select a folder"
    .AllowMultiSelect = False
    If .Show <> -1 Then GoTo NextCode
    myPath = .SelectedItems(1) & "\"
End With

'In Case of Cancel
NextCode:
    myPath = myPath
    If myPath = "" Then GoTo ResetSettings

'Target File Extension (must include wildcard "*")
myExtension = "*.xls*"

'Target Path with Ending Extention
myFile = Dir(myPath & myExtension)

'Loop through each Excel file in folder
Do While myFile <> ""
    'Set variable equal to opened workbook
    Set wb = Workbooks.Open(Filename:=myPath & myFile)
    
    For Each ws In Worksheets
        Call ChangeFontInWorksheet(ws)
        Application.Calculation = xlAutomatic
    Next
    
    'Save and Close Workbook
    wb.Close SaveChanges:=True

    'Get next file name
     myFile = Dir
Loop

'Message Box when tasks are completed
MsgBox "Task Done!"

ResetSettings:
    'Reset Macro Optimization Settings
    Application.EnableEvents = True
    Application.Calculation = xlCalculationAutomatic
    Application.ScreenUpdating = True

End Sub

Private Sub ChangeFontInWorksheet(ByVal ws As Worksheet)
    ws.Cells.Select
    With Selection
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlCenter
        .WrapText = False
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
    End With
    With Selection.Font
        .Name = "B Zar"
        .Size = 12
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ThemeColor = xlThemeColorLight1
        .TintAndShade = 0
        .ThemeFont = xlThemeFontNone
    End With
    
    Selection.Font.Bold = True
    Cells.EntireColumn.AutoFit
    ActiveSheet.DisplayRightToLeft = True
End Sub
