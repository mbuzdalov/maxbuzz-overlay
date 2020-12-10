# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Maxim Buzdalov: copy from the main Portage with a slightly more updated version

EAPI=7
inherit eutils desktop

SLOT="0"
PV_STRING="$(ver_cut 4-6)"
MY_PV="$(ver_cut 1-2)"
MY_PN="idea"

#Using the most recent Jetbrains Runtime binaries available at the time of writing
JRE11_BASE="11_0_8"
JRE11_VER="1098.1"

# distinguish settings for official stable releases and EAP-version releases
if [[ "$(ver_cut 7)"x = "prex" ]]
then
	# upstream EAP
	KEYWORDS=""
	SRC_URI="https://download.jetbrains.com/idea/${MY_PN}IC-${PV_STRING}.tar.gz"
else
	# upstream stable
	KEYWORDS="~amd64"
	SRC_URI="https://download.jetbrains.com/idea/${MY_PN}IC-${MY_PV}-no-jbr.tar.gz -> ${MY_PN}IC-${PV_STRING}.tar.gz
	amd64? ( https://bintray.com/jetbrains/intellij-jbr/download_file?file_path=jbr-${JRE11_BASE}-linux-x64-b${JRE11_VER}.tar.gz -> jbr-${JRE11_BASE}-linux-x64-b${JRE11_VER}.tar.gz )"
fi

DESCRIPTION="A complete toolset for web, mobile and enterprise development"
HOMEPAGE="https://www.jetbrains.com/idea"

LICENSE="Apache-2.0 jbr11? ( GPL-2 )"

DEPEND="!dev-util/${PN}:14
	!dev-util/${PN}:15"
RDEPEND="${DEPEND}
	>=virtual/jdk-1.7:*"

RESTRICT="splitdebug"
S="${WORKDIR}/${MY_PN}-IC-${PV_STRING}"

QA_PREBUILT="opt/${PN}-${MY_PV}/*"

src_unpack() {
    default_src_unpack
    mkdir jre64 && cd jre64 && unpack jbr-${JRE11_BASE}-linux-x64-b${JRE11_VER}.tar.gz
}

src_prepare() {
	if use amd64; then
		JRE_DIR=jre64
	else
		JRE_DIR=jre
	fi
	if ! use arm; then
		rm -rf lib/pty4j-native/linux/ppc64le || die
	fi
	eapply_user
}

src_install() {
	local dir="/opt/${PN}-${MY_PV}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}"/bin/{format.sh,idea.sh,inspect.sh,printenv.py,restart.py,fsnotifier{,64}}
	if use amd64; then
		JRE_DIR=jre64
	else
		JRE_DIR=jre
	fi
	if use jbr11 ; then
		JRE_BINARIES="jaotc java javapackager jjs jrunscript keytool pack200 rmid rmiregistry unpack200"
		if [[ -d ${JRE_DIR} ]]; then
			for jrebin in $JRE_BINARIES; do
				fperms 755 "${dir}"/"${JRE_DIR}"/bin/"${jrebin}"
			done
		fi
	fi

	make_wrapper "${PN}" "${dir}/bin/${MY_PN}.sh"
	newicon "bin/${MY_PN}.png" "${PN}.png"
	make_desktop_entry "${PN}" "IntelliJ Idea Community" "${PN}" "Development;IDE;"

	# recommended by: https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	mkdir -p "${D}/etc/sysctl.d/" || die
	echo "fs.inotify.max_user_watches = 524288" > "${D}/etc/sysctl.d/30-idea-inotify-watches.conf" || die
}
