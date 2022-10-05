Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEA95F51E2
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 11:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJEJkh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 05:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJEJkf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 05:40:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B511D674;
        Wed,  5 Oct 2022 02:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qfdlG7TuUH6DQ07dKCl1Vium/3gxszLw48q2k2MlonM=; b=VgaDIOUiLJ7Bk+v1TK1YwDdylq
        HbZHde6uT0sXYBvO5ZYngOhfMFPLC/xl2axGQ83oPwnzXkVlhV/Ik1c/ILK6aZThbMeq7q2J5B/Xz
        m3gB3KuEPd2YrPQIbsqZ62RBvlcK4lfpd5lLbNPaVX0Egx1VZyeKSZWtKRslGCD3FaJ8tajwFSMZu
        ROCra382vLhU0ruPOd6rYM63HoPM+rpYvFg/kgvQx4OEvP0HYUe+QlJcPiKSWLwHjPeEkaeRlue7D
        wPtMyGPV7PL/TAxnPOgf278iRMZoQ1b2qz20mXvDVQEJGtKkR76GILsyWs69lCq0jOyn+f6fsaDjJ
        iyXxG6NA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1og0sQ-000vaG-Qb; Wed, 05 Oct 2022 09:39:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E493230007E;
        Wed,  5 Oct 2022 11:39:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9B5F29982713; Wed,  5 Oct 2022 11:39:40 +0200 (CEST)
Date:   Wed, 5 Oct 2022 11:39:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v2 07/39] x86/cet: Add user control-protection fault
 handler
Message-ID: <Yz1Q3EGtvZBKNR31@hirez.programming.kicks-ass.net>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-8-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-8-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:04PM -0700, Rick Edgecombe wrote:

> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index d62b2cb85cea..b7dde8730236 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c

> @@ -229,16 +223,74 @@ enum cp_error_code {
>  	CP_ENCL	     = 1 << 15,
>  };
>  
> -DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> +#ifdef CONFIG_X86_SHADOW_STACK
> +static const char * const control_protection_err[] = {
> +	"unknown",
> +	"near-ret",
> +	"far-ret/iret",
> +	"endbranch",
> +	"rstorssp",
> +	"setssbsy",
> +};
> +
> +static DEFINE_RATELIMIT_STATE(cpf_rate, DEFAULT_RATELIMIT_INTERVAL,
> +			      DEFAULT_RATELIMIT_BURST);
> +
> +static void do_user_control_protection_fault(struct pt_regs *regs,
> +					     unsigned long error_code)
>  {
> -	if (!cpu_feature_enabled(X86_FEATURE_IBT)) {
> -		pr_err("Unexpected #CP\n");
> -		BUG();
> +	struct task_struct *tsk;
> +	unsigned long ssp;
> +
> +	/* Read SSP before enabling interrupts. */
> +	rdmsrl(MSR_IA32_PL3_SSP, ssp);
> +
> +	cond_local_irq_enable(regs);
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +		WARN_ONCE(1, "User-mode control protection fault with shadow support disabled\n");
> +
> +	tsk = current;
> +	tsk->thread.error_code = error_code;
> +	tsk->thread.trap_nr = X86_TRAP_CP;
> +
> +	/* Ratelimit to prevent log spamming. */
> +	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
> +	    __ratelimit(&cpf_rate)) {
> +		unsigned int cpec;
> +
> +		cpec = error_code & CP_EC;
> +		if (cpec >= ARRAY_SIZE(control_protection_err))
> +			cpec = 0;
> +
> +		pr_emerg("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)%s",
> +			 tsk->comm, task_pid_nr(tsk),
> +			 regs->ip, regs->sp, ssp, error_code,
> +			 control_protection_err[cpec],
> +			 error_code & CP_ENCL ? " in enclave" : "");
> +		print_vma_addr(KERN_CONT " in ", regs->ip);
> +		pr_cont("\n");
>  	}
>  
> -	if (WARN_ON_ONCE(user_mode(regs) || (error_code & CP_EC) != CP_ENDBR))
> -		return;

Why are you removing the (error_code & CP_EC) != CP_ENDBR check from the
kernel handler?

> +	force_sig_fault(SIGSEGV, SEGV_CPERR, (void __user *)0);
> +	cond_local_irq_disable(regs);
> +}
> +#else
> +static void do_user_control_protection_fault(struct pt_regs *regs,
> +					     unsigned long error_code)
> +{
> +	WARN_ONCE(1, "User-mode control protection fault with shadow support disabled\n");
> +}
> +#endif
> +
> +#ifdef CONFIG_X86_KERNEL_IBT
> +
> +static __ro_after_init bool ibt_fatal = true;
> +
> +extern void ibt_selftest_ip(void); /* code label defined in asm below */
>  
> +static void do_kernel_control_protection_fault(struct pt_regs *regs)
> +{
>  	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_ip)) {
>  		regs->ax = 0;
>  		return;
> @@ -283,9 +335,29 @@ static int __init ibt_setup(char *str)
>  }
>  
>  __setup("ibt=", ibt_setup);
> -
> +#else
> +static void do_kernel_control_protection_fault(struct pt_regs *regs)
> +{
> +	WARN_ONCE(1, "Kernel-mode control protection fault with IBT disabled\n");
> +}
>  #endif /* CONFIG_X86_KERNEL_IBT */
>  
> +#if defined(CONFIG_X86_KERNEL_IBT) || defined(CONFIG_X86_SHADOW_STACK)
> +DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_IBT) &&
> +	    !cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		pr_err("Unexpected #CP\n");
> +		BUG();
> +	}
> +
> +	if (user_mode(regs))
> +		do_user_control_protection_fault(regs, error_code);
> +	else
> +		do_kernel_control_protection_fault(regs);

These function names are weirdly long, surely they can do without the
_fault part at the very least. And as stated above, I would really like
the kernel thing to retain the error_code argument.

> +}
> +#endif /* defined(CONFIG_X86_KERNEL_IBT) || defined(CONFIG_X86_SHADOW_STACK) */


