Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E877341D65
	for <lists+linux-arch@lfdr.de>; Fri, 19 Mar 2021 13:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhCSMvx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Mar 2021 08:51:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34188 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhCSMvh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Mar 2021 08:51:37 -0400
Received: from zn.tnic (p200300ec2f091e000ec907ca620adac2.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:1e00:ec9:7ca:620a:dac2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 556D11EC0324;
        Fri, 19 Mar 2021 13:51:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616158295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Lk9msQ8lwSfedjnHkZUcL3GSRq6GlT11mzhXgP9EbMo=;
        b=F+67ambvthhfUAsYvwdThId59yMF1DvrzPxZKes7jJ03u7skgNXENIosppMKtRqB7BOhvF
        UZcVbO/t+Nvl9O1JIj4KXTyXNfmsamotMr6mBKDZbhKQpT+cJCgceO3zKAdI2EOrhIOL64
        0FbpUMUhser7r1WhrE7NuAcKnv2/L4Y=
Date:   Fri, 19 Mar 2021 13:51:29 +0100
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
Subject: Re: [PATCH v23 23/28] x86/cet/shstk: Handle signals for shadow stack
Message-ID: <20210319125129.GF6251@zn.tnic>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-24-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210316151054.5405-24-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 08:10:49AM -0700, Yu-cheng Yu wrote:
> To deliver a signal, create a shadow stack restore token and put the token
> and the signal restorer address on the shadow stack.  For sigreturn, verify
> the token and restore from it the shadow stack pointer.
> 
> A shadow stack restore token marks a restore point of the shadow stack, and
> the address in a token must point directly above the token, which is within
> the same shadow stack.  This is distinctively different from other pointers
> on the shadow stack; those pointers point to executable code area.
> 
> In sigreturn, restoring from a token ensures the target address is the
> location pointed by the token.
> 
> Introduce WRUSS, which is a kernel-mode instruction but writes directly to
> user shadow stack.  It is used to construct the user signal stack as
> described above.
> 
> Currently there is no systematic facility for extending a signal context.
> Introduce a signal context extension 'struct sc_ext', which is used to save
> shadow stack restore token address and WAIT_ENDBR status.  WAIT_ENDBR will
> be introduced later in the Indirect Branch Tracking (IBT) series, but add
> that into sc_ext now to keep the struct stable in case the IBT series is
> applied later.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/ia32/ia32_signal.c            |  17 +++
>  arch/x86/include/asm/cet.h             |   8 ++
>  arch/x86/include/asm/fpu/internal.h    |  10 ++
>  arch/x86/include/asm/special_insns.h   |  32 ++++++
>  arch/x86/include/uapi/asm/sigcontext.h |   9 ++
>  arch/x86/kernel/cet.c                  | 152 +++++++++++++++++++++++++
>  arch/x86/kernel/fpu/signal.c           | 100 ++++++++++++++++
>  arch/x86/kernel/signal.c               |  10 ++
>  8 files changed, 338 insertions(+)

The commit message lacks structure in explaining what the
problem/missing functionality is and why this is solved the way it is,
with stack tokens. Here's a good example how to structure it properly:

https://git.kernel.org/tip/323950a8a98b492ac2fa168e8e4c0becfb4554dd

Also, this patch does a couple of things at once and it needs splitting
for easier review.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
