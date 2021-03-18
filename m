Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E761340591
	for <lists+linux-arch@lfdr.de>; Thu, 18 Mar 2021 13:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhCRMcW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Mar 2021 08:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhCRMcS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Mar 2021 08:32:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8F6C06174A;
        Thu, 18 Mar 2021 05:32:18 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0fad00d75c69f143849f33.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:ad00:d75c:69f1:4384:9f33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9860B1EC0588;
        Thu, 18 Mar 2021 13:32:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616070736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KdZxGoW8E0Yb5R2XGKQeoZI3CfwvnJolse9Jj5h06wE=;
        b=VsgEwR4JlwvnISKDyXBK4k1m8sJNVs/L68IqL3bCPBrkf+EIhE+ttIW3o/P38FXupadupf
        CE8Tnk/w/6ekC2/AlPi0WMFZnmzeAvyF5fvJ95lzz9hclGDFVS1bY7sXdl8t7s0D006jnu
        ije1CeCZz37FiV3dDdTflsP+aw0Xgmo=
Date:   Thu, 18 Mar 2021 13:32:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
Subject: Re: [PATCH v23 22/28] x86/cet/shstk: User-mode shadow stack support
Message-ID: <20210318123215.GE19570@zn.tnic>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-23-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210316151054.5405-23-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> Subject: Re: [PATCH v23 22/28] x86/cet/shstk:   User-mode shadow stack support
						^
						Add

On Tue, Mar 16, 2021 at 08:10:48AM -0700, Yu-cheng Yu wrote:
> Introduce basic shadow stack enabling/disabling/allocation routines.
> A task's shadow stack is allocated from memory with VM_SHSTK flag and has
> a fixed size of min(RLIMIT_STACK, 4GB).
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/include/asm/cet.h       |  28 ++++++
>  arch/x86/include/asm/processor.h |   5 ++
>  arch/x86/kernel/Makefile         |   2 +
>  arch/x86/kernel/cet.c            | 147 +++++++++++++++++++++++++++++++

Yeah, since Peter wants stuff split, let's call that shstk.c and the IBT
stuff goes into a separate ibt.c please.

> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index dc6d149bf851..3fce5062261b 100644
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

	struct shstk_desc	shstk;

or so.

> +int cet_setup_shstk(void)
> +{
> +	unsigned long addr, size;
> +	struct cet_status *cet = &current->thread.cet;
> +
> +	if (!static_cpu_has(X86_FEATURE_SHSTK))

cpu_feature_enabled

> +		return -EOPNOTSUPP;
> +
> +	size = round_up(min(rlimit(RLIMIT_STACK), 1UL << 32), PAGE_SIZE);
						  ^
						  SZ_4G

> +	addr = alloc_shstk(size, 0);
> +

^ Superfluous newline.

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
> +void cet_disable_shstk(void)
> +{
> +	struct cet_status *cet = &current->thread.cet;
> +	u64 msr_val;
> +
> +	if (!static_cpu_has(X86_FEATURE_SHSTK) ||

cpu_feature_enabled

And put the || on the end of each line:

	if (!cpu_feature_enabled() ||
	    !cet->shstk_size ||
	    ... )


> +	    !cet->shstk_size || !cet->shstk_base)
> +		return;
> +
> +	start_update_msrs();
> +	rdmsrl(MSR_IA32_U_CET, msr_val);
> +	wrmsrl(MSR_IA32_U_CET, msr_val & ~CET_SHSTK_EN);
> +	wrmsrl(MSR_IA32_PL3_SSP, 0);
> +	end_update_msrs();
> +
> +	cet_free_shstk(current);
> +}

Put that function under cet_free_shstk().

> +void cet_free_shstk(struct task_struct *tsk)
> +{
> +	struct cet_status *cet = &tsk->thread.cet;
> +
> +	if (!static_cpu_has(X86_FEATURE_SHSTK) ||

cpu_feature_enabled and as above.

> +	    !cet->shstk_size || !cet->shstk_base)
> +		return;
> +
> +	if (!tsk->mm || tsk->mm != current->mm)
> +		return;

You're operating on current here merrily but what's protecting all those
paths operating on current from getting current changed underneath them
due to scheduling? IOW, is preemption safely disabled in all those
paths ending up here?

> +
> +	while (1) {

Uuh, an endless loop. What guarantees we'll exit it relatively timely...

> +		int r;
> +
> +		r = vm_munmap(cet->shstk_base, cet->shstk_size);
> +
> +		/*
> +		 * Retry if mmap_lock is not available.
> +		 */
> +		if (r == -EINTR) {
> +			cond_resched();

... that thing?

> +			continue;
> +		}
> +
> +		WARN_ON_ONCE(r);
> +		break;
> +	}
> +
> +	cet->shstk_base = 0;
> +	cet->shstk_size = 0;
> +}
> -- 
> 2.21.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
