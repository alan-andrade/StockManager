// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function hide_flash_messages(dom){
	setTimeout(function(){new Effect.Fade($(dom))} , 2500);
};

function focusfield(id){	
	id.style.border = "1px solid blue"
	notice = id.id + '_tag'
	// For avoiding weird overlapping after one product successfully get stored
	if ($('success-notice').visible() == false){
		$(notice).show();		
	};
};

function leavefield(id){
	id.style.border = "1px solid green"
	notice = id.id + '_tag'
	$(notice).hide();
};


function updateProductsCounter(){
	value = parseInt($('products-counter-number').textContent);
	$('products-counter-number').innerHTML = value + 1 ;
	$('products-counter').visualEffect('Highlight', {startcolor: '#ff0000'});
	$('products-counter').visualEffect('Pulsate');
}

function cleanForm(){
	$('product_product_name').value = "";
	$('product_price').value = "";
	$('product_description').value = "";
	$('stock_product_qty').value = "";
	$('form-errors').hide();	
}

function showSuccessNotice(){
	$('success-notice').show();
	setTimeout(function(){new Effect.Fade($('success-notice'))}, 3000);
	$('product_product_name').focus();
}

function findStoreProducts(id, form){
	if (id != ""){
		$('loading').show();			
		new Ajax.Request('/products/for_selection/' + id +".json", {
			method: 'get',
			onSuccess: function(request){updateProductsSelection(eval("(" + request.responseText + ")"), form)}			
		});
		$('loading').hide();
		showValidatesExistance();
	}else{
		cleanOptions(form.elements)
	}	
}

function showValidatesExistance(){
	links = document.forms[0].select('#validate-existance');
	for(a=0; a < links.length; a++){		
		links[a].style.display = ""
	}
}

function updateProductsSelection(products, form){		
		fe = form.elements;		
		cleanOptions(fe);	
		
		for(i=0;i<products.length;i++){
			fe[2].options[i] = new Option(products[i].product.product_name,products[i].product.id,false,false)
		}		

		fillAddedSelectors();
}

function cleanOptions(fe){
	for(i=2;i < fe.length-1;i+=2){
		fe[i].length = 0;		
	}
}

function fillAddedSelectors(){
	selects = document.forms[0].select('select') /*Array of form selectors*/
	/*first selector is from store... We dont want it.*/
	selects.shift(); /*Pop out the first element.*/
	/*Store the first selector*/
	example = selects.first();
	selects.shift(); 
	
	for(i=0; i < selects.length; i++){
		for(j=0; j < example.options.length; j++){
			selects[i].options[j] = new Option(example.options[j].text, example.options[j].value,false,false)			
		}
		if (selects[i].options[0].value != "") {
			selects[i].next('a').style.display = "";
		}
	}
	checkAllQtyValidated()
}

function enableBeforeSending(){
	
}

function confirmProductSelected(field){
	if (field.previous('select').selectedIndex < 0){
		field.form.focusFirstElement();
	}else{
		return true
	}
}

function validateProductQty(field){
		product_id = field.previous('select').value		
		new Ajax.Request('/stock_products/' + product_id + '.json',{
			method: 'get',
			onLoading: $('loading').show(),			
			onSuccess: function(request){
					sp = request.responseText.evalJSON();
					product_qty = sp.stock_product.qty;
					form_qty = field.previous('input').value;
					if(product_qty < form_qty )
					{
						alert('You have no existance. Total = ' + product_qty);
					}
					else if(form_qty < 1)
					{
						alert('Cant sell ZERO!');
					}
					else
					{
						disableProductFields(field);
						field.replace("<input type=\"button\" id=\"validate-existance\" value=\"Validated !\" />");
						checkAllQtyValidated();
					}//else
				},// OnSuccess
			onComplete:$('loading').hide()
			});// Ajax.Request
}

function selectFieldChanged(field){
	// Function to enble text field and validate field when selection is changed.
	field.next('input').readOnly = false
	if (field.next('input').next('input')){
		field.next('input').next('input').replace("<input id=\"validate-existance\" onclick=\"validateProductQty(this);\" type=\"button\" value=\"Validate Existance !\" />")		
	}
	document.forms[0].select('#sale_submit').first().disabled = true;
}

function checkAllQtyValidated(){
	links = document.forms[0].select('#validate-existance');
	boolean = false;
	for(a=0;a < links.length; a++){
		if (links[a].value == "Validated !"){
			boolean = true;
		}else{boolean = false;}
	}//for
	if (boolean){
		document.forms[0].select('#sale_submit').first().disabled = false;		
	}else{document.forms[0].select('#sale_submit').first().disabled = true;}
}

function disableProductFields(field){
	//field.previous('select').disable();
	field.previous('input').readOnly = true;
}

function enableBeforeSending(){
	form = document.forms[0]
	selects = form.select('select')
	inputs = form.select('input')
	for(i=0; selects.length; i++){
		selects[i].enable();
		inputs[i].enable();
	}
}


/*Number only script START */

function numbersonly(e, decimal) {
var key;
var keychar;

if (window.event) {
   key = window.event.keyCode;
}
else if (e) {
   key = e.which;
}
else {
   return true;
}
keychar = String.fromCharCode(key);

if ((key==null) || (key==0) || (key==8) ||  (key==9) || (key==13) || (key==27) ) {
   return true;
}
else if ((("0123456789").indexOf(keychar) > -1)) {
   return true;
}
else if (decimal && (keychar == ".")) { 
  return true;
}
else
   return false;
}

/*Number only END*/
