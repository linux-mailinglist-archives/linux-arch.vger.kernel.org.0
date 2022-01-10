Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC8948977B
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 12:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244759AbiAJLcP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 06:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244737AbiAJLbv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 06:31:51 -0500
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3440DC06173F;
        Mon, 10 Jan 2022 03:31:51 -0800 (PST)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon, 10 Jan 2022 12:31:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1641814309; bh=+3+XudVZJVlSF4hofBLXncn1knHit7hhlLwg5tcx9vE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/k8e89+sCIX3aQ0iNCG3Pv2AvcHnHHe1kto/10wnFFkObLqwkmG5UqCMWq21o25Z
         G/dJhs9B+2UaJMDL6RHQS9OoIAJIfm42P/ZBldUjsEqKing+VVnBFnEDch2uBPbYYJ
         2T67DnuPXcNunSXonHWi41dvqQ0zjYBFsdjrrI5k=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPSA id 3962D80514;
        Mon, 10 Jan 2022 12:31:49 +0100 (CET)
Date:   Mon, 10 Jan 2022 12:31:48 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/5] sh: rename suffix-y to suffix_y
Message-ID: <YdwZJO/ar+GHuBd1@buildd.core.avm.de>
References: <20220109181529.351420-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220109181529.351420-1-masahiroy@kernel.org>
X-purgate-ID: 149429::1641814309-0000056E-303CD523/0/0
X-purgate-type: clean
X-purgate-size: 3575
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 10, 2022 at 03:15:25AM +0900, Masahiro Yamada wrote:
> 'export suffix-y' does not work reliably because hyphens are disallowed
> in shell variables.
> 
> A similar issue was fixed by commit 2bfbe7881ee0 ("kbuild: Do not use
> hyphen in exported variable name").
> 
> If I do similar in dash, ARCH=sh fails to build.
> 
>   $ mv linux linux~
>   $ cd linux~
>   $ dash
>   $ make O=foo/bar ARCH=sh CROSS_COMPILE=sh4-linux-gnu- defconfig all
>   make[1]: Entering directory '/home/masahiro/linux~/foo/bar'
>     [ snip ]
>   make[4]: *** No rule to make target 'arch/sh/boot/compressed/vmlinux.bin.', needed by 'arch/sh/boot/compressed/piggy.o'.  Stop.
>   make[3]: *** [/home/masahiro/linux~/arch/sh/boot/Makefile:40: arch/sh/boot/compressed/vmlinux] Error 2
>   make[2]: *** [/home/masahiro/linux~/arch/sh/Makefile:194: zImage] Error 2
>   make[1]: *** [/home/masahiro/linux~/Makefile:350: __build_one_by_one] Error 2
>   make[1]: Leaving directory '/home/masahiro/linux~/foo/bar'
>   make: *** [Makefile:219: __sub-make] Error 2
> 
> The maintainer of GNU Make stated that there is no consistent way to
> export variables that do not meet the shell's naming criteria.
> (https://savannah.gnu.org/bugs/?55719)
> 
> Consequently, you cannot use hyphens in exported variables.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>

> 
>  arch/sh/boot/Makefile            | 16 ++++++++--------
>  arch/sh/boot/compressed/Makefile |  2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/sh/boot/Makefile b/arch/sh/boot/Makefile
> index 5c123f5b2797..1f5d2df3c7e0 100644
> --- a/arch/sh/boot/Makefile
> +++ b/arch/sh/boot/Makefile
> @@ -19,12 +19,12 @@ CONFIG_ZERO_PAGE_OFFSET	?= 0x00001000
>  CONFIG_ENTRY_OFFSET	?= 0x00001000
>  CONFIG_PHYSICAL_START	?= $(CONFIG_MEMORY_START)
>  
> -suffix-y := bin
> -suffix-$(CONFIG_KERNEL_GZIP)	:= gz
> -suffix-$(CONFIG_KERNEL_BZIP2)	:= bz2
> -suffix-$(CONFIG_KERNEL_LZMA)	:= lzma
> -suffix-$(CONFIG_KERNEL_XZ)	:= xz
> -suffix-$(CONFIG_KERNEL_LZO)	:= lzo
> +suffix_y := bin
> +suffix_$(CONFIG_KERNEL_GZIP)	:= gz
> +suffix_$(CONFIG_KERNEL_BZIP2)	:= bz2
> +suffix_$(CONFIG_KERNEL_LZMA)	:= lzma
> +suffix_$(CONFIG_KERNEL_XZ)	:= xz
> +suffix_$(CONFIG_KERNEL_LZO)	:= lzo
>  
>  targets := zImage vmlinux.srec romImage uImage uImage.srec uImage.gz \
>  	   uImage.bz2 uImage.lzma uImage.xz uImage.lzo uImage.bin \
> @@ -106,10 +106,10 @@ OBJCOPYFLAGS_uImage.srec := -I binary -O srec
>  $(obj)/uImage.srec: $(obj)/uImage FORCE
>  	$(call if_changed,objcopy)
>  
> -$(obj)/uImage: $(obj)/uImage.$(suffix-y)
> +$(obj)/uImage: $(obj)/uImage.$(suffix_y)
>  	@ln -sf $(notdir $<) $@
>  	@echo '  Image $@ is ready'
>  
>  export CONFIG_PAGE_OFFSET CONFIG_MEMORY_START CONFIG_BOOT_LINK_OFFSET \
>         CONFIG_PHYSICAL_START CONFIG_ZERO_PAGE_OFFSET CONFIG_ENTRY_OFFSET \
> -       KERNEL_MEMORY suffix-y
> +       KERNEL_MEMORY suffix_y
> diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
> index cf3174df7859..c1eb9a62de55 100644
> --- a/arch/sh/boot/compressed/Makefile
> +++ b/arch/sh/boot/compressed/Makefile
> @@ -64,5 +64,5 @@ OBJCOPYFLAGS += -R .empty_zero_page
>  
>  LDFLAGS_piggy.o := -r --format binary --oformat $(ld-bfd) -T
>  
> -$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.$(suffix-y) FORCE
> +$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.$(suffix_y) FORCE
>  	$(call if_changed,ld)
> -- 
> 2.32.0
> 
