Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1ED03241F1
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 17:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBXQQZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 11:16:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35762 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231787AbhBXQOa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Feb 2021 11:14:30 -0500
Received: from zn.tnic (p200300ec2f0d1800cad8e5da06da911c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1800:cad8:e5da:6da:911c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 09AED1EC030F;
        Wed, 24 Feb 2021 17:13:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614183225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Er7y3jCuuCKgbYlCZ7mXOhRm/JIUbE/Vg6GeirSlpE0=;
        b=O0HDByKCzxkxZNznG50gQwqin4Y2bSk8iAFHgW/VkUdQB4EzOKSXeY5F4aCBIh3AH29Egv
        4BWKltjoPD8Iwx3H7rWPZTKgkQzDf728LZ1fBpFV8vPm7JnCddiq6gCXR1QPFa+gCn13Ro
        Ot5RFiZrcITHPz3IDzoKk+BIjMPG8kg=
Date:   Wed, 24 Feb 2021 17:13:43 +0100
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
        Haitao Huang <haitao.huang@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v21 06/26] x86/cet: Add control-protection fault handler
Message-ID: <20210224161343.GE20344@zn.tnic>
References: <20210217222730.15819-1-yu-cheng.yu@intel.com>
 <20210217222730.15819-7-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210217222730.15819-7-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 17, 2021 at 02:27:10PM -0800, Yu-cheng Yu wrote:
> +/*
> + * When a control protection exception occurs, send a signal to the responsible
> + * application.  Currently, control protection is only enabled for user mode.
> + * This exception should not come from kernel mode.
> + */
> +DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> +{
> +	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> +				      DEFAULT_RATELIMIT_BURST);

Pls move that out of the function - those "static" qualifiers get missed
easily when inside a function.

> +	struct task_struct *tsk;
> +
> +	if (!user_mode(regs)) {
> +		pr_emerg("PANIC: unexpected kernel control protection fault\n");
> +		die("kernel control protection fault", regs, error_code);
> +		panic("Machine halted.");
> +	}
> +
> +	cond_local_irq_enable(regs);
> +
> +	if (!boot_cpu_has(X86_FEATURE_CET))
> +		WARN_ONCE(1, "Control protection fault with CET support disabled\n");
> +
> +	tsk = current;
> +	tsk->thread.error_code = error_code;
> +	tsk->thread.trap_nr = X86_TRAP_CP;
> +
> +	/*
> +	 * Ratelimit to prevent log spamming.
> +	 */
> +	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
> +	    __ratelimit(&rs)) {
> +		unsigned long ssp;
> +		int err;
> +
> +		err = array_index_nospec(error_code, ARRAY_SIZE(control_protection_err));

"err" as an automatic variable is confusing - we use those to denote
whether the function returned an error or not. Call yours "cpf_type" or
so.

> +
> +		rdmsrl(MSR_IA32_PL3_SSP, ssp);
> +		pr_emerg("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)",
> +			 tsk->comm, task_pid_nr(tsk),
> +			 regs->ip, regs->sp, ssp, error_code,
> +			 control_protection_err[err]);
> +		print_vma_addr(KERN_CONT " in ", regs->ip);
> +		pr_cont("\n");
> +	}
> +
> +	force_sig_fault(SIGSEGV, SEGV_CPERR,
> +			(void __user *)uprobe_get_trap_addr(regs));

Why is this calling an uprobes function?

Also, do not break that line even if it is longer than 80.

> +	cond_local_irq_disable(regs);
> +}
> +#endif
> +
>  static bool do_int3(struct pt_regs *regs)
>  {
>  	int res;
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index d2597000407a..1c2ea91284a0 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -231,7 +231,8 @@ typedef struct siginfo {
>  #define SEGV_ADIPERR	7	/* Precise MCD exception */
>  #define SEGV_MTEAERR	8	/* Asynchronous ARM MTE error */
>  #define SEGV_MTESERR	9	/* Synchronous ARM MTE exception */
> -#define NSIGSEGV	9
> +#define SEGV_CPERR	10	/* Control protection fault */
> +#define NSIGSEGV	10

I still don't see the patch adding this to the manpage of sigaction(2).

There's a git repo there: https://www.kernel.org/doc/man-pages/

and I'm pretty sure Michael takes patches.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
