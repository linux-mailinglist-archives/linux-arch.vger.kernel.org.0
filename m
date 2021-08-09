Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A203E4B2F
	for <lists+linux-arch@lfdr.de>; Mon,  9 Aug 2021 19:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhHIRuy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Aug 2021 13:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbhHIRuy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Aug 2021 13:50:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C376C0613D3;
        Mon,  9 Aug 2021 10:50:33 -0700 (PDT)
Received: from zn.tnic (p200300ec2f26f300329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:f300:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D10FB1EC03D5;
        Mon,  9 Aug 2021 19:50:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628531428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+x3/xw0UdgR0O51M+V/8Rb1MeOGiWw7WKdkNzGmn/YI=;
        b=U1X3txxUjanACHAzsR0g0dw+exNq+LViOYU7718e5a7O0H0nnZNcZ+u/6JuZ0smrHRzHae
        8nmHvJY3RZavNfP3ZNvxAzqDbJKgs/MR1ZKtuvdgluq+MkDPp9BDt35UhUmy4IPjD8yakb
        B4NQppg4Hd+7eoA365j3GHbF/SVZxPo=
Date:   Mon, 9 Aug 2021 19:51:12 +0200
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
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v28 06/32] x86/cet: Add control-protection fault handler
Message-ID: <YRFrECvCESC4Irlk@zn.tnic>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-7-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210722205219.7934-7-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 22, 2021 at 01:51:53PM -0700, Yu-cheng Yu wrote:
> +DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> +{
> +	struct task_struct *tsk;
> +
> +	if (!user_mode(regs)) {
> +		pr_emerg("PANIC: unexpected kernel control protection fault\n");

No need for that call...

> +		die("kernel control protection fault", regs, error_code);

... as this one can say "unexpected" in the string too.

> +		panic("Machine halted.");
> +	}
> +
> +	cond_local_irq_enable(regs);
> +
> +	if (!boot_cpu_has(X86_FEATURE_SHSTK))

cpu_feature_enabled()

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
> +	    __ratelimit(&cpf_rate)) {
> +		unsigned long ssp;
> +		int cpf_type;
> +
> +		cpf_type = array_index_nospec(error_code, ARRAY_SIZE(control_protection_err));
> +
> +		rdmsrl(MSR_IA32_PL3_SSP, ssp);
> +		pr_emerg("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)",
> +			 tsk->comm, task_pid_nr(tsk),
> +			 regs->ip, regs->sp, ssp, error_code,
> +			 control_protection_err[cpf_type]);
> +		print_vma_addr(KERN_CONT " in ", regs->ip);
> +		pr_cont("\n");
> +	}
> +
> +	force_sig_fault(SIGSEGV, SEGV_CPERR, (void __user *)0);
> +	cond_local_irq_disable(regs);
> +}
> +#endif
> +
>  static bool do_int3(struct pt_regs *regs)
>  {
>  	int res;
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index 5a3c221f4c9d..a1a153ea3cc3 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -235,7 +235,8 @@ typedef struct siginfo {
>  #define SEGV_ADIPERR	7	/* Precise MCD exception */
>  #define SEGV_MTEAERR	8	/* Asynchronous ARM MTE error */
>  #define SEGV_MTESERR	9	/* Synchronous ARM MTE exception */
> -#define NSIGSEGV	9
> +#define SEGV_CPERR	10	/* Control protection fault */
> +#define NSIGSEGV	10
>  
>  /*
>   * SIGBUS si_codes
> -- 

Was there a manpage patch for the user-visible bits?

I seem to remember something flying by very vaguely ...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
