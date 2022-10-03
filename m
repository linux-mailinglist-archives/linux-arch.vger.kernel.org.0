Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC43A5F3695
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 21:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJCToW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 15:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJCToI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 15:44:08 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851CD4A82F
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 12:43:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x6so5309854pll.11
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 12:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=nTjYpxylCPftc28XGbGyxF1rAzGkPAYWYknA79Bcm9I=;
        b=EFOLhY9uwbU3jKwIlSgp6Wc1OxzHVa0xTN0ozauSs8hKYBUWWwNoMINgbBUJosSMyl
         wKc3DBj4BOK1um35IMJlN5qQe1OFC/10GtXiIs8MD33AuB48CnlfO9kqSfKF945KvpWa
         rH6mdwRU/PaQUoLjIsiKRQ+nhYduuWv3u/WXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nTjYpxylCPftc28XGbGyxF1rAzGkPAYWYknA79Bcm9I=;
        b=gO12YVmTPNPJ3MXuHm/qGbebmfuDuNH4Gr6+GWCBY9bW5qroRDfSUPxGSbWZN0vHh2
         hHRp4ob1BySI0u8zyGEhgYk9SCPNcnfVk0YkrzNyKr9Hi8GFHSFtzRM/f3CCLvyli8vc
         dVbnHkXBkInfr04iGB5EJMCBrkaFJ7an8e7t2E8AbY/zwHQ1RQArU0fk1vsiBMbsRbG7
         uVFvVtGSBYb63eYtlKe1QERBZ3okS2PvAZIhzQNkL6I/iTtmWiu9JD/BY6S3/tLh0+5U
         cXH90hwBj1UQlxQOF0lYwQ7dELLOVyn5JrRR6HUdyNkfyCKZnx4V3IefWWUy9IQOBsvN
         cqvw==
X-Gm-Message-State: ACrzQf1ZRLLJro4rNZ1yzHS716dzMuBhsSNetS95XRz0LTDI+X4+dq7L
        AHwngoEGTWbEVL2+xZ52X6z+MQ==
X-Google-Smtp-Source: AMsMyM4azs07170Hq3zRJt3EyRU/z7auHCCo01WENtauqz4DldPChjM3Bei4nbAVz48xYC4QS7JGYw==
X-Received: by 2002:a17:90b:1e45:b0:202:fbc9:3df1 with SMTP id pi5-20020a17090b1e4500b00202fbc93df1mr14160711pjb.72.1664826238869;
        Mon, 03 Oct 2022 12:43:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9-20020a170903018900b001746f66244asm7694284plg.18.2022.10.03.12.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 12:43:58 -0700 (PDT)
Date:   Mon, 3 Oct 2022 12:43:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 24/39] x86/cet/shstk: Add user-mode shadow stack
 support
Message-ID: <202210031203.EB0DC0B7DD@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-25-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-25-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:21PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Introduce basic shadow stack enabling/disabling/allocation routines.
> A task's shadow stack is allocated from memory with VM_SHADOW_STACK flag
> and has a fixed size of min(RLIMIT_STACK, 4GB).
> 
> Keep the task's shadow stack address and size in thread_struct. This will
> be copied when cloning new threads, but needs to be cleared during exec,
> so add a function to do this.
> 
> Do not support IA32 emulation.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> 
> ---
> 
> v2:
>  - Get rid of unnessary shstk->base checks
>  - Don't support IA32 emulation
> 
> v1:
>  - Switch to xsave helpers.
>  - Expand commit log.
> 
> Yu-cheng v30:
>  - Remove superfluous comments for struct thread_shstk.
>  - Replace 'populate' with 'unused'.
> 
> Yu-cheng v28:
>  - Update shstk_setup() with wrmsrl_safe(), returns success when shadow
>    stack feature is not present (since this is a setup function).
> 
>  arch/x86/include/asm/cet.h        |  13 +++
>  arch/x86/include/asm/msr.h        |  11 +++
>  arch/x86/include/asm/processor.h  |   5 ++
>  arch/x86/include/uapi/asm/prctl.h |   2 +
>  arch/x86/kernel/Makefile          |   2 +
>  arch/x86/kernel/process_64.c      |   2 +
>  arch/x86/kernel/shstk.c           | 143 ++++++++++++++++++++++++++++++
>  7 files changed, 178 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
> index 0fa4dbc98c49..a4a1f4c0089b 100644
> --- a/arch/x86/include/asm/cet.h
> +++ b/arch/x86/include/asm/cet.h
> @@ -7,12 +7,25 @@
>  
>  struct task_struct;
>  
> +struct thread_shstk {
> +	u64	base;
> +	u64	size;
> +};
> +
>  #ifdef CONFIG_X86_SHADOW_STACK
>  long cet_prctl(struct task_struct *task, int option,
>  		      unsigned long features);
> +int shstk_setup(void);
> +void shstk_free(struct task_struct *p);
> +int shstk_disable(void);
> +void reset_thread_shstk(void);
>  #else
>  static inline long cet_prctl(struct task_struct *task, int option,
>  		      unsigned long features) { return -EINVAL; }
> +static inline int shstk_setup(void) { return -EOPNOTSUPP; }
> +static inline void shstk_free(struct task_struct *p) {}
> +static inline int shstk_disable(void) { return -EOPNOTSUPP; }
> +static inline void reset_thread_shstk(void) {}
>  #endif /* CONFIG_X86_SHADOW_STACK */

shstk_setup() and shstk_disable() are not called outside of shstk.c, so
they can be removed from this header entirely.

>  
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
> index 65ec1965cd28..a9cb4c434e60 100644
> --- a/arch/x86/include/asm/msr.h
> +++ b/arch/x86/include/asm/msr.h
> @@ -310,6 +310,17 @@ void msrs_free(struct msr *msrs);
>  int msr_set_bit(u32 msr, u8 bit);
>  int msr_clear_bit(u32 msr, u8 bit);
>  
> +static inline void set_clr_bits_msrl(u32 msr, u64 set, u64 clear)
> +{
> +	u64 val, new_val;
> +
> +	rdmsrl(msr, val);
> +	new_val = (val & ~clear) | set;
> +
> +	if (new_val != val)
> +		wrmsrl(msr, new_val);
> +}

I always get uncomfortable when I see these kinds of generalized helper
functions for touching cpu bits, etc. It just begs for future attacker
abuse to muck with arbitrary bits -- even marked inline there is a risk
the compiler will ignore that in some circumstances (not as currently
used in the code, but I'm imagining future changes leading to such a
condition). Will you humor me and change this to a macro instead? That'll
force it always inline (even __always_inline isn't always inline):

/* Helper that can never get accidentally un-inlined. */
#define set_clr_bits_msrl(msr, set, clear)	do {	\
	u64 __val, __new_val;				\
							\
	rdmsrl(msr, __val);				\
	__new_val = (__val & ~(clear)) | (set);		\
							\
	if (__new_val != __val)				\
		wrmsrl(msr, __new_val);			\
} while (0)


> +
>  #ifdef CONFIG_SMP
>  int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
>  int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index a92bf76edafe..3a0c9d9d4d1d 100644
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
> @@ -533,6 +534,10 @@ struct thread_struct {
>  	unsigned long		features;
>  	unsigned long		features_locked;
>  
> +#ifdef CONFIG_X86_SHADOW_STACK
> +	struct thread_shstk	shstk;
> +#endif
> +
>  	/* Floating point and extended processor state */
>  	struct fpu		fpu;
>  	/*
> diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
> index 028158e35269..41af3a8c4fa4 100644
> --- a/arch/x86/include/uapi/asm/prctl.h
> +++ b/arch/x86/include/uapi/asm/prctl.h
> @@ -26,4 +26,6 @@
>  #define ARCH_CET_DISABLE		0x4002
>  #define ARCH_CET_LOCK			0x4003
>  
For readability, maybe add: /* ARCH_CET_* "features" bits */

> +#define CET_SHSTK			0x1

This is UAPI, so the BIT() macro isn't available, but since this is
unsigned long, please use the form:  (1ULL <<  0)  etc...

> +
>  #endif /* _ASM_X86_PRCTL_H */
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index a20a5ebfacd7..8950d1f71226 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -139,6 +139,8 @@ obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
>  
>  obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
>  
> +obj-$(CONFIG_X86_SHADOW_STACK)		+= shstk.o
> +
>  ###
>  # 64 bit specific files
>  ifeq ($(CONFIG_X86_64),y)
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 8fa2c2b7de65..be544b4b4c8b 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -514,6 +514,8 @@ start_thread_common(struct pt_regs *regs, unsigned long new_ip,
>  		load_gs_index(__USER_DS);
>  	}
>  
> +	reset_thread_shstk();
> +
>  	loadsegment(fs, 0);
>  	loadsegment(es, _ds);
>  	loadsegment(ds, _ds);
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index e3276ac9e9b9..a0b8d4adb2bf 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -8,8 +8,151 @@
>  
>  #include <linux/sched.h>
>  #include <linux/bitops.h>
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
> +#include <asm/fpu/xstate.h>
> +#include <asm/fpu/types.h>
> +#include <asm/cet.h>
> +#include <asm/special_insns.h>
> +#include <asm/fpu/api.h>
>  #include <asm/prctl.h>
>  
> +static bool feature_enabled(unsigned long features)
> +{
> +	return current->thread.features & features;
> +}
> +
> +static void feature_set(unsigned long features)
> +{
> +	current->thread.features |= features;
> +}
> +
> +static void feature_clr(unsigned long features)
> +{
> +	current->thread.features &= ~features;
> +}

"feature" vs "features" here is confusing. Should these helpers enforce
the single-bit-set requirements? If so, please switch to a bit number
instead of a mask. If not, please rename these to
"features_{enabled,set,clr}", and fix "features_enabled" to check them
all:
	return (current->thread.features & features) == features;

> +static unsigned long alloc_shstk(unsigned long size)
> +{
> +	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
> +	struct mm_struct *mm = current->mm;
> +	unsigned long addr, unused;

WARN_ON + clamp on "size" here, or perhaps move the bounds check from
shstk_setup() into here?

> +
> +	mmap_write_lock(mm);
> +	addr = do_mmap(NULL, addr, size, PROT_READ, flags,
> +		       VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);

This will use the mmap base address offset randomization, I guess?

> +
> +	mmap_write_unlock(mm);
> +
> +	return addr;
> +}
> +
> +static void unmap_shadow_stack(u64 base, u64 size)
> +{
> +	while (1) {
> +		int r;
> +
> +		r = vm_munmap(base, size);
> +
> +		/*
> +		 * vm_munmap() returns -EINTR when mmap_lock is held by
> +		 * something else, and that lock should not be held for a
> +		 * long time.  Retry it for the case.
> +		 */
> +		if (r == -EINTR) {
> +			cond_resched();
> +			continue;
> +		}
> +
> +		/*
> +		 * For all other types of vm_munmap() failure, either the
> +		 * system is out of memory or there is bug.
> +		 */
> +		WARN_ON_ONCE(r);
> +		break;
> +	}
> +}
> +
> +int shstk_setup(void)

Only called local. Make static?

> +{
> +	struct thread_shstk *shstk = &current->thread.shstk;
> +	unsigned long addr, size;
> +
> +	/* Already enabled */
> +	if (feature_enabled(CET_SHSTK))
> +		return 0;
> +
> +	/* Also not supported for 32 bit */
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) || in_ia32_syscall())
> +		return -EOPNOTSUPP;
> +
> +	size = PAGE_ALIGN(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G));
> +	addr = alloc_shstk(size);
> +	if (IS_ERR_VALUE(addr))
> +		return PTR_ERR((void *)addr);
> +
> +	fpu_lock_and_load();
> +	wrmsrl(MSR_IA32_PL3_SSP, addr + size);
> +	wrmsrl(MSR_IA32_U_CET, CET_SHSTK_EN);
> +	fpregs_unlock();
> +
> +	shstk->base = addr;
> +	shstk->size = size;
> +	feature_set(CET_SHSTK);
> +
> +	return 0;
> +}
> +
> +void reset_thread_shstk(void)
> +{
> +	memset(&current->thread.shstk, 0, sizeof(struct thread_shstk));
> +	current->thread.features = 0;
> +	current->thread.features_locked = 0;
> +}

If features is always going to be tied to shstk, why not put them in the
shstk struct?

Also, shouldn't this also be called from arch_setup_new_exec() instead
of the open-coded wipe of features there?

> +
> +void shstk_free(struct task_struct *tsk)
> +{
> +	struct thread_shstk *shstk = &tsk->thread.shstk;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
> +	    !feature_enabled(CET_SHSTK))
> +		return;
> +
> +	if (!tsk->mm)
> +		return;
> +
> +	unmap_shadow_stack(shstk->base, shstk->size);

I feel like base and size should be zeroed here?

> +}
> +
> +int shstk_disable(void)

This is only called locally. static?

> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +		return -EOPNOTSUPP;
> +
> +	/* Already disabled? */
> +	if (!feature_enabled(CET_SHSTK))
> +		return 0;
> +
> +	fpu_lock_and_load();
> +	/* Disable WRSS too when disabling shadow stack */
> +	set_clr_bits_msrl(MSR_IA32_U_CET, 0, CET_SHSTK_EN);
> +	wrmsrl(MSR_IA32_PL3_SSP, 0);
> +	fpregs_unlock();
> +
> +	shstk_free(current);
> +	feature_clr(CET_SHSTK);
> +
> +	return 0;
> +}
> +
>  long cet_prctl(struct task_struct *task, int option, unsigned long features)
>  {
>  	if (option == ARCH_CET_LOCK) {
> -- 
> 2.17.1
> 

-- 
Kees Cook
