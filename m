Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D50652485
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 17:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiLTQTo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 11:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiLTQTm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 11:19:42 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE765B64;
        Tue, 20 Dec 2022 08:19:40 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 75E321EC0529;
        Tue, 20 Dec 2022 17:19:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1671553178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+VYkEsGbPer0Bj0EJK+U0s1hj+W19pg2cIhh+c92hxo=;
        b=Z+AMWLFjrXMCFqZqAZLklJL+QZbXdYnOba8zcsxcCf56dnbY0+Ti5dMWHLhy4BO0x4ooFU
        MNTthb5m2GcBbLG4RIv0Sek45g9ffbVSH5B3iuWQcoMT51PzTcOCVE/gGfEsPbltAkqTzW
        pD/5rWjPw4uIQKMM0WL6uBUE8HkE2zQ=
Date:   Tue, 20 Dec 2022 17:19:32 +0100
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
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v4 07/39] x86: Add user control-protection fault handler
Message-ID: <Y6HglBhrccduDTQA@zn.tnic>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-8-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-8-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:34PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> A control-protection fault is triggered when a control-flow transfer
> attempt violates Shadow Stack or Indirect Branch Tracking constraints.
> For example, the return address for a RET instruction differs from the copy
> on the shadow stack.
> 
> There already exists a control-protection fault handler for handling kernel
> IBT. Refactor this fault handler into sparate user and kernel handlers,

Unknown word [sparate] in commit message.
Suggestions: ['separate', 

You could use a spellchecker with your commit messages so that it
catches all those typos.

...

> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 8b83d8fbce71..e35c70dc1afb 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -213,12 +213,7 @@ DEFINE_IDTENTRY(exc_overflow)
>  	do_error_trap(regs, 0, "overflow", X86_TRAP_OF, SIGSEGV, 0, NULL);
>  }
>  
> -#ifdef CONFIG_X86_KERNEL_IBT
> -
> -static __ro_after_init bool ibt_fatal = true;
> -
> -extern void ibt_selftest_ip(void); /* code label defined in asm below */
> -
> +#ifdef CONFIG_X86_CET
>  enum cp_error_code {
>  	CP_EC        = (1 << 15) - 1,
>  
> @@ -231,15 +226,87 @@ enum cp_error_code {
>  	CP_ENCL	     = 1 << 15,
>  };
>  
> -DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> +static const char control_protection_err[][10] = {

You already use the "cp_" prefix for the other things, might as well use
it here too.

> +	[0] = "unknown",
> +	[1] = "near ret",
> +	[2] = "far/iret",
> +	[3] = "endbranch",
> +	[4] = "rstorssp",
> +	[5] = "setssbsy",
> +};
> +
> +static const char *cp_err_string(unsigned long error_code)
> +{
> +	unsigned int cpec = error_code & CP_EC;
> +
> +	if (cpec >= ARRAY_SIZE(control_protection_err))
> +		cpec = 0;
> +	return control_protection_err[cpec];
> +}
> +
> +static void do_unexpected_cp(struct pt_regs *regs, unsigned long error_code)
> +{
> +	WARN_ONCE(1, "Unexpected %s #CP, error_code: %s\n",
> +		     user_mode(regs) ? "user mode" : "kernel mode",
> +		     cp_err_string(error_code));
> +}
> +#endif /* CONFIG_X86_CET */
> +
> +void do_user_cp_fault(struct pt_regs *regs, unsigned long error_code);

What's that forward declaration for?

In any case, push it into traps.h pls.

I gotta say, I'm not a big fan of that ifdeffery here. Do we really
really need it?

> +#ifdef CONFIG_X86_USER_SHADOW_STACK
> +static DEFINE_RATELIMIT_STATE(cpf_rate, DEFAULT_RATELIMIT_INTERVAL,
> +			      DEFAULT_RATELIMIT_BURST);
> +
> +void do_user_cp_fault(struct pt_regs *regs, unsigned long error_code)
>  {
> -	if (!cpu_feature_enabled(X86_FEATURE_IBT)) {
> -		pr_err("Unexpected #CP\n");
> -		BUG();
> +	struct task_struct *tsk;
> +	unsigned long ssp;
> +
> +	/*
> +	 * An exception was just taken from userspace. Since interrupts are disabled
> +	 * here, no scheduling should have messed with the registers yet and they
> +	 * will be whatever is live in userspace. So read the SSP before enabling
> +	 * interrupts so locking the fpregs to do it later is not required.
> +	 */
> +	rdmsrl(MSR_IA32_PL3_SSP, ssp);
> +
> +	cond_local_irq_enable(regs);
> +
> +	tsk = current;
> +	tsk->thread.error_code = error_code;
> +	tsk->thread.trap_nr = X86_TRAP_CP;
> +
> +	/* Ratelimit to prevent log spamming. */
> +	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
> +	    __ratelimit(&cpf_rate)) {
> +		pr_emerg("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)%s",
> +			 tsk->comm, task_pid_nr(tsk),
> +			 regs->ip, regs->sp, ssp, error_code,
> +			 cp_err_string(error_code),
> +			 error_code & CP_ENCL ? " in enclave" : "");
> +		print_vma_addr(KERN_CONT " in ", regs->ip);
> +		pr_cont("\n");
>  	}
>  
> -	if (WARN_ON_ONCE(user_mode(regs) || (error_code & CP_EC) != CP_ENDBR))
> +	force_sig_fault(SIGSEGV, SEGV_CPERR, (void __user *)0);
> +	cond_local_irq_disable(regs);
> +}
> +#endif
> +
> +void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code);
> +
> +#ifdef CONFIG_X86_KERNEL_IBT
> +static __ro_after_init bool ibt_fatal = true;
> +
> +extern void ibt_selftest_ip(void); /* code label defined in asm below */

Yeah, pls put that comment above the function. Side comments are nasty.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
