program Palindromes;

uses
    SysUtils;

function nrclean(s: string): string;
var
    i: char;
begin
    nrclean := '';
    for i in s do
        if i in ['A'..'Z','a'..'z'] then
            nrclean := nrclean + LowerCase(i);
end;

function nr_ispal(s: string): boolean;
var
    lower, upper: integer;
begin
    lower := 1;
    upper := length(s);
    while upper > lower do
        if s[lower] <> s[upper] then
            exit(False)
        else begin
            lower := lower + 1;
            upper := upper - 1;
        end;
    nr_ispal := True
end;

var
    i: integer;
begin
    for i := 1 to ParamCount do
        writeln(ParamStr(i), ' ', nr_ispal(nrclean(ParamStr(i))));
end.
