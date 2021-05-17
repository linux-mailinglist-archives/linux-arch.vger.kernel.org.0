Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B8638259D
	for <lists+linux-arch@lfdr.de>; Mon, 17 May 2021 09:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhEQHq7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 03:46:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45190 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231787AbhEQHq6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 May 2021 03:46:58 -0400
Received: from zn.tnic (p200300ec2f061b008e3a9cb332cecf90.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:1b00:8e3a:9cb3:32ce:cf90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E15F1EC0345;
        Mon, 17 May 2021 09:45:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621237540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nLVgavtPi73oeu6JkSw1lXObVuaZk7TsBy+QjR6ZzJw=;
        b=fIhv70a8juEjUnMLPFsHbjmxjut56VtF5eRkDZkdil25TAZpcfoNfgtKBExBhJEfpd0c8E
        /tpmuT2K9V2iGq15P7JoEosMqldTASCHh+tbgslKxdYlGtd+sTfrc+oSx+cQ1PzDSnaWYl
        r+g1UTYZgP4TJI1fp14oft9y2FvN5Ks=
Date:   Mon, 17 May 2021 09:45:36 +0200
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
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v26 24/30] x86/cet/shstk: Introduce shadow stack token
 setup/verify routines
Message-ID: <YKIfIEyW+sR+bDCk@zn.tnic>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-25-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210427204315.24153-25-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 27, 2021 at 01:43:09PM -0700, Yu-cheng Yu wrote:
> +static inline int write_user_shstk_32(u32 __user *addr, u32 val)
> +{
> +	WARN_ONCE(1, "%s used but not supported.\n", __func__);
> +	return -EFAULT;
> +}
> +#endif

What is that supposed to catch? Any concrete (mis-)use cases?

> +
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
> index d387df84b7f1..48a0c87414ef 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -20,6 +20,7 @@
>  #include <asm/fpu/xstate.h>
>  #include <asm/fpu/types.h>
>  #include <asm/cet.h>
> +#include <asm/special_insns.h>
>  
>  static void start_update_msrs(void)
>  {
> @@ -176,3 +177,128 @@ void shstk_disable(void)
>  
>  	shstk_free(current);
>  }
> +
> +static unsigned long _get_user_shstk_addr(void)

What's the "_" prefix in the name supposed to denote?

Ditto for the other functions with "_" prefix you're adding.

> +{
> +	struct fpu *fpu = &current->thread.fpu;
> +	unsigned long ssp = 0;
> +
> +	fpregs_lock();
> +
> +	if (fpregs_state_valid(fpu, smp_processor_id())) {
> +		rdmsrl(MSR_IA32_PL3_SSP, ssp);
> +	} else {
> +		struct cet_user_state *p;
> +
> +		p = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
> +		if (p)
> +			ssp = p->user_ssp;
> +	}
> +
> +	fpregs_unlock();

<---- newline here.

> +	return ssp;
> +}
> +
> +#define TOKEN_MODE_MASK	3UL
> +#define TOKEN_MODE_64	1UL
> +#define IS_TOKEN_64(token) (((token) & TOKEN_MODE_MASK) == TOKEN_MODE_64)
> +#define IS_TOKEN_32(token) (((token) & TOKEN_MODE_MASK) == 0)

Why do you have to look at the second, busy bit, too in order to
determine the mode?

Also, you don't need most of those defines - see below.

> +/*
> + * Create a restore token on the shadow stack.  A token is always 8-byte
> + * and aligned to 8.
> + */
> +static int _create_rstor_token(bool ia32, unsigned long ssp,
> +			       unsigned long *token_addr)
> +{
> +	unsigned long addr;
> +
> +	*token_addr = 0;

What for? Callers should check this function's retval and then interpret
the validity of token_addr and it should not unconditionally write into
it.

> +
> +	if ((!ia32 && !IS_ALIGNED(ssp, 8)) || !IS_ALIGNED(ssp, 4))

Flip this logic:

	if ((ia32 && !IS_ALIGNED(ssp, 4)) || !IS_ALIGNED(ssp, 8))

> +		return -EINVAL;
> +
> +	addr = ALIGN_DOWN(ssp, 8) - 8;

Yah, so this is weird. Why does the restore token need to be at -8
instead on the shadow stack address itself?

Looking at

Figure 18-2. RSTORSSP to Switch to New Shadow Stack
Figure 18-3. SAVEPREVSSP to Save a Restore Point

in the SDM, it looks like unnecessarily more complex than it should be.
But maybe there's some magic I'm missing.

> +
> +	/* Is the token for 64-bit? */
> +	if (!ia32)
> +		ssp |= TOKEN_MODE_64;

		    |= BIT(0);

> +
> +	if (write_user_shstk_64((u64 __user *)addr, (u64)ssp))
> +		return -EFAULT;
> +
> +	*token_addr = addr;

<---- newline here.

> +	return 0;
> +}
> +
> +/*
> + * Create a restore token on shadow stack, and then push the user-mode
> + * function return address.
> + */
> +int shstk_setup_rstor_token(bool ia32, unsigned long ret_addr,
> +			    unsigned long *token_addr, unsigned long *new_ssp)
> +{
> +	struct cet_status *cet = &current->thread.cet;
> +	unsigned long ssp = 0;
> +	int err = 0;

What are those cleared to 0 for?

> +
> +	if (cet->shstk_size) {

Flip logic to save an indentation level:

	if (!cet->shstk_size)
		return err;

	if (!ret_addr)
		...


> +		if (!ret_addr)
> +			return -EINVAL;
> +
> +		ssp = _get_user_shstk_addr();

Needs to test retval for 0 here and return error if so.

> +		err = _create_rstor_token(ia32, ssp, token_addr);
> +		if (err)
> +			return err;
> +
> +		if (ia32) {
> +			*new_ssp = *token_addr - sizeof(u32);
> +			err = write_user_shstk_32((u32 __user *)*new_ssp, (u32)ret_addr);
> +		} else {
> +			*new_ssp = *token_addr - sizeof(u64);
> +			err = write_user_shstk_64((u64 __user *)*new_ssp, (u64)ret_addr);

In both cases, you should write *new_ssp only when write_user_shstk_*
functions have succeeded.

> +		}
> +	}
> +
> +	return err;
> +}
> +
> +/*
> + * Verify token_addr point to a valid token, and then set *new_ssp

			points

> + * according to the token.
> + */
> +int shstk_check_rstor_token(bool ia32, unsigned long token_addr, unsigned long *new_ssp)
> +{
> +	unsigned long token;
> +
> +	*new_ssp = 0;

Same as above.

> +
> +	if (!IS_ALIGNED(token_addr, 8))
> +		return -EINVAL;
> +
> +	if (get_user(token, (unsigned long __user *)token_addr))
> +		return -EFAULT;
> +
> +	/* Is 64-bit mode flag correct? */
> +	if (!ia32 && !IS_TOKEN_64(token))
> +		return -EINVAL;
> +	else if (ia32 && !IS_TOKEN_32(token))
> +		return -EINVAL;

That test can be done using the XOR function - i.e., you want to return
an error value when the two things are different.

In order to make this more readable, you call ia32 "proc32" to be clear
what that variable denotes - a 32-bit process. Then, you do

	bool shstk32 = !(token & BIT(0));

	if (proc32 ^ shstk32)
		return -EINVAL;

Voila.

> +	token &= ~TOKEN_MODE_MASK;
> +
> +	/*
> +	 * Restore address properly aligned?
> +	 */
> +	if ((!ia32 && !IS_ALIGNED(token, 8)) || !IS_ALIGNED(token, 4))

Flip logic as above.


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
