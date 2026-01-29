<?php

class CShop
{
    /** @var CData */
    protected $cdata;

    public function __construct($cdata)
    {
        $this->cdata = $cdata;
    }
	/*
	public function addToMemo($D) : void {
		if ($this->isUserLoggedIn()) {
            $this->cdata->set_data($D);
        }
	}*/

    /* ============================================================
     *  WARENKORB (SESSION)
     *  Struktur: $_SESSION['BASKET']['ARTICLE']['D'][$articleId]
     * ============================================================ */
	public function updateBasket(array $R): void
    {
		$_SESSION['BASKET'] = array_replace_recursive((array)($_SESSION['BASKET']??[]),(array)$R['BASKET']);
		
    }


    public function addToBasket(array $articleId, int $qty = 1): void
    {
        if (!isset($_SESSION['BASKET']['ARTICLE']['D'][$articleId])) {
            $_SESSION['BASKET']['ARTICLE']['D'][$articleId] = [
                'Stock'       => 0,
            ];
        }

        $_SESSION['BASKET']['ARTICLE']['D'][$articleId]['Stock'] += $qty;

        if ($this->isUserLoggedIn()) {
            $this->saveBasketToDb();
        }
    }

    public function removeFromBasket(string $articleId): void
    {
        unset($_SESSION['BASKET']['ARTICLE']['D'][$articleId]);

        if ($this->isUserLoggedIn()) {
            $this->saveBasketToDb();
        }
    }

    public function getBasket(): array
    {
        return $_SESSION['BASKET'] ?? [];
    }

    protected function clearBasketSession(): void
    {
        unset($_SESSION['BASKET']);
    }

    protected function isUserLoggedIn(): bool
    {
        return !empty($_SESSION['UserId']) && !empty($_SESSION['AccountId']);
    }

    /* ============================================================
     *  WARENKORB → DB SPEICHERN
     *  Struktur:
     *  ACCOUNT.D[AccountId].BASKET.D[BasketId].ARTICLE.D[ArticleId].QTY / ATTRIBUTE.D[AttrKey].Value
     * ============================================================ */

    public function saveBasketToDb(): void
    {
        if (!$this->isUserLoggedIn()) {
            return;
        }

        $accountId = $_SESSION['AccountId'];
        $basket    = $this->getBasket();

        if (empty($basket)) {
            // Wenn leer → Basket in DB löschen
            $this->clearBasketInDb($accountId);
            return;
        }

       # $this->ensureBasketId(); #hash('crc32b', hrtime(true))
        #$basketId = $this->getBasketId();

        $D = [];

        $D['ACCOUNT']['D'][$accountId]['BASKET']['D'][$basketId]['Active'] = 1;

        foreach ($basket as $articleId => $item) {
            $qty        = $item['QTY'] ?? 0;
            $attributes = $item['ATTRIBUTE'] ?? [];

            $D['ACCOUNT']['D'][$accountId]['BASKET']['D'][$basketId]['ARTICLE']['D'][$articleId]['QTY'] = $qty;

            foreach ($attributes as $attrKey => $attrValue) {
                $D['ACCOUNT']['D'][$accountId]['BASKET']['D'][$basketId]['ARTICLE']['D'][$articleId]['ATTRIBUTE']['D'][$attrKey]['Value'] = $attrValue;
            }
        }

        $this->cdata->set_data($D);
    }

    /* ============================================================
     *  WARENKORB → DB LADEN
     *  Lädt ersten vorhandenen Basket des Accounts
     * ============================================================ */

    public function loadBasketFromDb(): void
    {
        if (!$this->isUserLoggedIn()) {
            return;
        }

        $accountId = $_SESSION['AccountId'];

        $D = [];
        $F = [];

        $F['ACCOUNT']['W'][0]['ID'] = $accountId;
        $F['ACCOUNT']['BASKET']['ARTICLE']['ATTRIBUTE'] = [];

        $this->cdata->get_data($D, $F);

        $_SESSION['BASKET']['ARTICLE']['D'] = [];
        unset($_SESSION['BASKET_ID']);

        if (empty($D['ACCOUNT']['D'][$accountId]['BASKET']['D'])) {
            return;
        }

        // Ersten Basket nehmen
        $basketList = $D['ACCOUNT']['D'][$accountId]['BASKET']['D'];
        $basketId   = array_key_first($basketList);
        $_SESSION['BASKET_ID'] = $basketId;

        $basketRow = $basketList[$basketId];

        if (!empty($basketRow['ARTICLE']['D'])) {
            foreach ($basketRow['ARTICLE']['D'] as $articleId => $row) {
                $qty        = $row['QTY'] ?? 0;
                $attributes = [];

                if (!empty($row['ATTRIBUTE']['D'])) {
                    foreach ($row['ATTRIBUTE']['D'] as $attrKey => $attrRow) {
                        $attributes[$attrKey] = $attrRow['Value'] ?? null;
                    }
                }

                $_SESSION['BASKET']['ARTICLE']['D'][$articleId] = [
                    'QTY'       => $qty,
                    'ATTRIBUTE' => $attributes,
                ];
            }
        }
    }

    /* ============================================================
     *  BESTELLUNG ERZEUGEN
     *  Struktur:
     *  ACCOUNT.D[AccountId].ORDER.D[OrderId].ARTICLE.D[ArticleId].QTY / ATTRIBUTE.D[AttrKey].Value
     * ============================================================ */

    public function placeOrder(string $orderId): void
    {
        if (!$this->isUserLoggedIn()) {
            throw new \RuntimeException('User must be logged in to place an order.');
        }

        $accountId = $_SESSION['AccountId'];
        $basket    = $this->getBasket();

        if (empty($basket)) {
            throw new \RuntimeException('Basket is empty.');
        }

        $D = [];

        $D['ACCOUNT']['D'][$accountId]['ORDER']['D'][$orderId]['Active'] = 1;
        $D['ACCOUNT']['D'][$accountId]['ORDER']['D'][$orderId]['Date']   = date('Y-m-d H:i:s');

        foreach ($basket as $articleId => $item) {
            $qty        = $item['QTY'] ?? 0;
            $attributes = $item['ATTRIBUTE'] ?? [];

            $D['ACCOUNT']['D'][$accountId]['ORDER']['D'][$orderId]['ARTICLE']['D'][$articleId]['QTY'] = $qty;

            foreach ($attributes as $attrKey => $attrValue) {
                $D['ACCOUNT']['D'][$accountId]['ORDER']['D'][$orderId]['ARTICLE']['D'][$articleId]['ATTRIBUTE']['D'][$attrKey]['Value'] = $attrValue;
            }
        }

        $this->cdata->set_data($D);

        $this->clearBasketInDb($accountId);
        $this->clearBasketSession();
    }

    protected function clearBasketInDb(string $accountId): void
    {
        $basketId = $this->getBasketId();
        if (!$basketId) {
            return;
        }

        $D = [];
        $D['ACCOUNT']['D'][$accountId]['BASKET']['D'][$basketId]['__DELETE__'] = 1;
        $this->cdata->set_data($D);
    }
}
