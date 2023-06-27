#!/bin/bash

usage () {
	cat <<EOU
usage: $0 [-o | -d | -2 | -f]
where:
-o Copy the plugin to Oxygen's DITA-OT 3.x
-d DITA PDF build with the 'resume' transtype
-2 Apache FOP build of temp/stage2.fo
-f Apache FOP build of temp/topic.fo
-p Split the out/toc.pdf into separate documents
-ghpages Production run for distribution
EOU
exit 1
}


[ -z $1 ] && usage
[ -z $DITA_HOME ] && DITA_HOME=$HOME/.local/share/dita-ot-4.0.2
plugname=com.arkadianriver.resume
scriptdir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
oxyplugdir="$HOME/Apps/Oxygen XML Editor 25/frameworks/dita/DITA-OT3.x/plugins"

oxycopy ()
{
	rm -r "$oxyplugdir/com.arkadianriver.resume"
	pushd "$scriptdir/plugins"
	cp -r com.arkadianriver.resume "$oxyplugdir/"
	popd
}

runfop ()
{
	fname=$1
	mkdir -p "${scriptdir}/out"
	cat <<EOA > "${scriptdir}/temp/buildfo.xml"
<project name="hello" default="transform">

	<taskdef name="fop" classname="org.apache.fop.tools.anttasks.Fop">
		<classpath>
			<fileset dir="${DITA_HOME}/lib">
				<include name="*.jar"/>
			</fileset>
			<fileset dir="${DITA_HOME}/plugins/org.dita.pdf2.fop/lib">
				<include name="*.jar"/>
			</fileset>
		</classpath>
	</taskdef>

	<target name="transform">  
		<fop format="application/pdf"
			fofile="${scriptdir}/temp/${fname}"
			outfile="${scriptdir}/out/${fname%.*}.pdf"
			messagelevel="info" relativebase="true" force="true" />
	</target>

</project>
EOA
	ant -f "${scriptdir}/temp/buildfo.xml"
}

pagesinstall ()
{
	[ -z $GITHUB_WORKSPACE ] && echo 'To be run only by GitHub Actions.' && exit 1

  curl -L https://github.com/dita-ot/dita-ot/releases/download/$OT_VRM/dita-ot-${OT_VRM}.zip -O
  unzip -q dita-ot-${OT_VRM}.zip -d $GITHUB_WORKSPACE/Apps
  sed -i 's|\(plugindirs.*\)|\1;'"$GITHUB_WORKSPACE"'\/plugins|' \
    $GITHUB_WORKSPACE/Apps/dita-ot-$OT_VRM/config/configuration.properties
}

outnojekyll ()
{
	touch ./out/.nojekyll
	cat <<EOI > "./out/index.html"
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Resumes</title>
	<style>
		body {
			font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
		}
		h1 {
			font-size: 18pt;
		}
		div {
			display: flex;
			gap: 8px;
			flex-wrap: wrap;
		}
		div > div {
			background-color: #dedede;
			width: 240px;
			min-height: 240px;
			padding: 12px;
			height: auto;
			display: flex;
			border-radius: 12px;
		}
		div > div > div {
			justify-content: center;
			align-items: center;
			text-align: center;
		}
		a {
			text-decoration: none;
			font-weight: bold;
			color: cornflowerblue;
		}
	</style>
</head>
<body>
	<main>
		<article>
			<h1>DITA-created role-based resumes</h1>
			<div>
				<div><div><a href="resume_dev.pdf">Resumé ordered for Content DevOps Development</a></div></div>
				<div><div><a href="resume_ia.pdf">Resumé ordered for Information Architecture</a></div></div>
				<div><div><a href="resume_wrt.pdf">Resumé ordered for Technical Writing</a></div></div>
			</div>
		</article>
	</main>
</body>
</html>
EOI
}

splitpdf ()
{
	# credit https://stackoverflow.com/a/10086073/5360420

	infile="out/toc.pdf" # input pdf

	[ ! -e "$infile" ] && echo "$infile doesn't exist." && exit 1

	pagenumbers=( $(pdftk "$infile" dump_data | \
		grep '^BookmarkPageNumber: ' | cut -f2 -d' ' | uniq)
		end )

	roles=(dev ia wrt)

	for ((i=0; i < ${#pagenumbers[@]} - 1; ++i)); do
		a=${pagenumbers[i]} # start page number
		b=${pagenumbers[i+1]} # end page number
		[ "$b" = "end" ] || b=$[b-1]
		pdftk "$infile" cat $a-$b output out/resume_${roles[$i]}.pdf
	done

	rm $infile
}

case $1 in
	-o)
		oxycopy
		echo "Don't forget to run the Run DITA-OT Integrator transform in Oxygen."
		;;
	-d)
		dita -i src/toc.ditamap -f resume -t temp --clean.temp=no
		;;
	-2)
		runfop stage2.fo
		;;
	-f)
		runfop topic.fo
		;;
	-p)
		splitpdf
		;;
	-pagesinstall)
		pagesinstall
		$GITHUB_WORKSPACE/Apps/dita-ot-$OT_VRM/bin/dita install
		;;
	-ghpages)
		$GITHUB_WORKSPACE/Apps/dita-ot-$OT_VRM/bin/dita -i src/toc.ditamap -f resume
		outnojekyll
		;;
	*)
		usage
		;;
esac

