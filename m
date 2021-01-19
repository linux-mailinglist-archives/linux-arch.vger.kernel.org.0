Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606D52FBA5D
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jan 2021 15:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbhASOxb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 09:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392367AbhASMFQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 07:05:16 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFC9C061574;
        Tue, 19 Jan 2021 04:04:35 -0800 (PST)
Received: from zn.tnic (p200300ec2f0bca00c2aa0e949335efb7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ca00:c2aa:e94:9335:efb7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7A35E1EC05E9;
        Tue, 19 Jan 2021 13:04:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611057871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/Pv8SRw220kJLxdDOBMETHVBBP03v/5o64vtmGCNBWM=;
        b=aFehaN5VqYjE809Cxac/bMeLnYEeUHwYj7aStR7i3DSRTsYV1n9bR4MV51Fyepq+0KyUNv
        Hgv6PDg2vj96bWjRz7a/bliHjv/5tAC5qZVCOD0B9zLErTlYWbS5i0lRdCXQZYuo82/mtf
        TW846Qycog45LbPUY/XS3LDMejbLwp0=
Date:   Tue, 19 Jan 2021 13:04:25 +0100
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
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH v17 06/26] x86/cet: Add control-protection fault handler
Message-ID: <20210119120425.GI27433@zn.tnic>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-7-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201229213053.16395-7-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 29, 2020 at 01:30:33PM -0800, Yu-cheng Yu wrote:
> @@ -606,6 +606,65 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  	cond_local_irq_disable(regs);
>  }
>  
> +#ifdef CONFIG_X86_CET_USER
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
> + * When a control protection exception occurs, send a signal to the responsible
> + * application.  Currently, control protection is only enabled for the user
> + * mode.  This exception should not come from the kernel mode.
> + */

There's no "the user mode" or "the kernel mode" - just "user mode" or
"kernel mode".

> +DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> +{
> +	struct task_struct *tsk;
> +
> +	if (!user_mode(regs)) {
> +		if (notify_die(DIE_TRAP, "control protection fault", regs,
> +			       error_code, X86_TRAP_CP, SIGSEGV) == NOTIFY_STOP)
> +			return;
> +		die("Upexpected/unsupported kernel control protection fault", regs, error_code);

Isn't the machine supposed to panic() here and do no further progress?

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
> +	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
> +	    printk_ratelimit()) {

WARNING: Prefer printk_ratelimited or pr_<level>_ratelimited to printk_ratelimit
#136: FILE: arch/x86/kernel/traps.c:645:
+	    printk_ratelimit()) {

Still not using checkpatch?

> +		unsigned int max_err;
> +		unsigned long ssp;
> +
> +		max_err = ARRAY_SIZE(control_protection_err) - 1;
> +		if ((error_code < 0) || (error_code > max_err))
> +			error_code = 0;
> +
> +		rdmsrl(MSR_IA32_PL3_SSP, ssp);
> +		pr_info("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)",

If anything, all this stuff should be pr_emerg().

> +			tsk->comm, task_pid_nr(tsk),
> +			regs->ip, regs->sp, ssp, error_code,
> +			control_protection_err[error_code]);
> +		print_vma_addr(KERN_CONT " in ", regs->ip);
> +		pr_cont("\n");
> +	}
> +
> +	force_sig_fault(SIGSEGV, SEGV_CPERR,
> +			(void __user *)uprobe_get_trap_addr(regs));
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

This looks like it needs documentation in this manpage:

https://www.man7.org/linux/man-pages/man2/sigaction.2.html

+ Michael.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
