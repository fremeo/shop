{function name="form_artikle" kART=null ART=null}
<table class="table">
			<thead>
				<tr>
					<th scope="col">Attribut</th>
					{foreach from=$SetLanguage key="kLan" item="LAN"}
						{if $LAN.Active}
							{$_ActiveLanguage = $_ActiveLanguage+1}
					<th scope="col">{$kLan} Value</th>
						{/if}
					{/foreach}
				</tr>
			</thead>
			<tbody>
				<tr>
					<td scope="row">Active</td>
					<td scope="row" colspan="{$_ActiveLanguage}">{input p=['name' => "D[ARTICLE][D][{$kART}][Active]", "type" => 'checkbox', 'value'=>$ART.Active]}</td>
				</tr>

					{foreach from=$D.ATTRIBUTE.D key="kATT" item="ATT"}
						{if $ATT.Active}
						<tr>
							<td scope="row">{$ATT.LANGUAGE.D['DE'].Title}</td>
							{if $ATT.I18n}
								{foreach from=$SetLanguage key="kLan" item="LAN"}
									{if $LAN.Active}
									<td scope="row">
										{input p=['name' => "D[ARTICLE][D][{$kART}][ATTRIBUTE][D][{$kATT}][LANGUAGE][D][{$kLan}][Value]", "type" => $ATT.Type, 'value'=>$ART.ATTRIBUTE.D[$kATT].LANGUAGE.D[$kLan].Value]}
									</td>
									{/if}
								{/foreach}
							{else}
								<td scope="row" colspan="{$_ActiveLanguage}">
									{input p=['name' => "D[ARTICLE][D][{$kART}][ATTRIBUTE][D][{$kATT}][Value]", "type" => $ATT.Type, 'value'=>$ART.ATTRIBUTE.D[$kATT].Value]}
								</td>
							{/if}
						</tr>
						{/if}
					{/foreach}
				{*preis nach KundengruppeGruppe*}
				<tr>
					<td scope="row">Preis nach K.G.</td>
					<td scope="row" colspan="{$_ActiveLanguage}">
					Gast / Endkunde {input p=['name' => "D[ARTICLE][D][{$kART}][CUSTOMERGROUP][D][0][Price]", "type" => 'text', 'value'=>$ART.CUSTOMERGROUP.D[0].Price]}</td>
				</tr>
			</tbody>
		</table>
{/function}


{block name="inner_body"}
	<form method="post">
		<input type="hidden" name="D[ACTION]" value='save'>
		{$SetLanguage = json_decode($D.SETTING.D['Language'].Value,true)}
		
		
	{foreach from=$D.ARTICLE['ParentId'].D[NULL].ARTICLE.D key="kART" item="ART"}
		
		{form_artikle kART=$kART ART=$ART}
			Kinder<br>

		{foreach from=$D.ARTICLE['ParentId'].D[$kART].ARTICLE.D key="kVAR" item="VAR"}
			
			Variante: {$kVAR}
			{if $VAR.ATTRIBUTE.D['Image'].Value}{$Pics = json_decode($VAR.ATTRIBUTE.D['Image'].Value,true)}
			<picture> 
				<source srcset="file/{$Pics[0]}_50x50.avif" type="image/avif"/>
				<source srcset="file/{$Pics[0]}_50x50.webp" type="image/webp"/>
				<img src="file/{$Pics[0]}_50x50.png">
			</picture>
			{/if}
			{form_artikle kART=$kVAR ART=$VAR}
			
		{/foreach}
		
	{/foreach}
		<button type="submit" class="btn btn-primary btn-sm">Save</button>
	</form>
{/block}