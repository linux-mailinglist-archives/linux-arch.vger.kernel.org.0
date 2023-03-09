Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27976B2B49
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 17:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCIQ4z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 11:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjCIQ4a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 11:56:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6BE3BDA5;
        Thu,  9 Mar 2023 08:48:47 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B22151EC0464;
        Thu,  9 Mar 2023 17:48:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678380525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=y9fgVkJaonsv4Fq61FCxxoW1/dZqwLtrdhcT+JC/0gI=;
        b=oLq0+xRxpNxRF+7gFw40PrZBhMfN77YRoJympjw43zS4MFdGKCzTRi2By/ji9HJjNc7h7U
        O4mLJEfDttVF77nmvJWKyLxI3QXpfxZpZ0BF59AdTDPitGajtBIoCGPq1vS/PbRvDVzRYR
        muTbKHWIQuzKGhFAr+6/DSiudLrczeE=
Date:   Thu, 9 Mar 2023 17:48:42 +0100
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
        david@redhat.com, debug@rivosinc.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v7 31/41] x86/shstk: Introduce routines modifying shstk
Message-ID: <ZAoN6tGi8kzgcLrK@zn.tnic>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-32-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-32-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 02:29:47PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Shadow stacks are normally written to via CALL/RET or specific CET
				       ^
				       indirectly.

> instructions like RSTORSSP/SAVEPREVSSP. However during some Linux
> operations the kernel will need to write to directly using the ring-0 only

"However, sometimes the kernel will need to..."

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

s/is //

> valid restore token.

...

> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index de48d1389936..d6cd9344f6c7 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -202,6 +202,19 @@ static inline void clwb(volatile void *__p)
>  		: [pax] "a" (p));
>  }
>  
> +#ifdef CONFIG_X86_USER_SHADOW_STACK
> +static inline int write_user_shstk_64(u64 __user *addr, u64 val)
> +{
> +	asm_volatile_goto("1: wrussq %[val], (%[addr])\n"
> +			  _ASM_EXTABLE(1b, %l[fail])
> +			  :: [addr] "r" (addr), [val] "r" (val)
> +			  :: fail);
> +	return 0;
> +fail:
> +	return -EFAULT;

Nice!

> +}
> +#endif /* CONFIG_X86_USER_SHADOW_STACK */
> +
>  #define nop() asm volatile ("nop")
>  
>  static inline void serialize(void)

...

> +static int put_shstk_data(u64 __user *addr, u64 data)
> +{
> +	if (WARN_ON_ONCE(data & BIT(63)))

Dunno, maybe something like:

/*
 * A comment explaining what that is...
 */
#define SHSTK_SIGRETURN_TOKEN	BIT_ULL(63)

or so?

And use that instead of that magical bit 63.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
