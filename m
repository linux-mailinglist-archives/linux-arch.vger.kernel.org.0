Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221BC5F3744
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 22:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJCUoL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 16:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiJCUoJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 16:44:09 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D3C4B48E
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 13:44:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f140so5932940pfa.1
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 13:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=DEymI4UXKuno2vwW7X3SqwOHtKYAFnLvUda8byKuw7U=;
        b=h5EGfRQSnpVUKOXh1wmTJqELul745t40qQl3YjXugSBQjbjfkFqdTB1PGO4sN8A6lK
         E4tqlU9ZWgSwTrx/CUV9U+V9XEMfQ/39gLlxqnpX8cLQlIseL1h7EzyCtjpOK3Mm90Kd
         vNzwid07gjZUnkTDvwsdihGSYAIAqV+jeyPn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DEymI4UXKuno2vwW7X3SqwOHtKYAFnLvUda8byKuw7U=;
        b=V5QqjPeBgjOIaGT+GBMpOUD77AzvzFVcrHJjLoFp8F3s7B2XQB0xS+9aBDPHn671Yk
         SMI1KB5EACK4ni2NwuCu2r2itYjSgxwhyaiBywoe68ZAA2JQqlOpUU1217N/Ae0WwoHY
         rIeIoi8Suj9gtTfBZ+lkBpCJ7caYkavImdTsIjNge4Vp1Rb7AHoAPW+N5wLBB31tgdDn
         PotyiQsivMQadkjCPe4l+dRL8OQRrOM3DCttEvUcnPDJSpkhKlu0QZ5IdtlqdTvJhNSP
         LhnQcVnsRx58ntoE/1LqwObRqDwWwwO672z5van3FZpsy/eoyQOVh6V9RW3BcHEsHFgO
         we1Q==
X-Gm-Message-State: ACrzQf2EXHKIUwJskacLb89g6wprMNj8ZyUt2fqtecjtt6CtTQVLDUpK
        VWpieBkVdpBUsm2Qf6akZyZiyg==
X-Google-Smtp-Source: AMsMyM4auVZ34z6f92s0C3Gef51YamAxzq6h8jvTMlZV48heSEFRsDIi6UUvlKt0JqO0XWuu0H6Feg==
X-Received: by 2002:a63:6942:0:b0:41c:9261:54fd with SMTP id e63-20020a636942000000b0041c926154fdmr20687962pgc.34.1664829846954;
        Mon, 03 Oct 2022 13:44:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902b58f00b0017849a2b56asm7629779pls.46.2022.10.03.13.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 13:44:06 -0700 (PDT)
Date:   Mon, 3 Oct 2022 13:44:05 -0700
From:   Kees Cook <keescook@chromium.org>
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
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 26/39] x86/cet/shstk: Introduce routines modifying
 shstk
Message-ID: <202210031330.3C9F7E4E@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-27-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220929222936.14584-27-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:23PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Shadow stack's are normally written to via CALL/RET or specific CET
> instuctions like RSTORSSP/SAVEPREVSSP. However during some Linux
> operations the kernel will need to write to directly using the ring-0 only
> WRUSS instruction.
> 
> A shadow stack restore token marks a restore point of the shadow stack, and
> the address in a token must point directly above the token, which is within
> the same shadow stack. This is distinctively different from other pointers
> on the shadow stack, since those pointers point to executable code area.
> 
> Introduce token setup and verify routines. Also introduce WRUSS, which is
> a kernel-mode instruction but writes directly to user shadow stack.
> 
> In future patches that enable shadow stack to work with signals, the kernel
> will need something to denote the point in the stack where sigreturn may be
> called. This will prevent attackers calling sigreturn at arbitrary places
> in the stack, in order to help prevent SROP attacks.
> 
> To do this, something that can only be written by the kernel needs to be
> placed on the shadow stack. This can be accomplished by setting bit 63 in
> the frame written to the shadow stack. Userspace return addresses can't
> have this bit set as it is in the kernel range. It is also can't be a
> valid restore token.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> 
> ---
> 
> v2:
>  - Add data helpers for writing to shadow stack.
> 
> v1:
>  - Use xsave helpers.
> 
> Yu-cheng v30:
>  - Update commit log, remove description about signals.
>  - Update various comments.
>  - Remove variable 'ssp' init and adjust return value accordingly.
>  - Check get_user_shstk_addr() return value.
>  - Replace 'ia32' with 'proc32'.
> 
> Yu-cheng v29:
>  - Update comments for the use of get_xsave_addr().
> 
>  arch/x86/include/asm/special_insns.h |  13 ++++
>  arch/x86/kernel/shstk.c              | 108 +++++++++++++++++++++++++++
>  2 files changed, 121 insertions(+)
> 
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 35f709f619fb..f096f52bd059 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -223,6 +223,19 @@ static inline void clwb(volatile void *__p)
>  		: [pax] "a" (p));
>  }
>  
> +#ifdef CONFIG_X86_SHADOW_STACK
> +static inline int write_user_shstk_64(u64 __user *addr, u64 val)
> +{
> +	asm_volatile_goto("1: wrussq %[val], (%[addr])\n"
> +			  _ASM_EXTABLE(1b, %l[fail])
> +			  :: [addr] "r" (addr), [val] "r" (val)
> +			  :: fail);
> +	return 0;
> +fail:
> +	return -EFAULT;
> +}
> +#endif /* CONFIG_X86_SHADOW_STACK */
> +
>  #define nop() asm volatile ("nop")
>  
>  static inline void serialize(void)
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index db4e53f9fdaf..8904aef487bf 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -25,6 +25,8 @@
>  #include <asm/fpu/api.h>
>  #include <asm/prctl.h>
>  
> +#define SS_FRAME_SIZE 8
> +
>  static bool feature_enabled(unsigned long features)
>  {
>  	return current->thread.features & features;
> @@ -40,6 +42,31 @@ static void feature_clr(unsigned long features)
>  	current->thread.features &= ~features;
>  }
>  
> +/*
> + * Create a restore token on the shadow stack.  A token is always 8-byte
> + * and aligned to 8.
> + */
> +static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
> +{
> +	unsigned long addr;
> +
> +	/* Token must be aligned */
> +	if (!IS_ALIGNED(ssp, 8))
> +		return -EINVAL;
> +
> +	addr = ssp - SS_FRAME_SIZE;
> +
> +	/* Mark the token 64-bit */
> +	ssp |= BIT(0);

Wow, that confused me for a moment. :) SDE says:

- Bit 63:2 – Value of shadow stack pointer when this restore point was created.
- Bit 1 – Reserved. Must be zero.
- Bit 0 – Mode bit. If 0, the token is a compatibility/legacy mode
          “shadow stack restore” token. If 1, then this shadow stack restore
          token can be used with a RSTORSSP instruction in 64-bit mode.

So shouldn't this actually be:

	ssp &= ~BIT(1);	/* Reserved */
	ssp |=  BIT(0); /* RSTORSSP instruction in 64-bit mode */

> +
> +	if (write_user_shstk_64((u64 __user *)addr, (u64)ssp))
> +		return -EFAULT;
> +
> +	*token_addr = addr;
> +
> +	return 0;
> +}
> +
>  static unsigned long alloc_shstk(unsigned long size)
>  {
>  	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
> @@ -158,6 +185,87 @@ int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
>  	return 0;
>  }
>  
> +static unsigned long get_user_shstk_addr(void)
> +{
> +	unsigned long long ssp;
> +
> +	fpu_lock_and_load();
> +
> +	rdmsrl(MSR_IA32_PL3_SSP, ssp);
> +
> +	fpregs_unlock();
> +
> +	return ssp;
> +}
> +
> +static int put_shstk_data(u64 __user *addr, u64 data)
> +{
> +	WARN_ON(data & BIT(63));

Let's make this a bit more defensive:

	if (WARN_ON_ONCE(data & BIT(63)))
		return -EFAULT;

> +
> +	/*
> +	 * Mark the high bit so that the sigframe can't be processed as a
> +	 * return address.
> +	 */
> +	if (write_user_shstk_64(addr, data | BIT(63)))
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static int get_shstk_data(unsigned long *data, unsigned long __user *addr)
> +{
> +	unsigned long ldata;
> +
> +	if (unlikely(get_user(ldata, addr)))
> +		return -EFAULT;
> +
> +	if (!(ldata & BIT(63)))
> +		return -EINVAL;
> +
> +	*data = ldata & ~BIT(63);
> +
> +	return 0;
> +}
> +
> +/*
> + * Verify the user shadow stack has a valid token on it, and then set
> + * *new_ssp according to the token.
> + */
> +static int shstk_check_rstor_token(unsigned long *new_ssp)
> +{
> +	unsigned long token_addr;
> +	unsigned long token;
> +
> +	token_addr = get_user_shstk_addr();
> +	if (!token_addr)
> +		return -EINVAL;
> +
> +	if (get_user(token, (unsigned long __user *)token_addr))
> +		return -EFAULT;
> +
> +	/* Is mode flag correct? */
> +	if (!(token & BIT(0)))
> +		return -EINVAL;
> +
> +	/* Is busy flag set? */

"Busy"? Not "Reserved"?

> +	if (token & BIT(1))
> +		return -EINVAL;
> +
> +	/* Mask out flags */
> +	token &= ~3UL;
> +
> +	/* Restore address aligned? */
> +	if (!IS_ALIGNED(token, 8))
> +		return -EINVAL;
> +
> +	/* Token placed properly? */
> +	if (((ALIGN_DOWN(token, 8) - 8) != token_addr) || token >= TASK_SIZE_MAX)
> +		return -EINVAL;
> +
> +	*new_ssp = token;
> +
> +	return 0;
> +}
> +
>  void shstk_free(struct task_struct *tsk)
>  {
>  	struct thread_shstk *shstk = &tsk->thread.shstk;
> -- 
> 2.17.1
> 

-- 
Kees Cook
