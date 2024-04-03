use FACTORY;


go
/*
create type dbo.BuildQueueType as table(
		ID int not null identity
		,ID_Nomenclature int not null
		,ID_BuildArea int not null
		,StartDate DATETIME
		,EndDate DATETIME
		
)
*/
drop function  dbo.udf_GetMinDateNomenclature_withTempBuildQueue;

go 

create function dbo.udf_GetMinDateNomenclature_withTempBuildQueue (
	@ID_Nomenclarure as int
	,@BuildQueue as dbo.BuildQueueType readonly
	)
	returns @BuildAreaDate table (
		ID_BuildArea int
		,BuildAreaEndDate datetime
	)
	as
	begin
		declare @BuildPeriod decimal (18,2);
		
		select 
			@BuildPeriod=N.BuildPeriod
		from Nomenclatures as N
		where N.ID=@ID_Nomenclarure;

		insert into @BuildAreaDate(ID_BuildArea,BuildAreaEndDate)
			select
				BAN.ID_BuildArea AS ID_BuildArea,
			case 
				when  (max(BQ.EndDate) > getdate()) and  (max(BQ.EndDate) is not  null) 
					then dbo.ConvertDecimalToDateTime(@BuildPeriod,max(BQ.EndDate))
					else dbo.ConvertDecimalToDateTime(@BuildPeriod,cast(getdate() as smalldatetime))
			end as BuildAreaEndDate
			
			from dbo.Nomenclatures as N
				inner join dbo.BuildAreas_Nomenclatures AS BAN ON BAN.ID_Nomenclature = N.ID
				left join @BuildQueue AS BQ ON BQ.ID_BuildArea = BAN.ID_BuildArea
			where N.ID = @ID_Nomenclarure
			group by BAN.ID_BuildArea;

			return;
		
	end;