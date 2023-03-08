Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858B16B0C9E
	for <lists+linux-arch@lfdr.de>; Wed,  8 Mar 2023 16:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjCHP0M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Mar 2023 10:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjCHP0L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2023 10:26:11 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AD95D893;
        Wed,  8 Mar 2023 07:26:06 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E4F2B1EC053F;
        Wed,  8 Mar 2023 16:26:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678289165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0YZFEJ4cAs1XpubhR+bVW6Ra4NdOXmwmbEoV5/5yyRc=;
        b=dtU8MD7MnP6eQPuPrVOrLw3IOhDbONhvPWew+BaeOWqCec5Wv2fzyDEfHf4wjHzLBlYNYH
        Z9maXvegSwDqzaejWBASPjzFR36tHjxJJ6jB9g4zq8roVzifvs06B6rFJJjnkgcS3kZlvd
        zE6MuI7N30FA56Zls5hIliZDyjtUSm4=
Date:   Wed, 8 Mar 2023 16:26:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v7 30/41] x86/shstk: Handle thread shadow stack
Message-ID: <ZAipCNBCtPA2bcck@zn.tnic>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-31-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-31-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 02:29:46PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> When a process is duplicated, but the child shares the address space with
> the parent, there is potential for the threads sharing a single stack to
> cause conflicts for each other. In the normal non-cet case this is handled

"non-CET"

> in two ways.
> 
> With regular CLONE_VM a new stack is provided by userspace such that the
> parent and child have different stacks.
> 
> For vfork, the parent is suspended until the child exits. So as long as
> the child doesn't return from the vfork()/CLONE_VFORK calling function and
> sticks to a limited set of operations, the parent and child can share the
> same stack.
> 
> For shadow stack, these scenarios present similar sharing problems. For the
> CLONE_VM case, the child and the parent must have separate shadow stacks.
> Instead of changing clone to take a shadow stack, have the kernel just
> allocate one and switch to it.
> 
> Use stack_size passed from clone3() syscall for thread shadow stack size. A
> compat-mode thread shadow stack size is further reduced to 1/4. This
> allows more threads to run in a 32-bit address space. The clone() does not
> pass stack_size, which was added to clone3(). In that case, use
> RLIMIT_STACK size and cap to 4 GB.
> 
> For shadow stack enabled vfork(), the parent and child can share the same
> shadow stack, like they can share a normal stack. Since the parent is
> suspended until the child terminates, the child will not interfere with
> the parent while executing as long as it doesn't return from the vfork()
> and overwrite up the shadow stack. The child can safely overwrite down
> the shadow stack, as the parent can just overwrite this later. So CET does
> not add any additional limitations for vfork().
> 
> Userspace implementing posix vfork() can actually prevent the child from

"POSIX"

...

> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index f851558b673f..bc3de4aeb661 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -552,8 +552,41 @@ static inline void fpu_inherit_perms(struct fpu *dst_fpu)
>  	}
>  }
>  
> +#ifdef CONFIG_X86_USER_SHADOW_STACK
> +static int update_fpu_shstk(struct task_struct *dst, unsigned long ssp)
> +{
> +	struct cet_user_state *xstate;
> +
> +	/* If ssp update is not needed. */
> +	if (!ssp)
> +		return 0;
> +
> +	xstate = get_xsave_addr(&dst->thread.fpu.fpstate->regs.xsave,
> +				XFEATURE_CET_USER);
> +
> +	/*
> +	 * If there is a non-zero ssp, then 'dst' must be configured with a shadow
> +	 * stack and the fpu state should be up to date since it was just copied
> +	 * from the parent in fpu_clone(). So there must be a valid non-init CET
> +	 * state location in the buffer.
> +	 */
> +	if (WARN_ON_ONCE(!xstate))
> +		return 1;
> +
> +	xstate->user_ssp = (u64)ssp;
> +
> +	return 0;
> +}
> +#else
> +static int update_fpu_shstk(struct task_struct *dst, unsigned long shstk_addr)
								      ^^^^^^^^^^^
ssp, like above.

Better yet:

static int update_fpu_shstk(struct task_struct *dst, unsigned long ssp)
{
#ifdef CONFIG_X86_USER_SHADOW_STACK
	...
#endif
	return 0;
}

and less ifdeffery.



> +{
> +	return 0;
> +}
> +#endif
> +
>  /* Clone current's FPU state on fork */
> -int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal)
> +int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
> +	      unsigned long ssp)
>  {
>  	struct fpu *src_fpu = &current->thread.fpu;
>  	struct fpu *dst_fpu = &dst->thread.fpu;
> @@ -613,6 +646,12 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal)
>  	if (use_xsave())
>  		dst_fpu->fpstate->regs.xsave.header.xfeatures &= ~XFEATURE_MASK_PASID;
>  
> +	/*
> +	 * Update shadow stack pointer, in case it changed during clone.
> +	 */
> +	if (update_fpu_shstk(dst, ssp))
> +		return 1;
> +
>  	trace_x86_fpu_copy_src(src_fpu);
>  	trace_x86_fpu_copy_dst(dst_fpu);
>  
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index b650cde3f64d..bf703f53fa49 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -48,6 +48,7 @@
>  #include <asm/frame.h>
>  #include <asm/unwind.h>
>  #include <asm/tdx.h>
> +#include <asm/shstk.h>
>  
>  #include "process.h"
>  
> @@ -119,6 +120,7 @@ void exit_thread(struct task_struct *tsk)
>  
>  	free_vm86(t);
>  
> +	shstk_free(tsk);
>  	fpu__drop(fpu);
>  }
>  
> @@ -140,6 +142,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  	struct inactive_task_frame *frame;
>  	struct fork_frame *fork_frame;
>  	struct pt_regs *childregs;
> +	unsigned long shstk_addr = 0;
>  	int ret = 0;
>  
>  	childregs = task_pt_regs(p);
> @@ -174,7 +177,13 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  	frame->flags = X86_EFLAGS_FIXED;
>  #endif
>  
> -	fpu_clone(p, clone_flags, args->fn);
> +	/* Allocate a new shadow stack for pthread if needed */
> +	ret = shstk_alloc_thread_stack(p, clone_flags, args->stack_size,
> +				       &shstk_addr);

That function will return 0 even if shstk_addr hasn't been written in it
and you will continue merrily and call

	fpu_clone(..., shstk_addr=0);

why don't you return the shadow stack address or negative on error
instead of adding an I/O parameter which is pretty much always nasty to
deal with.



> +	if (ret)
> +		return ret;
> +
> +	fpu_clone(p, clone_flags, args->fn, shstk_addr);
>  
>  	/* Kernel thread ? */
>  	if (unlikely(p->flags & PF_KTHREAD)) {

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
