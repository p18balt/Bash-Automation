#!/bin/bash
function Gitpush(){
	git add .
	git commit -m "Commit"
	git push
}
function Gitconfig(){
echo "Config Git"
	    read -p "Write your git username: " User
	    Defaultemail="$User@users.noreply.github.com"
	    read -p "Write your git email address[Press enter to accept private email $Defaultemail ]" Email
	    Email="${Email:-${Defaultemail}}"
	    echo "Configuring global username and email"
	    git config --global user.name "$User"
	    git config --global user.email "$Email"
}
function Paradoteo1(){
	Basedir=$(dirname "$0")
	read -p "Please insert your github username: " Gitusername
	git clone "https://github.com/"$Gitusername"/site"
	cd site
	rm -rf _gallery images
	git rm -r --cached _gallery
	git rm -r --cached images
	git submodule add "https://github.com/"$Gitusername"/_gallery"
	cd ..
	read -p "Please enter the name of the first file WITHOUT .md extension[Example: norton]: " File1
	read -p "Please enter the name of the second file WITHOUT .md extension[Example: windows]: " File2
	cp $Basedir/file.md $Basedir/site/_gallery/$File1.md
	cp $Basedir/file.md $Basedir/site/_gallery/$File2.md
	sed -i "s/chauthor/$Gitusername/g" $Basedir/site/_gallery/$File1.md
	sed -i "s/chauthor/$Gitusername/g" $Basedir/site/_gallery/$File2.md
	sed -i "s/chimage/$File1.png/g" $Basedir/site/_gallery/$File1.md
	sed -i "s/chimage/$File2.png/g" $Basedir/site/_gallery/$File2.md
	cd $Basedir/site/_gallery/
	vim $File1.md
	vim $File2.md
	Gitpush
	cd ..
	git submodule add "https://github.com/"$Gitusername"/images"
	cd ..
	echo "Put your images in this folder"
	pwd
	echo "Type first image file name including extension name"
	echo "First image = first md file, Second image = Second md file"
	read -p "Insert image name file[Example: image.jpg]: " Imagename1
	read -p "Insert second image file name [Example: image2.jpg]: " Imagename2
	convert $Imagename1 -resize 160x160 $Basedir/site/images/$File1-thumb.png
	convert $Imagename2 -resize 160x160 $Basedir/site/images/$File2-thumb.png
	cp $Imagename1 $Basedir/site/images/$File1.png
	cp $Imagename2 $Basedir/site/images/$File2.png
	cd $Basedir/site/images
	pwd
	Gitpush
	cd ..
	pwd
	Gitpush
	echo "Thanks for Using"
}
echo "Select an option"
echo "1.Paradoteo A1"
echo "2.Paradoteo A2"
echo "3.Paradoteo B1"
echo "4.Paradoteo B2"
echo "5.Configure Git"
echo "6.Quit"
echo -n "Enter your choice [1-6]: "
while :
do
read Choice
case $Choice in
	1 ) clear
	    Paradoteo1;;
	2 ) echo "-";;
	3 ) echo "-";;
	4 ) echo "-";;
	5 ) clear
	    Gitconfig;;
	6 ) echo "Quiting"
	   exit;;
	* ) echo "Wrong input!";;
esac
	echo "Enter your choice [1-6]: "
	echo "1.Paradoteo A1"
	echo "2.Paradoteo A2"
        echo "3.Paradoteo B1"
	echo "4.Paradoteo B2"
	echo "5.Configure Git"
	echo "6.Quit"
done
