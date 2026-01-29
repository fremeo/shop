{block name="inner_body" prepend}
	<div class="container">
	<form method="post">
		<div class="row" id="basket">
			
			<div class="col">
			
				<h3 class="mb-3">
					<i class="fas fa-shopping-basket me-2"></i>Warenkorb
				</h3>
				<table class="table">
					<thead>
						<tr>
							<th scope="col" style="width:5%">#</th>
							<th scope="col" style="width:5%"></th>
							<th scope="col" style="width:5%"></th>
							<th scope="col">Artikel</th>
							<th scope="col">MwSt</th>
							<th scope="col">Einzelpreis</th>
							<th scope="col" style="width:10%">Anzahl</th>
							<th scope="col" class="text-center" style="width:10%">Preis</th>
						</tr>
					</thead>
					<tbody class="table-group-divider">
						{foreach from=$D.SESSION.BASKET.ORDER.D[ $D.SESSION.OrderId ].ARTICLE.D key="kART" item="ART" name="ART"}
						<tr>
							<th scope="row">{$smarty.foreach.ART.iteration}</th>
							<td>{input p=['value' => 1, 'type' => 'checkbox']}</td>
							<td>
							{$Pics = json_decode($D.ARTICLE.D[$kART].ATTRIBUTE.D['Image'].Value,true)}
							
							{if $Pics[0]}
								<picture> 
									<source srcset="file/{$Pics[0]}_50x50.avif" type="image/avif"/>
									<source srcset="file/{$Pics[0]}_50x50.webp" type="image/webp"/>
									<img src="file/{$Pics[0]}_50x50.jpg" style="image-rendering: pixelated;"/>
								</picture>
							{/if}
							</td>
							<td>{$D.ARTICLE.D[$kART].ATTRIBUTE.D['Title'].LANGUAGE.D['DE'].Value}<br>
							
							{*Varianten Bezeichnung*}
							{if $D.ARTICLE.D[ $D.ARTICLE.D[$kART].ParentId ].ATTRIBUTE.D['VarianteGroup'].Value}
								{$sVG = explode('|', $D.ARTICLE.D[ $D.ARTICLE.D[$kART].ParentId ].ATTRIBUTE.D['VarianteGroup'].Value)}
								{foreach from=$sVG key="kVG" item="VG"}
									<b>{$D.ARTICLE.D[$kART].ATTRIBUTE.D[$VG].LANGUAGE.D['DE'].Value}</b>
								{/foreach}
							{/if}
							</td>
							<td>19%</td>
							<td class="text-end">{$D.ARTICLE.D[$kART].CUSTOMERGROUP.D[0].Price|string_format:"%.2f"} €</td>
							<td>{input p=['name' => "R[BASKET][ORDER][D][{$D.SESSION.OrderId}][ARTICLE][D][{$kART}][Stock]", 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });", 'value' => $ART.Stock ]}
							{input p=['type' => 'hidden', 'name' => 'R[ACTION]', 'value'=> 'addToBasket']}
							<button type="submit">Save</button>
							</td>
							{*<td>{($D.ARTICLE.D[$kART].ATTRIBUTE.D['Price'].Value*$ART.Stock)|string_format:"%.2f"} €</td>*}
							<td class="text-end">{($D.ARTICLE.D[$kART].CUSTOMERGROUP.D[0].Price*$ART.Stock)|string_format:"%.2f"} €</td>
						</tr>
						{$_SUM = $_SUM + $D.ARTICLE.D[$kART].CUSTOMERGROUP.D[0].Price*$ART.Stock}
						{/foreach}
					</tbody>
					<tfoot class="table-light table-group-divider">
						<tr>
							<th scope="row"></th>
							<td></td>
							<td></td>
							<td>Summe</td>
							<td></td>
							<td></td>
							<td></td>
							<td class="text-end">{($_SUM+5.99)|string_format:"%.2f"} €</td>
						</tr>
					</tfoot>
				</table>
				
				{if count((array)$D.SESSION.BASKET.ORDER.D[$D.SESSION.OrderId].ARTICLE.D) > 0}
					{*
				<button type="button" class="btn btn-warning" onclick="wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=send_basket2Mail', 'data' : $('form').serialize() }); alert('Vielen Dank für Ihre Anfrage, wir werden uns bei Ihen dann melden.');location.href = '{$D.BasePath}'; ">Anfragen</button>
				*}
				<div class="text-end">
					<a href="?R[Page]=frontend__checkout_step1&R[ModuleId]=papp/shop" class="btn btn-warning btn-outline-primery">Zur Kasse</a>
				</div>
				{else}
					<div class="alert alert-danger" role="alert">Bitte fügen Sie Artikel dem Warenkorb hinzu!</div>
				{/if}
			</div>
		</div>
		<div class="row" id="thankyou" style="display:none;">
			<div class="col">
				<b>Hervorragend, das hat alles funktioniert!</b><br>
				Ihre Bestellnummer lautet: <b id='OrderNr'></b>
			</div>
		</div>
	</form>
	</div>
	{/block}