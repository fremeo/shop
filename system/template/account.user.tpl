
	{block name="account_body"}
	<form method="post">
	{foreach from=$D.ACCOUNT.D key="kACC" item="ACC"}
		{table p=[
					'thead' => ['#','Active','Name','E-Mail'],
					'tbody' => [ '#' ,['column'=> 'Active', 'type'=> 'checkbox', 'name' => "D[ACCOUNT][D][{$kACC}][CUSTOMER][D]"], 'Name', 'Mail' ], 
					'data' => $ACC.CUSTOMER.D 
				]}
	{/foreach}
	</form>
	{/block}
