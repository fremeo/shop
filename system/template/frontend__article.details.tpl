{block name="inner_body" prepend}
	
	{foreach from=$D.ARTICLE.D key="kART" item="ART"}
		{if $D['_ID'] == $kART}
		<div class="container px-4 px-lg-5 my-5">
			<h1 class="mb-1 fs-3">{$ART.ATTRIBUTE.D['Title'].LANGUAGE.D['DE'].Value}</h1>
			<hr class="my-6">
			<div class="row gx-4 gx-lg-5 align-items-start">
				<div class="col-md-5">

				<div id="carouselExampleIndicators" class="carousel slide carousel-fade">
					<div class="carousel">
						<div class="carousel-inner">
							{$Pics = json_decode($ART.ATTRIBUTE.D['Image'].Value,true)}
							{foreach name="PIC" from=$Pics key="kPIC" item="PIC"}
								<div class="carousel-item {if $smarty.foreach.PIC.iteration==1}active{/if}">
									<picture> 
										<source srcset="file/{$PIC}_500x500.avif" type="image/avif"/>
										<source srcset="file/{$PIC}_500x500.webp" type="image/webp"/>
										<img src="file/{$PIC}_500x500.jpg" class="d-block w-100" alt="{$ART.ATTRIBUTE.D['Title'].LANGUAGE.D['DE'].Value}"/>
									</picture>
								</div>
							{/foreach}
						</div>
						<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
					</div>
					<div class="carousel-indicators rounded-2" style="background:#eee9;position:unset;margin:auto;">
						{$Pics = json_decode($ART.ATTRIBUTE.D['Image'].Value,true)}
						{foreach name="PIC" from=$Pics key="kPIC" item="PIC"}
							<button type="button" style="height:100px;width:100px; background-image:url('file/{$PIC}_100x100.jpg'); background-image: image-set( url('file/{$PIC}_100x100.avif') type('image/avif'), url('file/{$PIC}_100x100.webp') type('image/webp') ); background-repeat:no-repeat; background-position:center;box-sizing:border-box;" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="{$smarty.foreach.PIC.iteration-1}" class="{if $smarty.foreach.PIC.iteration == 1}active{/if} rounded-2" aria-current="true" aria-label="Slide {$smarty.foreach.PIC.iteration}"></button>
						{/foreach}
					</div>
				</div>

				

				</div>
				<div class="col-md-7">
				<form method="post">
					{if $ART.ATTRIBUTE.D['Brand'].LANGUAGE.D['DE'].Value}<a href="#!" class="mb-4 d-block">$ART.ATTRIBUTE.D['Brand'].LANGUAGE.D['DE'].Value</a>{/if}
					
					{*<small class="text-warning">★★★★☆</small><span class="text-muted small">4.5(149)</span>*}
					<div class="small mb-1">{$ART.ATTRIBUTE.D['Sku'].Value}</div>
					

					{if $ART.ParentId}
						{$ParentId = $ART.ParentId}
					{else}
						{$ParentId = $kART}
					{/if}
					{*VARIANTE*}
					{if $D.ARTICLE['ParentId'].D[ $ParentId ].ARTICLE.D}
						{$sVG = explode('|', $D.ARTICLE.D[$ParentId].ATTRIBUTE.D['VarianteGroup'].Value)}
					
						<div style="display:none;">{*URL Links aller Kinder, für SEO*}
							{foreach from=$D.ARTICLE['ParentId'].D[ $ParentId ].ARTICLE.D key="kVART" item="VART"}
								{$Value = ''}
								{foreach from=$sVG key="kVG" item="VG"}
									{*if $D.ATTRIBUTE.D[$VG].I18n*}
									{if $VART.ATTRIBUTE.D[$VG].LANGUAGE.D['DE'].Value}
										{$Value = "{$Value}{$VART.ATTRIBUTE.D[$VG].LANGUAGE.D['DE'].Value}"}
										{$Value1 = "{$VART.ATTRIBUTE.D[$VG].LANGUAGE.D['DE'].Value}"}
									{else}
										{$Value = "{$Value}{$VART.ATTRIBUTE.D[$VG].Value}"}
										{$Value1 = "{$VART.ATTRIBUTE.D[$VG].Value}"}
									{/if}
									
									{if $_var[$VG][$Value1]['Active'] || $kVART == $D['_ID']}
										{$_var[$VG][$Value1]['Active']=1}
									{/if}
									{$Pics = json_decode($VART.ATTRIBUTE.D['Image'].Value,true)}
									{$_var[$VG][$Value1]['Image']=$Pics[0]}
								{/foreach}
									<a id="link{md5($Value)}" href="{$VART.ATTRIBUTE.D['Url'].LANGUAGE.D['DE'].Value}">{$VART.ATTRIBUTE.D['Title'].LANGUAGE.D['DE'].Value} - {$Value}</a><br>
							{/foreach}
						</div>

						{foreach from=$_var name="ATT" key="kATT" item="ATT"}
							<div>{$D.ATTRIBUTE.D[$kATT].LANGUAGE.D['DE'].Title}</div>
							<div class="Variante att-{$smarty.foreach.ATT.index}">
								<div class="btn-group btn-group-sm" role="group" aria-label="Large button group">
								{foreach from=$ATT key="kAVA" item="AVA"}
										<button id="VarButton-{$kATT}{md5($kAVA)}" onclick="openChild('{$kATT}','{md5($kAVA)}')" type="button" class=" btn btn-outline-primary p-1 {if $AVA.Active}active{/if}">
											{if $smarty.foreach.ATT.index == 0}
												<picture> 
												<source srcset="file/{$AVA.Image}_100x100.avif" type="image/avif"/>
												<source srcset="file/{$AVA.Image}_100x100.webp" type="image/webp"/>
												<img src="file/{$AVA.Image}_100x100.jpg" class="d-block w-100" alt="{$ART.ATTRIBUTE.D['Title'].LANGUAGE.D['DE'].Value}"/>
												</picture>
											{/if}
											{$kAVA}
											<input id="cbVarButton-{$kATT}{md5($kAVA)}" name="v{$kATT}" value="{md5($kAVA)}" style="display:none;" type="radio" {if $AVA.Active}checked{/if} onclick="openChild('{$kATT}','{md5($kAVA)}')">
										</button>
								{/foreach}
								</div>
							</div>
						{/foreach}

						<script>
							var oldId = [];
							var openChild = function (aid,id) {
								if(oldId[aid]) {
									$("#VarButton-"+aid+oldId[aid]).removeClass('active');
									$("#cbVarButton-"+aid+oldId[aid]).prop('checked', false);
								}
								oldId[aid] = id;
								
								$("#VarButton-"+aid+id).addClass('active');
								$("#cbVarButton-"+aid+id).prop('checked', true);
								link = '';
								notfound = 0;
								$('.Variante').each( function(index) {
									val = $('.att-'+index+' input:checked').val();
									if(typeof val === "undefined") {
										notfound = 1;
									}
									else {
										link = link+val;
									}
								});
								if(!notfound) {
									lnk = $('#link'+link).attr('href');
									if(typeof lnk !== "undefined") {
										window.open(lnk,'_self');
									}
								}
							}
						</script>
					{/if}

					

					<hr class="my-6">
					

					<div class="bg-light rounded-2 p-2">
						<div class="fs-5 mb-2" style="text-align:right;">
							{if $ART.CUSTOMERGROUP.D['0'].RRPrice}<span class="text-decoration-line-through">{$ART.CUSTOMERGROUP.D['0'].RRPrice}</span>
							{elseif $ART.ATTRIBUTE.D['RRPrice'].Value}UVP: {$ART.ATTRIBUTE.D['RRPrice'].Value} €{/if}
							<span class="fs-3">{if $ART.CUSTOMERGROUP.D['0'].Price}{$ART.CUSTOMERGROUP.D['0'].Price} €{/if}</span>
						</div>
						{*
						<div class="input-group">
							<input type="button" value="-" class="btn btn-sm btn-outline-secondary" data-field="quantity">
							<input type="number" step="1" max="10" value="1" name="D[_BASKET][ARTICLE][D][{$kART}][addStock]" class="form-control-sm">
							<input type="button" value="+" class="btn btn-sm btn-outline-secondary" data-field="quantity">
						</div>

						<div class="mt-3 row justify-content-start g-2 align-items-center">
							
								<button type="button" class="btn btn-warning" onclick="wp.ajax({ 'url' : '{$D.BasePath}io?D[ACTION]=set_basket', 'data' : $('form').serialize() });">
									<i class="fas fa-shopping-basket"></i> in den Warenkorb
								</button>
							
						</div>
						*}
						<div class="mt-3 row justify-content-start g-2 align-items-center">
						<b>Bei Interesse an diesem Produkt freuen wir uns über Ihre Kontaktaufnahme.</b> <a href="./kontakt">Kontakt</a>
						</div>
					</div>
				</form>
				</div>
			</div>
			<div class="row gx-4 gx-lg-5 align-items-start m-2">
				<div class="col-md-12">
					

				
					<ul class="nav nav-pills nav-lb-tab" id="myTab" role="tablist">
					   <!-- nav item -->
					   <li class="nav-item" role="presentation">
						  <!-- btn -->
						  <button class="nav-link active" id="product-tab" data-bs-toggle="tab" data-bs-target="#product-tab-pane" type="button" role="tab" aria-controls="product-tab-pane" aria-selected="true">
							 Product Details
						  </button>
					   </li>
					   {*
					   <!-- nav item -->
					   <li class="nav-item" role="presentation">
						  <!-- btn -->
						  <button class="nav-link" id="details-tab" data-bs-toggle="tab" data-bs-target="#details-tab-pane" type="button" role="tab" aria-controls="details-tab-pane" aria-selected="false" tabindex="-1">
							 Information
						  </button>
					   </li>
					   <!-- nav item -->
					   <li class="nav-item" role="presentation">
						  <!-- btn -->
						  <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews-tab-pane" type="button" role="tab" aria-controls="reviews-tab-pane" aria-selected="false" tabindex="-1">
							 Reviews
						  </button>
					   </li>*}
					</ul>
					<hr class="my-6">
					<!-- tab content -->
					<div class="tab-content" id="myTabContent">
					   <!-- tab pane -->
					   <div class="tab-pane fade active show" id="product-tab-pane" role="tabpanel" aria-labelledby="product-tab" tabindex="0">
						  <div class="my-8">
							 <div class="mb-5">
								{$ART.ATTRIBUTE.D['Description'].LANGUAGE.D['DE'].Value}
							</div>
						  </div>
					   </div>
					   <!-- tab pane -->
					   <div class="tab-pane fade" id="details-tab-pane" role="tabpanel" aria-labelledby="details-tab" tabindex="0">
						  <div class="my-8">
							 <div class="row">
								<div class="col-12">
									<h4 class="mb-4">Details</h4>
								</div>
								<div class="col-12 col-lg-6">
								   <table class="table table-striped">
									  <tbody>
										 <tr>
											<th>Weight</th>
											<td>1000 Grams</td>
										 </tr>
									  </tbody>
								   </table>
								</div>
								<div class="col-12 col-lg-6">
								   <table class="table table-striped">
									  <tbody>
										 <tr>
											<th>ASIN</th>
											<td>SB0025UJ75W</td>
										 </tr>
									  </tbody>
								   </table>
								</div>
							 </div>
						  </div>
					   </div>
					   <!-- tab pane -->
					   <div class="tab-pane fade" id="reviews-tab-pane" role="tabpanel" aria-labelledby="reviews-tab" tabindex="0">
						  <div class="my-8">
							 <!-- row -->
							 <div class="row">
								<div class="col-md-4">
								   <div class="me-lg-12 mb-6 mb-md-0">
									  <div class="mb-5">
										 <!-- title -->
										 <h4 class="mb-3">Customer reviews</h4>
										 <span>
											<!-- rating -->
											<small class="text-warning">★★★★☆</small>
											<span class="ms-3">4.1/5</span>
											<small class="ms-3">115 Bewertungen</small>
										 </span>
									  </div>
									  <div class="mb-8">
										 <!-- progress -->
										 <div class="d-flex align-items-center mb-2">
											<div class="text-nowrap me-3 text-muted">
											   <span class="d-inline-block align-middle text-muted">5</span>
											   <i class="bi bi-star-fill ms-1 small text-warning"></i>
											</div>
											<div class="w-100">
											   <div class="progress" style="height: 6px">
												  <div class="progress-bar bg-warning" role="progressbar" style="width: 60%" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
											   </div>
											</div>
											<span class="text-muted ms-3">53%</span>
										 </div>
										 <!-- progress -->
										 <div class="d-flex align-items-center mb-2">
											<div class="text-nowrap me-3 text-muted">
											   <span class="d-inline-block align-middle text-muted">4</span>
											   <i class="bi bi-star-fill ms-1 small text-warning"></i>
											</div>
											<div class="w-100">
											   <div class="progress" style="height: 6px">
												  <div class="progress-bar bg-warning" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="50"></div>
											   </div>
											</div>
											<span class="text-muted ms-3">22%</span>
										 </div>
										 <!-- progress -->
										 <div class="d-flex align-items-center mb-2">
											<div class="text-nowrap me-3 text-muted">
											   <span class="d-inline-block align-middle text-muted">3</span>
											   <i class="bi bi-star-fill ms-1 small text-warning"></i>
											</div>
											<div class="w-100">
											   <div class="progress" style="height: 6px">
												  <div class="progress-bar bg-warning" role="progressbar" style="width: 35%" aria-valuenow="35" aria-valuemin="0" aria-valuemax="35"></div>
											   </div>
											</div>
											<span class="text-muted ms-3">14%</span>
										 </div>
										 <!-- progress -->
										 <div class="d-flex align-items-center mb-2">
											<div class="text-nowrap me-3 text-muted">
											   <span class="d-inline-block align-middle text-muted">2</span>
											   <i class="bi bi-star-fill ms-1 small text-warning"></i>
											</div>
											<div class="w-100">
											   <div class="progress" style="height: 6px">
												  <div class="progress-bar bg-warning" role="progressbar" style="width: 22%" aria-valuenow="22" aria-valuemin="0" aria-valuemax="22"></div>
											   </div>
											</div>
											<span class="text-muted ms-3">5%</span>
										 </div>
										 <!-- progress -->
										 <div class="d-flex align-items-center mb-2">
											<div class="text-nowrap me-3 text-muted">
											   <span class="d-inline-block align-middle text-muted">1</span>
											   <i class="bi bi-star-fill ms-1 small text-warning"></i>
											</div>
											<div class="w-100">
											   <div class="progress" style="height: 6px">
												  <div class="progress-bar bg-warning" role="progressbar" style="width: 14%" aria-valuenow="14" aria-valuemin="0" aria-valuemax="14"></div>
											   </div>
											</div>
											<span class="text-muted ms-3">7%</span>
										 </div>
									  </div>
								   </div>
								</div>
								<!-- col -->
								<div class="col-md-8">
								   <div class="mb-10">
									  <div class="d-flex justify-content-between align-items-center mb-8">
										 <div>
											<!-- heading -->
											<h4>Reviews</h4>
										 </div>
										 <div>
											<select class="form-select">
											   <option selected="">Top Reviews</option>
											   <option value="Most Recent">Most Recent</option>
											</select>
										 </div>
									  </div>
									  <div class="d-flex border-bottom pb-6 mb-6">
										 <div class="ms-5">
											<h6 class="mb-1">Name</h6>
											<!-- select option -->
											<!-- content -->
											<p class="small">
											   <span class="text-muted">30.12.2023</span>
											   <span class="text-primary ms-3 fw-bold">Verified Purchase</span>
											</p>
											<!-- rating -->
											<div class="mb-2">
											<small class="text-warning">★★★★☆</small>
											<span class="ms-3 text-dark fw-bold">Kommentar Title</span>
											</div>
											<p>
											   Kommentar
											</p>
										 </div>
									  </div>
									  
								   </div>
								   <div>
									  <!-- rating -->
									  <h3 class="mb-5">Create Review</h3>
									  <div class="py-4 mb-4">
										 <!-- heading -->
										 <h5>Add a written review</h5>
										 <textarea class="form-control" rows="3" placeholder="What did you like or dislike? What did you use this product for?"></textarea>
									  </div>
									  <!-- button -->
									  <div class="d-flex justify-content-end">
										 <a href="#" class="btn btn-primary">Submit Review</a>
									  </div>
								   </div>
								</div>
							 </div>
						  </div>
					   </div>
					   
					</div>
				 



				</div>
			</div>

		</div>
		{/if}
	{/foreach}

{/block}