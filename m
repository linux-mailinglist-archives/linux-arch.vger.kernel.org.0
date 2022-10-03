Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564495F395F
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 00:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiJCWwS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 18:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiJCWwO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 18:52:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8701C5AC52;
        Mon,  3 Oct 2022 15:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A7D7B8165B;
        Mon,  3 Oct 2022 22:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4163C433D6;
        Mon,  3 Oct 2022 22:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664837521;
        bh=YuqryQv+2VNLlqIKzcek0mnAh0zfi2NsIbmmJLKzIRA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fFJZh/VJU83iUHZkS1ckcVz9uuKC1SHc2RoBtYifsLyr2S9vDllUF7vehaknkYoqn
         898ArZtex0fetHKUzLGBI79OcxwFo9rG+wUWKdb87egTES03XOrbNTJlIGZQi41onI
         pX/TDLMBHeBhxdjvdUcJrdpgM+9IA9V3nyx+ua8Gml6Pum9xauSacbKS7So75kCxF9
         +Tze+CwIkZktGNvvXuz3Ln+FFrZ/LZmz2mqJF6P/vvB2JaYBl1pUkenR60VKWNEazr
         GG1c7abCwNef2Fkr+2j2wrOG+aivL3mXNbHpxzNzbG8AjnqYy8f499ezYV3uJfbTZL
         7vYY4GjZiozhw==
Message-ID: <4e145653-a62c-e4ea-dfa7-f18c0282c315@kernel.org>
Date:   Mon, 3 Oct 2022 15:51:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 07/39] x86/cet: Add user control-protection fault
 handler
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-8-rick.p.edgecombe@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220929222936.14584-8-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/29/22 15:29, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 

> +static void do_user_control_protection_fault(struct pt_regs *regs,
> +					     unsigned long error_code)
>   {
> -	if (!cpu_feature_enabled(X86_FEATURE_IBT)) {
> -		pr_err("Unexpected #CP\n");
> -		BUG();
> +	struct task_struct *tsk;
> +	unsigned long ssp;
> +
> +	/* Read SSP before enabling interrupts. */
> +	rdmsrl(MSR_IA32_PL3_SSP, ssp); > +
> +	cond_local_irq_enable(regs);

I feel like I'm missing something.  Either PL3_SSL is context switched 
correctly and reading it with IRQs off is useless, or it's not context 
switched, and I'm very confused.

Please either improve the comment or move it after the 
cond_local_irq_enable().

--Andy

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
>   	}
>   
> -	if (WARN_ON_ONCE(user_mode(regs) || (error_code & CP_EC) != CP_ENDBR))
> -		return;
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
>   	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_ip)) {
>   		regs->ax = 0;
>   		return;
> @@ -283,9 +335,29 @@ static int __init ibt_setup(char *str)
>   }
>   
>   __setup("ibt=", ibt_setup);
> -
> +#else
> +static void do_kernel_control_protection_fault(struct pt_regs *regs)
> +{
> +	WARN_ONCE(1, "Kernel-mode control protection fault with IBT disabled\n");
> +}
>   #endif /* CONFIG_X86_KERNEL_IBT */
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
> +}
> +#endif /* defined(CONFIG_X86_KERNEL_IBT) || defined(CONFIG_X86_SHADOW_STACK) */
> +
>   #ifdef CONFIG_X86_F00F_BUG
>   void handle_invalid_op(struct pt_regs *regs)
>   #else
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index 0ed2e487a693..57faa287163f 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -628,7 +628,7 @@ static struct trap_array_entry trap_array[] = {
>   	TRAP_ENTRY(exc_coprocessor_error,		false ),
>   	TRAP_ENTRY(exc_alignment_check,			false ),
>   	TRAP_ENTRY(exc_simd_coprocessor_error,		false ),
> -#ifdef CONFIG_X86_KERNEL_IBT
> +#if defined(CONFIG_X86_KERNEL_IBT) || defined(CONFIG_X86_SHADOW_STACK)
>   	TRAP_ENTRY(exc_control_protection,		false ),
>   #endif
>   };
> diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
> index 6b4fdf6b9542..e45ff6300c7d 100644
> --- a/arch/x86/xen/xen-asm.S
> +++ b/arch/x86/xen/xen-asm.S
> @@ -148,7 +148,7 @@ xen_pv_trap asm_exc_page_fault
>   xen_pv_trap asm_exc_spurious_interrupt_bug
>   xen_pv_trap asm_exc_coprocessor_error
>   xen_pv_trap asm_exc_alignment_check
> -#ifdef CONFIG_X86_KERNEL_IBT
> +#if defined(CONFIG_X86_KERNEL_IBT) || defined(CONFIG_X86_SHADOW_STACK)
>   xen_pv_trap asm_exc_control_protection
>   #endif
>   #ifdef CONFIG_X86_MCE
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index ffbe4cec9f32..0f52d0ac47c5 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -242,7 +242,8 @@ typedef struct siginfo {
>   #define SEGV_ADIPERR	7	/* Precise MCD exception */
>   #define SEGV_MTEAERR	8	/* Asynchronous ARM MTE error */
>   #define SEGV_MTESERR	9	/* Synchronous ARM MTE exception */
> -#define NSIGSEGV	9
> +#define SEGV_CPERR	10	/* Control protection fault */
> +#define NSIGSEGV	10
>   
>   /*
>    * SIGBUS si_codes

