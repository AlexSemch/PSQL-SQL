/*Замінює степінь в форматі y^x, де x,y - будь-яке число, на html теги для коректного відображення в FastReport*/
SET TERM ^ ;

create or alter procedure SOI_INSERT_SUP (
TEXT_IN FULL_NAME)
returns (
TEXT_OUT FULL_NAME)
as
declare variable LNN integer;
declare variable CH char(10);
declare variable TEMP FULL_NAME;
declare variable I integer;
declare variable STEP FULL_NAME;
declare variable FS integer;
begin

TEXT_IN = trim(TEXT_IN);
TEMP = TEXT_IN;
LNN = char_length(TEXT_IN);
I = 1;
while (TEMP like '%^%') do
begin
  while (I <= LNN) do
  begin
    CH = substring(TEXT_IN from I for 1);
    if (CH = '^') then
    begin 
    FS = I + 1;
    I = I + 1;
    CH = substring(TEXT_IN from FS for 1);
    while ((I <= LNN) and (CH in ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'))) do
    begin
      I = I + 1;
      CH = substring(TEXT_IN from I for 1);
    end
    STEP = substring(TEXT_IN from FS for (I - FS));
    TEMP = replace(TEMP, '^' || STEP, '<sup>' || STEP || '</sup>');
  end
I = I + 1;
end


end

TEXT_OUT = TEMP;

suspend;
end
^

SET TERM ; ^

GRANT EXECUTE ON PROCEDURE SOI_INSERT_SUP TO "PUBLIC";
GRANT EXECUTE ON PROCEDURE SOI_INSERT_SUP TO SYSDBA;
GRANT EXECUTE ON PROCEDURE SOI_INSERT_SUP TO U_SYSWORK;
GRANT EXECUTE ON PROCEDURE SOI_INSERT_SUP TO R_SYSCONNECT;
GRANT EXECUTE ON PROCEDURE SOI_INSERT_SUP TO R_SYSREPL;
GRANT EXECUTE ON PROCEDURE SOI_INSERT_SUP TO R_SYSWORK;
