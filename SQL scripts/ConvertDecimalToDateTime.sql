use FACTORY;

go


create function dbo.ConvertDecimalToDateTime(
    @decimalValue as decimal(18,2),
    @baseDate as datetime
)
returns datetime
as
begin
    declare @resultDateTime as datetime;
    declare @days int = FLOOR(@decimalValue);
    declare @hours int = ROUND((@decimalValue - @days) * 24, 0);
    
    set @resultDateTime = DATEADD(DAY, @days, @baseDate);
    set @resultDateTime = DATEADD(HOUR, @hours, @resultDateTime);
    
    return @resultDateTime;
end;