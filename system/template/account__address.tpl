
{block name="account_body"}
	<form method="post">
	<input name="D[Action]" type="hidden" value="save">
	{foreach from=$D.ACCOUNT.D key="kACC" item="ACC"}
		<table class="table">
			<tr>
				<th>#</th>
				<th>Aktive</th>
				<th>Vorname</th>
				<th>Nachname</th>
				<th>Straße</th>
				<th>Nr</th>
				<th>PLZ</th>
				<th>Ort</th>
				<th>Land</th>
			</tr>
		{foreach from=$ACC.ADDRESS.D key="kADD" item="ADD" name="ADD"}
			<tr>
				<td>{$smarty.foreach.ADD.iteration}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$kADD}][Active]",'value'=>$ADD.Active, 'type'=>'checkbox']}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$kADD}][FName]",'value'=>$ADD.FName]}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$kADD}][LName]",'value'=>$ADD.LName]}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$kADD}][Street]",'value'=>$ADD.Street]}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$kADD}][HNumber]",'value'=>$ADD.HNumber]}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$kADD}][Postcode]",'value'=>$ADD.Postcode]}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$kADD}][City]",'value'=>$ADD.City]}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$kADD}][CountryId]",'value'=>$ADD.CountryId, 'option' => ['DE|Deutschland'], 'type'=>'select']}</td>
			</tr>
		{/foreach}
		</table>
		
		<button class="btn btn-success" type="sbumit">Speichern</button>
	{/foreach}
	</form>
{/block}
