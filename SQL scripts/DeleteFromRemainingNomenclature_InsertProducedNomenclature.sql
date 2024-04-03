USE FACTORY;

go
drop procedure dbo.usp_DeleteFromRemainingNomenclature_InsertProducedNomenclature;

go

create procedure dbo.usp_DeleteFromRemainingNomenclature_InsertProducedNomenclature
	@ID_Nomenclature int
    ,@NomenclatureCount int
	,@ID_order int
as
begin
	set nocount on;

		create table #tmp_RemainingNomenclatureList_for1Nomenclture (
			ID int
			,ID_BuildArea int
			,Count int
		);

		insert into #tmp_RemainingNomenclatureList_for1Nomenclture(ID,ID_BuildArea,Count)
				select
					RN.ID
					,RN.ID_BuildArea
					,RN.Count
				from dbo.RemainingNomenclature as RN
				where RN.ID_Nomenclature=@ID_Nomenclature;

		declare @R_Count int;
		set @R_Count=@NomenclatureCount;

		declare @ID_RNL int;
		declare @RNLBuildArea int;
		declare @RNLCount int;

		declare RNL_cursor cursor for
					select 
						tmp_RNL.ID
						,tmp_RNL.ID_BuildArea
						,tmp_RNL.Count
					from #tmp_RemainingNomenclatureList_for1Nomenclture as tmp_RNL;

				

				open RNL_cursor;
				fetch next from RNL_cursor into @ID_RNL,@RNLBuildArea,@RNLCount;
				
				while @@FETCH_STATUS =0  and  @R_Count>0
				begin
					
					if @R_Count>=@RNLCount
					begin
						insert into dbo.ProducedNomenclature (ID_Order,ID_Nomenclature,ID_BuildArea,Count)
						values
							(@ID_order,@ID_Nomenclature ,@RNLBuildArea,@RNLCount);


						delete 
						from dbo.RemainingNomenclature  
						where dbo.RemainingNomenclature.ID=@ID_RNL;

					end
					else
					begin
						insert into dbo.ProducedNomenclature (ID_Order,ID_Nomenclature,ID_BuildArea,Count)
						values
							(@ID_order,@ID_Nomenclature ,@RNLBuildArea,@R_Count);

						update dbo.RemainingNomenclature 
						set Count=Count-@R_Count
						where ID=@ID_RNL;
					end

				set @R_Count=@R_Count-@RNLCount;
				
				fetch next from RNL_cursor into @ID_RNL,@RNLBuildArea,@RNLCount;
				end

				close RNL_cursor;
				deallocate RNL_cursor;

				drop table #tmp_RemainingNomenclatureList_for1Nomenclture;
end