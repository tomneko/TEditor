{******************************************************************}
{                                                                  }
{  function SearchText                                             }
{                                                                  }
{  Start  : 1997/07/05                                             }
{  UpDate : 1999/07/25                                             }
{                                                                  }
{  Copyright  (C)  ñ{ìcèüïF  <vyr01647@niftyserve.or.jp>           }
{                                                                  }
{  Delphi 1.0 CD-ROM Delphi\Demos\TextDemo\Search.PasÅ@Çóòóp      }
{  TextLine: PChar Ç∆ Start, Length ÇìnÇµÇƒÅA                     }
{  å©Ç¬Ç©Ç¡ÇΩèÍçáÇÕêÊì™Ç©ÇÁÇÃÉoÉCÉgêîÇ Start Ç…ì¸ÇÍÇƒ             }
{  True Çï‘Ç∑                                                     }
{                                                                  }
{******************************************************************}

unit HTSearch;

interface

uses Windows, SysUtils, StdCtrls, Dialogs;

const
  WordDelimiters: set of Char = [#$0..#$FF] -
    ['a'..'z','A'..'Z','1'..'9','0',#$81..#$9F,#$E0..#$FC, #$A6..#$DF];

type
  TSearchOption = (sfrDown, sfrMatchCase, sfrWholeWord,
    sfrNoMatchZenkaku, sfrReplace, sfrReplaceAll, sfrReplaceConfirm,
    sfrIncludeCRLF, sfrIncludeSpace, sfrWholeFile);
  TSearchOptions = set of TSearchOption;
  TSearchInfo = record
    Start, Length: Integer;
  end;

function SearchText( TextLine: PChar;
                     var Info: TSearchInfo;
                     const SearchString: String;
                     Options: TSearchOptions): Boolean;

implementation

type
  TCharMap = array[Char] of Char;

var
  UpperCharMap, LargeAlphaCharMap: TCharMap;
  Ch: Char;

const
  DBCSCharArray: array[Char] of String[2] =
  (#$00, #$01, #$02, #$03, #$04, #$05, #$06, #$07,  // 00
   #$08, #$09, #$0A, #$0B, #$0C, #$0D, #$0E, #$0F,  // 08
   #$10, #$11, #$12, #$13, #$14, #$15, #$16, #$17,  // 10
   #$18, #$19, #$1A, #$1B, #$1C, #$1D, #$1E, #$1F,  // 18
   'Å@', 'ÅI', 'Åh', 'Åî', 'Åê', 'Åì', 'Åï', 'Åf',  // 20
   'Åi', 'Åj', 'Åñ', 'Å{', 'ÅC', 'Å|', 'ÅD', 'Å^',  // 28
   'ÇO', 'ÇP', 'ÇQ', 'ÇR', 'ÇS', 'ÇT', 'ÇU', 'ÇV',  // 30
   'ÇW', 'ÇX', 'ÅF', 'ÅG', 'ÅÉ', 'ÅÅ', 'ÅÑ', 'ÅH',  // 38
   'Åó', 'Ç`', 'Ça', 'Çb', 'Çc', 'Çd', 'Çe', 'Çf',  // 40
   'Çg', 'Çh', 'Çi', 'Çj', 'Çk', 'Çl', 'Çm', 'Çn',  // 48
   'Ço', 'Çp', 'Çq', 'Çr', 'Çs', 'Çt', 'Çu', 'Çv',  // 50
   'Çw', 'Çx', 'Çy', 'Åm', 'Åè', 'Ån', 'ÅO', 'ÅQ',  // 58
   'ÅM', 'ÇÅ', 'ÇÇ', 'ÇÉ', 'ÇÑ', 'ÇÖ', 'ÇÜ', 'Çá',  // 60
   'Çà', 'Çâ', 'Çä', 'Çã', 'Çå', 'Çç', 'Çé', 'Çè',  // 68
   'Çê', 'Çë', 'Çí', 'Çì', 'Çî', 'Çï', 'Çñ', 'Çó',  // 70
   'Çò', 'Çô', 'Çö', 'Åo', 'Åb', 'Åp', 'ÅP', #$7F,  // 78
   #$80, #$81, #$82, #$83, #$84, #$85, #$86, #$87,  // 80
   #$88, #$89, #$8A, #$8B, #$8C, #$8D, #$8E, #$8F,  // 88
   #$90, #$91, #$92, #$93, #$94, #$95, #$96, #$97,  // 90
   #$98, #$99, #$9A, #$9B, #$9C, #$9D, #$9E, #$9F,  // 98
   #$A0, 'ÅB', 'Åu', 'Åv', 'ÅA', 'ÅD', 'Éí', 'É@',  // A0
   'ÉB', 'ÉD', 'ÉF', 'ÉH', 'ÉÉ', 'ÉÖ', 'Éá', 'Éb',  // A8
   'Å[', 'ÉA', 'ÉC', 'ÉE', 'ÉG', 'ÉI', 'ÉJ', 'ÉL',  // B0
   'ÉN', 'ÉP', 'ÉR', 'ÉT', 'ÉV', 'ÉX', 'ÉZ', 'É\',  // B8
   'É^', 'É`', 'Éc', 'Ée', 'Ég', 'Éi', 'Éj', 'Ék',  // C0
   'Él', 'Ém', 'Én', 'Éq', 'Ét', 'Éw', 'Éz', 'É}',  // C8
   'É~', 'ÉÄ', 'ÉÅ', 'ÉÇ', 'ÉÑ', 'ÉÜ', 'Éà', 'Éâ',  // D0
   'Éä', 'Éã', 'Éå', 'Éç', 'Éè', 'Éì', 'ÅJ', 'ÅK',  // D8
   #$E0, #$E1, #$E2, #$E3, #$E4, #$E5, #$E6, #$E7,  // E0
   #$E8, #$E9, #$EA, #$EB, #$EC, #$ED, #$EE, #$EF,  // E8
   #$F0, #$F1, #$F2, #$F3, #$F4, #$F5, #$F6, #$F7,  // F0
   #$F8, #$F9, #$FA, #$FB, #$FC, #$FD, #$FE, #$FF); // F8

//////////////////////////////////////////////////////////////////////
//
// à»â∫ÇÕÅAó⁄‡˙Ç≥ÇÒ(KHB05271)çÏÇÃ HenkanJ.pas ÇÉÇÉfÉBÉtÉ@ÉCÇµÇΩÇ‡ÇÃ
//
// (1)
// end else if s[1] in [#$a6..#$af,#$b1..#$df] then begin
//                                         Å´
// end else if s[1] in [#$a6..#$af,#$b1..#$dd] then begin
//
// Ç∆ÇµÅA'ﬁ'(#$DE), 'ﬂ'(#$DF) ÇãLçÜÇ∆ÇµÇƒèàóùÇ∑ÇÈÇ±Ç∆Ç≈ÅAÅJÅKÇ…ïœä∑
// Ç≥ÇÍÇÈÇÊÇ§Ç…ÇµÇΩÅB
//
// (2)
// ÇÊÇ¡Çƒ if Kana[S[1]] = 0 then ÇÃèàóùÇÕçÌèúÇµÇΩÅB
//
// (3)
// ÅuÉîÅvÇÃèàóùÇí«â¡
//
// (4)
// Ç‹ÇΩÅAif S[1] in ['0'..'9', 'A'..'Z', 'a'..'z'] then à»â∫ÇÃ
// ÉJÉ^ÉJÉià»äOÇÃï∂éöèàóùÇÕÅAè„ãL DBCSCharArray Ç©ÇÁéÊìæÇ∑ÇÈÇÊÇ§Ç…ÇµÇΩÅB
//

  Kana: array[#$A6..#$DF] of Byte =
  ($72,$21,
   $23,$25,$27,$29,$63,$65,$67,$43,
   $00,$22,$24,$26,$28,$2A,$AB,$AD, // $00 #$B0 ∞
   $AF,$B1,$B3,$B5,$B7,$B9,$BB,$BD,
   $BF,$C1,$C4,$C6,$C8,$4A,$4B,$4C,
   $4D,$4E,$CF,$D2,$D5,$D8,$DB,$5E,
   $5F,$60,$61,$62,$64,$66,$68,$69,
   $6A,$6B,$6C,$6D,$6F,$73,$00,$00); // $00 #$DE ﬁ  #$DF ﬂ

function JisToSJis(N:WORD):WORD; register; assembler;
asm
    add  ax,0a17eh ; shr  ah,1      ; jb  @1
    cmp  al,0deh   ; sbb  al,5eh
@1: xor  ah,0e0h
end;

function WordToChar(N: Word):String;
begin
  Result := Char(Hi(N)) + Char(Lo(N))
end;

function HankToZen(S: String): String;
var
  W: Word;
begin
  Result := '';
  while Length(S) > 0 do
  begin
    if S[1] in [#$81..#$9F, #$E0..#$FC] then   // ëSäpï∂éö
    begin
      Result := Result + Copy(S, 1, 2);
      Delete(S, 1, 2);
    end
    else                                       // îºäpï∂éö
      if S[1] in [#$A6..#$AF, #$B1..#$DD] then // ¶..Ø, ±..›
      begin
        W := $2500 + (Kana[S[1]] and $7F);
        if (Kana[S[1]] and $80) = 0 then       // ﬂﬁ Ç™à”ñ°ÇÇ»Ç≥Ç»Ç¢
        begin
          if (Length(S) > 1) and (S[1] = #$B3) and (S[2] = #$DE) then
          begin
            Result := Result + 'Éî';           // ≥ﬁ ÇÃèàóù
            Delete(S, 1, 2);
          end
          else
          begin
            Result := Result + DBCSCharArray[S[1]];
            Delete(S, 1, 1);
          end;
        end
        else                                    // ﬂﬁ Ç™à”ñ°ÇÇ»Ç∑
        begin
          if (Length(S) > 1) and (S[2] in [#$DE, #$DF]) then
          begin
            W := W + 1 + (Ord(S[2]) and 1);
            Delete(S, 2, 1);
          end;
          Result := Result + WordToChar(JisToSJis(W));
          Delete(S, 1, 1)
        end;
      end
      else
      begin                                     // ãLçÜ
        Result := Result + DBCSCharArray[S[1]];
        Delete(S, 1, 1);
      end;
  end;
end;

//////////////////////////////////////////////////////////////////////

function SearchBuf(  Buf: PChar;
                     var Info: TSearchInfo;
                     SearchString: String;
                     Options: TSearchOptions): PChar;
var
  SC, BufLen, I, P, C, Extend, L, CharLen: Integer;
  B: Byte;
  Direction: ShortInt;
  Pattern, S: String;
  DBCSPattern, DBCSBuffer, MatchChar, IsDakuten: Boolean;
  AttrBuffer: PChar;

  function FindNextWordStart(var BufPtr: PChar): Boolean;
  begin
    // àÍåÍÇÃêÊì™Çå©ÇƒÇ¢ÇÈÇ∆Ç´ÇÕà⁄ìÆÇπÇ∏Ç…ê^Çï‘Ç∑
    if (Direction = 1) and not (BufPtr^ in WordDelimiters) and
       ((BufPtr = Buf) or
        ((BufPtr > Buf) and (Buf[BufPtr - Buf - 1] in WordDelimiters))) then
    begin
      Result := True;
      Exit;
    end;

    while (SC > 0) and
          ((Direction = 1) xor (BufPtr^ in WordDelimiters)) do
    begin
      Inc(BufPtr, Direction);
      Dec(SC);
    end;
    while (SC > 0) and
          ((Direction = -1) xor (BufPtr^ in WordDelimiters)) do
    begin
      Inc(BufPtr, Direction);
      Dec(SC);
    end;
    Result := SC >= 0;
    if (Direction = -1) and (BufPtr^ in WordDelimiters) then
    begin   { back up one char, to leave ptr on first non delim }
      Dec(BufPtr, Direction);
      Inc(SC);
    end;
    if AttrBuffer[BufPtr - Buf] = '2' then
    begin
      Inc(BufPtr, Direction);
      Dec(SC);
    end;
  end;

begin
  Result := nil;
  BufLen := StrLen(Buf);
  if (Info.Start < 0) or (Info.Start > BufLen) or (Info.Length < 0) then
    Exit;
  Pattern := SearchString;
  if not (sfrMatchCase in Options) then
    Pattern := AnsiUpperCase(Pattern);
  L := Length(Pattern);
  CharLen := 0;
  if sfrNoMatchZenkaku in Options then
  begin
    Pattern := HankToZen(Pattern);
    L := Length(Pattern);
    I := 1;
    while I <= L do
    begin
      if Pattern[I] in [#$81..#$9F, #$E0..#$FC] then
        Inc(I);
      Inc(I);
      Inc(CharLen);
    end;
  end;

  AttrBuffer := StrAlloc(BufLen + 1);
  try
    I := 0;
    while I < BufLen do
    begin
      if Buf[I] in [#$81..#$9F, #$E0..#$FC] then
      begin
        Move('12', AttrBuffer[I], 2);
        Inc(I);
      end
      else
        AttrBuffer[I] := '0';
      Inc(I);
    end;

    if sfrDown in Options then
    begin
      Direction := 1;
      Inc(Info.Start, Info.Length);
      if (Info.Start < BufLen) and (AttrBuffer[Info.Start] = '2') then
        Inc(Info.Start);
      if sfrNoMatchZenkaku in Options then
        SC := BufLen - Info.Start - CharLen
      else
        SC := BufLen - Info.Start - L;
      if SC < 0 then
        Exit;
      if Info.Start + SC > BufLen then
        Exit;
    end
    else
    begin
      Direction := -1;
      if not (sfrNoMatchZenkaku in Options) then
        Dec(Info.Start, L)
      else
        while CharLen > 0 do
        begin
          Dec(Info.Start);
          // ëSäpÇQÉoÉCÉgñ⁄Ç©ÅA≥, ∂..ƒ,  ..Œ + ﬁﬂ
          if (Info.Start > 0) and
             ((AttrBuffer[Info.Start] = '2') or
              ((Buf[Info.Start] in [#$DE..#$DF]) and
               (Buf[Info.Start - 1] in [#$B3, #$B6..#$C4, #$CA..#$CE]))) then
            Dec(Info.Start);
          Dec(CharLen);
        end;
      if (Info.Start >= 0) and (AttrBuffer[Info.Start] = '2') then
        Dec(Info.Start);
      SC := Info.Start;
    end;
    if (Info.Start < 0) or (Info.Start > BufLen) then
      Exit;
    Result := PChar(@Buf[Info.Start]);

    //  search
    while SC >= 0 do
    begin
      // SC = 0 ÇÃéû
      // Direction =  1 ... ç≈å„ÇÃàÍåÍ
      // Direction = -1 ... ÉoÉbÉtÉ@ÇÃêÊì™
      if (sfrWholeWord in Options) and (SC > 0) then
        if not FindNextWordStart(Result) then Break;

      I := 0; // hit counter
      C := 0; // crlf, space counter
      P := 1; // pointer to Pattern
      while True do
      begin
        DBCSPattern := Pattern[P] in [#$81..#$9F, #$E0..#$FC];
        DBCSBuffer := Result[I + C] in [#$81..#$9F, #$E0..#$FC];
        IsDakuten := False;

        if sfrNoMatchZenkaku in Options then // ëSäpÅEîºäpÇãÊï ÇµÇ»Ç¢
          if sfrMatchCase in Options then    // ëÂï∂éöè¨ï∂éöÇãÊï Ç∑ÇÈ
            if DBCSBuffer then
              MatchChar := (Pattern[P] = Result[I + C]) and
                           (Pattern[P + 1] = Result[I + C + 1])
            else
            begin                            // ëSäpÇ…ïœä∑ÇµÇƒîªï 
              // ≥, ∂..ƒ,  ..Œ + ﬁﬂ
              if (Result[I + C] in [#$B3, #$B6..#$C4, #$CA..#$CE]) and
                 (Result[I + C + 1] in [#$DE..#$DF]) then
              begin
                S := HankToZen(Result[I + C] +
                               Result[I + C + 1]);
                IsDakuten := True;
              end
              else
                S := DBCSCharArray[Result[I + C]];
              MatchChar := (Pattern[P] = S[1]) and
                           (Pattern[P + 1] = S[2]);
            end
          else                               // ëÂï∂éöè¨ï∂éöÇãÊï ÇµÇ»Ç¢
            if DBCSBuffer then               // ëSäpìØémÇÃîªï 
              if (Result[I + C] = #$82) and
                 (Result[I + C + 1] in [#$81..#$9A]) then // ÇÅ..Çö
                MatchChar :=
                  (Pattern[P] = #$82) and
                  (Pattern[P + 1] = LargeAlphaCharMap[Result[I + C + 1]])
              else
                MatchChar := (Pattern[P] = Result[I + C]) and
                             (Pattern[P + 1] = Result[I + C + 1])
            else
            begin                            // ëSäpÇ…ïœä∑ÇµÇƒî‰är
              // ≥, ∂..ƒ,  ..Œ + ﬁﬂ
              if (Result[I + C] in [#$B3, #$B6..#$C4, #$CA..#$CE]) and
                 (Result[I + C + 1] in [#$DE..#$DF]) then
              begin
                S := HankToZen(Result[I + C] +
                               Result[I + C + 1]);
                IsDakuten := True;
              end
              else
                S := DBCSCharArray[Result[I + C]];
              if (S[1] = #$82) and           // ëÂï∂éöÉ}ÉbÉvÇ≈îªï 
                 (S[2] in [#$81..#$9A]) then // ÇÅ..Çö
                MatchChar := (Pattern[P] = #$82) and
                             (Pattern[P + 1] = LargeAlphaCharMap[S[2]])
              else
                MatchChar := (Pattern[P] = S[1]) and
                             (Pattern[P + 1] = S[2]);
            end
        else                                 // ëSäpÅEîºäpÇãÊï Ç∑ÇÈ
          if sfrMatchCase in Options then    // ëÂï∂éöè¨ï∂éöÇãÊï Ç∑ÇÈ
            if DBCSBuffer then
              MatchChar := DBCSPattern and
                           (Pattern[P] = Result[I + C]) and
                           (Pattern[P + 1] = Result[I + C + 1])
            else
              MatchChar := Pattern[P] = Result[I + C]
          else                               // ëÂï∂éöè¨ï∂éöÇãÊï ÇµÇ»Ç¢
            if DBCSBuffer then
              if (Result[I + C] = #$82) and
                 (Result[I + C + 1] in [#$81..#$9A]) then // ÇÅ..Çö
                MatchChar :=
                  (Pattern[P] = #$82) and
                  (Pattern[P + 1] = LargeAlphaCharMap[Result[I + C + 1]])
              else
                MatchChar := (Pattern[P] = Result[I + C]) and
                             (Pattern[P + 1] = Result[I + C + 1])
            else
              MatchChar := Pattern[P] = UpperCharMap[Result[I + C]];
        if not MatchChar then
        begin
          Extend := 0;
          if I > 0 then
            if (sfrIncludeCRLF in Options) and
               (Result[I + C] in [#$0D, #$0A]) then
              Extend := 1
            else
              if (sfrIncludeSpace in Options) and
                 (Result[I + C] in [#$20, #$09]) then
                Extend := 1
              else
                if (sfrIncludeSpace in Options) and
                   (Result[I + C] = #$81) and
                   (Result[I + C + 1] = #$40) then
                  Extend := 2;
          if Extend > 0 then
          begin
            Inc(C, Extend);
            Continue;
          end
          else
            Break;
        end
        else
        begin
          Inc(I, Byte(DBCSBuffer or IsDakuten) + 1);
          Inc(P, Byte(DBCSPattern) + 1);
          if P > L then
            if (not (sfrWholeWord in Options)) or
               (SC = 0) or
               (Result[I + C] in WordDelimiters) then
            begin
              Info.Length := I + C;
              Exit;
            end
            else
              Break;
        end;
      end;
      Inc(Result, Direction);
      Dec(SC);
      if AttrBuffer[Result - Buf] = '2' then
      begin
        Inc(Result, Direction);
        Dec(SC);
      end;
    end;
    Result := nil;
  finally
    StrDispose(AttrBuffer);
  end;
end;

function SearchText( TextLine: PChar;
                     var Info: TSearchInfo;
                     const SearchString: String;
                     Options: TSearchOptions): Boolean;
var
  P: PChar;
begin
  Result := False;
  if (Length(SearchString) = 0) or (StrLen(TextLine) = 0) then
    Exit;
  P := SearchBuf(TextLine, Info, SearchString, Options);
  if P <> nil then
  begin
    //  Info.Length ÇÕ SearchBuf ì‡Ç≈ÉZÉbÉgÇ≥ÇÍÇÈ
    Info.Start := P - TextLine;
    Result := True;
  end;
end;

initialization
  for Ch := Low(UpperCharMap) to High(UpperCharMap) do
  begin
    UpperCharMap[Ch] := Ch;
    LargeAlphaCharMap[Ch] := Ch;
  end;
  // ëÂï∂éöÉeÅ[ÉuÉã
  CharUpperBuff(PChar(@UpperCharMap), SizeOf(UpperCharMap));
  // ÇÅ..ÇöÇÃÇQÉoÉCÉgñ⁄ÇÇ`..ÇyÇÃÇQÉoÉCÉgñ⁄Ç…Ç∑ÇËë÷Ç¶
  for Ch := #$81 to #$9A do
    LargeAlphaCharMap[Ch] := Char(Ord(Ch) - $21);

end.

