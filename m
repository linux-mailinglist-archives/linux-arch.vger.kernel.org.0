Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E66616F123
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 22:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgBYV3Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 16:29:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42937 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgBYV3P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 16:29:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id h8so172666pgs.9
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 13:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S/FIbI+B+1AXtIG+6X6UmoCI89bJQls8Ya5JRg19+CE=;
        b=nUVRiccN9kZCxZ83HtHJa51NNtoOmhsH0gDd2R02Zuy/bNWgSZfP9eP19YE814le55
         7kwf1lMZp4dvDhPY2ZgWfbUgLisO2TgpGB8/edRR/7sZJAFQZi9CSQY6bG3Wg9oz9KtI
         S7lj68pzu/b9+gus/FA3mGwlI/D4djZRtiV1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S/FIbI+B+1AXtIG+6X6UmoCI89bJQls8Ya5JRg19+CE=;
        b=W5xja3+Sx773RuinNVIG9OtivdCsdAd1zVo0AXz3NTUTVleCbDRoKJQQnBiEcz/7H0
         3VZ1JPO0B31ZPNoJbLHzt1TG6SJbZkSD17yNGy+zbzrK7rrxJJwdjFek5EFgdCpfvYri
         2zFIkmwqIoK7tYjZ4AZaTtj5EF+viVo9QX0siZ5keJYaavbdpNZCWPjO6N5r/xbUAjiz
         L4MyYKfv3pQh+ltEtYmB+szYt9wLGg3kcoPCIe1jqUa7H35qK23/eOkToehBP26srRmv
         3eZKwaClXUXCUvkysyA2wCPP33d4pr0+gESpL8J3qTXRtE41I0AI+ECSlsScAry9IonZ
         15Bg==
X-Gm-Message-State: APjAAAXZGsKaYvZKLzMgwp2aOkMT7NLD9BTQY7GWImdZnq9doTTcPi5p
        K12qA02onGqsoMoDW0ufJEfonQ==
X-Google-Smtp-Source: APXvYqxz9bH6oSUuy2LfLyRx0MtHyLriFGvoytHJvrFkPoAEiRc69XTS4QKMITcSoTrsvxe7ZtzgPQ==
X-Received: by 2002:a63:4763:: with SMTP id w35mr488829pgk.113.1582666154657;
        Tue, 25 Feb 2020 13:29:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id az9sm52982pjb.3.2020.02.25.13.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 13:29:13 -0800 (PST)
Date:   Tue, 25 Feb 2020 13:29:12 -0800
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
Subject: Re: [RFC PATCH v9 25/27] x86/cet/shstk: Handle thread Shadow Stack
Message-ID: <202002251324.5D515260@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-26-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-26-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:33AM -0800, Yu-cheng Yu wrote:
> The Shadow Stack (SHSTK) for clone/fork is handled as the following:
> 
> (1) If ((clone_flags & (CLONE_VFORK | CLONE_VM)) == CLONE_VM),
>     the kernel allocates (and frees on thread exit) a new SHSTK for the
>     child.
> 
>     It is possible for the kernel to complete the clone syscall and set the
>     child's SHSTK pointer to NULL and let the child thread allocate a SHSTK
>     for itself.  There are two issues in this approach: It is not
>     compatible with existing code that does inline syscall and it cannot
>     handle signals before the child can successfully allocate a SHSTK.
> 
> (2) For (clone_flags & CLONE_VFORK), the child uses the existing SHSTK.
> 
> (3) For all other cases, the SHSTK is copied/reused whenever the parent or
>     the child does a call/ret.
> 
> This patch handles cases (1) & (2).  Case (3) is handled in the SHSTK page
> fault patches.
> 
> A 64-bit SHSTK has a fixed size of RLIMIT_STACK. A compat-mode thread SHSTK
> has a fixed size of 1/4 RLIMIT_STACK.  This allows more threads to share a
> 32-bit address space.

I am not understanding this part. :) Entries are sizeof(unsigned long),
yes? A 1/2 RLIMIT_STACK would cover 32-bit, but 1/4 is less, so why does
that provide for more threads?

> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/cet.h         |  2 ++
>  arch/x86/include/asm/mmu_context.h |  3 +++
>  arch/x86/kernel/cet.c              | 41 ++++++++++++++++++++++++++++++
>  arch/x86/kernel/process.c          |  7 +++++
>  4 files changed, 53 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
> index 409d4f91a0dc..9a3e2da9c1c4 100644
> --- a/arch/x86/include/asm/cet.h
> +++ b/arch/x86/include/asm/cet.h
> @@ -19,10 +19,12 @@ struct cet_status {
>  
>  #ifdef CONFIG_X86_INTEL_CET
>  int cet_setup_shstk(void);
> +int cet_setup_thread_shstk(struct task_struct *p);
>  void cet_disable_free_shstk(struct task_struct *p);
>  int cet_restore_signal(bool ia32, struct sc_ext *sc);
>  int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
>  #else
> +static inline int cet_setup_thread_shstk(struct task_struct *p) { return 0; }
>  static inline void cet_disable_free_shstk(struct task_struct *p) {}
>  static inline int cet_restore_signal(bool ia32, struct sc_ext *sc) { return -EINVAL; }
>  static inline int cet_setup_signal(bool ia32, unsigned long rstor,
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index 5f33924e200f..6a8189308823 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -13,6 +13,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/paravirt.h>
>  #include <asm/mpx.h>
> +#include <asm/cet.h>
>  #include <asm/debugreg.h>
>  
>  extern atomic64_t last_mm_ctx_id;
> @@ -230,6 +231,8 @@ do {						\
>  #else
>  #define deactivate_mm(tsk, mm)			\
>  do {						\
> +	if (!tsk->vfork_done)			\
> +		cet_disable_free_shstk(tsk);	\
>  	load_gs_index(0);			\
>  	loadsegment(fs, 0);			\
>  } while (0)
> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
> index cba5c7656aab..5b45abda80a1 100644
> --- a/arch/x86/kernel/cet.c
> +++ b/arch/x86/kernel/cet.c
> @@ -170,6 +170,47 @@ int cet_setup_shstk(void)
>  	return 0;
>  }
>  
> +int cet_setup_thread_shstk(struct task_struct *tsk)
> +{
> +	unsigned long addr, size;
> +	struct cet_user_state *state;
> +	struct cet_status *cet = &tsk->thread.cet;
> +
> +	if (!cet->shstk_enabled)
> +		return 0;
> +
> +	state = get_xsave_addr(&tsk->thread.fpu.state.xsave,
> +			       XFEATURE_CET_USER);
> +
> +	if (!state)
> +		return -EINVAL;
> +
> +	size = rlimit(RLIMIT_STACK);

Is SHSTK incompatible with RLIM_INFINITY stack rlimits?

> +
> +	/*
> +	 * Compat-mode pthreads share a limited address space.
> +	 * If each function call takes an average of four slots
> +	 * stack space, we need 1/4 of stack size for shadow stack.
> +	 */
> +	if (in_compat_syscall())
> +		size /= 4;
> +
> +	addr = alloc_shstk(size);

I assume it'd fail here, but I worry about Stack Clash style attacks.
I'd like to see test cases that make sure the SHSTK gap is working
correctly.

-Kees

> +
> +	if (IS_ERR((void *)addr)) {
> +		cet->shstk_base = 0;
> +		cet->shstk_size = 0;
> +		cet->shstk_enabled = 0;
> +		return PTR_ERR((void *)addr);
> +	}
> +
> +	fpu__prepare_write(&tsk->thread.fpu);
> +	state->user_ssp = (u64)(addr + size);
> +	cet->shstk_base = addr;
> +	cet->shstk_size = size;
> +	return 0;
> +}
> +
>  void cet_disable_free_shstk(struct task_struct *tsk)
>  {
>  	struct cet_status *cet = &tsk->thread.cet;
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index e102e63de641..7098618142f2 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -110,6 +110,7 @@ void exit_thread(struct task_struct *tsk)
>  
>  	free_vm86(t);
>  
> +	cet_disable_free_shstk(tsk);
>  	fpu__drop(fpu);
>  }
>  
> @@ -180,6 +181,12 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
>  	if (clone_flags & CLONE_SETTLS)
>  		ret = set_new_tls(p, tls);
>  
> +#ifdef CONFIG_X86_64
> +	/* Allocate a new shadow stack for pthread */
> +	if (!ret && (clone_flags & (CLONE_VFORK | CLONE_VM)) == CLONE_VM)
> +		ret = cet_setup_thread_shstk(p);
> +#endif
> +
>  	if (!ret && unlikely(test_tsk_thread_flag(current, TIF_IO_BITMAP)))
>  		io_bitmap_share(p);
>  
> -- 
> 2.21.0
> 

-- 
Kees Cook
