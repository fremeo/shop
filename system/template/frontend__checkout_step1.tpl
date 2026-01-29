
{block name="inner_body" prepend}

<div class="container mb-5">

    <!-- Checkout Progress -->
    <div class="row mb-4">
        <div class="col">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item active">1. Anschrift</li>
                <li class="breadcrumb-item">2. Versand & Zahlung</li>
                <li class="breadcrumb-item">3. Prüfen & Bestellen</li>
            </ol>
        </div>
    </div>

    <!-- Page Title -->
    <div class="row mb-3">
        <div class="col">
            <h1 class="h3">Schritt 1: Ihre Anschrift</h1>
            <p class="text-muted mb-0">Bitte geben Sie Ihre Rechnungs- und ggf. Lieferanschrift an.</p>
        </div>
    </div>

    <div class="row">
        <!-- Address Form -->
        <div class="col-lg-8 mb-4">
            <form action="?R[Page]=frontend__checkout_step2&R[ModuleId]=papp/shop" method="post" class="card">
                <div class="card-body">

                    <!-- Rechnungsadresse -->
                    <h2 class="h5 mb-3">Rechnungsadresse</h2>

                    <div class="row g-3">
                        
                        <div class="col-md-4">
                            <label for="firstname" class="form-label">Vorname *</label>
                            <input type="text" class="form-control" id="firstname" name="R[BASKET][ORDER][D][{$D.SESSION.OrderId}][FName]" value="{$D.SESSION.BASKET.ORDER.FName}" required>
                        </div>

                        <div class="col-md-8">
                            <label for="lastname" class="form-label">Nachname *</label>
                            <input type="text" class="form-control" id="lastname" name="R[BASKET][ORDER][D][{$D.SESSION.OrderId}][LName]" value="{$D.SESSION.BASKET.ORDER.LName}" required>
                        </div>

                        <div class="col-12">
                            <label for="company" class="form-label">Firma (optional)</label>
                            <input type="text" class="form-control" id="company" name="R[BASKET][ORDER][D][{$D.SESSION.OrderId}][Company]" value="{$D.SESSION.BASKET.ORDER.Company}">
                        </div>

                        <div class="col-9">
                            <label for="street" class="form-label">Straße *</label>
                            <input type="text" class="form-control" id="street" name="R[BASKET][ORDER][D][{$D.SESSION.OrderId}][LName]" value="{$D.SESSION.BASKET.ORDER.LName}" required>
                        </div>
						
						<div class="col-md-3">
                            <label for="zip" class="form-label">Hausnummer *</label>
                            <input type="text" class="form-control" id="zip" name="R[BASKET][ORDER][D][{$D.SESSION.OrderId}][HNumber]" value="{$D.SESSION.BASKET.ORDER.HNumber}" required>
                        </div>

                        <div class="col-md-3">
                            <label for="zip" class="form-label">PLZ *</label>
                            <input type="text" class="form-control" id="zip" name="R[BASKET][ORDER][D][{$D.SESSION.OrderId}][Postcode]" value="{$D.SESSION.BASKET.ORDER.Postcode}" required>
                        </div>

                        <div class="col-md-9">
                            <label for="city" class="form-label">Ort *</label>
                            <input type="text" class="form-control" id="city" name="R[BASKET][ORDER][D][{$D.SESSION.OrderId}][City]" value="{$D.SESSION.BASKET.ORDER.City}" required>
                        </div>

                        <div class="col-md-6">
                            <label for="country" class="form-label">Land *</label>
                            <select id="country" name="R[BASKET][ORDER][D][{$D.SESSION.OrderId}][CountryId]" class="form-select" required>
                                <option value="">Bitte wählen</option>
                                <option value="DE" {if $D.SESSION.BASKET.ORDER.CountryId == 'DE'}selected{/if}>Deutschland</option>
                                <option value="AT" {if $D.SESSION.BASKET.ORDER.CountryId == 'AT'}selected{/if}>Österreich</option>
                                <option value="CH" {if $D.SESSION.BASKET.ORDER.CountryId == 'CH'}selected{/if}>Schweiz</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label for="phone" class="form-label">Telefon (für Rückfragen)</label>
                            <input type="tel" class="form-control" id="phone" name="R[BASKET][ORDER][D][{$D.SESSION.OrderId}][Phone]" value="{$D.SESSION.BASKET.ORDER.Phone}">
                        </div>

                        <div class="col-12">
                            <label for="email" class="form-label">E-Mail-Adresse *</label>
                            <input type="email" class="form-control" id="email" name="R[BASKET][ORDER][D][{$D.SESSION.OrderId}][Mail]" value="{$D.SESSION.BASKET.ORDER.Mail}" required>
                            <div class="form-text">Wir senden Ihnen die Bestellbestätigung an diese Adresse.</div>
                        </div>
                    </div>

                    <hr class="my-4">

                    <!-- Lieferadresse -->
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" value="1" id="differentShipping" name="different_shipping">
                        <label class="form-check-label" for="differentShipping">
                            Abweichende Lieferadresse verwenden
                        </label>
                    </div>

                    <div id="shippingAddress" class="border rounded p-3 bg-light">
                        <h2 class="h6 mb-3">Lieferadresse</h2>

                        <div class="row g-3">
                            <div class="col-md-4">
                                <label for="shipping_firstname" class="form-label">Vorname *</label>
                                <input type="text" class="form-control" id="shipping_firstname" name="R[BASKET][ORDER][D][{$D.SESSION.OrderId}][DELIVERY][D][0][FName]" value="{$D.SESSION.BASKET.ORDER.D[ $D.SESSION.OrderId ].DELIVERY.D[0].FName}">
                            </div>

                            <div class="col-md-8">
                                <label for="shipping_lastname" class="form-label">Nachname *</label>
                                <input type="text" class="form-control" id="shipping_lastname" name="R[BASKET][ORDER][D][{$D.SESSION.OrderId}][DELIVERY][D][0][LName]" value="{$D.SESSION.BASKET.ORDER.D[ $D.SESSION.OrderId ].DELIVERY.D[0].LName}">
                            </div>

                            <div class="col-9">
                                <label for="shipping_street" class="form-label">Straße *</label>
                                <input type="text" class="form-control" id="shipping_street" name="R[BASKET][ORDER][D][{$D.SESSION.OrderId}][DELIVERY][D][0][Street]" value="{$D.SESSION.BASKET.ORDER.D[ $D.SESSION.OrderId ].DELIVERY.D[0].Street}">
                            </div>
							<div class="col-3">
                                <label for="shipping_street" class="form-label">Hausnummer *</label>
                                <input type="text" class="form-control" id="shipping_street" name="R[BASKET][ORDER][D][{$D.SESSION.OrderId}][DELIVERY][D][0][HNumber]" value="{$D.SESSION.BASKET.ORDER.D[ $D.SESSION.OrderId ].DELIVERY.D[0].HNumber}">
                            </div>

                            <div class="col-md-3">
                                <label for="shipping_zip" class="form-label">PLZ *</label>
                                <input type="text" class="form-control" id="shipping_zip" name="R[BASKET][ORDER][D][{$D.SESSION.OrderId}][DELIVERY][D][0][Postcode]" value="{$D.SESSION.BASKET.ORDER.D[ $D.SESSION.OrderId ].DELIVERY.D[0].Postcode}">
                            </div>

                            <div class="col-md-9">
                                <label for="shipping_city" class="form-label">Ort *</label>
                                <input type="text" class="form-control" id="shipping_city" name="R[BASKET][ORDER][D][{$D.SESSION.OrderId}][DELIVERY][D][0][City]" value="{$D.SESSION.BASKET.ORDER.D[ $D.SESSION.OrderId ].DELIVERY.D[0].City}">
                            </div>

                            <div class="col-md-6">
                                <label for="shipping_country" class="form-label">Land *</label>
                                <select id="shipping_country" name="R[BASKET][ORDER][D][{$D.SESSION.OrderId}][DELIVERY][D][0][CountryId]" class="form-select">
                                    <option value="">Bitte wählen</option>
                                    <option value="DE">Deutschland</option>
                                    <option value="AT">Österreich</option>
                                    <option value="CH">Schweiz</option>
                                </select>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="card-footer d-flex justify-content-between">
                    <a href="basket" class="btn btn-outline-secondary">Zurück zum Warenkorb</a>
					{input p=['type' => 'hidden', 'name' => 'R[ACTION]', 'value'=> 'addToBasket']}
                    <button type="submit" class="btn btn-primary">
                        Weiter zu Versand &amp; Zahlung
                    </button>
                </div>
            </form>
        </div>

        <!-- Sidebar: Order Summary -->
        <div class="col-lg-4">
{*
			<div class="card mb-3">
				<div class="card-header">
                    Login
                </div>
				<div class="card-body">
					
                            <label for="mail" class="form-label">E-Mail</label>
                            <input type="text" class="form-control" id="mail" name="E-Mail" required>
					
                            <label for="passwort" class="form-label">Passwort </label>
                            <input type="text" class="form-control" id="passwort" name="passwort" required>
							
                    <button type="submit" class="btn btn-primary">
                        Login
                    </button>
						
				</div>
			</div>
*}
{*
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
                        Alle Preise inkl. MwSt. – Die endgültigen Versandkosten werden im nächsten Schritt angezeigt.
                    </p>
                </div>
            </div>
*}
        </div>
    </div>
</div>


<script>
// Optional: Lieferadresse-Block ein-/ausblenden
document.addEventListener('DOMContentLoaded', function () {
    const checkbox = document.getElementById('differentShipping');
    const shippingBox = document.getElementById('shippingAddress');

    const toggleShipping = () => {
        shippingBox.style.display = checkbox.checked ? 'block' : 'none';
    };

    toggleShipping();
    checkbox.addEventListener('change', toggleShipping);
});
</script>



	{/block}