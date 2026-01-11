{block name="inner_body"}
	
	<form method="post">
	<input type="hidden" name="D[ACTION]" value='save'>
<div class="row">
	<div class="col-2">
		<div class="nav flex-column nav-pills" >
		{foreach from=$D.ATTRIBUTE_SET.D key="kATTS" item="ATTS"}
			<a class="nav-link {if $kATTS == $D.P.ATTSETID}active{/if}" href="?D[_PAGE]=attribute.list&P[ATTSETID]={$kATTS}">{$ATTS.LANGUAGE.D['DE'].Title}</a>
		{/foreach}
		</div>
	</div>
	<div class="col-10">
	{$SetLanguage = json_decode($D.SETTING.D['Language'].Value,true)}

	{foreach from=$D.ATTRIBUTE_SET.D key="kATTS" item="ATTS"}
	{foreach from=$ATTS.ATTRIBUTE_GROUP.D key="kATTG" item="ATTG"}
		<div class="h3">{$ATTG.LANGUAGE.D['DE'].Title}</div>

		<table class="table">
		<thead>
			<tr>
				<th scope="col">Id</th>
				<th scope="col">Active</th>
				<th scope="col">Sort</th>
				<th scope="col">Type</th>
				<th scope="col">I18n</th>
				{foreach from=$SetLanguage key="kLAN" item="LAN"}
					{if $LAN.Active}
						<th scope="col">{$kLAN} Title</th>
					{/if}
				{/foreach}
			</tr>
		</thead>
		<tbody>
		{foreach from=$ATTG.ATTRIBUTE.D key="kATT" item="ATT"}
			<tr>
				<td scope="row">{$kATT}</td>
				<td scope="row">{input p=['name' => "D[ATTRIBUTE][D][{$kATT}][Active]", "type" => 'checkbox', 'value'=>$ATT.Active]}</td>
				<td scope="row">{input p=['name' => "D[ATTRIBUTE][D][{$kATT}][Sort]", "type" => 'text', 'value'=>$ATT.Sort]}</td>
				<td scope="row">{input p=['name' => "D[ATTRIBUTE][D][{$kATT}][Type]", "type" => 'select', 'option' => ['text','textarea','wysiwyg','checkbox','select','file'], 'value'=>$ATT.Type]}</td>
				<td scope="row">{input p=['name' => "D[ATTRIBUTE][D][{$kATT}][I18n]", "type" => 'checkbox', 'value'=>$ATT.I18n]}</td>
				{foreach from=$SetLanguage key="kLAN" item="LAN"}
					{if $LAN.Active}
				<td scope="row">{input p=['name' => "D[ATTRIBUTE][D][{$kATT}][LANGUAGE][D][{$kLAN}][Title]", "type" => 'text', 'value'=>$ATT.LANGUAGE.D[$kLAN].Title]}</td>
					{/if}
				{/foreach}
				
			</tr>
		{/foreach}
		</tbody>
	</table>
		
		
			
	
		{/foreach}
	{/foreach}


	<table class="table">
				<thead>
					<tr>
						<th scope="col">Id</th>
						<th scope="col">Active</th>
						<th scope="col">Sort</th>
						<th scope="col">Type</th>
						<th scope="col">I18n</th>
						{foreach from=$SetLanguage key="kLAN" item="LAN"}
							{if $LAN.Active}
								<th scope="col">{$kLAN} Title</th>
							{/if}
						{/foreach}
					</tr>
				</thead>
				<tbody>
				{foreach from=$D.ATTRIBUTE.D key="kATT" item="ATT"}
					<tr>
						<td scope="row">{$kATT}</td>
						<td scope="row">{input p=['name' => "D[ATTRIBUTE][D][{$kATT}][Active]", "type" => 'checkbox', 'value'=>$ATT.Active]}</td>
						<td scope="row">{input p=['name' => "D[ATTRIBUTE][D][{$kATT}][Sort]", "type" => 'text', 'value'=>$ATT.Sort]}</td>
						<td scope="row">{input p=['name' => "D[ATTRIBUTE][D][{$kATT}][Type]", "type" => 'select', 'option' => ['text','textarea','wysiwyg','checkbox','select','file'], 'value'=>$ATT.Type]}</td>
						<td scope="row">{input p=['name' => "D[ATTRIBUTE][D][{$kATT}][I18n]", "type" => 'checkbox', 'value'=>$ATT.I18n]}</td>
						{foreach from=$SetLanguage key="kLAN" item="LAN"}
							{if $LAN.Active}
						<td scope="row">{input p=['name' => "D[ATTRIBUTE][D][{$kATT}][LANGUAGE][D][{$kLAN}][Title]", "type" => 'text', 'value'=>$ATT.LANGUAGE.D[$kLAN].Title]}</td>
							{/if}
						{/foreach}
						
					</tr>
				{/foreach}
				</tbody>
			</table>
	</div>
</div>
<button type="submit" class="btn btn-primary btn-sm">Save</button>
</form>
	
{/block}