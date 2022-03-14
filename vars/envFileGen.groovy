//import groovy.json.JsonSlurper 
import groovy.json.JsonSlurperClassic
def call(String file_name){
	def jsonSlurper = new JsonSlurperClassic()
	data = jsonSlurper.parse(new File(file_name)) 
	println(data)
	// need to give absolute paths when creating files
	File output =  new File("$WORKSPACE/output.env") 
	for(key in data){ 
	   output.append(key)
	   output.append("\n")
	   println(key)
	} 
	jsonSlurper = null
	data = null // use this to remove not serializable by jenkins error
}
