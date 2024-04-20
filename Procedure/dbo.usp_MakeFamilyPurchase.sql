create or alter procedure dbo.usp_MakeFamilyPurchase(
	@FamilySurName varchar(255)
)
as
begin
	set nocount on

	declare 
		@ID_Family int,
		@ErrorMessage varchar(500)
	
	select @ID_Family = f.[ID identity] from dbo.Family as f where f.SurName = @FamilySurName

	if @ID_Family is null 
	begin
		set @ErrorMessage = concat(@FamilySurName, ' отсутствует в списке')

		raiserror(@ErrorMessage, 1, 1)

		return
	end
	
	merge dbo.Family as t
	using (
		select 
			sum(b.Value) as Value
			,b.ID_Family
		from dbo.Basket as b
		where b.ID_Family = @ID_Family
		group by b.ID_Family
	) as s on s.ID_Family = t.[ID identity]
	when matched then
		update
		set t.BudgetValue = t.BudgetValue - s.Value;

	set nocount off
end