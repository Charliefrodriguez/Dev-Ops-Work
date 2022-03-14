//import groovy.json.JsonSlurper 
import groovy.json.JsonSlurperClassic
def call(String file_name){
	def jsonSlurper = new JsonSlurperClassic()
	data = jsonSlurper.parse(new File(file_name)) 
	println(data)
	File output =  new File("output.env") 
	for(key in data){ 
	   output.append(key)
	   output.append("\n")
	   println(key)
	} 
	jsonSlurper = null
	data = null // use this to remove not serializable by jenkins error
}
