
{block name="inner_body"}




<div class="container mb-5">

    <!-- Checkout Progress -->
    <div class="row mb-4">
        <div class="col">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item">1. Anschrift</li>
                <li class="breadcrumb-item active">2. Versand & Zahlung</li>
                <li class="breadcrumb-item">3. Prüfen & Bestellen</li>
            </ol>
        </div>
    </div>

    <!-- Page Title -->
    <div class="row mb-3">
        <div class="col">
            <h1 class="h3">Schritt 2: Versand & Zahlung</h1>
            <p class="text-muted mb-0">Bitte wählen Sie Ihre Versand- und Zahlungsart.</p>
        </div>
    </div>

    <div class="row">
        <!-- Main Content -->
        <div class="col-lg-8 mb-4">

            <form action="?R[Page]=frontend__checkout_step3&R[ModuleId]=papp/shop" method="post" class="card">
                <div class="card-body">

                    <!-- Versandarten -->
                    <h2 class="h5 mb-3">Versandart</h2>

                    <div class="list-group mb-4">

                        <label class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <input class="form-check-input me-2" type="radio" name="R[BASKET][ShippingId]" value="standard" {if $D.SESSION.BASKET.ShippingId == 'standard'}checked{/if} required>
                                Standardversand (2–3 Werktage)
                            </div>
                            <strong>4,90 €</strong>
                        </label>
{*
                        <label class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <input class="form-check-input me-2" type="radio" name="shipping" value="express" required>
                                Expressversand (1 Werktag)
                            </div>
                            <strong>9,90 €</strong>
                        </label>

                        <label class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <input class="form-check-input me-2" type="radio" name="shipping" value="pickup" required>
                                Abholung im Store
                            </div>
                            <strong>0,00 €</strong>
                        </label>
*}
                    </div>

                    <hr class="my-4">

                    <!-- Zahlungsarten -->
                    <h2 class="h5 mb-3">Zahlungsart</h2>

                    <div class="list-group mb-4">
{*
                        <label class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <input class="form-check-input me-2" type="radio" name="payment" value="paypal" required>
                                PayPal
                            </div>
                            <img src="https://www.paypalobjects.com/webstatic/mktg/logo/pp_cc_mark_111x69.jpg" height="30" alt="">
                        </label>

                        <label class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <input class="form-check-input me-2" type="radio" name="payment" value="creditcard" required>
                                Kreditkarte (Visa, Mastercard)
                            </div>
                            <span class="text-muted small">Sicher verschlüsselt</span>
                        </label>

                        <label class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <input class="form-check-input me-2" type="radio" name="payment" value="invoice" required>
                                Kauf auf Rechnung
                            </div>
                            <span class="text-muted small">Bonitätsprüfung</span>
                        </label>
*}
						<label class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <input class="form-check-input me-2" type="radio" name="R[BASKET][PaymentId]" {if $D.SESSION.BASKET.PaymentId == 'invoice'}checked{/if} value="invoice" required>
                                Vorkasse
                            </div>
                            <span class="text-muted small"></span>
                        </label>

                    </div>

                </div>

                <div class="card-footer d-flex justify-content-between">
                    <a href="?R[Page]=frontend__checkout_step1&R[ModuleId]=papp/shop" class="btn btn-outline-secondary">Zurück zur Anschrift</a>
{input p=['type' => 'hidden', 'name' => 'R[ACTION]', 'value'=> 'addToBasket']}
                    <button type="submit" class="btn btn-primary">
                        Weiter zu Prüfen &amp; Bestellen
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
                        Alle Preise inkl. MwSt. – Die Versandkosten können je nach Auswahl variieren.
                    </p>
                </div>
            </div>
        </div>
*}
    </div>
</div>





	{/block}