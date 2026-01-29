{block name="inner_body" prepend}
	{*
	<div class="card mb-4 bg-light border-0">
		<div class="card-body p-9">
			<h1 class="mb-0 fs-1">Kategorie Name</h1>
		</div>
	</div>*}


	<div class="d-lg-flex justify-content-between align-items-center">
		<div class="mb-3 mb-lg-0">
			<p class="mb-0">
				<span class="text-dark">{$D.ARTICLE._PARENT_COUNT}</span> Products
			</p>
		</div>

		<form method="post">
		<div class="d-md-flex justify-content-between align-items-center">
			<div class="d-flex mt-2 mt-lg-0">
				<div class="me-2 flex-grow-1">
					<select class="form-select" onchange="this.form.submit()" name="D[_STEP]">
						<option value="10" {if $D['_ARTICLE']['STEP'] == 10}selected{/if}>10</option>
						<option value="20" {if $D['_ARTICLE']['STEP'] == 20}selected{/if}>20</option>
						<option value="30" {if $D['_ARTICLE']['STEP'] == 30}selected{/if}>30</option>
						<option value="50" {if $D['_ARTICLE']['STEP'] == 50}selected{/if}>50</option>
					</select>
				</div>{*
				<div>
					<select class="form-select">
						<option selected="">Sort by: Featured</option>
						<option value="Low to High">Price: Low to High</option>
						<option value="High to Low">Price: High to Low</option>
						<option value="Release Date">Release Date</option>
						<option value="Avg. Rating">Avg. Rating</option>
					</select>
				</div>*}
			</div>
		</div>
		</form>
	</div>

	<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center mt-2">

		{foreach from=$D.ARTICLE['ParentId'].D[NULL].ARTICLE.D key="kART" item="ART"}
		
		
		<div class="col p-2">
			<div class="card h-100">
				<div class="card-body text-center">
					<div class="position-absolute top-1 start-1">
						<span class="badge bg-danger">Sale</span>
			 		</div>
					<a href="{$ART.ATTRIBUTE.D['Url'].LANGUAGE.D['DE'].Value}">
						{$Pics = json_decode($ART.ATTRIBUTE.D['Image'].Value,true)}
						{if $Pics[0]}
							<picture> 
								<source srcset="file/{$Pics[0]}_300x300.avif" type="image/avif"/>
								<source srcset="file/{$Pics[0]}_300x300.webp" type="image/webp"/>
								<img src="file/{$Pics[0]}_300x300.jpg" style="width:100%;image-rendering: pixelated;" alt="{$ART.ATTRIBUTE.D['Title'].LANGUAGE.D['DE'].Value}"/>
							</picture>
						{/if}
					</a>
					<div style="height:50px;overflow:hidden;">
						{$_ab = false}
						{$_Price = $ART.CUSTOMERGROUP.D['0'].Price}
						{foreach from=$D.ARTICLE['ParentId'].D[ $kART ].ARTICLE.D key="kVART" item="VART"}
							{strip}
								{if $_Price == 0 || $_Price > $VART.CUSTOMERGROUP.D['0'].Price}
									{$_Price = $VART.CUSTOMERGROUP.D['0'].Price}
								{/if}
								{if $_Price > 0 && $_Price != $VART.CUSTOMERGROUP.D['0'].Price}{$_ab = true}{/if}

							{$sVG = explode('|', $ART.ATTRIBUTE.D['VarianteGroup'].Value)}
							{$VTitle = ''}
							{foreach from=$sVG key="kVG" item="VG"}
								{if $VART.ATTRIBUTE.D[$VG].LANGUAGE.D['DE'].Value}
									{$VTitle = "{$VTitle} {$VART.ATTRIBUTE.D[$VG].LANGUAGE.D['DE'].Value}"}
								{else}
									{$VTitle = "{$VTitle} {$VART.ATTRIBUTE.D[$VG].Value}"}
								{/if}
							{/foreach}
							{$vPics = json_decode($VART.ATTRIBUTE.D['Image'].Value,true)}
							<a href="{$VART.ATTRIBUTE.D['Url'].LANGUAGE.D['DE'].Value}" title="{$VTitle}">
								<picture> 
									<source srcset="file/{$vPics[0]}_100x100.avif" type="image/avif"/>
									<source srcset="file/{$vPics[0]}_100x100.webp" type="image/webp"/>
									<img src="file/{$vPics[0]}_100x100.jpg" class="img-thumbnail" style="width:50px;" alt="{$VART.ATTRIBUTE.D['Title'].LANGUAGE.D['DE'].Value} - {$VTitle}"/>
								</picture>
							</a>
							{/strip}
						{/foreach}
					</div>
					<div class="text-small mb-1">
						{*<a href="#!" class="text-decoration-none text-muted"><small>Snack &amp; Munchies</small></a>*}
					</div>
					<h2 class="card-title fs-6">{$ART.ATTRIBUTE.D['Title'].LANGUAGE.D['DE'].Value}</h2>

					{*<small class="text-warning">★★★★☆</small><span class="text-muted small">4.5(149)</span>*}
{*
					<div>{count((array)$D.ARTICLE['ParentId'].D[$kART].ARTICLE.D)} <br>
						<ul>
						{foreach from=$D.ARTICLE['ParentId'].D[$kART].ARTICLE.D key="kVAR" item="VAR"}
							<li>{$VAR.ATTRIBUTE.D['Title'].LANGUAGE.D['DE'].Value}</li>
						{/foreach}
					</ul>
					</div>*}

				</div>

				<div class="card-footer text-muted bg-white border-white">
					<div class="d-flex justify-content-between align-items-center">
						<div>
							<span class="text-dark fw-bold">{if $_Price}{if $_ab}ab {/if} {$_Price} €{/if} {*(1,55€/St)*}</span>
						</div>
						<div>
						<a class="btn btn-primary btn-sm" href="{$D['SEO_URL']}?R[ACTION]=addMemo&D[ACCOUNT][D][{$D.SESSION.AccountId}][MEMO][D][A][ARTICLE][D][{$kART}][Active]=1">&#128270; in die Wunschliste</a>
							<a class="btn btn-primary btn-sm" href="{$ART.ATTRIBUTE.D['Url'].LANGUAGE.D['DE'].Value}">&#128270; View</a>
						</div>
					</div>
				</div>

			</div>
		</div>
		
		{/foreach}
	</div>


	<div class="row mt-8">
		<div class="col">
			<!-- nav -->
			{*
			<nav>
				<ul class="pagination">
					<li class="page-item disabled">
						<a class="page-link mx-1" href="#" aria-label="Previous">◁</a>
					</li>
					<li class="page-item"><a class="page-link mx-1 active" href="#">1</a></li>
					<li class="page-item"><a class="page-link mx-1" href="#">2</a></li>

					<li class="page-item"><a class="page-link mx-1" href="#">...</a></li>
					<li class="page-item"><a class="page-link mx-1" href="#">12</a></li>
					<li class="page-item">
						<a class="page-link mx-1" href="#" aria-label="Next">▷</a>
					</li>
				</ul>
			</nav>
			*}
		</div>
	</div>
{/block}