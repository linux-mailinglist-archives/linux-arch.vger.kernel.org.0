Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07D468A28E
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 20:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjBCTJY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 14:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjBCTJX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 14:09:23 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD47EA;
        Fri,  3 Feb 2023 11:09:22 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C593D1EC04E2;
        Fri,  3 Feb 2023 20:09:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675451360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LXY2XoEteH+dNqMW7AfnSnTBOxxYLXAUN7HmaIMxBkM=;
        b=N8WcH7X0tVKglRYLqZtDwZoK8S+1l2pz7CtwpUyF9jIHUhxEgOvmxEiarZF7XyQmhxIttC
        4RpkcwEUAfMrKVn+FwZuu3wBPI67biMbhwYr4g060noTNhZ0fBz+HtT1rvxDsfYWg32T7n
        b/qJbY+RUHNvJw2Y50jVoYs5SSZFBig=
Date:   Fri, 3 Feb 2023 20:09:15 +0100
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
Subject: Re: [PATCH v5 07/39] x86: Add user control-protection fault handler
Message-ID: <Y91b2x8pSFtmB+w6@zn.tnic>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-8-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-8-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 19, 2023 at 01:22:45PM -0800, Rick Edgecombe wrote:
> Subject: Re: [PATCH v5 07/39] x86: Add user control-protection fault handler

Subject: x86/shstk: Add...

> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> A control-protection fault is triggered when a control-flow transfer
> attempt violates Shadow Stack or Indirect Branch Tracking constraints.
> For example, the return address for a RET instruction differs from the copy
> on the shadow stack.

...

> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
> new file mode 100644
> index 000000000000..33d7d119be26
> --- /dev/null
> +++ b/arch/x86/kernel/cet.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/ptrace.h>
> +#include <asm/bugs.h>
> +#include <asm/traps.h>
> +
> +enum cp_error_code {
> +	CP_EC        = (1 << 15) - 1,

That looks like a mask, so

	CP_EC_MASK

I guess.

> +
> +	CP_RET       = 1,
> +	CP_IRET      = 2,
> +	CP_ENDBR     = 3,
> +	CP_RSTRORSSP = 4,
> +	CP_SETSSBSY  = 5,
> +
> +	CP_ENCL	     = 1 << 15,
> +};

...

> +static void do_user_cp_fault(struct pt_regs *regs, unsigned long error_code)
> +{
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

Hmm, should you read current before you enable interrupts? Not that it
changes from under us...

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
> +	}
> +
> +	force_sig_fault(SIGSEGV, SEGV_CPERR, (void __user *)0);
> +	cond_local_irq_disable(regs);
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
