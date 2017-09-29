require 'nokogiri'
require 'open-uri'
#Se carga la pagina pasando el enlace
html=open("https://www.port-monitor.com/plans-and-pricing").read

doc=Nokogiri::HTML(html)

cont=0
array=Array.new(6){Hash.new}
#Se carga en el array los elementos dd del fichero html de la pagina
doc.search('.product dd').map do |element|
	cadena=element.inner_text
	if (cont%4)==0
		cadena.scan(/\d+/) {|w| cadena = "#{w}" }
		array[cont/4]["check_rate"]= cadena.to_i
	elsif (cont%4)==1
		cadena.scan(/\d+/) {|w| cadena = "#{w}" }
		array[cont/4]["history"]=cadena.to_i
	elsif (cont%4)==2
		array[cont/4]["multiple_notifications"]=cadena
	elsif (cont%4)==3
		array[cont/4]["push_notifications"]=cadena
	end
	cont=cont+1
end

var = 0  


html1=open("https://www.port-monitor.com/plans-and-pricing").read

doc1=Nokogiri::HTML(html)
cont = 0
n = 0
#Aqui conseguimos el precio de los productos desde la pagina html 
doc1.search('p a').map do |element|
	precio=element.inner_text
	if (cont%2)==0 and (cont/array.length)!=2
		precio.scan(/\d+.\d+/) {|w| precio = "#{w}" }
		array[n]["price"]=precio.to_f
		n=n+1
	end
	cont=cont+1
end

html2=open("https://www.port-monitor.com/plans-and-pricing").read

doc2=Nokogiri::HTML(html)

cont = 0
#Se cnsegue aqui el numero del monitor del producto
doc1.search('.product h2').map do |element|
	titulo=element.inner_text
	array[cont]["monitor"]=titulo
	cont=cont+1
end

#impresion de los datos de los productos
var1 = 0
while var1 < array.size() 
	array[var1].each do |key, valor|
  		puts "#{key}: "
  		puts valor
	end
	puts ""
    var1=var1+1
end
