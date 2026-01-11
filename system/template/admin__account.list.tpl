{block name="body"}
	<form method="post">
		<input type="hidden" name="D[ACTION]" value='save'>
		
		<table class="table">
			<thead>
				<tr>
					<th scope="col">Id</th>
					<th scope="col">Active</th>
					<th scope="col">Gruppe</th>
					<th scope="col">Company</th>
					<th scope="col">Name</th>
					<th scope="col">Benutzer</th>
					<th scope="col"></th>
				</tr>
			</thead>
			<tbody>
			{foreach from=$D.ACCOUNT.D key="kACC" item="ACC"}
				<tr>
					<td scope="row">{$kACC}</td>
					<td scope="row">{input p=['name' => "D[ACCOUNT][D][{$kACC}][Active]", "type" => 'checkbox', 'value'=>$ACC.Active]}</td>
					<td scope="row">{$ACC.CustomerGroupId}</td>
					<td scope="row">{$c = current((array)$ACC.ADDRESS.D)}{$c['Company']}</td>
					<td scope="row">{$c['FName']}{$c['LName']}</td>
					<td scope="row">{count((array)$ACC.CUSTOMER.D)}</td>
					<td scope="row"><a href="?D[_PAGE]=account.edit&D[_ID]={$kACC}">edit</a></td>
				</tr>
			{/foreach}
			</tbody>
		</table>
		<button type="submit" class="btn btn-primary btn-sm">Save</button>
	</form>
{/block}