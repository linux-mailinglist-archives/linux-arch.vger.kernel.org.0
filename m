Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF796B2B90
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 18:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCIRG6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 12:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCIRGl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 12:06:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AE6F6927;
        Thu,  9 Mar 2023 09:02:34 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 206C81EC0464;
        Thu,  9 Mar 2023 18:02:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678381352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2EzHzmcCNV+hERnYGLmd7J3Hxny9vW/fCLbxwPiF+nY=;
        b=UTIj0bjNQ8tGPkfWd7G2gwZV3Qvhn3M5rZhVEwIFvbwSC1ecnxrHBw99KYD7QFpw2tp7lp
        LW+Cp843oRJRVtsLOq8At1/Ut0Pr+dpLc+U8aHStU+1wD8bWxDsjPoyJ5WsOmAcB4VvhDJ
        qW9JffSymArXGmcDl7niUASKvz7y7wA=
Date:   Thu, 9 Mar 2023 18:02:27 +0100
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
Subject: Re: [PATCH v7 32/41] x86/shstk: Handle signals for shadow stack
Message-ID: <ZAoRI8J9MjOf58+r@zn.tnic>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-33-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-33-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 02:29:48PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> When a signal is handled normally the context is pushed to the stack

s/normally //

> before handling it. For shadow stacks, since the shadow stack only track's

"tracks"

> return addresses, there isn't any state that needs to be pushed. However,
> there are still a few things that need to be done. These things are
> userspace visible and which will be kernel ABI for shadow stacks.

"visible to userspace"

s/which //

> One is to make sure the restorer address is written to shadow stack, since
> the signal handler (if not changing ucontext) returns to the restorer, and
> the restorer calls sigreturn. So add the restorer on the shadow stack
> before handling the signal, so there is not a conflict when the signal
> handler returns to the restorer.
> 
> The other thing to do is to place some type of checkable token on the
> thread's shadow stack before handling the signal and check it during
> sigreturn. This is an extra layer of protection to hamper attackers
> calling sigreturn manually as in SROP-like attacks.
> 
> For this token we can use the shadow stack data format defined earlier.
		^^^

Please use passive voice in your commit message: no "we" or "I", etc.

> Have the data pushed be the previous SSP. In the future the sigreturn
> might want to return back to a different stack. Storing the SSP (instead
> of a restore offset or something) allows for future functionality that
> may want to restore to a different stack.
> 
> So, when handling a signal push
>  - the SSP pointing in the shadow stack data format
>  - the restorer address below the restore token.
> 
> In sigreturn, verify SSP is stored in the data format and pop the shadow
> stack.

...

> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index 13c02747386f..40f0a55762a9 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -232,6 +232,104 @@ static int get_shstk_data(unsigned long *data, unsigned long __user *addr)
>  	return 0;
>  }
>  
> +static int shstk_push_sigframe(unsigned long *ssp)
> +{
> +	unsigned long target_ssp = *ssp;
> +
> +	/* Token must be aligned */
> +	if (!IS_ALIGNED(*ssp, 8))
> +		return -EINVAL;
> +
> +	if (!IS_ALIGNED(target_ssp, 8))
> +		return -EINVAL;

Those two statements are identical AFAICT.

> +	*ssp -= SS_FRAME_SIZE;
> +	if (put_shstk_data((void *__user)*ssp, target_ssp))
> +		return -EFAULT;
> +
> +	return 0;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
