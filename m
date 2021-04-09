Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5246735A26F
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 17:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhDIP51 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 11:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhDIP51 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2021 11:57:27 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CA9C061760
        for <linux-arch@vger.kernel.org>; Fri,  9 Apr 2021 08:57:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g8so10429814lfv.12
        for <linux-arch@vger.kernel.org>; Fri, 09 Apr 2021 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XsvaSY8zYN9q+b8PbsWtp1w+Khl2vjj666Eagwy6n5c=;
        b=Sxywz2hcOMwDVDk2CRpRj35+nfOUayyt5AgurLU6/5LbZVVIrGm0OSEUetnqf8s+Xr
         Ca3L5pd44k1WYJtzFaqb1ge5LmarpaDUj83GyGgHm1xh5gwqrIAqy0/csimThBS4XZKp
         F90EiIohVQpSZ/n+/XVxCqqjsXRNzApETZu2jafVluNR5Toh2A4EiU+Cy3IjahBUR2KM
         /rfpuVa/n9Zh2fkO1GBaDCNniGZj/oEm9Od19IKM2cQ3TIcXZ3/MV0RGluxxEd6Vl8dm
         jBevVax0yxfRXa6E9Lxz5kQMBqE6l252/antXatpXEYgFPqzK22/wjgjhUmtKaffmm8B
         jeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XsvaSY8zYN9q+b8PbsWtp1w+Khl2vjj666Eagwy6n5c=;
        b=IEuQR6u/KWTheG3zrJDlAmCBsD0J7+66jT93m6JtvnxFDtR1eq7Vp/5vi8g0XtIt2k
         a6LyxmZSQH4fJmigq8Xi/kVQBE80RrLLXL1ED3lR4DhGa4WPJqApIl/Kn8V5xAFrUN9z
         Bf0Zkrr/RGle/5sctNTOAcTDq/Bo7/CNGrBjFejuafAQt/fe2dr9sNuQDkG6qg34x6vQ
         NQUzJexgra6ziHxh7qsq+U7GemwzIPFddFafOlP7lhilpvHxnJ74dzfVZT8zFoxCqLIN
         WGmDCf5tI+58b7rxuXZcYrdj1avnvGp4B5uyvNEXFe3qK52On2RjNZmcFLqPzwc/M3wp
         4q9A==
X-Gm-Message-State: AOAM530MUcWDCvsu2f3yJsyl3mWxFzE/HxAyUfzIzeJwd/MkDLK3SyCz
        RcZH1aOKCPFpYl7fci1dZL6GjQ==
X-Google-Smtp-Source: ABdhPJx4167C4epw4GZ3O6x+I3bz4h7dUH3Dy06BAJVx7+AZjRBM6+oPCgBhDIGlc3OtAdyHcZZ4mw==
X-Received: by 2002:a05:6512:33a8:: with SMTP id i8mr10617815lfg.375.1617983832458;
        Fri, 09 Apr 2021 08:57:12 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f15sm304423lfr.51.2021.04.09.08.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:57:11 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 586C5102498; Fri,  9 Apr 2021 18:57:11 +0300 (+03)
Date:   Fri, 9 Apr 2021 18:57:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v24 22/30] x86/cet/shstk: Add user-mode shadow stack
 support
Message-ID: <20210409155711.kxf3fjc7csvqpl33@box.shutemov.name>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
 <20210401221104.31584-23-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401221104.31584-23-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 01, 2021 at 03:10:56PM -0700, Yu-cheng Yu wrote:
> Introduce basic shadow stack enabling/disabling/allocation routines.
> A task's shadow stack is allocated from memory with VM_SHADOW_STACK flag
> and has a fixed size of min(RLIMIT_STACK, 4GB).
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
> v24:
> - Rename cet.c to shstk.c, update related areas accordingly.
> 
>  arch/x86/include/asm/cet.h       |  29 +++++++
>  arch/x86/include/asm/processor.h |   5 ++
>  arch/x86/kernel/Makefile         |   2 +
>  arch/x86/kernel/shstk.c          | 128 +++++++++++++++++++++++++++++++
>  4 files changed, 164 insertions(+)
>  create mode 100644 arch/x86/include/asm/cet.h
>  create mode 100644 arch/x86/kernel/shstk.c
> 
> diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
> new file mode 100644
> index 000000000000..aa85d599b184
> --- /dev/null
> +++ b/arch/x86/include/asm/cet.h
> @@ -0,0 +1,29 @@
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
> +};
> +
> +#ifdef CONFIG_X86_SHADOW_STACK
> +int shstk_setup(void);
> +void shstk_free(struct task_struct *p);
> +void shstk_disable(void);
> +#else
> +static inline int shstk_setup(void) { return 0; }
> +static inline void shstk_free(struct task_struct *p) {}
> +static inline void shstk_disable(void) {}
> +#endif
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* _ASM_X86_CET_H */
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index f1b9ed5efaa9..a5d703fda74e 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -27,6 +27,7 @@ struct vm86;
>  #include <asm/unwind_hints.h>
>  #include <asm/vmxfeatures.h>
>  #include <asm/vdso/processor.h>
> +#include <asm/cet.h>
>  
>  #include <linux/personality.h>
>  #include <linux/cache.h>
> @@ -535,6 +536,10 @@ struct thread_struct {
>  
>  	unsigned int		sig_on_uaccess_err:1;
>  
> +#ifdef CONFIG_X86_CET
> +	struct cet_status	cet;
> +#endif
> +
>  	/* Floating point and extended processor state */
>  	struct fpu		fpu;
>  	/*
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 2ddf08351f0b..0f99b093f350 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -150,6 +150,8 @@ obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
>  obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
>  
>  obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev-es.o
> +obj-$(CONFIG_X86_SHADOW_STACK)		+= shstk.o
> +
>  ###
>  # 64 bit specific files
>  ifeq ($(CONFIG_X86_64),y)
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> new file mode 100644
> index 000000000000..5406fdf6df3c
> --- /dev/null
> +++ b/arch/x86/kernel/shstk.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * shstk.c - Intel shadow stack support
> + *
> + * Copyright (c) 2021, Intel Corporation.
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
> +#include <linux/sizes.h>
> +#include <linux/user.h>
> +#include <asm/msr.h>
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
> +static unsigned long alloc_shstk(unsigned long size, int flags)
> +{
> +	struct mm_struct *mm = current->mm;
> +	unsigned long addr, populate;
> +
> +	/* VM_SHADOW_STACK requires MAP_ANONYMOUS, MAP_PRIVATE */
> +	flags |= MAP_ANONYMOUS | MAP_PRIVATE;

Looks like all callers has flags == 0. Do I miss something.

> +
> +	mmap_write_lock(mm);
> +	addr = do_mmap(NULL, 0, size, PROT_READ, flags, VM_SHADOW_STACK, 0,
> +		       &populate, NULL);
> +	mmap_write_unlock(mm);
> +
> +	if (populate)
> +		mm_populate(addr, populate);

If all callers pass down flags==0, populate will never happen.

> +
> +	return addr;
> +}
> +
> +int shstk_setup(void)
> +{
> +	unsigned long addr, size;
> +	struct cet_status *cet = &current->thread.cet;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +		return -EOPNOTSUPP;
> +
> +	size = round_up(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G), PAGE_SIZE);
> +	addr = alloc_shstk(size, 0);
> +	if (IS_ERR_VALUE(addr))
> +		return PTR_ERR((void *)addr);
> +
> +	cet->shstk_base = addr;
> +	cet->shstk_size = size;
> +
> +	start_update_msrs();
> +	wrmsrl(MSR_IA32_PL3_SSP, addr + size);
> +	wrmsrl(MSR_IA32_U_CET, CET_SHSTK_EN);
> +	end_update_msrs();
> +	return 0;
> +}
> +
> +void shstk_free(struct task_struct *tsk)
> +{
> +	struct cet_status *cet = &tsk->thread.cet;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
> +	    !cet->shstk_size ||
> +	    !cet->shstk_base)
> +		return;
> +
> +	if (!tsk->mm)
> +		return;
> +
> +	while (1) {
> +		int r;
> +
> +		r = vm_munmap(cet->shstk_base, cet->shstk_size);
> +
> +		/*
> +		 * vm_munmap() returns -EINTR when mmap_lock is held by
> +		 * something else, and that lock should not be held for a
> +		 * long time.  Retry it for the case.
> +		 */

Hm, no. -EINTR is not about the lock being held by somebody else. The task
got a signal and need to return to userspace.

I have not looked at the rest of the patches yet, but why do you need a
special free path for shadow stack? Why the normal unmap route doesn't
work for you?

> +		if (r == -EINTR) {
> +			cond_resched();
> +			continue;
> +		}
> +		break;
> +	}
> +
> +	cet->shstk_base = 0;
> +	cet->shstk_size = 0;
> +}
> +
> +void shstk_disable(void)
> +{
> +	struct cet_status *cet = &current->thread.cet;
> +	u64 msr_val;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
> +	    !cet->shstk_size ||
> +	    !cet->shstk_base)
> +		return;
> +
> +	start_update_msrs();
> +	rdmsrl(MSR_IA32_U_CET, msr_val);
> +	wrmsrl(MSR_IA32_U_CET, msr_val & ~CET_SHSTK_EN);
> +	wrmsrl(MSR_IA32_PL3_SSP, 0);
> +	end_update_msrs();
> +
> +	shstk_free(current);
> +}
> -- 
> 2.21.0
> 
> 

-- 
 Kirill A. Shutemov
