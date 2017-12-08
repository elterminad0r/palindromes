program recpals;

uses
    SysUtils;

function _is_palindrome(s: string; lower, upper: integer): boolean;
begin
    if lower >= upper then
        _is_palindrome := True
    else if s[lower] = s[upper] then
        _is_palindrome := _is_palindrome(s, lower + 1, upper - 1)
    else
        _is_palindrome := False;
end;

function is_palindrome(s: string): boolean;
begin
    is_palindrome := _is_palindrome(s, 1, length(s));
end;

function _clean(s: string; i: integer): string;
begin
    if i > length(s) then
        _clean := ''
    else if s[i] in ['A'..'Z', 'a'..'z'] then
        _clean := LowerCase(s[i]) + _clean(s, i + 1)
    else
        _clean := _clean(s, i + 1);
end;

function clean(s: string): string;
begin
    clean := _clean(s, 1);
end;

var
    i: integer;
begin
    for i := 1 to ParamCount do
        writeln(ParamStr(i), ' ', is_palindrome(clean(ParamStr(i))));
end.
