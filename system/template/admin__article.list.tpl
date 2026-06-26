{block name="inner_body"}
	
	<form method="post">
		<input type="hidden" name="D[ACTION]" value='save'>
		<table class="table">
			<thead>
				<tr>
					<th scope="col">Id</th>
					<th scope="col">Bild</th>
					<th scope="col">Active</th>
					<th scope="col">Title</th>
					<th scope="col">ParentId</th>
					<th scope="col">Kinder</th>
					<th scope="col"></th>
				</tr>
			</thead>
			<tbody>
			{foreach from=$D.ARTICLE['ParentId'].D[NULL].ARTICLE.D key="kART" item="ART"}
				<tr>
					<td scope="row">{$kART}</td>
					<td scope="row">{if $ART.ATTRIBUTE.D['Image'].Value}{$Pics = json_decode($ART.ATTRIBUTE.D['Image'].Value,true)}
						<picture> 
							<source srcset="file/{$Pics[0]}_50x50.avif" type="image/avif"/>
							<source srcset="file/{$Pics[0]}_50x50.webp" type="image/webp"/>
							<img src="file/{$Pics[0]}_50x50.png">
						</picture>
						{/if}</td>
					<td scope="row">{input p=['name' => "D[ARTICLE][D][{$kART}][Active]", "type" => 'checkbox', 'value'=>$ART.Active]}</td>
					<td scope="row">{$ART.ATTRIBUTE.D['Title'].LANGUAGE.D['DE'].Value}</td>
					<td scope="row">{$ART['ParentId']}</td>
					<td scope="row">{count((array)$D.ARTICLE['ParentId'].D[$kART].ARTICLE.D)}</td>
					<td scope="row"><a href="?R[Page]=admin__article.edit&R[ModuleId]=fremeo/shop&D[_ID]={$kART}">edit</a></td>
				</tr>
			{/foreach}
			</tbody>
		</table>
		<button type="submit" class="btn btn-primary btn-sm">Save</button> <a href="?R[Page]=admin__article.edit&R[ModuleId]=fremeo/shop&R[ACTION]=new" class="btn btn-primary btn-sm">NEW</a>
	</form>
{/block}