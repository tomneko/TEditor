
{********************************************************************}
{                                                                    }
{    Register for TEditor & TEditorProp                              }
{                                                                    }
{    start  1998/06/20                                               }
{                                                                    }
{    update 2000/04/01                                               }
{                                                                    }
{    Copyright (c) 1999, 2000 本田勝彦 <katsuhiko.honda@nifty.ne.jp> }
{                                                                    }
{********************************************************************}

unit HEditReg;

interface

uses
  Classes, DsgnIntf;

procedure Register;

implementation

uses
  Controls, HEditor, HEdtProp, HPropert;

procedure Register;
begin
  RegisterComponents('Samples', [TEditor, TEditorProp]);

  RegisterComponentEditor(TEditor, TEditorComponentEditor);
  RegisterComponentEditor(TEditorProp, TEditorPropComponentEditor);

  RegisterPropertyEditor(TypeInfo(TEditorBracketCollection),
    TEditorViewInfo, 'Brackets', TEditorBracketsPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TEditorCaret),
    nil, '', TEditorCaretPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TEditorColors),
    TEditorViewInfo, 'Colors', TEditorColorsPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TEditorMargin),
    nil, '', TEditorMarginPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TEditorMarks),
    nil, '', TEditorMarksPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TEditorViewInfo),
    nil, '', TEditorViewPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TEditorWrapOption),
    nil, '', TEditorWrapOptionPropertyEditor);

  { TEditor にだけ TStringsPropertyEditor を適用する場合 }
  RegisterPropertyEditor(TypeInfo(TStrings),
    TEditor, '', TStringsPropertyEditor);
  { 総ての TStrings に対して TStringsPropertyEditor を有効にする場合 }
  {RegisterPropertyEditor(TypeInfo(TStrings),
    nil, '', TStringsPropertyEditor);}

  { TEditor.Caret.Cursors にだけ crRightArrow を認識する
    TEditorCursorPropertyEditor を適用する場合 }
  RegisterPropertyEditor(TypeInfo(TCursor),
    TEditorCursors, '', TEditorCursorsPropertyEditor);

  { 総ての Cursor プロパティに TEditorCursorPropertyEditor を有効に
    する場合}
  {RegisterPropertyEditor(TypeInfo(TCursor),
    nil, '', TEditorCursorsPropertyEditor);}
end;

end.
