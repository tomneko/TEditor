
{********************************************************************}
{                                                                    }
{    Register for TEditor & TEditorProp                              }
{                                                                    }
{    start  1998/06/20                                               }
{                                                                    }
{    update 2000/04/01                                               }
{                                                                    }
{    Copyright (c) 1999, 2000 �{�c���F <katsuhiko.honda@nifty.ne.jp> }
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

  { TEditor �ɂ��� TStringsPropertyEditor ��K�p����ꍇ }
  RegisterPropertyEditor(TypeInfo(TStrings),
    TEditor, '', TStringsPropertyEditor);
  { ���Ă� TStrings �ɑ΂��� TStringsPropertyEditor ��L���ɂ���ꍇ }
  {RegisterPropertyEditor(TypeInfo(TStrings),
    nil, '', TStringsPropertyEditor);}

  { TEditor.Caret.Cursors �ɂ��� crRightArrow ��F������
    TEditorCursorPropertyEditor ��K�p����ꍇ }
  RegisterPropertyEditor(TypeInfo(TCursor),
    TEditorCursors, '', TEditorCursorsPropertyEditor);

  { ���Ă� Cursor �v���p�e�B�� TEditorCursorPropertyEditor ��L����
    ����ꍇ}
  {RegisterPropertyEditor(TypeInfo(TCursor),
    nil, '', TEditorCursorsPropertyEditor);}
end;

end.