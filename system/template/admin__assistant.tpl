{block name="body"}
	<form method="post">
		<input type="hidden" name="D[ACTION]" value='save'>
		{*LANGUAGE*}
		<div id="Language">
		
			{*$D['LANGUAGE']['D'] = [ 'DE' => [ 'Active' => 1 ], 'EN' => [ 'Active' => 1 ], 'RU' => [ 'Active' => 1 ] ]}
			{$_L = json_decode($D.SETTING.D['Language'].Value,1)*}
			<table class="table">
			{*foreach from=$D.LANGUAGE.D key="kLAN" item="LAN"}
				<tr>
					<td>{input p=['name' => $kLAN, 'type' => 'checkbox', 'onclick' => 'language();', 'value' => $_L[$kLAN].Active ]}</td>
					<td>{$kLAN}</td>
				</tr>
			{/foreach*}
			</table>
			<script>
				language = function() {
					var values = {};
					$('#Language :hidden').each(function() { if(typeof this.name !== "undefined" && this.value == 1){ values[this.name] = { 'Active' : this.value} } }); 
					JSON.stringify(values);
					//alert(JSON.stringify(values));
					$("textarea[name='D[SETTING][D][Language][Value]']").val(JSON.stringify(values));
				}
			</script>
			{input p=['name' => "D[SETTING][D][Language][Value]", 'type' => 'textarea', 'value' => $D.SETTING.D['Language'].Value ]}
		</div>
		<button type="submit" class="btn btn-primary btn-sm">Save</button>
	</form>
{/block}