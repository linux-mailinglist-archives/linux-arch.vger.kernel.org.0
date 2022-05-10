Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE505211DE
	for <lists+linux-arch@lfdr.de>; Tue, 10 May 2022 12:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbiEJKOW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 May 2022 06:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239602AbiEJKOU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 May 2022 06:14:20 -0400
X-Greylist: delayed 363 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 May 2022 03:10:21 PDT
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEB92ABBEC;
        Tue, 10 May 2022 03:10:20 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Tue, 10 May 2022 12:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1652177053; bh=NDtdDRJm9bh7TtDTiCoNRiPPignoVAd1zLKUc3YHgng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uPd2XSSDA9mhT4iOUn+RZqr9huBovh2xoqAzyHLMekQvDXj+depxq5QnQxORTOiDN
         sifUVSNjvgsL8g6r82o8wmHrbL+f0FhS5a+8r1iKeqph2jBVGaR/kPZ6UcvVqosWoX
         DnQdmO6uzOoWG8Qn5r8PtLA9kTLDrbj3N7bjoags=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id E157A80403;
        Tue, 10 May 2022 12:04:11 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id D022E1810A2; Tue, 10 May 2022 12:04:11 +0200 (CEST)
Date:   Tue, 10 May 2022 12:04:11 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: factor out the common installation code into
 scripts/install.sh
Message-ID: <Yno4m91/H65yX4T1@buildd.core.avm.de>
References: <20220503024716.76666-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220503024716.76666-1-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux bookworm/sid
X-purgate-ID: 149429::1652177052-0000038B-1D420E49/0/0
X-purgate-type: clean
X-purgate-size: 15035
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue,  3 May 2022 11:47 +0900 Masahiro Yamada wrote:
> Many architectures have similar install.sh scripts.
> 
> The first half is really generic; verifies that the kernel image and
> System.map exist, then executes ~/bin/${INSTALLKERNEL} or
> /sbin/${INSTALLKERNEL} if available.
> 
> The second half is kind of arch-specific. It just copies the kernel image
> and System.map to the destination, but the code is slightly different.
> 
> This patch factors out the generic part into scripts/install.sh.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v2:
>   - Move the installkernel parameters to scripts/install.sh
> 
>  Makefile                     |  3 ++-
>  arch/arm/Makefile            |  4 ++--
>  arch/arm/boot/install.sh     | 21 ------------------
>  arch/arm64/Makefile          |  6 ++----
>  arch/arm64/boot/install.sh   | 21 ------------------
>  arch/ia64/Makefile           |  3 ++-
>  arch/ia64/install.sh         | 10 ---------
>  arch/m68k/Makefile           |  3 ++-
>  arch/m68k/install.sh         | 22 -------------------
>  arch/nios2/Makefile          |  3 +--
>  arch/nios2/boot/install.sh   | 22 -------------------
>  arch/parisc/Makefile         | 11 +++++-----
>  arch/parisc/install.sh       | 28 ------------------------
>  arch/powerpc/Makefile        |  3 +--
>  arch/powerpc/boot/install.sh | 23 --------------------
>  arch/riscv/Makefile          |  7 +++---
>  arch/riscv/boot/install.sh   | 21 ------------------
>  arch/s390/Makefile           |  3 +--
>  arch/s390/boot/install.sh    |  6 ------
>  arch/sparc/Makefile          |  3 +--
>  arch/sparc/boot/install.sh   | 22 -------------------
>  arch/x86/Makefile            |  3 +--
>  arch/x86/boot/install.sh     | 22 -------------------
>  scripts/install.sh           | 41 ++++++++++++++++++++++++++++++++++++
>  24 files changed, 64 insertions(+), 247 deletions(-)
>  mode change 100644 => 100755 arch/arm/boot/install.sh
>  mode change 100644 => 100755 arch/arm64/boot/install.sh
>  mode change 100644 => 100755 arch/ia64/install.sh
>  mode change 100644 => 100755 arch/m68k/install.sh
>  mode change 100644 => 100755 arch/nios2/boot/install.sh
>  mode change 100644 => 100755 arch/parisc/install.sh
>  mode change 100644 => 100755 arch/powerpc/boot/install.sh
>  mode change 100644 => 100755 arch/riscv/boot/install.sh
>  mode change 100644 => 100755 arch/s390/boot/install.sh
>  mode change 100644 => 100755 arch/sparc/boot/install.sh
>  mode change 100644 => 100755 arch/x86/boot/install.sh
>  create mode 100755 scripts/install.sh
> 
> diff --git a/Makefile b/Makefile
> index 9a60f732bb3c..154c32af8805 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1298,7 +1298,8 @@ scripts_unifdef: scripts_basic
>  # to this Makefile to build and install external modules.
>  # Cancel sub_make_done so that options such as M=, V=, etc. are parsed.
>  
> -install: sub_make_done :=
> +quiet_cmd_install = INSTALL $(INSTALL_PATH)
> +      cmd_install = unset sub_make_done; $(srctree)/scripts/install.sh

This is the third 'cmd_install' in the tree; might it be better to take 
a more unique name (e.g. cmd_installkernel) to prevent confusion?

>  
>  # ---------------------------------------------------------------------------
>  # Tools
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index a2391b8de5a5..187f4b2c5c73 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -318,9 +318,9 @@ $(BOOT_TARGETS): vmlinux
>  	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
>  	@$(kecho) '  Kernel: $(boot)/$@ is ready'
>  
> +$(INSTALL_TARGETS): KBUILD_IMAGE = $(boot)/$(patsubst %install,%Image,$@)
>  $(INSTALL_TARGETS):
> -	$(CONFIG_SHELL) $(srctree)/$(boot)/install.sh "$(KERNELRELEASE)" \
> -	$(boot)/$(patsubst %install,%Image,$@) System.map "$(INSTALL_PATH)"
> +	$(call cmd,install)
>  
>  PHONY += vdso_install
>  vdso_install:
> diff --git a/arch/arm/boot/install.sh b/arch/arm/boot/install.sh
> old mode 100644
> new mode 100755
> index 2a45092a40e3..9ec11fac7d8d
> --- a/arch/arm/boot/install.sh
> +++ b/arch/arm/boot/install.sh
> @@ -1,7 +1,5 @@
>  #!/bin/sh
>  #
> -# arch/arm/boot/install.sh
> -#
>  # This file is subject to the terms and conditions of the GNU General Public
>  # License.  See the file "COPYING" in the main directory of this archive
>  # for more details.
> @@ -18,25 +16,6 @@
>  #   $2 - kernel image file
>  #   $3 - kernel map file
>  #   $4 - default install path (blank if root directory)
> -#
> -
> -verify () {
> -	if [ ! -f "$1" ]; then
> -		echo ""                                                   1>&2
> -		echo " *** Missing file: $1"                              1>&2
> -		echo ' *** You need to run "make" before "make install".' 1>&2
> -		echo ""                                                   1>&2
> -		exit 1
> -	fi
> -}
> -
> -# Make sure the files actually exist
> -verify "$2"
> -verify "$3"
> -
> -# User may have a custom install script
> -if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
> -if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
>  
>  if [ "$(basename $2)" = "zImage" ]; then
>  # Compressed install
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 2f1de88651e6..6d9d4a58b898 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -162,11 +162,9 @@ Image: vmlinux
>  Image.%: Image
>  	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>  
> -install: install-image := Image
> -zinstall: install-image := Image.gz
> +install: KBUILD_IMAGE := $(boot)/Image

For me, it would have been more clear, if we'd also move the default 
KBUILD_IMAGE definition here (similar to the corresponding part in 
arch/parisc/Makefile):

zinstall: KBUILD_IMAGE := $(boot)/Image.gz

($(KBUILD_IMAGE) seems not to be used anywhere else in arch/arm64/ 
tree; but I haven't checked in depth.)

>  install zinstall:
> -	$(CONFIG_SHELL) $(srctree)/$(boot)/install.sh $(KERNELRELEASE) \
> -	$(boot)/$(install-image) System.map "$(INSTALL_PATH)"
> +	$(call cmd,install)
>  
>  PHONY += vdso_install
>  vdso_install:
> diff --git a/arch/arm64/boot/install.sh b/arch/arm64/boot/install.sh
> old mode 100644
> new mode 100755
> index d91e1f022573..7399d706967a
> --- a/arch/arm64/boot/install.sh
> +++ b/arch/arm64/boot/install.sh
> @@ -1,7 +1,5 @@
>  #!/bin/sh
>  #
> -# arch/arm64/boot/install.sh
> -#
>  # This file is subject to the terms and conditions of the GNU General Public
>  # License.  See the file "COPYING" in the main directory of this archive
>  # for more details.
> @@ -18,25 +16,6 @@
>  #   $2 - kernel image file
>  #   $3 - kernel map file
>  #   $4 - default install path (blank if root directory)
> -#
> -
> -verify () {
> -	if [ ! -f "$1" ]; then
> -		echo ""                                                   1>&2
> -		echo " *** Missing file: $1"                              1>&2
> -		echo ' *** You need to run "make" before "make install".' 1>&2
> -		echo ""                                                   1>&2
> -		exit 1
> -	fi
> -}
> -
> -# Make sure the files actually exist
> -verify "$2"
> -verify "$3"
> -
> -# User may have a custom install script
> -if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
> -if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
>  
>  if [ "$(basename $2)" = "Image.gz" ]; then
>  # Compressed install
> diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
> index 6c4bfa54b703..e55c2f138656 100644
> --- a/arch/ia64/Makefile
> +++ b/arch/ia64/Makefile
> @@ -72,8 +72,9 @@ archheaders:
>  
>  CLEAN_FILES += vmlinux.gz
>  
> +install: KBUILD_IMAGE := vmlinux.gz
>  install:
> -	sh $(srctree)/arch/ia64/install.sh $(KERNELRELEASE) vmlinux.gz System.map "$(INSTALL_PATH)"
> +	$(call cmd,install)
>  
>  define archhelp
>    echo '* compressed	- Build compressed kernel image'
> diff --git a/arch/ia64/install.sh b/arch/ia64/install.sh
> old mode 100644
> new mode 100755
> index 0e932f5dcd1a..2d4b66a9f362
> --- a/arch/ia64/install.sh
> +++ b/arch/ia64/install.sh
> @@ -1,7 +1,5 @@
>  #!/bin/sh
>  #
> -# arch/ia64/install.sh
> -#
>  # This file is subject to the terms and conditions of the GNU General Public
>  # License.  See the file "COPYING" in the main directory of this archive
>  # for more details.
> @@ -17,14 +15,6 @@
>  #   $2 - kernel image file
>  #   $3 - kernel map file
>  #   $4 - default install path (blank if root directory)
> -#
> -
> -# User may have a custom install script
> -
> -if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
> -if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
> -
> -# Default install - same as make zlilo
>  
>  if [ -f $4/vmlinuz ]; then
>  	mv $4/vmlinuz $4/vmlinuz.old
> diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
> index 740fc97b9c0f..e358605b70ba 100644
> --- a/arch/m68k/Makefile
> +++ b/arch/m68k/Makefile
> @@ -138,5 +138,6 @@ CLEAN_FILES += vmlinux.gz vmlinux.bz2
>  archheaders:
>  	$(Q)$(MAKE) $(build)=arch/m68k/kernel/syscalls all
>  
> +install: KBUILD_IMAGE := vmlinux.gz
>  install:
> -	sh $(srctree)/arch/m68k/install.sh $(KERNELRELEASE) vmlinux.gz System.map "$(INSTALL_PATH)"
> +	$(call cmd,install)
> diff --git a/arch/m68k/install.sh b/arch/m68k/install.sh
> old mode 100644
> new mode 100755
> index 57d640d4382c..af65e16e5147
> --- a/arch/m68k/install.sh
> +++ b/arch/m68k/install.sh
> @@ -15,28 +15,6 @@
>  #   $2 - kernel image file
>  #   $3 - kernel map file
>  #   $4 - default install path (blank if root directory)
> -#
> -
> -verify () {
> -	if [ ! -f "$1" ]; then
> -		echo ""                                                   1>&2
> -		echo " *** Missing file: $1"                              1>&2
> -		echo ' *** You need to run "make" before "make install".' 1>&2
> -		echo ""                                                   1>&2
> -		exit 1
> -	fi
> -}
> -
> -# Make sure the files actually exist
> -verify "$2"
> -verify "$3"
> -
> -# User may have a custom install script
> -
> -if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
> -if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
> -
> -# Default install - same as make zlilo
>  
>  if [ -f $4/vmlinuz ]; then
>  	mv $4/vmlinuz $4/vmlinuz.old
> diff --git a/arch/nios2/Makefile b/arch/nios2/Makefile
> index 02d678559066..d6a7499b814c 100644
> --- a/arch/nios2/Makefile
> +++ b/arch/nios2/Makefile
> @@ -56,8 +56,7 @@ $(BOOT_TARGETS): vmlinux
>  	$(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@
>  
>  install:
> -	sh $(srctree)/$(nios2-boot)/install.sh $(KERNELRELEASE) \
> -	$(KBUILD_IMAGE) System.map "$(INSTALL_PATH)"
> +	$(call cmd,install)
>  
>  define archhelp
>    echo  '* vmImage         - Kernel-only image for U-Boot ($(KBUILD_IMAGE))'
> diff --git a/arch/nios2/boot/install.sh b/arch/nios2/boot/install.sh
> old mode 100644
> new mode 100755
> index 3cb3f468bc51..34a2feec42c8
> --- a/arch/nios2/boot/install.sh
> +++ b/arch/nios2/boot/install.sh
> @@ -15,28 +15,6 @@
>  #   $2 - kernel image file
>  #   $3 - kernel map file
>  #   $4 - default install path (blank if root directory)
> -#
> -
> -verify () {
> -	if [ ! -f "$1" ]; then
> -		echo ""                                                   1>&2
> -		echo " *** Missing file: $1"                              1>&2
> -		echo ' *** You need to run "make" before "make install".' 1>&2
> -		echo ""                                                   1>&2
> -		exit 1
> -	fi
> -}
> -
> -# Make sure the files actually exist
> -verify "$2"
> -verify "$3"
> -
> -# User may have a custom install script
> -
> -if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
> -if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
> -
> -# Default install - same as make zlilo
>  
>  if [ -f $4/vmlinuz ]; then
>  	mv $4/vmlinuz $4/vmlinuz.old
> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
> index 7583fc39ab2d..aca1710fd658 100644
> --- a/arch/parisc/Makefile
> +++ b/arch/parisc/Makefile
> @@ -184,12 +184,11 @@ vdso_install:
>  	$(Q)$(MAKE) $(build)=arch/parisc/kernel/vdso $@
>  	$(if $(CONFIG_COMPAT_VDSO), \
>  		$(Q)$(MAKE) $(build)=arch/parisc/kernel/vdso32 $@)
> -install:
> -	$(CONFIG_SHELL) $(srctree)/arch/parisc/install.sh \
> -			$(KERNELRELEASE) vmlinux System.map "$(INSTALL_PATH)"
> -zinstall:
> -	$(CONFIG_SHELL) $(srctree)/arch/parisc/install.sh \
> -			$(KERNELRELEASE) vmlinuz System.map "$(INSTALL_PATH)"
> +
> +install: KBUILD_IMAGE := vmlinux
> +zinstall: KBUILD_IMAGE := vmlinuz

Does this make the KBUILD_IMAGE definition in line 19 obsolete and 
unused?

> +install zinstall:
> +	$(call cmd,install)
>  
>  CLEAN_FILES	+= lifimage
>  MRPROPER_FILES	+= palo.conf
> diff --git a/arch/parisc/install.sh b/arch/parisc/install.sh
> old mode 100644
> new mode 100755
> index 70d3cffb0251..933d031c249a
> --- a/arch/parisc/install.sh
> +++ b/arch/parisc/install.sh
> @@ -1,7 +1,5 @@
>  #!/bin/sh
>  #
> -# arch/parisc/install.sh, derived from arch/i386/boot/install.sh
> -#
>  # This file is subject to the terms and conditions of the GNU General Public
>  # License.  See the file "COPYING" in the main directory of this archive
>  # for more details.
> @@ -17,32 +15,6 @@
>  #   $2 - kernel image file
>  #   $3 - kernel map file
>  #   $4 - default install path (blank if root directory)
> -#
> -
> -verify () {
> -	if [ ! -f "$1" ]; then
> -		echo ""                                                   1>&2
> -		echo " *** Missing file: $1"                              1>&2
> -		echo ' *** You need to run "make" before "make install".' 1>&2
> -		echo ""                                                   1>&2
> -		exit 1
> -	fi
> -}
> -
> -# Make sure the files actually exist
> -
> -verify "$2"
> -verify "$3"
> -
> -# User may have a custom install script
> -
> -if [ -n "${INSTALLKERNEL}" ]; then
> -  if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
> -  if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
> -  if [ -x /usr/sbin/${INSTALLKERNEL} ]; then exec /usr/sbin/${INSTALLKERNEL} "$@"; fi
> -fi
> -
> -# Default install
>  
>  if [ "$(basename $2)" = "vmlinuz" ]; then
>  # Compressed install
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index eb541e730d3c..45a9caa37b4e 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -408,8 +408,7 @@ endef
>  
>  PHONY += install
>  install:

I can't find a KBUILD_IMAGE definition in arch/powerpc/Makefile.  
Should it be set here as a target-specific varibable, too?

Kind regards,
Nicolas
