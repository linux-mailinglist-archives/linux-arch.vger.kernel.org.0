Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B68291185A6
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2019 11:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfLJK6P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Dec 2019 05:58:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46353 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfLJK6P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Dec 2019 05:58:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id z17so19285866ljk.13;
        Tue, 10 Dec 2019 02:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hVGRfhy9yrmfU+rOlyHiy18+MzZZ51Ax5wEwytMGsyw=;
        b=d2Il6Y8XKPFhKtg9o9IfhVnNPv2u7ygAwBIX+YU4ZoO8BjZ4U1wOe9eYRL3+sgGCOG
         HMDDuF0SO2xYxt7Nd1NCVXxovr9E8BpjtMzeeezA7McvWY7XYKg70qeqL85VvfAFBZvl
         DfurwbBu2AWOUsVxNwTNqKZKZvOJkKDexxEqEVgTHb54L1F+VbvpB0RY28OQSnutZGzy
         e/xYVWA0R+9HmGvil356LbbzfYrd17d2T048qqvNb23DQSUOyOgjKH/rLbISoJ/7VWIO
         QKr0CgCWBUKAsOB8sn2jQgqpeB9n7laKTTIMGzmGOq78NbbWvDGZ14gBG8TW5YvdYyeJ
         +Zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hVGRfhy9yrmfU+rOlyHiy18+MzZZ51Ax5wEwytMGsyw=;
        b=QOKXN9lhWmhK/wpMdGUbJGKWPk1o/leL0PtYUDHb8LgDlJIBXi8mYEnFobXtOcUY95
         +zS+7H6pfCiGaQxQNiFC22dIQDOSk6cR3SSXqu6XqFOJSzSYbhN3f8Ww0gK377jM8NxC
         fLzrQrbcmIDPdXsLD8d4fQjFvZG8jQkm3CDhuh86x6Hg5rDNkHXX3wYHARuJiFw4p5bG
         hWq7hJR9q9EgA58XE+m+MdAoF/UZPqrSmS8almvh0SzG9tsVe3tZpjMjXp0WXu5U/mJG
         1lX4/2yjjIYqoFOPvhiLUzzBfTJdNa9Kdy98s6qDDV3MeDnxn5T9T3sSDTXxv7Efl4Va
         AUQA==
X-Gm-Message-State: APjAAAVATUpwdKx8z/pf4crIADiW4xNIKJZcspbeog2T4i+gvI+ceFZs
        kfb8xVRIKwSUvw1FFWz96XI=
X-Google-Smtp-Source: APXvYqxizKdmwRv9WE3y7JgaE/HcVXr8EPFS3BZYwBpFMZrIXedMwaV/Yy3MP+g2IOb5g/NuLIHzjg==
X-Received: by 2002:a2e:3608:: with SMTP id d8mr15287035lja.152.1575975489795;
        Tue, 10 Dec 2019 02:58:09 -0800 (PST)
Received: from [192.168.68.106] ([193.119.54.228])
        by smtp.gmail.com with ESMTPSA id d24sm1528028lja.82.2019.12.10.02.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 02:58:09 -0800 (PST)
Subject: Re: [PATCH v2 4/4] powerpc: Book3S 64-bit "heavyweight" KASAN support
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kasan-dev@googlegroups.com, christophe.leroy@c-s.fr,
        aneesh.kumar@linux.ibm.com
References: <20191210044714.27265-1-dja@axtens.net>
 <20191210044714.27265-5-dja@axtens.net>
From:   Balbir Singh <bsingharora@gmail.com>
Message-ID: <71751e27-e9c5-f685-7a13-ca2e007214bc@gmail.com>
Date:   Tue, 10 Dec 2019 21:57:58 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191210044714.27265-5-dja@axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 10/12/19 3:47 pm, Daniel Axtens wrote:
> KASAN support on powerpc64 is challenging:
> 
>  - We want to be able to support inline instrumentation so as to be
>    able to catch global and stack issues.
> 
>  - We run some code in real mode after boot, most notably a lot of
>    KVM code. We'd like to be able to instrument this.
> 
>    [For those not immersed in ppc64, in real mode, the top nibble or
>    2 bits (depending on radix/hash mmu) of the address is ignored. The
>    linear mapping is placed at 0xc000000000000000. This means that a
>    pointer to part of the linear mapping will work both in real mode,
>    where it will be interpreted as a physical address of the form
>    0x000..., and out of real mode, where it will go via the linear
>    mapping.]
> 
>  - Inline instrumentation requires a fixed offset.
> 
>  - Because of our running things in real mode, the offset has to
>    point to valid memory both in and out of real mode.
> 
> This makes finding somewhere to put the KASAN shadow region challenging.
> 
> One approach is just to give up on inline instrumentation and override
> the address->shadow calculation. This way we can delay all checking
> until after we get everything set up to our satisfaction. However,
> we'd really like to do better.
> 
> What we can do - if we know _at compile time_ how much contiguous
> physical memory we have - is to set aside the top 1/8th of the memory
> and use that. This is a big hammer (hence the "heavyweight" name) and
> comes with 3 big consequences:
> 
>  - kernels will simply fail to boot on machines with less memory than
>    specified when compiling.
> 
>  - kernels running on machines with more memory than specified when
>    compiling will simply ignore the extra memory.
> 
>  - there's no nice way to handle physically discontiguous memory, so
>    you are restricted to the first physical memory block.
> 
> If you can bear all this, you get full support for KASAN.
> 
> Despite the limitations, it can still find bugs,
> e.g. http://patchwork.ozlabs.org/patch/1103775/
> 
> The current implementation is Radix only.
> 
> Massive thanks to mpe, who had the idea for the initial design.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> ---
> Changes since v1:
>  - Landed kasan vmalloc support upstream
>  - Lots of feedback from Christophe.
> 
> Changes since the rfc:
> 
>  - Boots real and virtual hardware, kvm works.
> 
>  - disabled reporting when we're checking the stack for exception
>    frames. The behaviour isn't wrong, just incompatible with KASAN.
> 
>  - Documentation!
> 
>  - Dropped old module stuff in favour of KASAN_VMALLOC.
> 
> The bugs with ftrace and kuap were due to kernel bloat pushing
> prom_init calls to be done via the plt. Because we did not have
> a relocatable kernel, and they are done very early, this caused
> everything to explode. Compile with CONFIG_RELOCATABLE!
> ---
>  Documentation/dev-tools/kasan.rst             |   8 +-
>  Documentation/powerpc/kasan.txt               | 102 +++++++++++++++++-
>  arch/powerpc/Kconfig                          |   3 +
>  arch/powerpc/Kconfig.debug                    |  21 ++++
>  arch/powerpc/Makefile                         |  11 ++
>  arch/powerpc/include/asm/kasan.h              |  20 +++-
>  arch/powerpc/kernel/process.c                 |   8 ++
>  arch/powerpc/kernel/prom.c                    |  59 +++++++++-
>  arch/powerpc/mm/kasan/Makefile                |   3 +-
>  .../mm/kasan/{kasan_init_32.c => init_32.c}   |   0
>  arch/powerpc/mm/kasan/init_book3s_64.c        |  67 ++++++++++++
>  11 files changed, 293 insertions(+), 9 deletions(-)
>  rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)
>  create mode 100644 arch/powerpc/mm/kasan/init_book3s_64.c
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 4af2b5d2c9b4..d99dc580bc11 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -22,8 +22,9 @@ global variables yet.
>  Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
>  
>  Currently generic KASAN is supported for the x86_64, arm64, xtensa and s390
> -architectures. It is also supported on 32-bit powerpc kernels. Tag-based KASAN
> -is supported only on arm64.
> +architectures. It is also supported on powerpc, for 32-bit kernels, and for
> +64-bit kernels running under the Radix MMU. Tag-based KASAN is supported only
> +on arm64.
>  
>  Usage
>  -----
> @@ -256,7 +257,8 @@ CONFIG_KASAN_VMALLOC
>  ~~~~~~~~~~~~~~~~~~~~
>  
>  With ``CONFIG_KASAN_VMALLOC``, KASAN can cover vmalloc space at the
> -cost of greater memory usage. Currently this is only supported on x86.
> +cost of greater memory usage. Currently this is optional on x86, and
> +required on 64-bit powerpc.
>  
>  This works by hooking into vmalloc and vmap, and dynamically
>  allocating real shadow memory to back the mappings.
> diff --git a/Documentation/powerpc/kasan.txt b/Documentation/powerpc/kasan.txt
> index a85ce2ff8244..d6e7a415195c 100644
> --- a/Documentation/powerpc/kasan.txt
> +++ b/Documentation/powerpc/kasan.txt
> @@ -1,4 +1,4 @@
> -KASAN is supported on powerpc on 32-bit only.
> +KASAN is supported on powerpc on 32-bit and 64-bit Radix only.
>  
>  32 bit support
>  ==============
> @@ -10,3 +10,103 @@ fixmap area and occupies one eighth of the total kernel virtual memory space.
>  
>  Instrumentation of the vmalloc area is not currently supported, but modules
>  are.
> +
> +64 bit support
> +==============
> +
> +Currently, only the radix MMU is supported. There have been versions for Book3E
> +processors floating around on the mailing list, but nothing has been merged.
> +
> +KASAN support on Book3S is a bit tricky to get right:
> +
> + - We want to be able to support inline instrumentation so as to be able to
> +   catch global and stack issues.
> +
> + - Inline instrumentation requires a fixed offset.
> +
> + - We run a lot of code in real mode. Most notably a lot of KVM runs in real
> +   mode, and we'd like to be able to instrument it.
> +
> + - Because we run code in real mode after boot, the offset has to point to
> +   valid memory both in and out of real mode.
> +
> +One approach is just to give up on inline instrumentation. This way we can
> +delay all checks until after we get everything set up correctly. However, we'd
> +really like to do better.
> +
> +If we know _at compile time_ how much contiguous physical memory we have, we
> +can set aside the top 1/8th of the first block of physical memory and use
> +that. This is a big hammer and comes with 3 big consequences:
> +
> + - there's no nice way to handle physically discontiguous memory, so
> +   you are restricted to the first physical memory block.
> +
> + - kernels will simply fail to boot on machines with less memory than specified
> +   when compiling.
> +
> + - kernels running on machines with more memory than specified when compiling
> +   will simply ignore the extra memory.
> +
> +If you can live with this, you get full support for KASAN.
> +
> +Tips
> +----
> +
> + - Compile with CONFIG_RELOCATABLE.
> +
> +   In development, we found boot hangs when building with ftrace and KUAP
> +   on. These ended up being due to kernel bloat pushing prom_init calls to be
> +   done via the PLT. Because we did not have a relocatable kernel, and they are
> +   done very early, this caused us to jump off into somewhere invalid. Enabling
> +   relocation fixes this.
> +
> +NUMA/discontiguous physical memory
> +----------------------------------
> +
> +We currently cannot really deal with discontiguous physical memory. You are
> +restricted to the physical memory that is contiguous from physical address
> +zero, and must specify the size of that memory, not total memory, when
> +configuring your kernel.
> +
> +Discontiguous memory can occur when you have a machine with memory spread
> +across multiple nodes. For example, on a Talos II with 64GB of RAM:
> +
> + - 32GB runs from 0x0 to 0x0000_0008_0000_0000,
> + - then there's a gap,
> + - then the final 32GB runs from 0x0000_2000_0000_0000 to 0x0000_2008_0000_0000
> +
> +This can create _significant_ issues:
> +
> + - If we try to treat the machine as having 64GB of _contiguous_ RAM, we would
> +   assume that ran from 0x0 to 0x0000_0010_0000_0000. We'd then reserve the
> +   last 1/8th - 0x0000_000e_0000_0000 to 0x0000_0010_0000_0000 as the shadow
> +   region. But when we try to access any of that, we'll try to access pages
> +   that are not physically present.
> +

If we reserved memory for KASAN from each node (discontig region), we might survive
this no? May be we need NUMA aware KASAN? That might be a generic change, just thinking
out loud.

> + - If we try to base the shadow region size on the top address, we'll need to
> +   reserve 0x2008_0000_0000 / 8 = 0x0401_0000_0000 bytes = 4100 GB of memory,
> +   which will clearly not work on a system with 64GB of RAM.
> +
> +Therefore, you are restricted to the memory in the node starting at 0x0. For
> +this system, that's 32GB. If you specify a contiguous physical memory size
> +greater than the size of the first contiguous region of memory, the system will
> +be unable to boot or even print an error message warning you.
> +
> +You can determine the layout of your system's memory by observing the messages
> +that the Radix MMU prints on boot. The Talos II discussed earlier has:
> +
> +radix-mmu: Mapped 0x0000000000000000-0x0000000040000000 with 1.00 GiB pages (exec)
> +radix-mmu: Mapped 0x0000000040000000-0x0000000800000000 with 1.00 GiB pages
> +radix-mmu: Mapped 0x0000200000000000-0x0000200800000000 with 1.00 GiB pages
> +
> +As discussed, you'd configure this system for 32768 MB.
> +
> +Another system prints:
> +
> +radix-mmu: Mapped 0x0000000000000000-0x0000000040000000 with 1.00 GiB pages (exec)
> +radix-mmu: Mapped 0x0000000040000000-0x0000002000000000 with 1.00 GiB pages
> +radix-mmu: Mapped 0x0000200000000000-0x0000202000000000 with 1.00 GiB pages
> +
> +This machine has more memory: 0x0000_0040_0000_0000 total, but only
> +0x0000_0020_0000_0000 is physically contiguous from zero, so we'd configure the
> +kernel for 131072 MB of physically contiguous memory.
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1ec34e16ed65..f68650f14e61 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -173,6 +173,9 @@ config PPC
>  	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_ARCH_KASAN			if PPC32
> +	select HAVE_ARCH_KASAN			if PPC_BOOK3S_64 && PPC_RADIX_MMU
> +	select HAVE_ARCH_KASAN_VMALLOC		if PPC_BOOK3S_64
> +	select KASAN_VMALLOC			if KASAN && PPC_BOOK3S_64
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_MMAP_RND_BITS
>  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 4e1d39847462..90bb48455cb8 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -394,6 +394,27 @@ config PPC_FAST_ENDIAN_SWITCH
>  	help
>  	  If you're unsure what this is, say N.
>  
> +config PHYS_MEM_SIZE_FOR_KASAN
> +	int "Contiguous physical memory size for KASAN (MB)" if KASAN && PPC_BOOK3S_64
> +	default 0
> +	help
> +
> +	  To get inline instrumentation support for KASAN on 64-bit Book3S
> +	  machines, you need to know how much contiguous physical memory your
> +	  system has. A shadow offset will be calculated based on this figure,
> +	  which will be compiled in to the kernel. KASAN will use this offset
> +	  to access its shadow region, which is used to verify memory accesses.
> +
> +	  If you attempt to boot on a system with less memory than you specify
> +	  here, your system will fail to boot very early in the process. If you
> +	  boot on a system with more memory than you specify, the extra memory
> +	  will wasted - it will be reserved and not used.
> +
> +	  For systems with discontiguous blocks of physical memory, specify the
> +	  size of the block starting at 0x0. You can determine this by looking
> +	  at the memory layout info printed to dmesg by the radix MMU code
> +	  early in boot. See Documentation/powerpc/kasan.txt.
> +
>  config KASAN_SHADOW_OFFSET
>  	hex
>  	depends on KASAN
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index f35730548e42..eff693527462 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -230,6 +230,17 @@ ifdef CONFIG_476FPE_ERR46
>  		-T $(srctree)/arch/powerpc/platforms/44x/ppc476_modules.lds
>  endif
>  
> +ifdef CONFIG_PPC_BOOK3S_64
> +# The KASAN shadow offset is such that linear map (0xc000...) is shadowed by
> +# the last 8th of linearly mapped physical memory. This way, if the code uses
> +# 0xc addresses throughout, accesses work both in in real mode (where the top
> +# 2 bits are ignored) and outside of real mode.
> +#
> +# 0xc000000000000000 >> 3 = 0xa800000000000000 = 12105675798371893248
> +KASAN_SHADOW_OFFSET = $(shell echo 7 \* 1024 \* 1024 \* $(CONFIG_PHYS_MEM_SIZE_FOR_KASAN) / 8 + 12105675798371893248 | bc)
> +KBUILD_CFLAGS += -DKASAN_SHADOW_OFFSET=$(KASAN_SHADOW_OFFSET)UL
> +endif
> +
>  # No AltiVec or VSX instructions when building kernel
>  KBUILD_CFLAGS += $(call cc-option,-mno-altivec)
>  KBUILD_CFLAGS += $(call cc-option,-mno-vsx)
> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
> index 296e51c2f066..98d995bc9b5e 100644
> --- a/arch/powerpc/include/asm/kasan.h
> +++ b/arch/powerpc/include/asm/kasan.h
> @@ -14,13 +14,20 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -#include <asm/page.h>
> +#ifdef CONFIG_KASAN
> +void kasan_init(void);
> +#else
> +static inline void kasan_init(void) { }
> +#endif
>  
>  #define KASAN_SHADOW_SCALE_SHIFT	3
>  
>  #define KASAN_SHADOW_START	(KASAN_SHADOW_OFFSET + \
>  				 (PAGE_OFFSET >> KASAN_SHADOW_SCALE_SHIFT))
>  
> +#ifdef CONFIG_PPC32
> +#include <asm/page.h>
> +
>  #define KASAN_SHADOW_OFFSET	ASM_CONST(CONFIG_KASAN_SHADOW_OFFSET)
>  
>  #define KASAN_SHADOW_END	0UL
> @@ -30,11 +37,18 @@
>  #ifdef CONFIG_KASAN
>  void kasan_early_init(void);
>  void kasan_mmu_init(void);
> -void kasan_init(void);
>  #else
> -static inline void kasan_init(void) { }
>  static inline void kasan_mmu_init(void) { }
>  #endif
> +#endif
> +
> +#ifdef CONFIG_PPC_BOOK3S_64
> +#include <asm/pgtable.h>
> +
> +#define KASAN_SHADOW_SIZE ((u64)CONFIG_PHYS_MEM_SIZE_FOR_KASAN * \
> +				1024 * 1024 * 1 / 8)
> +
> +#endif /* CONFIG_PPC_BOOK3S_64 */
>  
>  #endif /* __ASSEMBLY */
>  #endif
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 4df94b6e2f32..c60ff299f39b 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -2081,7 +2081,14 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
>  		/*
>  		 * See if this is an exception frame.
>  		 * We look for the "regshere" marker in the current frame.
> +		 *
> +		 * KASAN may complain about this. If it is an exception frame,
> +		 * we won't have unpoisoned the stack in asm when we set the
> +		 * exception marker. If it's not an exception frame, who knows
> +		 * how things are laid out - the shadow could be in any state
> +		 * at all. Just disable KASAN reporting for now.
>  		 */
> +		kasan_disable_current();
>  		if (validate_sp(sp, tsk, STACK_INT_FRAME_SIZE)
>  		    && stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER) {
>  			struct pt_regs *regs = (struct pt_regs *)
> @@ -2091,6 +2098,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
>  			       regs->trap, (void *)regs->nip, (void *)lr);
>  			firstframe = 1;
>  		}
> +		kasan_enable_current();
>  
>  		sp = newsp;
>  	} while (count++ < kstack_depth_to_print);
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 6620f37abe73..b32036f61cad 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -72,6 +72,7 @@ unsigned long tce_alloc_start, tce_alloc_end;
>  u64 ppc64_rma_size;
>  #endif
>  static phys_addr_t first_memblock_size;
> +static phys_addr_t top_phys_addr;
>  static int __initdata boot_cpu_count;
>  
>  static int __init early_parse_mem(char *p)
> @@ -449,6 +450,21 @@ static bool validate_mem_limit(u64 base, u64 *size)
>  {
>  	u64 max_mem = 1UL << (MAX_PHYSMEM_BITS);
>  
> +#ifdef CONFIG_KASAN
> +	/*
> +	 * To handle the NUMA/discontiguous memory case, don't allow a block
> +	 * to be added if it falls completely beyond the configured physical
> +	 * memory.
> +	 *
> +	 * See Documentation/powerpc/kasan.txt
> +	 */
> +	if (base >= (u64)CONFIG_PHYS_MEM_SIZE_FOR_KASAN * 1024 * 1024) {
> +		pr_warn("KASAN: not adding mem block at %llx (size %llx)",
> +			base, *size);
> +		return false;
> +	}
> +#endif
> +
>  	if (base >= max_mem)
>  		return false;
>  	if ((base + *size) > max_mem)
> @@ -572,8 +588,11 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>  
>  	/* Add the chunk to the MEMBLOCK list */
>  	if (add_mem_to_memblock) {
> -		if (validate_mem_limit(base, &size))
> +		if (validate_mem_limit(base, &size)) {
>  			memblock_add(base, size);
> +			if (base + size > top_phys_addr)
> +				top_phys_addr = base + size;
> +		}
>  	}
>  }
>  
> @@ -613,6 +632,8 @@ static void __init early_reserve_mem_dt(void)
>  static void __init early_reserve_mem(void)
>  {
>  	__be64 *reserve_map;
> +	phys_addr_t kasan_shadow_start;
> +	phys_addr_t kasan_memory_size;
>  
>  	reserve_map = (__be64 *)(((unsigned long)initial_boot_params) +
>  			fdt_off_mem_rsvmap(initial_boot_params));
> @@ -651,6 +672,42 @@ static void __init early_reserve_mem(void)
>  		return;
>  	}
>  #endif
> +
> +	if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_PPC_BOOK3S_64)) {
> +		kasan_memory_size =
> +			((phys_addr_t)CONFIG_PHYS_MEM_SIZE_FOR_KASAN << 20);
> +
> +		if (top_phys_addr < kasan_memory_size) {
> +			/*
> +			 * We are doomed. Attempts to call e.g. panic() are
> +			 * likely to fail because they call out into
> +			 * instrumented code, which will almost certainly
> +			 * access memory beyond the end of physical
> +			 * memory. Hang here so that at least the NIP points
> +			 * somewhere that will help you debug it if you look at
> +			 * it in qemu.
> +			 */
> +			while (true)
> +				;

Again with the right hooks in check_memory_region_inline() these are recoverable,
or so I think

> +		} else if (top_phys_addr > kasan_memory_size) {
> +			/* print a biiiig warning in hopes people notice */
> +			pr_err("===========================================\n"
> +				"Physical memory exceeds compiled-in maximum!\n"
> +				"This kernel was compiled for KASAN with %u MB physical memory.\n"
> +				"The actual physical memory detected is %llu MB.\n"
> +				"Memory above the compiled limit will not be used!\n"
> +				"===========================================\n",
> +				CONFIG_PHYS_MEM_SIZE_FOR_KASAN,
> +				top_phys_addr / (1024 * 1024));
> +		}
> +
> +		kasan_shadow_start = _ALIGN_DOWN(kasan_memory_size * 7 / 8,
> +						 PAGE_SIZE);
> +		DBG("reserving %llx -> %llx for KASAN",
> +		    kasan_shadow_start, top_phys_addr);
> +		memblock_reserve(kasan_shadow_start,
> +				 top_phys_addr - kasan_shadow_start);
> +	}
>  }
>  
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
> index 6577897673dd..f02b15c78e4d 100644
> --- a/arch/powerpc/mm/kasan/Makefile
> +++ b/arch/powerpc/mm/kasan/Makefile
> @@ -2,4 +2,5 @@
>  
>  KASAN_SANITIZE := n
>  
> -obj-$(CONFIG_PPC32)           += kasan_init_32.o
> +obj-$(CONFIG_PPC32)           += init_32.o
> +obj-$(CONFIG_PPC_BOOK3S_64)   += init_book3s_64.o
> diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/init_32.c
> similarity index 100%
> rename from arch/powerpc/mm/kasan/kasan_init_32.c
> rename to arch/powerpc/mm/kasan/init_32.c
> diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/kasan/init_book3s_64.c
> new file mode 100644
> index 000000000000..43e9252c8bd3
> --- /dev/null
> +++ b/arch/powerpc/mm/kasan/init_book3s_64.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KASAN for 64-bit Book3S powerpc
> + *
> + * Copyright (C) 2019 IBM Corporation
> + * Author: Daniel Axtens <dja@axtens.net>
> + */
> +
> +#define DISABLE_BRANCH_PROFILING
> +
> +#include <linux/kasan.h>
> +#include <linux/printk.h>
> +#include <linux/sched/task.h>
> +#include <asm/pgalloc.h>
> +
> +void __init kasan_init(void)
> +{
> +	int i;
> +	void *k_start = kasan_mem_to_shadow((void *)RADIX_KERN_VIRT_START);
> +	void *k_end = kasan_mem_to_shadow((void *)RADIX_VMEMMAP_END);
> +
> +	pte_t pte = __pte(__pa(kasan_early_shadow_page) |
> +			  pgprot_val(PAGE_KERNEL) | _PAGE_PTE);
> +
> +	if (!early_radix_enabled())
> +		panic("KASAN requires radix!");
> +

I think this is avoidable, we could use a static key for disabling kasan in
the generic code. I wonder what happens if someone tries to boot this
image on a Power8 box and keeps panic'ing with no easy way of recovering.

> +	for (i = 0; i < PTRS_PER_PTE; i++)
> +		__set_pte_at(&init_mm, (unsigned long)kasan_early_shadow_page,
> +			     &kasan_early_shadow_pte[i], pte, 0);
> +
> +	for (i = 0; i < PTRS_PER_PMD; i++)
> +		pmd_populate_kernel(&init_mm, &kasan_early_shadow_pmd[i],
> +				    kasan_early_shadow_pte);
> +
> +	for (i = 0; i < PTRS_PER_PUD; i++)
> +		pud_populate(&init_mm, &kasan_early_shadow_pud[i],
> +			     kasan_early_shadow_pmd);
> +
> +	memset(kasan_mem_to_shadow((void *)PAGE_OFFSET), KASAN_SHADOW_INIT,
> +	       KASAN_SHADOW_SIZE);
> +
> +	kasan_populate_early_shadow(
> +		kasan_mem_to_shadow((void *)RADIX_KERN_VIRT_START),
> +		kasan_mem_to_shadow((void *)RADIX_VMALLOC_START));
> +
> +	/* leave a hole here for vmalloc */
> +
> +	kasan_populate_early_shadow(
> +		kasan_mem_to_shadow((void *)RADIX_VMALLOC_END),
> +		kasan_mem_to_shadow((void *)RADIX_VMEMMAP_END));
> +
> +	flush_tlb_kernel_range((unsigned long)k_start, (unsigned long)k_end);
> +
> +	/* mark early shadow region as RO and wipe */
> +	pte = __pte(__pa(kasan_early_shadow_page) |
> +		    pgprot_val(PAGE_KERNEL_RO) | _PAGE_PTE);
> +	for (i = 0; i < PTRS_PER_PTE; i++)
> +		__set_pte_at(&init_mm, (unsigned long)kasan_early_shadow_page,
> +			     &kasan_early_shadow_pte[i], pte, 0);
> +
> +	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
> +
> +	/* Enable error messages */
> +	init_task.kasan_depth = 0;
> +	pr_info("KASAN init done (64-bit Book3S heavyweight mode)\n");
> +}
> 

NOTE: I can't test any of these, well may be with qemu, let me see if I can spin
the series and provide more feedback

Balbir
