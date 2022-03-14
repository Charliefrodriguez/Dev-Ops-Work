import groovy.json.JsonSlurper 
def call(String file_name){
	def jsonSlurper = new JsonSlurper()
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
