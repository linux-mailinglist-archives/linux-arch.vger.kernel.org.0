Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA057472D5B
	for <lists+linux-arch@lfdr.de>; Mon, 13 Dec 2021 14:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbhLMNeB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 08:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhLMNeA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 08:34:00 -0500
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C68C061574;
        Mon, 13 Dec 2021 05:34:00 -0800 (PST)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon, 13 Dec 2021 14:33:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1639402439; bh=gkXVUexOKIxKyFShz//BEgi9UOYm2bjmuezR+lLl+N0=;
        h=Resent-From:Resent-Date:Resent-To:Date:From:To:Cc:Subject:
         References:In-Reply-To:From;
        b=vPgsac3sTZ6wOc5Tphdchaz2En6p++QevS8G91mQE2kvvHD5SotJ8NQbHyLxdSz+n
         IcfN2grt0apAUJqw9WK84wMTYcTsXdtTlBtFt5uJlDMwoC+ZXLm6ihzOnJPkO0DGTV
         ypLSw9gQNg9kwL+Pp6PldIrfIDIJuwg23HZr/Rz8=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPSA id 59A15804FF;
        Mon, 13 Dec 2021 14:33:58 +0100 (CET)
Received: from mail.avm.de ([212.42.244.94])
          by mail-notes.avm.de (HCL Domino Release 11.0.1FP4)
          with ESMTP id 2021121314170776-9423 ;
          Mon, 13 Dec 2021 14:17:07 +0100 
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail.avm.de (Postfix) with ESMTP
        for <n.schier@avm.de>; Mon, 13 Dec 2021 14:17:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1639401427; bh=gkXVUexOKIxKyFShz//BEgi9UOYm2bjmuezR+lLl+N0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HgPqxuwrj2tUbK3eNvNPzouBVAfVuDRPrliQSU7iB0JvLibATFiSKNYBbG4sK70sN
         b48byHQ8UtP2GQd3pt8L8WOAeDYkN27Imild3845dBaiLY/Nx+YQEP8X44oiq6L6k7
         9nwB6XE30oXMnaJG+20lEnuJGDrYRG6c4CzhfQ1U=
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 6CF391810BF; Mon, 13 Dec 2021 14:17:07 +0100 (CET)
Date:   Mon, 13 Dec 2021 14:17:07 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 08/10] kbuild: do not include include/config/auto.conf
 from shell scripts
Message-ID: <YbdH0xZHlG7TtV3n@buildd.core.avm.de>
References: <20211212192941.1149247-1-masahiroy@kernel.org>
 <20211212192941.1149247-9-masahiroy@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211212192941.1149247-9-masahiroy@kernel.org>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 11.0.1FP4|October 01,
 2021) at 13.12.2021 14:17:07,  Serialize by http on ANIS1/AVM(Release
 11.0.1FP4|October 01, 2021) at 13.12.2021 14:18:58,    Serialize complete at
 13.12.2021 14:18:58
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Notes-UNID: 8D1C55B424088CD1F62FE36FC4F30EF2
X-purgate-ID: 149429::1639402438-0000060F-4261F511/0/0
X-purgate-type: clean
X-purgate-size: 10603
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 13, 2021 at 04:29:39AM +0900, Masahiro Yamada wrote:
> Richard Weinberger pointed out the risk of sourcing the kernel config
> from shell scripts [1], and proposed some patches [2], [3]. It is a good
> point, but it took a long time because I was wondering how to fix this.
> 
> This commit goes with simple grep approach because there are only a few
> scripts including the kernel configuration.
> 
> scripts/link_vmlinux.sh has references to a bunch of CONFIG options,
> all of which are boolean. I added is_enabled() helper as
> scripts/package/{mkdebian,builddeb} do.
> 
> scripts/gen_autoksyms.sh uses 'eval', stating "to expand the whitelist
> path". I removed it since it is the issue we are trying to fix.
> 
> I was a bit worried about the cost of invoking the grep command over
> again. I extracted the grep parts from it, and measured the cost. It
> was approximately 0.03 sec, which I hope is acceptable.
> 
> [test code]
> 
>   $ cat test-grep.sh
>   #!/bin/sh
> 
>   is_enabled() {
>           grep -q "^$1=y" include/config/auto.conf
>   }
> 
>   is_enabled CONFIG_LTO_CLANG
>   is_enabled CONFIG_LTO_CLANG
>   is_enabled CONFIG_STACK_VALIDATION
>   is_enabled CONFIG_UNWINDER_ORC
>   is_enabled CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
>   is_enabled CONFIG_VMLINUX_VALIDATION
>   is_enabled CONFIG_FRAME_POINTER
>   is_enabled CONFIG_GCOV_KERNEL
>   is_enabled CONFIG_LTO_CLANG
>   is_enabled CONFIG_RETPOLINE
>   is_enabled CONFIG_X86_SMAP
>   is_enabled CONFIG_LTO_CLANG
>   is_enabled CONFIG_VMLINUX_MAP
>   is_enabled CONFIG_KALLSYMS_ALL
>   is_enabled CONFIG_KALLSYMS_ABSOLUTE_PERCPU
>   is_enabled CONFIG_KALLSYMS_BASE_RELATIVE
>   is_enabled CONFIG_DEBUG_INFO_BTF
>   is_enabled CONFIG_KALLSYMS
>   is_enabled CONFIG_DEBUG_INFO_BTF
>   is_enabled CONFIG_BPF
>   is_enabled CONFIG_BUILDTIME_TABLE_SORT
>   is_enabled CONFIG_KALLSYMS
> 
>   $ time ./test-grep.sh
>   real    0m0.036s
>   user    0m0.027s
>   sys     m0.009s
> 
> [1]: https://lore.kernel.org/all/1919455.eZKeABUfgV@blindfold/
> [2]: https://lore.kernel.org/all/20180219092245.26404-1-richard@nod.at/
> [3]: https://lore.kernel.org/all/20210920213957.1064-2-richard@nod.at/
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/gen_autoksyms.sh |  6 ++---
>  scripts/link-vmlinux.sh  | 47 ++++++++++++++++++++--------------------
>  scripts/setlocalversion  |  9 ++++----
>  3 files changed, 30 insertions(+), 32 deletions(-)
> 
> diff --git a/scripts/gen_autoksyms.sh b/scripts/gen_autoksyms.sh
> index 6ed0d225c8b1..12ffb01f13cb 100755
> --- a/scripts/gen_autoksyms.sh
> +++ b/scripts/gen_autoksyms.sh
> @@ -26,10 +26,8 @@ if [ -n "$CONFIG_MODVERSIONS" ]; then
>  	needed_symbols="$needed_symbols module_layout"
>  fi

As kernel test robot pointed out, gen_autoksyms.sh still sources
include/config/auto.conf.  What about this:


diff --git a/scripts/gen_autoksyms.sh b/scripts/gen_autoksyms.sh
index 31872d95468b..be9ee250200e 100755
--- a/scripts/gen_autoksyms.sh
+++ b/scripts/gen_autoksyms.sh
@@ -16,13 +16,11 @@ case "$KBUILD_VERBOSE" in
        ;;
 esac
 
-# We need access to CONFIG_ symbols
-. include/config/auto.conf
 
 needed_symbols=
 
 # Special case for modversions (see modpost.c)
-if [ -n "$CONFIG_MODVERSIONS" ]; then
+if grep -qe "^CONFIG_MODVERSIONS=y" include/config/auto.conf; then
        needed_symbols="$needed_symbols module_layout"
 fi
 

For the other hunks:

Reviewed-by: Nicolas Schier <n.schier@avm.de>


>  
> -ksym_wl=
> -if [ -n "$CONFIG_UNUSED_KSYMS_WHITELIST" ]; then
> -	# Use 'eval' to expand the whitelist path and check if it is relative
> -	eval ksym_wl="$CONFIG_UNUSED_KSYMS_WHITELIST"
> +ksym_wl=$(sed -n 's/^CONFIG_UNUSED_KSYMS_WHITELIST="\(.*\)"$/\1/p' include/config/auto.conf)
> +if [ -n "$ksym_wl" ]; then
>  	[ "${ksym_wl}" != "${ksym_wl#/}" ] || ksym_wl="$abs_srctree/$ksym_wl"
>  	if [ ! -f "$ksym_wl" ] || [ ! -r "$ksym_wl" ]; then
>  		echo "ERROR: '$ksym_wl' whitelist file not found" >&2
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 5cdd9bc5c385..a4b61a2f65db 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -34,6 +34,10 @@ LD="$1"
>  KBUILD_LDFLAGS="$2"
>  LDFLAGS_vmlinux="$3"
>  
> +is_enabled() {
> +	grep -q "^$1=y" include/config/auto.conf
> +}
> +
>  # Nice output in kbuild format
>  # Will be supressed by "make -s"
>  info()
> @@ -80,11 +84,11 @@ modpost_link()
>  		${KBUILD_VMLINUX_LIBS}				\
>  		--end-group"
>  
> -	if [ -n "${CONFIG_LTO_CLANG}" ]; then
> +	if is_enabled CONFIG_LTO_CLANG; then
>  		gen_initcalls
>  		lds="-T .tmp_initcalls.lds"
>  
> -		if [ -n "${CONFIG_MODVERSIONS}" ]; then
> +		if is_enabled CONFIG_MODVERSIONS; then
>  			gen_symversions
>  			lds="${lds} -T .tmp_symversions.lds"
>  		fi
> @@ -104,21 +108,21 @@ objtool_link()
>  	local objtoolcmd;
>  	local objtoolopt;
>  
> -	if [ "${CONFIG_LTO_CLANG} ${CONFIG_STACK_VALIDATION}" = "y y" ]; then
> +	if is_enabled CONFIG_LTO_CLANG && is_enabled CONFIG_STACK_VALIDATION; then
>  		# Don't perform vmlinux validation unless explicitly requested,
>  		# but run objtool on vmlinux.o now that we have an object file.
> -		if [ -n "${CONFIG_UNWINDER_ORC}" ]; then
> +		if is_enabled CONFIG_UNWINDER_ORC; then
>  			objtoolcmd="orc generate"
>  		fi
>  
>  		objtoolopt="${objtoolopt} --duplicate"
>  
> -		if [ -n "${CONFIG_FTRACE_MCOUNT_USE_OBJTOOL}" ]; then
> +		if is_enabled CONFIG_FTRACE_MCOUNT_USE_OBJTOOL; then
>  			objtoolopt="${objtoolopt} --mcount"
>  		fi
>  	fi
>  
> -	if [ -n "${CONFIG_VMLINUX_VALIDATION}" ]; then
> +	if is_enabled CONFIG_VMLINUX_VALIDATION; then
>  		objtoolopt="${objtoolopt} --noinstr"
>  	fi
>  
> @@ -127,16 +131,16 @@ objtool_link()
>  			objtoolcmd="check"
>  		fi
>  		objtoolopt="${objtoolopt} --vmlinux"
> -		if [ -z "${CONFIG_FRAME_POINTER}" ]; then
> +		if ! is_enabled CONFIG_FRAME_POINTER; then
>  			objtoolopt="${objtoolopt} --no-fp"
>  		fi
> -		if [ -n "${CONFIG_GCOV_KERNEL}" ] || [ -n "${CONFIG_LTO_CLANG}" ]; then
> +		if is_enabled CONFIG_GCOV_KERNEL || is_enabled CONFIG_LTO_CLANG; then
>  			objtoolopt="${objtoolopt} --no-unreachable"
>  		fi
> -		if [ -n "${CONFIG_RETPOLINE}" ]; then
> +		if is_enabled CONFIG_RETPOLINE; then
>  			objtoolopt="${objtoolopt} --retpoline"
>  		fi
> -		if [ -n "${CONFIG_X86_SMAP}" ]; then
> +		if is_enabled CONFIG_X86_SMAP; then
>  			objtoolopt="${objtoolopt} --uaccess"
>  		fi
>  		info OBJTOOL ${1}
> @@ -161,7 +165,7 @@ vmlinux_link()
>  	# skip output file argument
>  	shift
>  
> -	if [ -n "${CONFIG_LTO_CLANG}" ]; then
> +	if is_enabled CONFIG_LTO_CLANG; then
>  		# Use vmlinux.o instead of performing the slow LTO link again.
>  		objs=vmlinux.o
>  		libs=
> @@ -189,7 +193,7 @@ vmlinux_link()
>  		ldflags="${ldflags} ${wl}--strip-debug"
>  	fi
>  
> -	if [ -n "${CONFIG_VMLINUX_MAP}" ]; then
> +	if is_enabled CONFIG_VMLINUX_MAP; then
>  		ldflags="${ldflags} ${wl}-Map=${output}.map"
>  	fi
>  
> @@ -239,15 +243,15 @@ kallsyms()
>  {
>  	local kallsymopt;
>  
> -	if [ -n "${CONFIG_KALLSYMS_ALL}" ]; then
> +	if is_enabled CONFIG_KALLSYMS_ALL; then
>  		kallsymopt="${kallsymopt} --all-symbols"
>  	fi
>  
> -	if [ -n "${CONFIG_KALLSYMS_ABSOLUTE_PERCPU}" ]; then
> +	if is_enabled CONFIG_KALLSYMS_ABSOLUTE_PERCPU; then
>  		kallsymopt="${kallsymopt} --absolute-percpu"
>  	fi
>  
> -	if [ -n "${CONFIG_KALLSYMS_BASE_RELATIVE}" ]; then
> +	if is_enabled CONFIG_KALLSYMS_BASE_RELATIVE; then
>  		kallsymopt="${kallsymopt} --base-relative"
>  	fi
>  
> @@ -312,9 +316,6 @@ if [ "$1" = "clean" ]; then
>  	exit 0
>  fi
>  
> -# We need access to CONFIG_ symbols
> -. include/config/auto.conf
> -
>  # Update version
>  info GEN .version
>  if [ -r .version ]; then
> @@ -343,7 +344,7 @@ tr '\0' '\n' < modules.builtin.modinfo | sed -n 's/^[[:alnum:]:_]*\.file=//p' |
>  	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$/.ko/' > modules.builtin
>  
>  btf_vmlinux_bin_o=""
> -if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
> +if is_enabled CONFIG_DEBUG_INFO_BTF; then
>  	btf_vmlinux_bin_o=.btf.vmlinux.bin.o
>  	if ! gen_btf .tmp_vmlinux.btf $btf_vmlinux_bin_o ; then
>  		echo >&2 "Failed to generate BTF for vmlinux"
> @@ -355,7 +356,7 @@ fi
>  kallsymso=""
>  kallsymso_prev=""
>  kallsyms_vmlinux=""
> -if [ -n "${CONFIG_KALLSYMS}" ]; then
> +if is_enabled CONFIG_KALLSYMS; then
>  
>  	# kallsyms support
>  	# Generate section listing all symbols and add it into vmlinux
> @@ -395,12 +396,12 @@ fi
>  vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
>  
>  # fill in BTF IDs
> -if [ -n "${CONFIG_DEBUG_INFO_BTF}" -a -n "${CONFIG_BPF}" ]; then
> +if is_enabled CONFIG_DEBUG_INFO_BTF && is_enabled CONFIG_BPF; then
>  	info BTFIDS vmlinux
>  	${RESOLVE_BTFIDS} vmlinux
>  fi
>  
> -if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
> +if is_enabled CONFIG_BUILDTIME_TABLE_SORT; then
>  	info SORTTAB vmlinux
>  	if ! sorttable vmlinux; then
>  		echo >&2 Failed to sort kernel tables
> @@ -412,7 +413,7 @@ info SYSMAP System.map
>  mksysmap vmlinux System.map
>  
>  # step a (see comment above)
> -if [ -n "${CONFIG_KALLSYMS}" ]; then
> +if is_enabled CONFIG_KALLSYMS; then
>  	mksysmap ${kallsyms_vmlinux} .tmp_System.map
>  
>  	if ! cmp -s System.map .tmp_System.map; then
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index 6b54e46a0f12..d06137405190 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -111,9 +111,7 @@ if $scm_only; then
>  	exit
>  fi
>  
> -if test -e include/config/auto.conf; then
> -	. include/config/auto.conf
> -else
> +if ! test -e include/config/auto.conf; then
>  	echo "Error: kernelrelease not valid - run 'make prepare' to update it" >&2
>  	exit 1
>  fi
> @@ -125,10 +123,11 @@ if test ! "$srctree" -ef .; then
>  fi
>  
>  # CONFIG_LOCALVERSION and LOCALVERSION (if set)
> -res="${res}${CONFIG_LOCALVERSION}${LOCALVERSION}"
> +config_localversion=$(sed -n 's/^CONFIG_LOCALVERSION="\(.*\)"$/\1/p' include/config/auto.conf)
> +res="${res}${config_localversion}${LOCALVERSION}"
>  
>  # scm version string if not at a tagged commit
> -if test "$CONFIG_LOCALVERSION_AUTO" = "y"; then
> +if grep -q "^CONFIG_LOCALVERSION_AUTO=y$" include/config/auto.conf; then
>  	# full scm version string
>  	res="$res$(scm_version)"
>  elif [ "${LOCALVERSION+set}" != "set" ]; then
> -- 
> 2.32.0
> 
