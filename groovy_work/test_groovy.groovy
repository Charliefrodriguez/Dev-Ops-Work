import groovy.json.JsonSlurper 
def env_file_gen(String file_name){
	def jsonSlurper = new JsonSlurper()
	data = jsonSlurper.parse(new File(file_name)) 
	println(data)
	File output =  new File("output.env") 
	for(key in data){ 
	   output.append(key)
	   output.append("\n")
	   println(key)
	} 
}

//env_file_gen("./example.json")
