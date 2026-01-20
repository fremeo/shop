
{block name="inner_body" prepend}
	<div class="container">
	<form method="post">
		<div class="row" id="basket">
			<div class="col-sm-3">
				<div class="row">
					<div class="col-12 col-sm-12">
							
						<div class="card">
							<div class="card-header">
								<i class="fas fa-receipt float-start"></i> Rechnungsadresse
								<div class="float-end"><button type="button" onclick="$('#InvoiceAddressBox input').toggleClass('border-0 pe-auto');" class="btn btn-light btn-sm">edit</button></div>
							</div>
							<div class="card-body" id="InvoiceAddressBox">

									<div class="input-group mb-1">
									{input p=['placeholder'=>'Vorname', 'class' =>'form-control form-control-sm', 'required' => '1', 'name' => "D[_BASKET][InvoiceAddress][FName]", 'value' => $D.SESSION.BASKET.InvoiceAddress.FName, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
									{input p=['placeholder'=>'Nachname','class' =>'form-control form-control-sm', 'name' => "D[_BASKET][InvoiceAddress][LName]", 'value' => $D.SESSION.BASKET.InvoiceAddress.LName, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
									</div>
									<div class="input-group mb-1">
										{input p=['placeholder'=>'Straße', 'class' =>'form-control form-control-sm', 'name' => "D[_BASKET][InvoiceAddress][Street]",'value' => $D.SESSION.BASKET.InvoiceAddress.Street, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
										{input p=['placeholder'=>'Hausnummer','class' =>'form-control form-control-sm', 'name' => "D[_BASKET][InvoiceAddress][HNumber]",'value' => $D.SESSION.BASKET.InvoiceAddress.HNumber, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
									</div>
									<div class="input-group mb-1">
										{input p=['placeholder'=>'PLZ', 'class' =>'form-control form-control-sm', 'name' => "D[_BASKET][InvoiceAddress][Postcode]",'value' => $D.SESSION.BASKET.InvoiceAddress.Postcode, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
										{input p=['placeholder'=>'Stadt', 'class' =>'form-control form-control-sm', 'name' => "D[_BASKET][InvoiceAddress][City]",'value' => $D.SESSION.BASKET.InvoiceAddress.City, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
									</div>
									<div class="mb-1">
										{input p=['placeholder'=>'Land', 'class' =>'form-control form-control-sm', 'name' => "D[_BASKET][InvoiceAddress][CountryId]",'value' => $D.SESSION.BASKET.InvoiceAddress.CountryId, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
									</div>
									<div class="mb-1">
										{input p=['placeholder'=>'Telefon', 'class' =>'form-control form-control-sm', 'name' => "D[_BASKET][InvoiceAddress][Phone]",'value' => $D.SESSION.BASKET.InvoiceAddress.Phone, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
									</div>
									<div class="mb-1">
										{input p=['placeholder'=>'E-Mail', 'class' =>'form-control form-control-sm', 'name' => "D[_BASKET][InvoiceAddress][Mail]",'value' => $D.SESSION.BASKET.InvoiceAddress.Mail, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
									</div>
							
							
							{*<button type="button" class="btn btn-outline-warning">Abbrechen</button> <button type="button" class="btn btn-primary">OK</button>*}
						</div>
					</div>
	
						
					{*</div>
					<div class="col-12 col-sm-6">*}
						<div class="card">
							<div class="card-header">
								<i class="fas fa-location-arrow"></i>  Lieferadresse
								<div class="float-end"><button type="button" onclick="$('#ShippingAddressBox input').toggleClass('border-0 pe-auto');" class="btn btn-light btn-sm">edit</button></div>
							</div>
							<div class="card-body" id="ShippingAddressBox">
								<div class="input-group mb-1">
									{input p=['placeholder'=>'Vorname', 'class' =>'form-control form-control-sm', 'name' => "D[_BASKET][ShippingAddress][FName]", 'value' => $D.SESSION.BASKET.ShippingAddress.FName, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
									{input p=['placeholder'=>'Nachname', 'class' =>'form-control form-control-sm', 'name' => "D[_BASKET][ShippingAddress][LName]", 'value' => $D.SESSION.BASKET.ShippingAddress.LName, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
								</div>
								<div class="input-group mb-1">
									{input p=['placeholder'=>'Straße', 'class' =>'form-control form-control-sm', 'name' => "D[_BASKET][ShippingAddress][Street]",'value' => $D.SESSION.BASKET.ShippingAddress.Street, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
									{input p=['placeholder'=>'Hausnummer', 'class' =>'form-control form-control-sm', 'name' => "D[_BASKET][ShippingAddress][HNumber]",'value' => $D.SESSION.BASKET.ShippingAddress.HNumber, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
								</div>
								<div class="input-group mb-1">
									{input p=['placeholder'=>'PLZ', 'class' =>'form-control form-control-sm','name' => "D[_BASKET][ShippingAddress][Postcode]",'value' => $D.SESSION.BASKET.ShippingAddress.Postcode, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
									{input p=['placeholder'=>'Stadt', 'class' =>'form-control form-control-sm','name' => "D[_BASKET][ShippingAddress][City]",'value' => $D.SESSION.BASKET.ShippingAddress.City, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
								</div>
								<div class="mb-1">
									{input p=['placeholder'=>'Land', 'class' =>'form-control form-control-sm','name' => "D[_BASKET][ShippingAddress][CountryId]",'value' => $D.SESSION.BASKET.ShippingAddress.CountryId, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
								</div>
								<div class="mb-1">
									{input p=['placeholder'=>'Telefon', 'class' =>'form-control form-control-sm', 'name' => "D[_BASKET][ShippingAddress][Phone]",'value' => $D.SESSION.BASKET.ShippingAddress.Phone, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
								</div>
								<div class="mb-1">
									{input p=['placeholder'=>'E-Mail', 'class' =>'form-control form-control-sm','name' => "D[_BASKET][ShippingAddress][Mail]",'value' => $D.SESSION.BASKET.ShippingAddress.Mail, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-12 col-sm-12">
						<i class="fas fa-money-bill-alt"> Zahlungsart</i><br>
						
						{foreach from=$D.PAYMENT.D key="kPAY" item="PAY" name="PAY"}
							{$_PAY[] = "{$kPAY}|{$PAY.LANGUAGE.D['DE'].Title}"}
						{/foreach}
						{input p=[ 'name' => 'D[_BASKET][PaymentId]', 'type' => 'select', 'option' => $_PAY, 'value' => $D.SESSION.BASKET.PaymentId, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
						
					{*</div>
					<div class="col-12 col-sm-6">*}
						<i class="fas fa-dolly"> Varsandart</i>
						{foreach from=$D.SHIPPING.D key="kSHI" item="SHI" name="SHI"}
							{$_SHI[] = "{$kSHI}|{$SHI.LANGUAGE.D['DE'].Title} ({$SHI.Price} €)"}
						{/foreach}
						{input p=['name' => 'D[_BASKET][ShippingId]', 'type' => 'select', 'option' => $_SHI, 'value' => $D.SESSION.BASKET.ShippingId, 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });"]}
					</div>
				</div>
			</div>
			<div class="col">
			
				
	
				<i class="fas fa-shopping-basket"> Warenkorb</i>
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
							<th scope="col" style="width:10%">Preis</th>
						</tr>
					</thead>
					<tbody class="table-group-divider">
						{foreach from=$D.SESSION.BASKET.ARTICLE.D key="kART" item="ART" name="ART"}
						<tr>
							<th scope="row">{$smarty.foreach.ART.iteration}</th>
							<td>{input p=['value' => 1, 'type' => 'checkbox']}</td>
							<td>
							{$Pics = json_decode($D.ARTICLE.D[$kART].ATTRIBUTE.D['Image'].Value,true)}
							
							{if $Pics[0]}
								<picture> 
									<source srcset="/file/{$Pics[0]}_50x50.avif" type="image/avif"/>
									<source srcset="/file/{$Pics[0]}_50x50.webp" type="image/webp"/>
									<img src="/file/{$Pics[0]}_50x50.jpg" style="image-rendering: pixelated;"/>
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
							<td>{$D.ARTICLE.D[$kART].CUSTOMERGROUP.D[0].Price|string_format:"%.2f"} €</td>
							<td>{input p=['name' => "D[_BASKET][ARTICLE][D][{$kART}][Stock]", 'onchange'=>"wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });", 'value' => $ART.Stock ]}</td>
							{*<td>{($D.ARTICLE.D[$kART].ATTRIBUTE.D['Price'].Value*$ART.Stock)|string_format:"%.2f"} €</td>*}
							<td>{($D.ARTICLE.D[$kART].CUSTOMERGROUP.D[0].Price*$ART.Stock)|string_format:"%.2f"} €</td>
						</tr>
						{$_SUM = $_SUM + $D.ARTICLE.D[$kART].CUSTOMERGROUP.D[0].Price*$ART.Stock}
						{/foreach}
					</tbody>
					<tfoot class="table-light table-group-divider">
						<tr>
							<th scope="row"></th>
							<td></td>
							<td></td>
							<td>Versand DHL</td>
							<td>0%</td>
							<td></td>
							<td></td>
							<td>5,99€</td>
						</tr>
						<tr>
							<th scope="row"></th>
							<td></td>
							<td></td>
							<td>Zahlungsart Vorkasse</td>
							<td></td>
							<td></td>
							<td></td>
							<td>0,00€</td>
						</tr>
						{*
						<tr>
							<th scope="row"></th>
							<td></td>
							<td></td>
							<td>Gutschein 10%</td>
							<td></td>
							<td></td>
							<td></td>
							<td>-10,55€</td>
						</tr>*}
						<tr>
							<th scope="row"></th>
							<td></td>
							<td></td>
							<td>Summe</td>
							<td></td>
							<td></td>
							<td></td>
							<td>{($_SUM+5.99)|string_format:"%.2f"}€</td>
						</tr>
					</tfoot>
				</table>
				{input p=['type' => 'checkbox']} Ich akzeptiere AGB und Datenschutz<br>
				{if count((array)$D.SESSION.BASKET.ARTICLE.D) > 0}
					{*
				<button type="button" class="btn btn-warning" onclick="wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=send_basket2Mail', 'data' : $('form').serialize() }); alert('Vielen Dank für Ihre Anfrage, wir werden uns bei Ihen dann melden.');location.href = '{$D.BasePath}'; ">Anfragen</button>
				*}
				<div style="float:Right;">
				<button type="button" class="btn btn-warning" onclick="wp.ajax({ 'div' : 'OrderNr', 'url' : '{$D.BasePath}io?D[ACTION]=buy_basket', 'data' : $('form').serialize() });$('#basket').hide();$('#thankyou').show(); ">Jetzt Kaufen</button>
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