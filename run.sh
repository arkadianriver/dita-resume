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
	-ghpages)
		$DITA_HOME/bin/dita install
		$DITA_HOME/bin/dita -i src/toc.ditamap -f resume
		;;
	*)
		usage
		;;
esac


