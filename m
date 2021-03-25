Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DFE3499C5
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 19:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhCYSzG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 14:55:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:48274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhCYSyn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 14:54:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC244AC16;
        Thu, 25 Mar 2021 18:54:40 +0000 (UTC)
Date:   Thu, 25 Mar 2021 19:54:35 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Carlos O'Donell <carlos@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 5/6] x86/signal: Detect and prevent an alternate
 signal stack overflow
Message-ID: <20210325185435.GB32296@zn.tnic>
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
 <20210316065215.23768-6-chang.seok.bae@intel.com>
 <CALCETrU_n+dP4GaUJRQoKcDSwaWL9Vc99Yy+N=QGVZ_tx_j3Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrU_n+dP4GaUJRQoKcDSwaWL9Vc99Yy+N=QGVZ_tx_j3Zg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 25, 2021 at 11:13:12AM -0700, Andy Lutomirski wrote:
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index ea794a083c44..53781324a2d3 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -237,7 +237,8 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
>  	unsigned long math_size = 0;
>  	unsigned long sp = regs->sp;
>  	unsigned long buf_fx = 0;
> -	int onsigstack = on_sig_stack(sp);
> +	bool already_onsigstack = on_sig_stack(sp);
> +	bool entering_altstack = false;
>  	int ret;
>  
>  	/* redzone */
> @@ -246,15 +247,25 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
>  
>  	/* This is the X/Open sanctioned signal stack switching.  */
>  	if (ka->sa.sa_flags & SA_ONSTACK) {
> -		if (sas_ss_flags(sp) == 0)
> +		/*
> +		 * This checks already_onsigstack via sas_ss_flags().
> +		 * Sensible programs use SS_AUTODISARM, which disables
> +		 * that check, and programs that don't use
> +		 * SS_AUTODISARM get compatible but potentially
> +		 * bizarre behavior.
> +		 */
> +		if (sas_ss_flags(sp) == 0) {
>  			sp = current->sas_ss_sp + current->sas_ss_size;
> +			entering_altstack = true;
> +		}
>  	} else if (IS_ENABLED(CONFIG_X86_32) &&
> -		   !onsigstack &&
> +		   !already_onsigstack &&
>  		   regs->ss != __USER_DS &&
>  		   !(ka->sa.sa_flags & SA_RESTORER) &&
>  		   ka->sa.sa_restorer) {
>  		/* This is the legacy signal stack switching. */
>  		sp = (unsigned long) ka->sa.sa_restorer;
> +		entering_altstack = true;
>  	}

What a mess this whole signal handling is. I need a course in signal
handling to understand what's going on here...

>  
>  	sp = fpu__alloc_mathframe(sp, IS_ENABLED(CONFIG_X86_32),
> @@ -267,8 +278,16 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
>  	 * If we are on the alternate signal stack and would overflow it, don't.
>  	 * Return an always-bogus address instead so we will die with SIGSEGV.
>  	 */
> -	if (onsigstack && !likely(on_sig_stack(sp)))
> +	if (unlikely(entering_altstack &&
> +		     (sp <= current->sas_ss_sp ||
> +		      sp - current->sas_ss_sp > current->sas_ss_size))) {

You could've simply done

	if (unlikely(entering_altstack && !on_sig_stack(sp)))

here.


> +		if (show_unhandled_signals && printk_ratelimit()) {
> +			pr_info("%s[%d] overflowed sigaltstack",
> +				tsk->comm, task_pid_nr(tsk));
> +		}

Why do you even wanna issue that? It looks like callers will propagate
an error value up and people don't look at dmesg all the time.

Btw, s/tsk/current/g

IOW, this builds:

---
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index a06cb107c0e8..c00e932b5f18 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -234,10 +234,11 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	     void __user **fpstate)
 {
 	/* Default to using normal stack */
+	bool already_onsigstack = on_sig_stack(regs->sp);
+	bool entering_altstack = false;
 	unsigned long math_size = 0;
 	unsigned long sp = regs->sp;
 	unsigned long buf_fx = 0;
-	int onsigstack = on_sig_stack(sp);
 	int ret;
 
 	/* redzone */
@@ -246,15 +247,24 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (sas_ss_flags(sp) == 0)
+		/*
+		 * This checks already_onsigstack via sas_ss_flags(). Sensible
+		 * programs use SS_AUTODISARM, which disables that check, and
+		 * programs that don't use SS_AUTODISARM get compatible but
+		 * potentially bizarre behavior.
+		 */
+		if (sas_ss_flags(sp) == 0) {
 			sp = current->sas_ss_sp + current->sas_ss_size;
+			entering_altstack = true;
+		}
 	} else if (IS_ENABLED(CONFIG_X86_32) &&
-		   !onsigstack &&
+		   !already_onsigstack &&
 		   regs->ss != __USER_DS &&
 		   !(ka->sa.sa_flags & SA_RESTORER) &&
 		   ka->sa.sa_restorer) {
 		/* This is the legacy signal stack switching. */
 		sp = (unsigned long) ka->sa.sa_restorer;
+		entering_altstack = true;
 	}
 
 	sp = fpu__alloc_mathframe(sp, IS_ENABLED(CONFIG_X86_32),
@@ -267,8 +277,14 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	 * If we are on the alternate signal stack and would overflow it, don't.
 	 * Return an always-bogus address instead so we will die with SIGSEGV.
 	 */
-	if (onsigstack && !likely(on_sig_stack(sp)))
+	if (unlikely(entering_altstack && !on_sig_stack(sp))) {
+
+		if (show_unhandled_signals && printk_ratelimit())
+			pr_info("%s[%d] overflowed sigaltstack",
+				current->comm, task_pid_nr(current));
+
 		return (void __user *)-1L;
+	}
 
 	/* save i387 and extended state */
 	ret = copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size);


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
