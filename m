Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 614C916F0DB
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 22:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgBYVHv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 16:07:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35113 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgBYVHu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 16:07:50 -0500
Received: by mail-pg1-f196.google.com with SMTP id 7so167203pgr.2
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 13:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TKd4I5/WwOk7TgiwtjETXh7Zo7Mjc0q4nGb96fr6GK0=;
        b=BZO6oZ6A8cZmZqloX0DKy1GOEbceLI9chiAHebEX2VgYIjjy2O+rybKtsk8PsauMss
         wKVQhwbcAHqdbU/nCqot9JTYXaSI30aTzB8stl7tMJxbsnYzRLifKayBEYI+9/gsHzRQ
         gvG3xJqT55s5r9hvHnvwCO/GWxtsVG+L620Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TKd4I5/WwOk7TgiwtjETXh7Zo7Mjc0q4nGb96fr6GK0=;
        b=s/10W8wEl9rmOfNNAY212Ju5dvJxq0fmqMbKr1qcqNYKWju7VbdFVSJWvolx+RAH0c
         DV5b4b0py8Clq0qE61ll0rbJuidBwAPktiEBCEGb4ZPP8tpB2U1XniDFGJf/thKmGmFP
         4oeoWhdNveCV13ilvdfmygdvNYIQYPVj9X5CRQh9v97+EOgH7UEj2BzjcFxVs5jkzqG0
         H/rgccypnqLz5XStIy5kNXAbRKc8eJktVb2znJG2ZqG0KCzn7ndY5sKammd6myICowLo
         I4BgmfVavEJp4wopsaw+hD0mpc5/MicVDLqL9wm+nj7vys1cKYcklQw9hEfew/BF4vbF
         2C2Q==
X-Gm-Message-State: APjAAAV68sRLmD4a8dVKu2qUQgFe3yiFx5zIPM3O0rSSlWLzMHVEVPuL
        F8DzwW5krqD00GPIP95bWCAciw==
X-Google-Smtp-Source: APXvYqyXkndaV7rJA0zMXDICnSqxAjerRHL3b37R/Kb6u2Hc1kQ2oyP1AQMzZ2Y3ORigrLDdZyOhiw==
X-Received: by 2002:aa7:83c7:: with SMTP id j7mr638913pfn.228.1582664867330;
        Tue, 25 Feb 2020 13:07:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i3sm18067049pfg.94.2020.02.25.13.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 13:07:46 -0800 (PST)
Date:   Tue, 25 Feb 2020 13:07:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Subject: Re: [RFC PATCH v9 17/27] x86/cet/shstk: User-mode Shadow Stack
 support
Message-ID: <202002251306.2011C9374@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-18-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-18-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:25AM -0800, Yu-cheng Yu wrote:
> This patch adds basic Shadow Stack (SHSTK) enabling/disabling routines.
> A task's SHSTK is allocated from memory with VM_SHSTK flag and read-only
> protection.  It has a fixed size of RLIMIT_STACK.
> 
> v9:
> - Change cpu_feature_enabled() to static_cpu_has().
> - Merge cet_disable_shstk to cet_disable_free_shstk.
> - Remove the empty slot at the top of the SHSTK, as it is not needed.
> - Move do_mmap_locked() to alloc_shstk(), which is a static function.
> 
> v6:
> - Create a function do_mmap_locked() for SHSTK allocation.
> 
> v2:
> - Change noshstk to no_cet_shstk.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/cet.h                    |  31 +++++
>  arch/x86/include/asm/disabled-features.h      |   8 +-
>  arch/x86/include/asm/processor.h              |   5 +
>  arch/x86/kernel/Makefile                      |   2 +
>  arch/x86/kernel/cet.c                         | 121 ++++++++++++++++++
>  arch/x86/kernel/cpu/common.c                  |  25 ++++
>  arch/x86/kernel/process.c                     |   1 +
>  .../arch/x86/include/asm/disabled-features.h  |   8 +-
>  8 files changed, 199 insertions(+), 2 deletions(-)
>  create mode 100644 arch/x86/include/asm/cet.h
>  create mode 100644 arch/x86/kernel/cet.c
> 
> diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
> new file mode 100644
> index 000000000000..c44c991ca91f
> --- /dev/null
> +++ b/arch/x86/include/asm/cet.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_CET_H
> +#define _ASM_X86_CET_H
> +
> +#ifndef __ASSEMBLY__
> +#include <linux/types.h>
> +
> +struct task_struct;
> +/*
> + * Per-thread CET status
> + */
> +struct cet_status {
> +	unsigned long	shstk_base;
> +	unsigned long	shstk_size;
> +	unsigned int	shstk_enabled:1;
> +};
> +
> +#ifdef CONFIG_X86_INTEL_CET
> +int cet_setup_shstk(void);
> +void cet_disable_free_shstk(struct task_struct *p);
> +#else
> +static inline void cet_disable_free_shstk(struct task_struct *p) {}
> +#endif
> +
> +#define cpu_x86_cet_enabled() \
> +	(static_cpu_has(X86_FEATURE_SHSTK) || \
> +	 static_cpu_has(X86_FEATURE_IBT))
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* _ASM_X86_CET_H */
> diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
> index 8e1d0bb46361..e1454509ad83 100644
> --- a/arch/x86/include/asm/disabled-features.h
> +++ b/arch/x86/include/asm/disabled-features.h
> @@ -62,6 +62,12 @@
>  # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
>  #endif
>  
> +#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> +#define DISABLE_SHSTK	0
> +#else
> +#define DISABLE_SHSTK	(1<<(X86_FEATURE_SHSTK & 31))
> +#endif
> +
>  /*
>   * Make sure to add features to the correct mask
>   */
> @@ -81,7 +87,7 @@
>  #define DISABLED_MASK13	0
>  #define DISABLED_MASK14	0
>  #define DISABLED_MASK15	0
> -#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP)
> +#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP|DISABLE_SHSTK)
>  #define DISABLED_MASK17	0
>  #define DISABLED_MASK18	0
>  #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 0340aad3f2fc..793d210e64da 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -25,6 +25,7 @@ struct vm86;
>  #include <asm/special_insns.h>
>  #include <asm/fpu/types.h>
>  #include <asm/unwind_hints.h>
> +#include <asm/cet.h>
>  
>  #include <linux/personality.h>
>  #include <linux/cache.h>
> @@ -539,6 +540,10 @@ struct thread_struct {
>  	unsigned int		sig_on_uaccess_err:1;
>  	unsigned int		uaccess_err:1;	/* uaccess failed */
>  
> +#ifdef CONFIG_X86_INTEL_CET
> +	struct cet_status	cet;
> +#endif
> +
>  	/* Floating point and extended processor state */
>  	struct fpu		fpu;
>  	/*
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 6175e370ee4a..b8c1ea4ab7eb 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -142,6 +142,8 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
>  obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
>  obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
>  
> +obj-$(CONFIG_X86_INTEL_CET)		+= cet.o
> +
>  ###
>  # 64 bit specific files
>  ifeq ($(CONFIG_X86_64),y)
> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
> new file mode 100644
> index 000000000000..b4c7d88e9a8f
> --- /dev/null
> +++ b/arch/x86/kernel/cet.c
> @@ -0,0 +1,121 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * cet.c - Control-flow Enforcement (CET)
> + *
> + * Copyright (c) 2019, Intel Corporation.
> + * Yu-cheng Yu <yu-cheng.yu@intel.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/mm.h>
> +#include <linux/mman.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/sched/signal.h>
> +#include <linux/compat.h>
> +#include <asm/msr.h>
> +#include <asm/user.h>
> +#include <asm/fpu/internal.h>
> +#include <asm/fpu/xstate.h>
> +#include <asm/fpu/types.h>
> +#include <asm/cet.h>
> +
> +static void start_update_msrs(void)
> +{
> +	fpregs_lock();
> +	if (test_thread_flag(TIF_NEED_FPU_LOAD))
> +		__fpregs_load_activate();
> +}
> +
> +static void end_update_msrs(void)
> +{
> +	fpregs_unlock();
> +}
> +
> +static unsigned long cet_get_shstk_addr(void)
> +{
> +	struct fpu *fpu = &current->thread.fpu;
> +	unsigned long ssp = 0;
> +
> +	fpregs_lock();
> +
> +	if (fpregs_state_valid(fpu, smp_processor_id())) {
> +		rdmsrl(MSR_IA32_PL3_SSP, ssp);
> +	} else {
> +		struct cet_user_state *p;
> +
> +		p = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
> +		if (p)
> +			ssp = p->user_ssp;
> +	}
> +
> +	fpregs_unlock();
> +	return ssp;
> +}
> +
> +static unsigned long alloc_shstk(unsigned long size)
> +{
> +	struct mm_struct *mm = current->mm;
> +	unsigned long addr, populate;
> +
> +	down_write(&mm->mmap_sem);
> +	addr = do_mmap(NULL, 0, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE,
> +		       VM_SHSTK, 0, &populate, NULL);
> +	up_write(&mm->mmap_sem);
> +
> +	if (populate)
> +		mm_populate(addr, populate);
> +
> +	return addr;
> +}
> +
> +int cet_setup_shstk(void)
> +{
> +	unsigned long addr, size;
> +	struct cet_status *cet = &current->thread.cet;
> +
> +	if (!static_cpu_has(X86_FEATURE_SHSTK))
> +		return -EOPNOTSUPP;
> +
> +	size = rlimit(RLIMIT_STACK);
> +	addr = alloc_shstk(size);
> +
> +	if (IS_ERR((void *)addr))
> +		return PTR_ERR((void *)addr);
> +
> +	cet->shstk_base = addr;
> +	cet->shstk_size = size;
> +	cet->shstk_enabled = 1;
> +
> +	start_update_msrs();
> +	wrmsrl(MSR_IA32_PL3_SSP, addr + size);
> +	wrmsrl(MSR_IA32_U_CET, MSR_IA32_CET_SHSTK_EN);
> +	end_update_msrs();
> +	return 0;
> +}
> +
> +void cet_disable_free_shstk(struct task_struct *tsk)
> +{
> +	struct cet_status *cet = &tsk->thread.cet;
> +
> +	if (!static_cpu_has(X86_FEATURE_SHSTK) ||
> +	    !cet->shstk_enabled || !cet->shstk_base)
> +		return;
> +
> +	if (!tsk->mm || (tsk->mm != current->mm))
> +		return;
> +
> +	if (tsk == current) {
> +		u64 msr_val;
> +
> +		start_update_msrs();
> +		rdmsrl(MSR_IA32_U_CET, msr_val);
> +		wrmsrl(MSR_IA32_U_CET, msr_val & ~MSR_IA32_CET_SHSTK_EN);
> +		end_update_msrs();
> +	}
> +
> +	vm_munmap(cet->shstk_base, cet->shstk_size);
> +	cet->shstk_base = 0;
> +	cet->shstk_size = 0;
> +	cet->shstk_enabled = 0;
> +}
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 2e4d90294fe6..40498ec72fda 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -54,6 +54,7 @@
>  #include <asm/microcode_intel.h>
>  #include <asm/intel-family.h>
>  #include <asm/cpu_device_id.h>
> +#include <asm/cet.h>
>  #include <asm/uv/uv.h>
>  
>  #include "cpu.h"
> @@ -486,6 +487,29 @@ static __init int setup_disable_pku(char *arg)
>  __setup("nopku", setup_disable_pku);
>  #endif /* CONFIG_X86_64 */
>  
> +static __always_inline void setup_cet(struct cpuinfo_x86 *c)
> +{
> +	if (cpu_x86_cet_enabled())
> +		cr4_set_bits(X86_CR4_CET);
> +}
> +
> +#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> +static __init int setup_disable_shstk(char *s)
> +{
> +	/* require an exact match without trailing characters */
> +	if (s[0] != '\0')
> +		return 0;
> +
> +	if (!boot_cpu_has(X86_FEATURE_SHSTK))
> +		return 1;
> +
> +	setup_clear_cpu_cap(X86_FEATURE_SHSTK);
> +	pr_info("x86: 'no_cet_shstk' specified, disabling Shadow Stack\n");
> +	return 1;
> +}
> +__setup("no_cet_shstk", setup_disable_shstk);
> +#endif

I wonder if this should be "cet_shstk=..." instead? Will it always be a
giant knob like this? Will we want to disable it for userspace but keep
it for kernel space, etc?

> +
>  /*
>   * Some CPU features depend on higher CPUID levels, which may not always
>   * be available due to CPUID level capping or broken virtualization
> @@ -1510,6 +1534,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>  	x86_init_rdrand(c);
>  	x86_init_cache_qos(c);
>  	setup_pku(c);
> +	setup_cet(c);
>  
>  	/*
>  	 * Clear/Set all flags overridden by options, need do it
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 8d0b9442202e..e102e63de641 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -43,6 +43,7 @@
>  #include <asm/spec-ctrl.h>
>  #include <asm/io_bitmap.h>
>  #include <asm/proto.h>
> +#include <asm/cet.h>
>  
>  #include "process.h"
>  
> diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
> index 8e1d0bb46361..e1454509ad83 100644
> --- a/tools/arch/x86/include/asm/disabled-features.h
> +++ b/tools/arch/x86/include/asm/disabled-features.h
> @@ -62,6 +62,12 @@
>  # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
>  #endif
>  
> +#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> +#define DISABLE_SHSTK	0
> +#else
> +#define DISABLE_SHSTK	(1<<(X86_FEATURE_SHSTK & 31))
> +#endif
> +
>  /*
>   * Make sure to add features to the correct mask
>   */
> @@ -81,7 +87,7 @@
>  #define DISABLED_MASK13	0
>  #define DISABLED_MASK14	0
>  #define DISABLED_MASK15	0
> -#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP)
> +#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP|DISABLE_SHSTK)
>  #define DISABLED_MASK17	0
>  #define DISABLED_MASK18	0
>  #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
> -- 
> 2.21.0
> 
> 

Otherwise, looks good to me. :)

-- 
Kees Cook
