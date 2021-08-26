Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812463F8CDB
	for <lists+linux-arch@lfdr.de>; Thu, 26 Aug 2021 19:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243176AbhHZRWD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Aug 2021 13:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhHZRWC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Aug 2021 13:22:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E654FC061757;
        Thu, 26 Aug 2021 10:21:13 -0700 (PDT)
Received: from zn.tnic (p200300ec2f131000d5458c5ba0c26ca5.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:1000:d545:8c5b:a0c2:6ca5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 551FE1EC0559;
        Thu, 26 Aug 2021 19:21:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629998468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EonioUivdSHRImBC3PCgIPIuZ93TTqYlk6Cf+NhB2yU=;
        b=eP67D4GBayt1luaFcnj9xg3Ewz+wWsfRCdknkAiwD96W6nie+WBgRzm8p0vkGR2ZJ2wMhf
        A8mL/8JdYuziyw+8RBBfiC2ObnUXuq5i57KWqtvgFaExj52Rj1LFM+9C5b/gvfYe9RXtHH
        nod0DAM/cfl0ALjAaOWXUN/g109ni6w=
Date:   Thu, 26 Aug 2021 19:21:46 +0200
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v29 26/32] x86/cet/shstk: Introduce shadow stack token
 setup/verify routines
Message-ID: <YSfNqo3xMBULne2a@zn.tnic>
References: <20210820181201.31490-1-yu-cheng.yu@intel.com>
 <20210820181201.31490-27-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820181201.31490-27-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 20, 2021 at 11:11:55AM -0700, Yu-cheng Yu wrote:
> A shadow stack restore token marks a restore point of the shadow stack, and
> the address in a token must point directly above the token, which is within
> the same shadow stack.  This is distinctively different from other pointers
> on the shadow stack, since those pointers point to executable code area.
> 
> The restore token can be used as an extra protection for signal handling.
> To deliver a signal, create a shadow stack restore token and put the token
> and the signal restorer address on the shadow stack.  In sigreturn, verify
> the token and restore from it the shadow stack pointer.

I guess this all bla about signals needs to go now too...

> Introduce token setup and verify routines.  Also introduce WRUSS, which is
> a kernel-mode instruction but writes directly to user shadow stack.  It is
> used to construct user signal stack as described above.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Kees Cook <keescook@chromium.org>

...

> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index 7c1ca2476a5e..548d0552f9b3 100644
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
> @@ -193,3 +194,142 @@ void shstk_disable(void)
>  
>  	shstk_free(current);
>  }
> +
> +static unsigned long get_user_shstk_addr(void)
> +{
> +	struct fpu *fpu = &current->thread.fpu;
> +	unsigned long ssp = 0;

Unneeded variable init.

> +
> +	fpregs_lock();
> +
> +	if (fpregs_state_valid(fpu, smp_processor_id())) {
> +		rdmsrl(MSR_IA32_PL3_SSP, ssp);
> +	} else {
> +		struct cet_user_state *p;
> +
> +		/*
> +		 * When !fpregs_state_valid() and get_xsave_addr() returns

What does "!fpregs_state_valid()" mean in English?

> +		 * null, XFEAUTRE_CET_USER is in init state.  Shadow stack

XFEATURE_CET_USER

> +		 * pointer is null in this case, so return zero.  This can
> +		 * happen when shadow stack is enabled, but its xstates in

s/its xstates/the shadow stack component/

> +		 * memory is corrupted.
> +		 */
> +		p = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
> +		if (p)
> +			ssp = p->user_ssp;
		else
			ssp = 0;

and this way it is absolutely unambiguous what the comment says.

> +	}
> +
> +	fpregs_unlock();
> +
> +	return ssp;
> +}
> +
> +/*
> + * Create a restore token on the shadow stack.  A token is always 8-byte
> + * and aligned to 8.
> + */
> +static int create_rstor_token(bool ia32, unsigned long ssp,

s/ia32/proc32/g

> +			       unsigned long *token_addr)
> +{
> +	unsigned long addr;
> +
> +	/* Aligned to 8 is aligned to 4, so test 8 first */
> +	if ((!ia32 && !IS_ALIGNED(ssp, 8)) || !IS_ALIGNED(ssp, 4))
> +		return -EINVAL;
> +
> +	addr = ALIGN_DOWN(ssp, 8) - 8;
> +
> +	/* Is the token for 64-bit? */
> +	if (!ia32)
> +		ssp |= BIT(0);
> +
> +	if (write_user_shstk_64((u64 __user *)addr, (u64)ssp))
> +		return -EFAULT;
> +
> +	*token_addr = addr;
> +
> +	return 0;
> +}

...

> +/*
> + * Verify token_addr points to a valid token, and then set *new_ssp

"Verify the user shadow stack has a valid token on it, ... "

> + * according to the token.
> + */
> +int shstk_check_rstor_token(bool proc32, unsigned long *new_ssp)
> +{
> +	unsigned long token_addr;
> +	unsigned long token;
> +	bool shstk32;
> +
> +	token_addr = get_user_shstk_addr();

	if (!token_addr)
		return -EINVAL;

> +
> +	if (get_user(token, (unsigned long __user *)token_addr))
> +		return -EFAULT;
> +
> +	/* Is mode flag correct? */
> +	shstk32 = !(token & BIT(0));
> +	if (proc32 ^ shstk32)
> +		return -EINVAL;
> +
> +	/* Is busy flag set? */
> +	if (token & BIT(1))
> +		return -EINVAL;
> +
> +	/* Mask out flags */
> +	token &= ~3UL;
> +
> +	/*
> +	 * Restore address aligned?
> +	 */

Single line comment works too:

	/* Restore address aligned? */

> +	if ((!proc32 && !IS_ALIGNED(token, 8)) || !IS_ALIGNED(token, 4))
> +		return -EINVAL;
> +
> +	/*
> +	 * Token placed properly?
> +	 */

Ditto.

> +	if (((ALIGN_DOWN(token, 8) - 8) != token_addr) || token >= TASK_SIZE_MAX)
> +		return -EINVAL;
> +
> +	*new_ssp = token;
> +
> +	return 0;
> +}
> -- 
> 2.21.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
