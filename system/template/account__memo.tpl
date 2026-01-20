{block name="account_body"}
	<form method="post">
	{foreach from=$D.ACCOUNT.D key="kACC" item="ACC"}
		{table p=[
					'thead' => ['#','Active','Title' ],
					'tbody' => [ '#' ,'Active','Title' ], 
					'data' => $ACC.MEMO.D 
				]}
	{/foreach}
	</form>
{/block}
