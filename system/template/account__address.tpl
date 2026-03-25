

{block name="account_body"}
	<form method="post">
	<input name="D[Action]" type="hidden" value="save">
	
	{$head=[
		'add' => [ 'label' => '<i class="fa-solid fa-plus"></i>', 'type' => 'label'],
				'#' => ['label' => '<i class="fa-solid fa-hashtag"></i>', 'type' => 'label'],
				'Active' => ['label' => 'Aktive', 'type' => 'checkbox'],
				'FName' => ['label' => 'Vorname', 'type' => 'text'],
				'LName' => ['label' => 'Nachname', 'type' => 'text'],
				'Street' => ['label' => 'Straße', 'type' => 'text'],
				'HNumber' => ['label' => 'Nr', 'type' => 'text'],
				'Postcode' => ['label' => 'PLZ', 'type' => 'text'],
				'City' => ['label' => 'Ort', 'type' => 'text'],
				'CountryId' => ['label' => 'Land', 'type' => 'select', 'option' => ['DE|Deutschland'] ],
				'Phone' => ['label' => 'Phone', 'type' => 'text'],
				'Mail' => ['label' => 'Mail', 'type' => 'text'],
				'edit' => ['label' => '<i class="fa-regular fa-pen-to-square"></i>', 'type' => 'button'],
				'del' => ['label' => '<i class="fa-regular fa-trash-can"></i>', 'type' => 'button']
			]
	}
	{foreach from=$D.ACCOUNT.D key="kACC" item="ACC"}
		{foreach from=$ACC.ADDRESS.D key="kADD" item="ADD" name="ADD"}
			{foreach from=$head item=fieldValue key=fieldName}
				
				{$row[$kADD][$fieldName] = [
					'value' => $ADD[$fieldName],
					'name'  => "D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$kADD}][{$fieldName}]"
				]}
			{/foreach}
			{$row[$kADD]['#'] = ['value' => $smarty.foreach.ADD.iteration]}
			{$row[$kADD]['add'] = ['type' => 'button', 'label' => '<i class="fa-solid fa-plus"></i>', 'onclick' => '', 'class' => 'btn-success']}
			{$row[$kADD]['del'] = ['type' => 'button', 'value'=> '__DELETE__', 'label' => '<i class="fa-regular fa-trash-can"></i>', 'onclick' => "this.closest('tr').style.display = 'none';", 'id' => "_del{$kACC}{$kADD}", "name" => "D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$kADD}]", 'class' => 'btn-danger']}
			{$row[$kADD]['edit'] = ['type' => 'button', 'label' => '<i class="fa-regular fa-pen-to-square"></i>', 'onclick' => '', 'class' => 'btn-warning']}
		{/foreach}
	{/foreach}
	
	{table head=$head rows=$row}
	
	{*foreach from=$D.ACCOUNT.D key="kACC" item="ACC"}
	
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
				<th>Phone</th>
				<th>Mail</th>
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
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$kADD}][Phone]",'value'=>$ADD.Phone]}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$kADD}][Mail]",'value'=>$ADD.Mail]}
			</tr>
		{/foreach}
		{$_id = hash("crc32b", time())}
			<tr>
				<td>+</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$_id}][Active]",'value'=>$ADD.Active, 'type'=>'checkbox']}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$_id}][FName]"]}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$_id}][LName]"]}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$_id}][Street]"]}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$_id}][HNumber]"]}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$_id}][Postcode]"]}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$_id}][City]"]}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$_id}][CountryId]", 'option' => ['DE|Deutschland'], 'type'=>'select']}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$_id}][Phone]"]}</td>
				<td>{input p=['name'=>"D[ACCOUNT][D][{$kACC}][ADDRESS][D][{$_id}][Mail]"]}</td>
			</tr>
		</table>
		
		
	{/foreach*}
	<button class="btn btn-success" type="sbumit">Speichern</button>
	</form>
{/block}
