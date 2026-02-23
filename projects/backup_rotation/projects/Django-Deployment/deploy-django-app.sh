#!/bin/bash
<< task 
deploy a jango app and handle code for errors
task

# Function to clone the Django app code
code_clone(){
	echo "cloning the Django App.."
	if [ -d "django-notes-app" ]; then
		echo "The code directory already exists. Skipping clone."
	else
	git clone https://github.com/LondheShubham153/django-notes-app.git||{	
		echo "Failed to clone the code."
		return 1
 	
	}
      fi
      cd django-notes-app || return 1
}

# Function to install required dependencies

install_requirements(){
	echo " Installing dependencies"
	sudo apt-get update && sudo apt-get install -y  docker.io nginx docker-compose||{
		echo "Failed to install dependencies."
		return 1
	}
}

# Function to perform required restarts
required_restarts(){
	echo "Performing required restarts..."
    sudo chown "$USER" /var/run/docker.sock || {
          echo "Failed to change ownership of docker.sock."
          return 1 
	}

	# fix project file permissions
    sudo chown -R $USER:$USER ~/Shell-Scripting/projects/django-notes-app || {
        echo "Failed to fix project permissions."
        return 1
        #Uncomment the following lines if needed
	#sudo systemctl enable docker
	#sudo systemctl enable nginx
	#sudo systemctl restart docker
}
} 

#deploy(){
#	cd django-notes-app	
#	docker build -t notes-app .
#	docker run -d -p 8000:8000 notes-app:latest
#}
deploy(){
    echo "Building and deploying the Django app..."
    docker build -t notes-app . || return 1
    docker compose up -d || docker-compose up -d || return 1

} 
# Main deployment script
echo "******** DEPLOYMENT STARTED*********"

#Clone the code
code_clone || exit 1

#if ! code_clone; then 
#	cd django-notes-app || exit 1
#fi

# Install dependencies
if ! install_requirements; then 
	exit 1
fi

#Perform required restarts
if ! required_restarts; then
	exit 1
fi	
# Deploy the app
if ! deploy; then 
	echo "Deployment failed. Mailing the admin..."
	exit 1
fi


echo "***********DEployemnt completed********"
