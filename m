Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0D048978E
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 12:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244826AbiAJLey (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 06:34:54 -0500
Received: from mail.avm.de ([212.42.244.119]:44686 "EHLO mail.avm.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244832AbiAJLdY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jan 2022 06:33:24 -0500
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon, 10 Jan 2022 12:33:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1641814397; bh=+1/wurvzbOmSe9efEhHX6Z3P1rikL+W5V03HkaE8L2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ybNoF1gdbOpO3phSD0GVxVGYaUoRePk/wE2aAH1xiFwVPFCWilCajAxhWBqzkLK9T
         7XxiFCWUdOnFUZurNtAkxQKFLYxdgTdia713q65rAlVmZbKDxudOE6Uq7us9ED+YDg
         eDkUljZmqWEd7+Sld1mmS7QM+ZCFIqQDdHBD4EM0=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPSA id 981BF80514;
        Mon, 10 Jan 2022 12:33:16 +0100 (CET)
Date:   Mon, 10 Jan 2022 12:33:15 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/5] kbuild: rename cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd22}
Message-ID: <YdwZe9DHJZUaa6aO@buildd.core.avm.de>
References: <20220109181529.351420-1-masahiroy@kernel.org>
 <20220109181529.351420-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220109181529.351420-3-masahiroy@kernel.org>
X-purgate-ID: 149429::1641814397-0000056E-B9D03EAB/0/0
X-purgate-type: clean
X-purgate-size: 13163
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 10, 2022 at 03:15:27AM +0900, Masahiro Yamada wrote:
> GZIP-compressed files end with 4 byte data that represents the size
> of the original input. The decompressors (the self-extracting kernel)
> exploit it to know the vmlinux size beforehand. To mimic the GZIP's
> trailer, Kbuild provides cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd22}.
> Unfortunately these macros are used everywhere despite the appended
> size data is only useful for the decompressors.
> 
> There is no guarantee that such hand-crafted trailers are safely ignored.
> In fact, the kernel refuses compressed initramdisks with the garbage
> data. That is why usr/Makefile overrides size_append to make it no-op.
> 
> To limit the use of such broken compressed files, this commit renames
> the existing macros as follows:
> 
>   cmd_bzip2   --> cmd_bzip2_with_size
>   cmd_lzma    --> cmd_lzma_with_size
>   cmd_lzo     --> cmd_lzo_with_size
>   cmd_lz4     --> cmd_lz4_with_size
>   cmd_xzkern  --> cmd_xzkern_with_size
>   cmd_zstd22  --> cmd_zstd22_with_size
> 
> To keep the decompressors working, I updated the following Makefiles
> accordingly:
> 
>   arch/arm/boot/compressed/Makefile
>   arch/h8300/boot/compressed/Makefile
>   arch/mips/boot/compressed/Makefile
>   arch/parisc/boot/compressed/Makefile
>   arch/s390/boot/compressed/Makefile
>   arch/sh/boot/compressed/Makefile
>   arch/x86/boot/compressed/Makefile
> 
> I reused the current macro names for the normal usecases; they produce
> the compressed data in the proper format.
> 
> I did not touch the following:
> 
>   arch/arc/boot/Makefile
>   arch/arm64/boot/Makefile
>   arch/csky/boot/Makefile
>   arch/mips/boot/Makefile
>   arch/riscv/boot/Makefile
>   arch/sh/boot/Makefile
>   kernel/Makefile
> 
> This means those Makefiles will stop appending the size data.
> 
> I dropped the 'override size_append' hack from usr/Makefile.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>

> 
>  arch/arm/boot/compressed/Makefile    |  8 ++++----
>  arch/h8300/boot/compressed/Makefile  |  4 +++-
>  arch/mips/boot/compressed/Makefile   | 12 +++++------
>  arch/parisc/boot/compressed/Makefile | 10 +++++-----
>  arch/s390/boot/compressed/Makefile   | 12 +++++------
>  arch/sh/boot/compressed/Makefile     |  8 ++++----
>  arch/x86/boot/compressed/Makefile    | 12 +++++------
>  scripts/Makefile.lib                 | 30 ++++++++++++++++++++++------
>  usr/Makefile                         |  5 -----
>  9 files changed, 58 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 91265e7ff672..adc0e318a1ea 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -77,10 +77,10 @@ CPPFLAGS_vmlinux.lds += -DTEXT_OFFSET="$(TEXT_OFFSET)"
>  CPPFLAGS_vmlinux.lds += -DMALLOC_SIZE="$(MALLOC_SIZE)"
>  
>  compress-$(CONFIG_KERNEL_GZIP) = gzip
> -compress-$(CONFIG_KERNEL_LZO)  = lzo
> -compress-$(CONFIG_KERNEL_LZMA) = lzma
> -compress-$(CONFIG_KERNEL_XZ)   = xzkern
> -compress-$(CONFIG_KERNEL_LZ4)  = lz4
> +compress-$(CONFIG_KERNEL_LZO)  = lzo_with_size
> +compress-$(CONFIG_KERNEL_LZMA) = lzma_with_size
> +compress-$(CONFIG_KERNEL_XZ)   = xzkern_with_size
> +compress-$(CONFIG_KERNEL_LZ4)  = lz4_with_size
>  
>  libfdt_objs := fdt_rw.o fdt_ro.o fdt_wip.o fdt.o
>  
> diff --git a/arch/h8300/boot/compressed/Makefile b/arch/h8300/boot/compressed/Makefile
> index 5942793f77a0..6ab2fa5ba105 100644
> --- a/arch/h8300/boot/compressed/Makefile
> +++ b/arch/h8300/boot/compressed/Makefile
> @@ -30,9 +30,11 @@ $(obj)/vmlinux.bin: vmlinux FORCE
>  
>  suffix-$(CONFIG_KERNEL_GZIP)    := gzip
>  suffix-$(CONFIG_KERNEL_LZO)     := lzo
> +compress-$(CONFIG_KERNEL_GZIP)  := gzip
> +compress-$(CONFIG_KERNEL_LZO)   := lzo_with_size
>  
>  $(obj)/vmlinux.bin.$(suffix-y): $(obj)/vmlinux.bin FORCE
> -	$(call if_changed,$(suffix-y))
> +	$(call if_changed,$(compress-y))
>  
>  LDFLAGS_piggy.o := -r --format binary --oformat elf32-h8300-linux -T
>  OBJCOPYFLAGS := -O binary
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index f27cf31b4140..832f8001d7d9 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -64,12 +64,12 @@ $(obj)/vmlinux.bin: $(KBUILD_IMAGE) FORCE
>  	$(call if_changed,objcopy)
>  
>  tool_$(CONFIG_KERNEL_GZIP)    = gzip
> -tool_$(CONFIG_KERNEL_BZIP2)   = bzip2
> -tool_$(CONFIG_KERNEL_LZ4)     = lz4
> -tool_$(CONFIG_KERNEL_LZMA)    = lzma
> -tool_$(CONFIG_KERNEL_LZO)     = lzo
> -tool_$(CONFIG_KERNEL_XZ)      = xzkern
> -tool_$(CONFIG_KERNEL_ZSTD)    = zstd22
> +tool_$(CONFIG_KERNEL_BZIP2)   = bzip2_with_size
> +tool_$(CONFIG_KERNEL_LZ4)     = lz4_with_size
> +tool_$(CONFIG_KERNEL_LZMA)    = lzma_with_size
> +tool_$(CONFIG_KERNEL_LZO)     = lzo_with_size
> +tool_$(CONFIG_KERNEL_XZ)      = xzkern_with_size
> +tool_$(CONFIG_KERNEL_ZSTD)    = zstd22_with_size
>  
>  targets += vmlinux.bin.z
>  
> diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
> index bf4f2891d0b7..2640f72d69ce 100644
> --- a/arch/parisc/boot/compressed/Makefile
> +++ b/arch/parisc/boot/compressed/Makefile
> @@ -70,15 +70,15 @@ suffix-$(CONFIG_KERNEL_XZ)  := xz
>  $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
>  	$(call if_changed,gzip)
>  $(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,bzip2)
> +	$(call if_changed,bzip2_with_size)
>  $(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,lz4)
> +	$(call if_changed,lz4_with_size)
>  $(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,lzma)
> +	$(call if_changed,lzma_with_size)
>  $(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,lzo)
> +	$(call if_changed,lzo_with_size)
>  $(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,xzkern)
> +	$(call if_changed,xzkern_with_size)
>  
>  LDFLAGS_piggy.o := -r --format binary --oformat $(LD_BFD) -T
>  $(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.$(suffix-y) FORCE
> diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
> index 3b860061e84d..8ea880b7c3ec 100644
> --- a/arch/s390/boot/compressed/Makefile
> +++ b/arch/s390/boot/compressed/Makefile
> @@ -71,17 +71,17 @@ suffix-$(CONFIG_KERNEL_ZSTD)  := .zst
>  $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
>  	$(call if_changed,gzip)
>  $(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,bzip2)
> +	$(call if_changed,bzip2_with_size)
>  $(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,lz4)
> +	$(call if_changed,lz4_with_size)
>  $(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,lzma)
> +	$(call if_changed,lzma_with_size)
>  $(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,lzo)
> +	$(call if_changed,lzo_with_size)
>  $(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,xzkern)
> +	$(call if_changed,xzkern_with_size)
>  $(obj)/vmlinux.bin.zst: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,zstd22)
> +	$(call if_changed,zstd22_with_size)
>  
>  OBJCOPYFLAGS_piggy.o := -I binary -O elf64-s390 -B s390:64-bit --rename-section .data=.vmlinux.bin.compressed
>  $(obj)/piggy.o: $(obj)/vmlinux.bin$(suffix-y) FORCE
> diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
> index c1eb9a62de55..a6808a403f4b 100644
> --- a/arch/sh/boot/compressed/Makefile
> +++ b/arch/sh/boot/compressed/Makefile
> @@ -52,13 +52,13 @@ vmlinux.bin.all-y := $(obj)/vmlinux.bin
>  $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
>  	$(call if_changed,gzip)
>  $(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,bzip2)
> +	$(call if_changed,bzip2_with_size)
>  $(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,lzma)
> +	$(call if_changed,lzma_with_size)
>  $(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,xzkern)
> +	$(call if_changed,xzkern_with_size)
>  $(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,lzo)
> +	$(call if_changed,lzo_with_size)
>  
>  OBJCOPYFLAGS += -R .empty_zero_page
>  
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 431bf7f846c3..2825c74bcae3 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -123,17 +123,17 @@ vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) += $(obj)/vmlinux.relocs
>  $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
>  	$(call if_changed,gzip)
>  $(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,bzip2)
> +	$(call if_changed,bzip2_with_size)
>  $(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,lzma)
> +	$(call if_changed,lzma_with_size)
>  $(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,xzkern)
> +	$(call if_changed,xzkern_with_size)
>  $(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,lzo)
> +	$(call if_changed,lzo_with_size)
>  $(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,lz4)
> +	$(call if_changed,lz4_with_size)
>  $(obj)/vmlinux.bin.zst: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,zstd22)
> +	$(call if_changed,zstd22_with_size)
>  
>  suffix-$(CONFIG_KERNEL_GZIP)	:= gz
>  suffix-$(CONFIG_KERNEL_BZIP2)	:= bz2
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 5366466ea0e4..4207a72d429f 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -395,19 +395,31 @@ printf "%08x\n" $$dec_size |						\
>  )
>  
>  quiet_cmd_bzip2 = BZIP2   $@
> -      cmd_bzip2 = { cat $(real-prereqs) | $(KBZIP2) -9; $(size_append); } > $@
> +      cmd_bzip2 = cat $(real-prereqs) | $(KBZIP2) -9 > $@
> +
> +quiet_cmd_bzip2_with_size = BZIP2   $@
> +      cmd_bzip2_with_size = { cat $(real-prereqs) | $(KBZIP2) -9; $(size_append); } > $@
>  
>  # Lzma
>  # ---------------------------------------------------------------------------
>  
>  quiet_cmd_lzma = LZMA    $@
> -      cmd_lzma = { cat $(real-prereqs) | $(LZMA) -9; $(size_append); } > $@
> +      cmd_lzma = cat $(real-prereqs) | $(LZMA) -9 > $@
> +
> +quiet_cmd_lzma_with_size = LZMA    $@
> +      cmd_lzma_with_size = { cat $(real-prereqs) | $(LZMA) -9; $(size_append); } > $@
>  
>  quiet_cmd_lzo = LZO     $@
> -      cmd_lzo = { cat $(real-prereqs) | $(KLZOP) -9; $(size_append); } > $@
> +      cmd_lzo = cat $(real-prereqs) | $(KLZOP) -9 > $@
> +
> +quiet_cmd_lzo_with_size = LZO     $@
> +      cmd_lzo_with_size = { cat $(real-prereqs) | $(KLZOP) -9; $(size_append); } > $@
>  
>  quiet_cmd_lz4 = LZ4     $@
> -      cmd_lz4 = { cat $(real-prereqs) | $(LZ4) -l -c1 stdin stdout; \
> +      cmd_lz4 = cat $(real-prereqs) | $(LZ4) -l -c1 stdin stdout > $@
> +
> +quiet_cmd_lz4_with_size = LZ4     $@
> +      cmd_lz4_with_size = { cat $(real-prereqs) | $(LZ4) -l -c1 stdin stdout; \
>                    $(size_append); } > $@
>  
>  # U-Boot mkimage
> @@ -450,7 +462,10 @@ quiet_cmd_uimage = UIMAGE  $@
>  # big dictionary would increase the memory usage too much in the multi-call
>  # decompression mode. A BCJ filter isn't used either.
>  quiet_cmd_xzkern = XZKERN  $@
> -      cmd_xzkern = { cat $(real-prereqs) | sh $(srctree)/scripts/xz_wrap.sh; \
> +      cmd_xzkern = cat $(real-prereqs) | sh $(srctree)/scripts/xz_wrap.sh > $@
> +
> +quiet_cmd_xzkern_with_size = XZKERN  $@
> +      cmd_xzkern_with_size = { cat $(real-prereqs) | sh $(srctree)/scripts/xz_wrap.sh; \
>                       $(size_append); } > $@
>  
>  quiet_cmd_xzmisc = XZMISC  $@
> @@ -476,7 +491,10 @@ quiet_cmd_zstd = ZSTD    $@
>        cmd_zstd = cat $(real-prereqs) | $(ZSTD) -19 > $@
>  
>  quiet_cmd_zstd22 = ZSTD22  $@
> -      cmd_zstd22 = { cat $(real-prereqs) | $(ZSTD) -22 --ultra; $(size_append); } > $@
> +      cmd_zstd22 = cat $(real-prereqs) | $(ZSTD) -22 --ultra > $@
> +
> +quiet_cmd_zstd22_with_size = ZSTD22  $@
> +      cmd_zstd22_with_size = { cat $(real-prereqs) | $(ZSTD) -22 --ultra; $(size_append); } > $@
>  
>  # ASM offsets
>  # ---------------------------------------------------------------------------
> diff --git a/usr/Makefile b/usr/Makefile
> index b1a81a40eab1..7b89c0175a3a 100644
> --- a/usr/Makefile
> +++ b/usr/Makefile
> @@ -3,11 +3,6 @@
>  # kbuild file for usr/ - including initramfs image
>  #
>  
> -# cmd_bzip2, cmd_lzma, cmd_lzo, cmd_lz4 from scripts/Makefile.lib appends the
> -# size at the end of the compressed file, which unfortunately does not work
> -# with unpack_to_rootfs(). Make size_append no-op.
> -override size_append := :
> -
>  compress-y					:= shipped
>  compress-$(CONFIG_INITRAMFS_COMPRESSION_GZIP)	:= gzip
>  compress-$(CONFIG_INITRAMFS_COMPRESSION_BZIP2)	:= bzip2
> -- 
> 2.32.0
> 
