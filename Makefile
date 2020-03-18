
#expected arguments:
#	app-name: name of the image to build
#	
image_build:
	echo 'building $(app-name)'

tomcat_build_image:
	docker build -t neko-tomcat-img ./tomcat/.

tomcat_run_image:
	# hotport ?= 
	# containerport ?=
	docker run -d -p 8080:8080 --name neko neko-tomcat-img

port ?= 8080
user ?= admin
pwd  ?= admin

tomcat_deploy:
	curl -v -u $(user):$(pwd) -T $(war-path) 'http://localhost:$(port)/manager/text/deploy?path=/$(war-path)&update=true'

tomcat_undeploy:
	