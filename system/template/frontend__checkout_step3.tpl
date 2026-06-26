
{block name="inner_body"}

<div class="container mb-5">

    <!-- Checkout Progress -->
    <div class="row mb-4">
        <div class="col">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item">1. Anschrift</li>
                <li class="breadcrumb-item">2. Versand & Zahlung</li>
                <li class="breadcrumb-item active">3. Prüfen & Bestellen</li>
            </ol>
        </div>
    </div>

    <!-- Page Title -->
    <div class="row mb-3">
        <div class="col">
            <h1 class="h3">Schritt 3: Prüfen & Bestellen</h1>
            <p class="text-muted mb-0">Bitte überprüfen Sie Ihre Angaben und schließen Sie die Bestellung ab.</p>
        </div>
    </div>

    <div class="row">
        <!-- Main Content -->
        <div class="col-lg-8 mb-4">

            <form action="?R[Page]=frontend__checkout_thankyou&R[ModuleId]=fremeo/shop" method="post" class="card">
                <div class="card-body">

                    <!-- Anschrift -->
                    <h2 class="h5 mb-3">Ihre Anschrift</h2>
					<div class="row">
						<div class="col-md-6">
							<h2 class="h5 mb-3">Rechnungsadresse</h2>
							<div class="border rounded p-3 mb-4 bg-light">
								<strong>{$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].FName} {$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].LName}</strong><br>
								{$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].Company}<br>
								{$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].LName} {$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].HNumber}<br>
								{$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].Postcode} {$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].City}<br>
								{$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].CountryId}<br>
								{$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].Phone}<br>
								<small class="text-muted">E-Mail: {$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].Mail}</small>
							</div>
						</div>
						<div class="col-md-6">
							<h2 class="h5 mb-3">Lieferadresse</h2>
							<div class="border rounded p-3 mb-4 bg-light">
								<strong>{$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].DELIVERY.D[0].FName} {$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].DELIVERY.D[0].LName}</strong><br>
								{$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].DELIVERY.D[0].Company}<br>
								{$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].DELIVERY.D[0].LName} {$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].DELIVERY.D[0].HNumber}<br>
								{$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].DELIVERY.D[0].Postcode} {$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].DELIVERY.D[0].City}<br>
								{$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].DELIVERY.D[0].CountryId}<br>
								{$D.SESSION.BASKET.ORDER.D[{$D.SESSION.OrderId}].DELIVERY.D[0].Phone}<br><br>
							</div>
						</div>
					</div>
                    
                    
<div class="row">
	<div class="col-md-6">
                    <!-- Zahlungsart -->
                    <h2 class="h5 mb-3">Zahlungsart</h2>

                    <div class="border rounded p-3 mb-4 bg-light">
                        PayPal<br>
                        <small class="text-muted">Sichere Online-Zahlung</small>
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
                    <!-- Warenkorb -->
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
{foreach from=$D.SESSION.BASKET.ORDER.D[ $D.SESSION.OrderId ].ARTICLE.D key="kART" item="ART" name="ART"}
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
                                    <td class="text-end"><nobr>{$D.ARTICLE.D[$kART].CUSTOMERGROUP.D[0].Price|string_format:"%.2f"} €</nobr></td>
                                    <td class="text-end">{$ART.Stock}</td>
                                    <td class="text-end"><nobr>{($D.ARTICLE.D[$kART].CUSTOMERGROUP.D[0].Price*$ART.Stock)|string_format:"%.2f"} €</nobr></td>
                                </tr>
{/foreach}
                            </tbody>
                        </table>
                    </div>

                    <!-- Rechtliche Hinweise -->
                    <div class="mb-4">
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" id="agb" required>
                            <label class="form-check-label" for="agb">
                                Ich habe die <a href="#">AGB</a> gelesen und akzeptiere sie.
                            </label>
                        </div>

                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" id="revocation" required>
                            <label class="form-check-label" for="revocation">
                                Ich habe die <a href="#">Widerrufsbelehrung</a> zur Kenntnis genommen.
                            </label>
                        </div>

                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="privacy" required>
                            <label class="form-check-label" for="privacy">
                                Ich stimme der Verarbeitung meiner Daten gemäß der <a href="#">Datenschutzerklärung</a> zu.
                            </label>
                        </div>
                    </div>

                </div>

                <!-- Button-Lösung (gesetzlich vorgeschrieben) -->
				<div class="card-footer d-flex justify-content-between">
                    <a href="?R[Page]=frontend__checkout_step2&R[ModuleId]=fremeo/shop" class="btn btn-outline-secondary">Zurück</a>
{input p=['type' => 'hidden', 'name' => 'R[ACTION]', 'value'=> 'goCheckout']}
                    <button type="submit" class="btn btn-warning">
                        Kaufen
                    </button>
                </div>
            </form>
        </div>
{*
        <!-- Sidebar: Order Summary -->
        <div class="col-lg-4">
            <div class="card">
                <div class="card-header">
                    Bestellübersicht
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between mb-1">
                        <span>Zwischensumme</span>
                        <strong>99,00 €</strong>
                    </div>
                    <div class="d-flex justify-content-between mb-1">
                        <span>Versand</span>
                        <strong>4,90 €</strong>
                    </div>
                    <div class="d-flex justify-content-between border-top pt-2 mt-2">
                        <span>Gesamt</span>
                        <strong>103,90 €</strong>
                    </div>
                    <p class="text-muted small mt-2 mb-0">
                        Alle Preise inkl. MwSt. – Mit Klick auf „zahlungspflichtig bestellen“ schließen Sie den Kauf ab.
                    </p>
                </div>
            </div>
        </div>
*}
    </div>
</div>

	{/block}