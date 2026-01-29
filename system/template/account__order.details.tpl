
{block name="account_body"}
	<form method="post">

	{foreach from=$D.ACCOUNT.D key="kACC" item="ACC"}

		{foreach from=$ACC.ORDER.D key="kD" item="D" name="D"}
<!-- Anschrift -->
					<div class="row">
						<div class="col-md-6">
							<h2 class="h5 mb-3">Rechnungsadresse</h2>
							<div class="border rounded p-3 mb-4 bg-light">
								<strong>{$D.FName} {$D.LName}</strong><br>
								{$D.Company}<br>
								{$D.LName} {$D.HNumber}<br>
								{$D.Postcode} {$D.City}<br>
								{$D.CountryId}<br>
								{$D.Phone}<br>
								<small class="text-muted">E-Mail: {$D.Mail}</small>
							</div>
						</div>
						<div class="col-md-6">
							<h2 class="h5 mb-3">Lieferadresse</h2>
							<div class="border rounded p-3 mb-4 bg-light">
								<strong>{$D.FName} {$D.LName}</strong><br>
								{$D.Company}<br>
								{$D.LName} {$D.HNumber}<br>
								{$D.Postcode} {$D.City}<br>
								{$D.CountryId}<br>
								{$D.Phone}<br><br>
							</div>
						</div>
					</div>


<div class="row">
	<div class="col-md-6">
                    <!-- Zahlungsart -->
                    <h2 class="h5 mb-3">Zahlungsart</h2>

                    <div class="border rounded p-3 mb-4 bg-light">
                        Vorkasse<br>
                        <small class="text-muted">&nbsp;</small>
                    </div>
	</div>
	<div class="col-md-6">
<!-- Versandart -->
					<h2 class="h5 mb-3">Versandart</h2>
                    <div class="border rounded p-3 mb-4 bg-light">
                        Standardversand (2–3 Werktage)<br>
                        <strong>4,90 €</strong>
                    </div>
	</div>

</div>

<h2 class="h5 mb-3">Ihre Artikel</h2>
<div class="table-responsive mb-4">
                        <table class="table align-middle">
                            <thead>
                                <tr>
									<th>Pos</th>
                                    <th>Artikel</th>
                                    <th class="text-end">Preis</th>
                                    <th class="text-end">Menge</th>
                                    <th class="text-end">Summe</th>
                                </tr>
                            </thead>
                            <tbody>
{foreach from=$D.ARTICLE.D key="kART" item="ART" name="ART"}
                                <tr>
                                    <td>{$smarty.foreach.ART.iteration}</td>
                                    <td>{$D.ARTICLE.D[$kART].ATTRIBUTE.D['Title'].LANGUAGE.D['DE'].Value}
										{*Varianten Bezeichnung*}
										{if $D.ARTICLE.D[ $D.ARTICLE.D[$kART].ParentId ].ATTRIBUTE.D['VarianteGroup'].Value}
											<br>
											{$sVG = explode('|', $D.ARTICLE.D[ $D.ARTICLE.D[$kART].ParentId ].ATTRIBUTE.D['VarianteGroup'].Value)}
											{foreach from=$sVG key="kVG" item="VG"}
												<b>{$D.ARTICLE.D[$kART].ATTRIBUTE.D[$VG].LANGUAGE.D['DE'].Value}</b>
											{/foreach}
										{/if}
									</td>
                                    <td class="text-end"><nobr>{$ART.Price|string_format:"%.2f"} €</nobr></td>
                                    <td class="text-end">{$ART.Stock}</td>
                                    <td class="text-end"><nobr>{($ART.Price*$ART.Stock)|string_format:"%.2f"} €</nobr></td>
                                </tr>
{/foreach}
                            </tbody>
                        </table>
                    </div>




	
		{/foreach}
	
		
		
	{/foreach}
	</form>
	{/block}
