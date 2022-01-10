Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38ED489790
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 12:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244738AbiAJLez (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 06:34:55 -0500
Received: from mail.avm.de ([212.42.244.119]:44698 "EHLO mail.avm.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244778AbiAJLdf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jan 2022 06:33:35 -0500
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon, 10 Jan 2022 12:33:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1641814411; bh=IQKaqdH156p/wZTHmMcpjgJLGYbIE+1wmtxpxVKGWnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x24Mfq+1pm4llZwx/h12m3JmGOYXPzWlKDP1ihlhwctD1hD5KwtwOGidaI8nXi421
         Ucmi4qX/5YjOb4P4NIatkVy0L3vn4wPNstHeIMhK+VeEVnOYUv4TJR/9px2R8trmQX
         X3A5rB7kckMBGe0QNIpDAN6oAxilVTi+ioVTXYL0=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPSA id D76B880514;
        Mon, 10 Jan 2022 12:33:30 +0100 (CET)
Date:   Mon, 10 Jan 2022 12:33:29 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/5] arch: decompressor: remove useless vmlinux.bin.all-y
Message-ID: <YdwZiSAMs4PYR+S8@buildd.core.avm.de>
References: <20220109181529.351420-1-masahiroy@kernel.org>
 <20220109181529.351420-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220109181529.351420-4-masahiroy@kernel.org>
X-purgate-ID: 149429::1641814410-0000056E-73D66413/0/0
X-purgate-type: clean
X-purgate-size: 5313
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 10, 2022 at 03:15:28AM +0900, Masahiro Yamada wrote:
> Presumably, arch/{parisc,s390,sh}/boot/compressed/Makefile copied
> arch/x86/boot/compressed/Makefile, but vmlinux.bin.all-y is useless
> here because it is the same as $(obj)/vmlinux.bin.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>

> 
>  arch/parisc/boot/compressed/Makefile | 14 ++++++--------
>  arch/s390/boot/compressed/Makefile   | 16 +++++++---------
>  arch/sh/boot/compressed/Makefile     | 12 +++++-------
>  3 files changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
> index 2640f72d69ce..877a7099b5e1 100644
> --- a/arch/parisc/boot/compressed/Makefile
> +++ b/arch/parisc/boot/compressed/Makefile
> @@ -58,8 +58,6 @@ OBJCOPYFLAGS_vmlinux.bin := -R .comment -R .note -S
>  $(obj)/vmlinux.bin: vmlinux FORCE
>  	$(call if_changed,objcopy)
>  
> -vmlinux.bin.all-y := $(obj)/vmlinux.bin
> -
>  suffix-$(CONFIG_KERNEL_GZIP)  := gz
>  suffix-$(CONFIG_KERNEL_BZIP2) := bz2
>  suffix-$(CONFIG_KERNEL_LZ4)  := lz4
> @@ -67,17 +65,17 @@ suffix-$(CONFIG_KERNEL_LZMA)  := lzma
>  suffix-$(CONFIG_KERNEL_LZO)  := lzo
>  suffix-$(CONFIG_KERNEL_XZ)  := xz
>  
> -$(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,gzip)
> -$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,bzip2_with_size)
> -$(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.lz4: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,lz4_with_size)
> -$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,lzma_with_size)
> -$(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,lzo_with_size)
> -$(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.xz: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,xzkern_with_size)
>  
>  LDFLAGS_piggy.o := -r --format binary --oformat $(LD_BFD) -T
> diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
> index 8ea880b7c3ec..d04e0e7de0b3 100644
> --- a/arch/s390/boot/compressed/Makefile
> +++ b/arch/s390/boot/compressed/Makefile
> @@ -58,8 +58,6 @@ OBJCOPYFLAGS_vmlinux.bin := -O binary --remove-section=.comment --remove-section
>  $(obj)/vmlinux.bin: vmlinux FORCE
>  	$(call if_changed,objcopy)
>  
> -vmlinux.bin.all-y := $(obj)/vmlinux.bin
> -
>  suffix-$(CONFIG_KERNEL_GZIP)  := .gz
>  suffix-$(CONFIG_KERNEL_BZIP2) := .bz2
>  suffix-$(CONFIG_KERNEL_LZ4)  := .lz4
> @@ -68,19 +66,19 @@ suffix-$(CONFIG_KERNEL_LZO)  := .lzo
>  suffix-$(CONFIG_KERNEL_XZ)  := .xz
>  suffix-$(CONFIG_KERNEL_ZSTD)  := .zst
>  
> -$(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,gzip)
> -$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,bzip2_with_size)
> -$(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.lz4: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,lz4_with_size)
> -$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,lzma_with_size)
> -$(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,lzo_with_size)
> -$(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.xz: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,xzkern_with_size)
> -$(obj)/vmlinux.bin.zst: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.zst: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,zstd22_with_size)
>  
>  OBJCOPYFLAGS_piggy.o := -I binary -O elf64-s390 -B s390:64-bit --rename-section .data=.vmlinux.bin.compressed
> diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
> index a6808a403f4b..591125c42d49 100644
> --- a/arch/sh/boot/compressed/Makefile
> +++ b/arch/sh/boot/compressed/Makefile
> @@ -47,17 +47,15 @@ $(obj)/vmlinux: $(addprefix $(obj)/, $(OBJECTS)) FORCE
>  $(obj)/vmlinux.bin: vmlinux FORCE
>  	$(call if_changed,objcopy)
>  
> -vmlinux.bin.all-y := $(obj)/vmlinux.bin
> -
> -$(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,gzip)
> -$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,bzip2_with_size)
> -$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,lzma_with_size)
> -$(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.xz: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,xzkern_with_size)
> -$(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
> +$(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,lzo_with_size)
>  
>  OBJCOPYFLAGS += -R .empty_zero_page
> -- 
> 2.32.0
> 
