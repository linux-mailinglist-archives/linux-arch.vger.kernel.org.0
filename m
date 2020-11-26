Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD2E2C5C24
	for <lists+linux-arch@lfdr.de>; Thu, 26 Nov 2020 19:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404567AbgKZStl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Nov 2020 13:49:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35552 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404018AbgKZStl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Nov 2020 13:49:41 -0500
Received: from zn.tnic (p200300ec2f0c9000558d893f9f23e622.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9000:558d:893f:9f23:e622])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EA7DB1EC051F;
        Thu, 26 Nov 2020 19:49:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606416579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2W+NL3SAFLUluBOMDMd2sp2541nCq4pNaSr+RwgKTNo=;
        b=FlzZs4iD/b1N/2T6ze+nzfRu5fchjA5IhevHmlusf1y3m5/h8mqAnGoz6gDYdGcG7pDV46
        5NC838TlUNV/76f1iPpRpp+I5SQ6QTgqyL5FOl2Ax/jwED3ngFT3Au1m6fbcyWqa9S+mxW
        u71XOVZbahIDozSfK49q+L8fWUgOX4s=
Date:   Thu, 26 Nov 2020 19:49:33 +0100
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
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v15 04/26] x86/cet: Add control-protection fault handler
Message-ID: <20201126184933.GF31565@zn.tnic>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-5-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201110162211.9207-5-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 10, 2020 at 08:21:49AM -0800, Yu-cheng Yu wrote:
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index e19df6cde35d..6c21c1e92605 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -598,6 +598,65 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  	cond_local_irq_disable(regs);
>  }
>  
> +#ifdef CONFIG_X86_CET
> +static const char * const control_protection_err[] = {
> +	"unknown",
> +	"near-ret",
> +	"far-ret/iret",
> +	"endbranch",
> +	"rstorssp",
> +	"setssbsy",
> +};
> +
> +/*
> + * When a control protection exception occurs, send a signal
> + * to the responsible application.  Currently, control
> + * protection is only enabled for the user mode.  This
> + * exception should not come from the kernel mode.
> + */

Make that 80 cols wide.

> +DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> +{
> +	struct task_struct *tsk;
> +
> +	if (notify_die(DIE_TRAP, "control protection fault", regs,
> +		       error_code, X86_TRAP_CP, SIGSEGV) == NOTIFY_STOP)
> +		return;

What is the intent here, notifiers can prevent the machine from printing
the CP error below?

> +	cond_local_irq_enable(regs);
> +
> +	if (!user_mode(regs))
> +		die("kernel control protection fault", regs, error_code);

Let's write that more explicitly:

		die("Unexpected/unsupported control protection fault"...

> +
> +	if (!static_cpu_has(X86_FEATURE_SHSTK) &&
> +	    !static_cpu_has(X86_FEATURE_IBT))

Why static_cpu_has?

> +		WARN_ONCE(1, "CET is disabled but got control protection fault\n");

			     "Control protection fault with CET support disabled\n"

> +
> +	tsk = current;
> +	tsk->thread.error_code = error_code;
> +	tsk->thread.trap_nr = X86_TRAP_CP;
> +
> +	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
> +	    printk_ratelimit()) {
> +		unsigned int max_err;
> +		unsigned long ssp;
> +
> +		max_err = ARRAY_SIZE(control_protection_err) - 1;
> +		if ((error_code < 0) || (error_code > max_err))
> +			error_code = 0;

<---- newline here.

> +		rdmsrl(MSR_IA32_PL3_SSP, ssp);
> +		pr_info("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)",
> +			tsk->comm, task_pid_nr(tsk),
> +			regs->ip, regs->sp, ssp, error_code,
> +			control_protection_err[error_code]);
> +		print_vma_addr(KERN_CONT " in ", regs->ip);
> +		pr_cont("\n");
> +	}

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
