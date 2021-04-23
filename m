Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBAC368BF2
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 06:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhDWEXU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 00:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWEXU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2021 00:23:20 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DB0C06174A
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2021 21:22:44 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id d10so34342871pgf.12
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2021 21:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=QTiEFaxluq5/WKcFJk9m1/B9kx+VMYaKp2N5owqIZN8=;
        b=H16206A6cctZdSd+NQkPl9LOA6vKp4qRFdNrN75XBgqQeQjDIbG3hyUCyEfH4bWwZV
         amfL257uOww4luQnp6AIt9AN2z9X1mo16G1JlilEI2rKccCyPG/cacjGGXzRm0CkyJFz
         l4zm1W9Tntim3P5xOgxusPXzqxDjapBa8EgTdWIAlXwNc9cQVSabPdym7RmmI5AeJV8U
         N0/84nn1c1Zf/VP64fULgVa/8G3vi4Yok5H/HfGBTOxinVvspCXTBlf41kLXgPs9qM6+
         3A6G61qDNjRbU6foMKPswrSxXUsthYHRYlj6J5+O65ol+bQUID+QXAupYpm9Qyn5mrL3
         GXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=QTiEFaxluq5/WKcFJk9m1/B9kx+VMYaKp2N5owqIZN8=;
        b=R1KmniVEuqvOPPfxkJxxqA7tKeQKRPj8L3f2lwCR0yVGrXGTs9SFO1CBU8ONdTp8NM
         I9EpDot2w/mKAnyRBA02IzkCKyBakf7MVykbrgZG9y5s35XO/rnIm1d9a39xnnj7bWpc
         lTFZdVSo0wG6HpdDqNtmDuhCdSLqaivwQIdc4hslStUPU90GsDH9uHcvGV1vCUrZJbzG
         HNkRReXQp563r4hPS7IFw5hHPtd6ytozNefkQ41xn8fkDnQa5YvYoBA5l8iD37c+3N9t
         SuJEG+8fMVhThi6XeF1AgwKCSxxnNykH2llU4k2R2TOOgCq40sfoj1KIdw+Lq7QeEaUt
         TdaQ==
X-Gm-Message-State: AOAM532t2GUwEZDhL3qE/Gi6t2QUpzUSE2a4v5FENRs6K+KbUt8Ud9Yn
        eq1kuATn2UeDofWX4OD42m8wG+X1SiV7Xob3
X-Google-Smtp-Source: ABdhPJwjfiZieUq7m81KeC5cUozRlNS7NyT/qHJQM9uE2bjoQY/VxwHju+DZomT2IRs7VeTvmd6BLA==
X-Received: by 2002:aa7:9f5d:0:b029:265:e8b5:ecd0 with SMTP id h29-20020aa79f5d0000b0290265e8b5ecd0mr2048066pfr.26.1619151763526;
        Thu, 22 Apr 2021 21:22:43 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d3sm6307181pjw.35.2021.04.22.21.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 21:22:42 -0700 (PDT)
Date:   Thu, 22 Apr 2021 21:22:42 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 21:16:28 PDT (-0700)
Subject:     Re: [PATCH v8] RISC-V: enable XIP
In-Reply-To: <20210413063514.23105-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        vitaly.wool@konsulko.com, alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-308e5471-7834-470f-8111-9d140ad33ac9@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 12 Apr 2021 23:35:14 PDT (-0700), alex@ghiti.fr wrote:
> From: Vitaly Wool <vitaly.wool@konsulko.com>
>
> Introduce XIP (eXecute In Place) support for RISC-V platforms.
> It allows code to be executed directly from non-volatile storage
> directly addressable by the CPU, such as QSPI NOR flash which can
> be found on many RISC-V platforms. This makes way for significant
> optimization of RAM footprint. The XIP kernel is not compressed
> since it has to run directly from flash, so it will occupy more
> space on the non-volatile storage. The physical flash address used
> to link the kernel object files and for storing it has to be known
> at compile time and is represented by a Kconfig option.
>
> XIP on RISC-V will for the time being only work on MMU-enabled
> kernels.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr> [ Rebase on top of "Move
> kernel mapping outside the linear mapping" ]
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> ---
>  arch/riscv/Kconfig                  |  55 +++++++++++-
>  arch/riscv/Makefile                 |   8 +-
>  arch/riscv/boot/Makefile            |  13 +++
>  arch/riscv/include/asm/page.h       |  21 +++++
>  arch/riscv/include/asm/pgtable.h    |  25 +++++-
>  arch/riscv/kernel/head.S            |  46 +++++++++-
>  arch/riscv/kernel/head.h            |   3 +
>  arch/riscv/kernel/setup.c           |  10 ++-
>  arch/riscv/kernel/vmlinux-xip.lds.S | 133 ++++++++++++++++++++++++++++
>  arch/riscv/kernel/vmlinux.lds.S     |   6 ++
>  arch/riscv/mm/init.c                | 115 ++++++++++++++++++++++--
>  11 files changed, 418 insertions(+), 17 deletions(-)
>  create mode 100644 arch/riscv/kernel/vmlinux-xip.lds.S
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8ea60a0a19ae..7c7efdd67a10 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -28,7 +28,7 @@ config RISCV
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_SET_DIRECT_MAP
>  	select ARCH_HAS_SET_MEMORY
> -	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
> +	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL

We now also have STRICT_MODULE_RWX, which causes a merge conflict.  I've 
added both as !XIP_KERNEL, though TBH I'm not even sure thot modules 
make any sense with XIP.

>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
> @@ -441,7 +441,7 @@ config EFI_STUB
>
>  config EFI
>  	bool "UEFI runtime support"
> -	depends on OF
> +	depends on OF && !XIP_KERNEL
>  	select LIBFDT
>  	select UCS2_STRING
>  	select EFI_PARAMS_FROM_FDT
> @@ -465,11 +465,60 @@ config STACKPROTECTOR_PER_TASK
>  	def_bool y
>  	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
>
> +config PHYS_RAM_BASE_FIXED
> +	bool "Explicitly specified physical RAM address"
> +	default n
> +
> +config PHYS_RAM_BASE
> +	hex "Platform Physical RAM address"
> +	depends on PHYS_RAM_BASE_FIXED
> +	default "0x80000000"
> +	help
> +	  This is the physical address of RAM in the system. It has to be
> +	  explicitly specified to run early relocations of read-write data
> +	  from flash to RAM.
> +
> +config XIP_KERNEL
> +	bool "Kernel Execute-In-Place from ROM"
> +	depends on MMU && SPARSEMEM
> +	select PHYS_RAM_BASE_FIXED
> +	help
> +	  Execute-In-Place allows the kernel to run from non-volatile storage
> +	  directly addressable by the CPU, such as NOR flash. This saves RAM
> +	  space since the text section of the kernel is not loaded from flash
> +	  to RAM.  Read-write sections, such as the data section and stack,
> +	  are still copied to RAM.  The XIP kernel is not compressed since
> +	  it has to run directly from flash, so it will take more space to
> +	  store it.  The flash address used to link the kernel object files,
> +	  and for storing it, is configuration dependent. Therefore, if you
> +	  say Y here, you must know the proper physical address where to
> +	  store the kernel image depending on your own flash memory usage.
> +
> +	  Also note that the make target becomes "make xipImage" rather than
> +	  "make zImage" or "make Image".  The final kernel binary to put in
> +	  ROM memory will be arch/riscv/boot/xipImage.
> +
> +	  SPARSEMEM is required because the kernel text and rodata that are
> +	  flash resident are not backed by memmap, then any attempt to get
> +	  a struct page on those regions will trigger a fault.
> +
> +	  If unsure, say N.
> +
> +config XIP_PHYS_ADDR
> +	hex "XIP Kernel Physical Location"
> +	depends on XIP_KERNEL
> +	default "0x21000000"
> +	help
> +	  This is the physical address in your flash memory the kernel will
> +	  be linked for and stored to.  This address is dependent on your
> +	  own flash usage.
> +
>  endmenu
>
>  config BUILTIN_DTB
> -	def_bool n
> +	bool
>  	depends on OF
> +	default y if XIP_KERNEL
>
>  menu "Power management options"
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 1368d943f1f3..8fcbec03974d 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -82,7 +82,11 @@ CHECKFLAGS += -D__riscv -D__riscv_xlen=$(BITS)
>
>  # Default target when executing plain make
>  boot		:= arch/riscv/boot
> +ifeq ($(CONFIG_XIP_KERNEL),y)
> +KBUILD_IMAGE := $(boot)/xipImage
> +else
>  KBUILD_IMAGE	:= $(boot)/Image.gz
> +endif
>
>  head-y := arch/riscv/kernel/head.o
>
> @@ -95,12 +99,14 @@ PHONY += vdso_install
>  vdso_install:
>  	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
>
> +ifneq ($(CONFIG_XIP_KERNEL),y)
>  ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN),yy)
>  KBUILD_IMAGE := $(boot)/loader.bin
>  else
>  KBUILD_IMAGE := $(boot)/Image.gz
>  endif
> -BOOT_TARGETS := Image Image.gz loader loader.bin
> +endif
> +BOOT_TARGETS := Image Image.gz loader loader.bin xipImage
>
>  all:	$(notdir $(KBUILD_IMAGE))
>
> diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
> index 03404c84f971..6bf299f70c27 100644
> --- a/arch/riscv/boot/Makefile
> +++ b/arch/riscv/boot/Makefile
> @@ -17,8 +17,21 @@
>  KCOV_INSTRUMENT := n
>
>  OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
> +OBJCOPYFLAGS_xipImage :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
>
>  targets := Image Image.* loader loader.o loader.lds loader.bin
> +targets := Image Image.* loader loader.o loader.lds loader.bin xipImage
> +
> +ifeq ($(CONFIG_XIP_KERNEL),y)
> +
> +quiet_cmd_mkxip = $(quiet_cmd_objcopy)
> +cmd_mkxip = $(cmd_objcopy)
> +
> +$(obj)/xipImage: vmlinux FORCE
> +	$(call if_changed,mkxip)
> +	@$(kecho) '  Physical Address of xipImage: $(CONFIG_XIP_PHYS_ADDR)'
> +
> +endif
>
>  $(obj)/Image: vmlinux FORCE
>  	$(call if_changed,objcopy)
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 22cfb2be60dc..635c6b486806 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -91,6 +91,9 @@ typedef struct page *pgtable_t;
>  #ifdef CONFIG_MMU
>  extern unsigned long va_pa_offset;
>  extern unsigned long va_kernel_pa_offset;
> +#ifdef CONFIG_XIP_KERNEL
> +extern unsigned long va_kernel_xip_pa_offset;
> +#endif
>  extern unsigned long pfn_base;
>  #define ARCH_PFN_OFFSET		(pfn_base)
>  #else
> @@ -102,11 +105,29 @@ extern unsigned long pfn_base;
>  extern unsigned long kernel_virt_addr;
>
>  #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + va_pa_offset))
> +#ifdef CONFIG_XIP_KERNEL
> +#define kernel_mapping_pa_to_va(y)	({						\
> +	unsigned long _y = y;								\
> +	(_y >= CONFIG_PHYS_RAM_BASE) ?							\
> +		(void *)((unsigned long)(_y) + va_kernel_pa_offset + XIP_OFFSET) :	\
> +		(void *)((unsigned long)(_y) + va_kernel_xip_pa_offset);		\
> +	})
> +#else
>  #define kernel_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + va_kernel_pa_offset))
> +#endif
>  #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
>
>  #define linear_mapping_va_to_pa(x)	((unsigned long)(x) - va_pa_offset)
> +#ifdef CONFIG_XIP_KERNEL
> +#define kernel_mapping_va_to_pa(y) ({						\
> +	unsigned long _y = y;							\
> +	(_y < kernel_virt_addr + XIP_OFFSET) ?					\
> +		((unsigned long)(_y) - va_kernel_xip_pa_offset) :		\
> +		((unsigned long)(_y) - va_kernel_pa_offset - XIP_OFFSET);	\
> +	})
> +#else
>  #define kernel_mapping_va_to_pa(x)	((unsigned long)(x) - va_kernel_pa_offset)
> +#endif
>  #define __va_to_pa_nodebug(x)	({						\
>  	unsigned long _x = x;							\
>  	(_x < kernel_virt_addr) ?						\
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 80e63a93e903..c2dc4f83eed8 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -64,6 +64,19 @@
>  #define FIXADDR_SIZE     PGDIR_SIZE
>  #endif
>  #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
> +
> +#ifdef CONFIG_XIP_KERNEL
> +#define XIP_OFFSET		SZ_8M
> +#define XIP_FIXUP(addr) ({							\
> +	uintptr_t __a = (uintptr_t)(addr);					\
> +	(__a >= CONFIG_XIP_PHYS_ADDR && __a < CONFIG_XIP_PHYS_ADDR + SZ_16M) ?	\
> +		__a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - XIP_OFFSET :\
> +		__a;								\
> +	})
> +#else
> +#define XIP_FIXUP(addr)		(addr)
> +#endif /* CONFIG_XIP_KERNEL */
> +
>  #endif
>
>  #ifndef __ASSEMBLY__
> @@ -499,8 +512,16 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>  #define kern_addr_valid(addr)   (1) /* FIXME */
>
>  extern char _start[];
> -extern void *dtb_early_va;
> -extern uintptr_t dtb_early_pa;
> +extern void *_dtb_early_va;
> +extern uintptr_t _dtb_early_pa;
> +#if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_MMU)
> +#define dtb_early_va	(*(void **)XIP_FIXUP(&_dtb_early_va))
> +#define dtb_early_pa	(*(uintptr_t *)XIP_FIXUP(&_dtb_early_pa))
> +#else
> +#define dtb_early_va	_dtb_early_va
> +#define dtb_early_pa	_dtb_early_pa
> +#endif /* CONFIG_XIP_KERNEL */
> +
>  void setup_bootmem(void);
>  void paging_init(void);
>  void misc_mem_init(void);
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 6cb05f22e52a..89cc58ab52b4 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -9,11 +9,23 @@
>  #include <linux/linkage.h>
>  #include <asm/thread_info.h>
>  #include <asm/page.h>
> +#include <asm/pgtable.h>
>  #include <asm/csr.h>
>  #include <asm/hwcap.h>
>  #include <asm/image.h>
>  #include "efi-header.S"
>
> +#ifdef CONFIG_XIP_KERNEL
> +.macro XIP_FIXUP_OFFSET reg
> +	REG_L t0, _xip_fixup
> +	add \reg, \reg, t0
> +.endm
> +_xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
> +#else
> +.macro XIP_FIXUP_OFFSET reg
> +.endm
> +#endif /* CONFIG_XIP_KERNEL */
> +
>  __HEAD
>  ENTRY(_start)
>  	/*
> @@ -70,6 +82,7 @@ pe_head_start:
>  relocate:
>  	/* Relocate return address */
>  	la a1, kernel_virt_addr
> +	XIP_FIXUP_OFFSET a1
>  	REG_L a1, 0(a1)
>  	la a2, _start
>  	sub a1, a1, a2
> @@ -92,6 +105,7 @@ relocate:
>  	 * to ensure the new translations are in use.
>  	 */
>  	la a0, trampoline_pg_dir
> +	XIP_FIXUP_OFFSET a0
>  	srl a0, a0, PAGE_SHIFT
>  	or a0, a0, a1
>  	sfence.vma
> @@ -145,7 +159,9 @@ secondary_start_sbi:
>
>  	slli a3, a0, LGREG
>  	la a4, __cpu_up_stack_pointer
> +	XIP_FIXUP_OFFSET a4
>  	la a5, __cpu_up_task_pointer
> +	XIP_FIXUP_OFFSET a5
>  	add a4, a3, a4
>  	add a5, a3, a5
>  	REG_L sp, (a4)
> @@ -157,6 +173,7 @@ secondary_start_common:
>  #ifdef CONFIG_MMU
>  	/* Enable virtual memory and relocate to virtual address */
>  	la a0, swapper_pg_dir
> +	XIP_FIXUP_OFFSET a0
>  	call relocate
>  #endif
>  	call setup_trap_vector
> @@ -237,12 +254,33 @@ pmp_done:
>  .Lgood_cores:
>  #endif
>
> +#ifndef CONFIG_XIP_KERNEL
>  	/* Pick one hart to run the main boot sequence */
>  	la a3, hart_lottery
>  	li a2, 1
>  	amoadd.w a3, a2, (a3)
>  	bnez a3, .Lsecondary_start
>
> +#else
> +	/* hart_lottery in flash contains a magic number */
> +	la a3, hart_lottery
> +	mv a2, a3
> +	XIP_FIXUP_OFFSET a2
> +	lw t1, (a3)
> +	amoswap.w t0, t1, (a2)
> +	/* first time here if hart_lottery in RAM is not set */
> +	beq t0, t1, .Lsecondary_start
> +
> +	la sp, _end + THREAD_SIZE
> +	XIP_FIXUP_OFFSET sp
> +	mv s0, a0
> +	call __copy_data
> +
> +	/* Restore a0 copy */
> +	mv a0, s0
> +#endif
> +
> +#ifndef CONFIG_XIP_KERNEL
>  	/* Clear BSS for flat non-ELF images */
>  	la a3, __bss_start
>  	la a4, __bss_stop
> @@ -252,15 +290,18 @@ clear_bss:
>  	add a3, a3, RISCV_SZPTR
>  	blt a3, a4, clear_bss
>  clear_bss_done:
> -
> +#endif
>  	/* Save hart ID and DTB physical address */
>  	mv s0, a0
>  	mv s1, a1
> +
>  	la a2, boot_cpu_hartid
> +	XIP_FIXUP_OFFSET a2
>  	REG_S a0, (a2)
>
>  	/* Initialize page tables and relocate to virtual addresses */
>  	la sp, init_thread_union + THREAD_SIZE
> +	XIP_FIXUP_OFFSET sp
>  #ifdef CONFIG_BUILTIN_DTB
>  	la a0, __dtb_start
>  #else
> @@ -269,6 +310,7 @@ clear_bss_done:
>  	call setup_vm
>  #ifdef CONFIG_MMU
>  	la a0, early_pg_dir
> +	XIP_FIXUP_OFFSET a0
>  	call relocate
>  #endif /* CONFIG_MMU */
>
> @@ -293,7 +335,9 @@ clear_bss_done:
>
>  	slli a3, a0, LGREG
>  	la a1, __cpu_up_stack_pointer
> +	XIP_FIXUP_OFFSET a1
>  	la a2, __cpu_up_task_pointer
> +	XIP_FIXUP_OFFSET a2
>  	add a1, a3, a1
>  	add a2, a3, a2
>
> diff --git a/arch/riscv/kernel/head.h b/arch/riscv/kernel/head.h
> index b48dda3d04f6..aabbc3ac3e48 100644
> --- a/arch/riscv/kernel/head.h
> +++ b/arch/riscv/kernel/head.h
> @@ -12,6 +12,9 @@ extern atomic_t hart_lottery;
>
>  asmlinkage void do_page_fault(struct pt_regs *regs);
>  asmlinkage void __init setup_vm(uintptr_t dtb_pa);
> +#ifdef CONFIG_XIP_KERNEL
> +asmlinkage void __init __copy_data(void);
> +#endif
>
>  extern void *__cpu_up_stack_pointer[];
>  extern void *__cpu_up_task_pointer[];
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 30e4af0fd50c..2ddf654c72bb 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -50,7 +50,11 @@ struct screen_info screen_info __section(".data") = {
>   * This is used before the kernel initializes the BSS so it can't be in the
>   * BSS.
>   */
> -atomic_t hart_lottery __section(".sdata");
> +atomic_t hart_lottery __section(".sdata")
> +#ifdef CONFIG_XIP_KERNEL
> += ATOMIC_INIT(0xC001BEEF)
> +#endif
> +;
>  unsigned long boot_cpu_hartid;
>  static DEFINE_PER_CPU(struct cpu, cpu_devices);
>
> @@ -254,7 +258,7 @@ void __init setup_arch(char **cmdline_p)
>  #if IS_ENABLED(CONFIG_BUILTIN_DTB)
>  	unflatten_and_copy_device_tree();
>  #else
> -	if (early_init_dt_verify(__va(dtb_early_pa)))
> +	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
>  		unflatten_device_tree();
>  	else
>  		pr_err("No DTB found in kernel mappings\n");
> @@ -266,7 +270,7 @@ void __init setup_arch(char **cmdline_p)
>  	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
>  		protect_kernel_text_data();
>
> -#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
> +#if defined(CONFIG_64BIT) && defined(CONFIG_MMU) && !defined(CONFIG_XIP_KERNEL)
>  	protect_kernel_linear_mapping_text_rodata();
>  #endif

My tree doesn't look quite like this.  Not sure if I just got the wrong 
version of something, but I didn't have the CONFIG_MMU check.  It turns 
out that, as I was merging this in, I saw that failing allnoconfig 
(which is !MMU).  I went ahead and squashed in

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index ab394d173cd4..3e7930869ee7 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -266,7 +266,7 @@ void __init setup_arch(char **cmdline_p)

 	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
 		protect_kernel_text_data();
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
 		protect_kernel_linear_mapping_text_rodata();
 #endif
 	}

to your memory map rearrangement patch, but I'm a bit worried that I managed to
miss something in the process.

>
> diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmlinux-xip.lds.S
> new file mode 100644
> index 000000000000..4b29b9917f99
> --- /dev/null
> +++ b/arch/riscv/kernel/vmlinux-xip.lds.S
> @@ -0,0 +1,133 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2012 Regents of the University of California
> + * Copyright (C) 2017 SiFive
> + * Copyright (C) 2020 Vitaly Wool, Konsulko AB
> + */
> +
> +#include <asm/pgtable.h>
> +#define LOAD_OFFSET KERNEL_LINK_ADDR
> +/* No __ro_after_init data in the .rodata section - which will always be ro */
> +#define RO_AFTER_INIT_DATA
> +
> +#include <asm/vmlinux.lds.h>
> +#include <asm/page.h>
> +#include <asm/pgtable.h>
> +#include <asm/cache.h>
> +#include <asm/thread_info.h>
> +
> +OUTPUT_ARCH(riscv)
> +ENTRY(_start)
> +
> +jiffies = jiffies_64;
> +
> +SECTIONS
> +{
> +	/* Beginning of code and text segment */
> +	. = LOAD_OFFSET;
> +	_xiprom = .;
> +	_start = .;
> +	HEAD_TEXT_SECTION
> +	INIT_TEXT_SECTION(PAGE_SIZE)
> +	/* we have to discard exit text and such at runtime, not link time */
> +	.exit.text :
> +	{
> +		EXIT_TEXT
> +	}
> +
> +	.text : {
> +		_text = .;
> +		_stext = .;
> +		TEXT_TEXT
> +		SCHED_TEXT
> +		CPUIDLE_TEXT
> +		LOCK_TEXT
> +		KPROBES_TEXT
> +		ENTRY_TEXT
> +		IRQENTRY_TEXT
> +		SOFTIRQENTRY_TEXT
> +		*(.fixup)
> +		_etext = .;
> +	}
> +	RO_DATA(L1_CACHE_BYTES)
> +	.srodata : {
> +		*(.srodata*)
> +	}
> +	.init.rodata : {
> +		INIT_SETUP(16)
> +		INIT_CALLS
> +		CON_INITCALL
> +		INIT_RAM_FS
> +	}
> +	_exiprom = .;			/* End of XIP ROM area */
> +
> +
> +/*
> + * From this point, stuff is considered writable and will be copied to RAM
> + */
> +	__data_loc = ALIGN(16);		/* location in file */
> +	. = LOAD_OFFSET + XIP_OFFSET;	/* location in memory */
> +
> +	_sdata = .;			/* Start of data section */
> +	_data = .;
> +	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
> +	_edata = .;
> +	__start_ro_after_init = .;
> +	.data.ro_after_init : AT(ADDR(.data.ro_after_init) - LOAD_OFFSET) {
> +		*(.data..ro_after_init)
> +	}
> +	__end_ro_after_init = .;
> +
> +	. = ALIGN(PAGE_SIZE);
> +	__init_begin = .;
> +	.init.data : {
> +		INIT_DATA
> +	}
> +	.exit.data : {
> +		EXIT_DATA
> +	}
> +	. = ALIGN(8);
> +	__soc_early_init_table : {
> +		__soc_early_init_table_start = .;
> +		KEEP(*(__soc_early_init_table))
> +		__soc_early_init_table_end = .;
> +	}
> +	__soc_builtin_dtb_table : {
> +		__soc_builtin_dtb_table_start = .;
> +		KEEP(*(__soc_builtin_dtb_table))
> +		__soc_builtin_dtb_table_end = .;
> +	}
> +	PERCPU_SECTION(L1_CACHE_BYTES)
> +
> +	. = ALIGN(PAGE_SIZE);
> +	__init_end = .;
> +
> +	.sdata : {
> +		__global_pointer$ = . + 0x800;
> +		*(.sdata*)
> +		*(.sbss*)
> +	}
> +
> +	BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
> +	EXCEPTION_TABLE(0x10)
> +
> +	.rel.dyn : AT(ADDR(.rel.dyn) - LOAD_OFFSET) {
> +		*(.rel.dyn*)
> +	}
> +
> +	/*
> +	 * End of copied data. We need a dummy section to get its LMA.
> +	 * Also located before final ALIGN() as trailing padding is not stored
> +	 * in the resulting binary file and useless to copy.
> +	 */
> +	.data.endmark : AT(ADDR(.data.endmark) - LOAD_OFFSET) { }
> +	_edata_loc = LOADADDR(.data.endmark);
> +
> +	. = ALIGN(PAGE_SIZE);
> +	_end = .;
> +
> +	STABS_DEBUG
> +	DWARF_DEBUG
> +
> +	DISCARDS
> +}
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index 0726c05e0336..0a59b65cf789 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -4,8 +4,13 @@
>   * Copyright (C) 2017 SiFive
>   */
>
> +#ifdef CONFIG_XIP_KERNEL
> +#include "vmlinux-xip.lds.S"
> +#else
> +
>  #include <asm/pgtable.h>
>  #define LOAD_OFFSET KERNEL_LINK_ADDR
> +
>  #include <asm/vmlinux.lds.h>
>  #include <asm/page.h>
>  #include <asm/cache.h>
> @@ -133,3 +138,4 @@ SECTIONS
>
>  	DISCARDS
>  }
> +#endif /* CONFIG_XIP_KERNEL */
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 093f3a96ecfc..d03e5e43d2d0 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -27,6 +27,9 @@
>
>  unsigned long kernel_virt_addr = KERNEL_LINK_ADDR;
>  EXPORT_SYMBOL(kernel_virt_addr);
> +#ifdef CONFIG_XIP_KERNEL
> +#define kernel_virt_addr       (*((unsigned long *)XIP_FIXUP(&kernel_virt_addr)))
> +#endif
>
>  unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
>  							__page_aligned_bss;
> @@ -34,8 +37,8 @@ EXPORT_SYMBOL(empty_zero_page);
>
>  extern char _start[];
>  #define DTB_EARLY_BASE_VA      PGDIR_SIZE
> -void *dtb_early_va __initdata;
> -uintptr_t dtb_early_pa __initdata;
> +void *_dtb_early_va __initdata;
> +uintptr_t _dtb_early_pa __initdata;
>
>  struct pt_alloc_ops {
>  	pte_t *(*get_pte_virt)(phys_addr_t pa);
> @@ -118,6 +121,10 @@ void __init setup_bootmem(void)
>  	phys_addr_t dram_end = memblock_end_of_DRAM();
>  	phys_addr_t max_mapped_addr = __pa(~(ulong)0);
>
> +#ifdef CONFIG_XIP_KERNEL
> +	vmlinux_start = __pa_symbol(&_sdata);
> +#endif
> +
>  	/* The maximal physical memory size is -PAGE_OFFSET. */
>  	memblock_enforce_memory_limit(-PAGE_OFFSET);
>
> @@ -159,15 +166,39 @@ void __init setup_bootmem(void)
>  	memblock_allow_resize();
>  }
>
> +#ifdef CONFIG_XIP_KERNEL
> +
> +extern char _xiprom[], _exiprom[];
> +extern char _sdata[], _edata[];
> +
> +#endif /* CONFIG_XIP_KERNEL */
> +
>  #ifdef CONFIG_MMU
> -static struct pt_alloc_ops pt_ops;
> +static struct pt_alloc_ops _pt_ops;
> +
> +#ifdef CONFIG_XIP_KERNEL
> +#define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&_pt_ops))
> +#else
> +#define pt_ops _pt_ops
> +#endif
>
>  /* Offset between linear mapping virtual address and kernel load address */
>  unsigned long va_pa_offset;
>  EXPORT_SYMBOL(va_pa_offset);
> +#ifdef CONFIG_XIP_KERNEL
> +#define va_pa_offset   (*((unsigned long *)XIP_FIXUP(&va_pa_offset)))
> +#endif
>  /* Offset between kernel mapping virtual address and kernel load address */
>  unsigned long va_kernel_pa_offset;
>  EXPORT_SYMBOL(va_kernel_pa_offset);
> +#ifdef CONFIG_XIP_KERNEL
> +#define va_kernel_pa_offset    (*((unsigned long *)XIP_FIXUP(&va_kernel_pa_offset)))
> +#endif
> +unsigned long va_kernel_xip_pa_offset;
> +EXPORT_SYMBOL(va_kernel_xip_pa_offset);
> +#ifdef CONFIG_XIP_KERNEL
> +#define va_kernel_xip_pa_offset        (*((unsigned long *)XIP_FIXUP(&va_kernel_xip_pa_offset)))
> +#endif
>  unsigned long pfn_base;
>  EXPORT_SYMBOL(pfn_base);
>
> @@ -177,6 +208,12 @@ pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
>
>  pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>
> +#ifdef CONFIG_XIP_KERNEL
> +#define trampoline_pg_dir      ((pgd_t *)XIP_FIXUP(trampoline_pg_dir))
> +#define fixmap_pte             ((pte_t *)XIP_FIXUP(fixmap_pte))
> +#define early_pg_dir           ((pgd_t *)XIP_FIXUP(early_pg_dir))
> +#endif /* CONFIG_XIP_KERNEL */
> +
>  void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>  {
>  	unsigned long addr = __fix_to_virt(idx);
> @@ -252,6 +289,12 @@ pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
>  pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>  pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>
> +#ifdef CONFIG_XIP_KERNEL
> +#define trampoline_pmd ((pmd_t *)XIP_FIXUP(trampoline_pmd))
> +#define fixmap_pmd     ((pmd_t *)XIP_FIXUP(fixmap_pmd))
> +#define early_pmd      ((pmd_t *)XIP_FIXUP(early_pmd))
> +#endif /* CONFIG_XIP_KERNEL */
> +
>  static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
>  {
>  	/* Before MMU is enabled */
> @@ -368,6 +411,19 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
>  	return PMD_SIZE;
>  }
>
> +#ifdef CONFIG_XIP_KERNEL
> +/* called from head.S with MMU off */
> +asmlinkage void __init __copy_data(void)
> +{
> +	void *from = (void *)(&_sdata);
> +	void *end = (void *)(&_end);
> +	void *to = (void *)CONFIG_PHYS_RAM_BASE;
> +	size_t sz = (size_t)(end - from + 1);
> +
> +	memcpy(to, from, sz);
> +}
> +#endif
> +
>  /*
>   * setup_vm() is called from head.S with MMU-off.
>   *
> @@ -387,7 +443,35 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
>  #endif
>
>  uintptr_t load_pa, load_sz;
> +#ifdef CONFIG_XIP_KERNEL
> +#define load_pa        (*((uintptr_t *)XIP_FIXUP(&load_pa)))
> +#define load_sz        (*((uintptr_t *)XIP_FIXUP(&load_sz)))
> +#endif
> +
> +#ifdef CONFIG_XIP_KERNEL
> +uintptr_t xiprom, xiprom_sz;
> +#define xiprom_sz      (*((uintptr_t *)XIP_FIXUP(&xiprom_sz)))
> +#define xiprom         (*((uintptr_t *)XIP_FIXUP(&xiprom)))
>
> +static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
> +{
> +	uintptr_t va, end_va;
> +
> +	/* Map the flash resident part */
> +	end_va = kernel_virt_addr + xiprom_sz;
> +	for (va = kernel_virt_addr; va < end_va; va += map_size)
> +		create_pgd_mapping(pgdir, va,
> +				   xiprom + (va - kernel_virt_addr),
> +				   map_size, PAGE_KERNEL_EXEC);
> +
> +	/* Map the data in RAM */
> +	end_va = kernel_virt_addr + XIP_OFFSET + load_sz;
> +	for (va = kernel_virt_addr + XIP_OFFSET; va < end_va; va += map_size)
> +		create_pgd_mapping(pgdir, va,
> +				   load_pa + (va - (kernel_virt_addr + XIP_OFFSET)),
> +				   map_size, PAGE_KERNEL);
> +}
> +#else
>  static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
>  {
>  	uintptr_t va, end_va;
> @@ -398,16 +482,28 @@ static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
>  				   load_pa + (va - kernel_virt_addr),
>  				   map_size, PAGE_KERNEL_EXEC);
>  }
> +#endif
>
>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  {
> -	uintptr_t pa;
> +	uintptr_t __maybe_unused pa;
>  	uintptr_t map_size;
>  #ifndef __PAGETABLE_PMD_FOLDED
>  	pmd_t fix_bmap_spmd, fix_bmap_epmd;
>  #endif
> +
> +#ifdef CONFIG_XIP_KERNEL
> +	xiprom = (uintptr_t)CONFIG_XIP_PHYS_ADDR;
> +	xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
> +
> +	load_pa = (uintptr_t)CONFIG_PHYS_RAM_BASE;
> +	load_sz = (uintptr_t)(&_end) - (uintptr_t)(&_sdata);
> +
> +	va_kernel_xip_pa_offset = kernel_virt_addr - xiprom;
> +#else
>  	load_pa = (uintptr_t)(&_start);
>  	load_sz = (uintptr_t)(&_end) - load_pa;
> +#endif
>
>  	va_pa_offset = PAGE_OFFSET - load_pa;
>  	va_kernel_pa_offset = kernel_virt_addr - load_pa;
> @@ -441,8 +537,13 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	/* Setup trampoline PGD and PMD */
>  	create_pgd_mapping(trampoline_pg_dir, kernel_virt_addr,
>  			   (uintptr_t)trampoline_pmd, PGDIR_SIZE, PAGE_TABLE);
> +#ifdef CONFIG_XIP_KERNEL
> +	create_pmd_mapping(trampoline_pmd, kernel_virt_addr,
> +			   xiprom, PMD_SIZE, PAGE_KERNEL_EXEC);
> +#else
>  	create_pmd_mapping(trampoline_pmd, kernel_virt_addr,
>  			   load_pa, PMD_SIZE, PAGE_KERNEL_EXEC);
> +#endif
>  #else
>  	/* Setup trampoline PGD */
>  	create_pgd_mapping(trampoline_pg_dir, kernel_virt_addr,
> @@ -474,7 +575,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	 * whereas dtb_early_va will be used before setup_vm_final installs
>  	 * the linear mapping.
>  	 */
> -	dtb_early_va = kernel_mapping_pa_to_va(dtb_pa);
> +	dtb_early_va = kernel_mapping_pa_to_va(XIP_FIXUP(dtb_pa));
>  #endif /* CONFIG_BUILTIN_DTB */
>  #else
>  #ifndef CONFIG_BUILTIN_DTB
> @@ -486,7 +587,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  			   pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
>  	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
>  #else /* CONFIG_BUILTIN_DTB */
> -	dtb_early_va = kernel_mapping_pa_to_va(dtb_pa);
> +	dtb_early_va = kernel_mapping_pa_to_va(XIP_FIXUP(dtb_pa));
>  #endif /* CONFIG_BUILTIN_DTB */
>  #endif
>  	dtb_early_pa = dtb_pa;
> @@ -522,7 +623,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  #endif
>  }
>
> -#ifdef CONFIG_64BIT
> +#if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
>  void protect_kernel_linear_mapping_text_rodata(void)
>  {
>  	unsigned long text_start = (unsigned long)lm_alias(_start);
