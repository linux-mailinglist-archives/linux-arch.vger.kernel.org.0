Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8BF6B5D23
	for <lists+linux-arch@lfdr.de>; Sat, 11 Mar 2023 16:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCKPGL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Mar 2023 10:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCKPGK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Mar 2023 10:06:10 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984D9311C3;
        Sat, 11 Mar 2023 07:06:08 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 250D91EC0501;
        Sat, 11 Mar 2023 16:06:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678547167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=i83jfo39n7QMWxUoY3tEAV03lUsmodN+NDXkdxSgb/8=;
        b=SggQnHUgQJgx3LqZReMr0kMmCymGL3wmgRsic7eHnZ0lKfbKfBbtV3o/gIij9K4QAzCZI/
        ewqsr3IuyHt2IdnynzYStZidsPtO5oYVJBw6cX88UZd5t5g5YELH+rP2ZHr4CKEb2PaLr+
        DZUyBLy+vG75cHJywPqFlYmuMf3DEuQ=
Date:   Sat, 11 Mar 2023 16:06:02 +0100
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
Subject: Re: [PATCH v7 39/41] x86: Add PTRACE interface for shadow stack
Message-ID: <ZAyY2mor+HJAO1ht@zn.tnic>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-40-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-40-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 02:29:55PM -0800, Rick Edgecombe wrote:
> The only downside to not having a generic supervisor xfeature regset,
> is that apps need to be enlightened of any new supervisor xfeature
> exposed this way (i.e. they can't try to have generic save/restore
> logic). But maybe that is a good thing, because they have to think
> through each new xfeature instead of encountering issues when new a new

Remove the first "new".

> supervisor xfeature was added.
> 
> By adding a shadow stack regset, it also has the effect of including the
> shadow stack state in a core dump, which could be useful for debugging.
> 
> The shadow stack specific xstate includes the SSP, and the shadow stack
> and WRSS enablement status. Enabling shadow stack or wrss in the kernel
						       ^^^^

"WRSS"

> involves more than just flipping the bit. The kernel is made aware that
> it has to do extra things when cloning or handling signals. That logic
> is triggered off of separate feature enablement state kept in the task
> struct. So the flipping on HW shadow stack enforcement without notifying
> the kernel to change its behavior would severely limit what an application
> could do without crashing, and the results would depend on kernel
> internal implementation details. There is also no known use for controlling
> this state via prtace today. So only expose the SSP, which is something

Unknown word [prtace] in commit message.
Suggestions: ['ptrace'

> that userspace already has indirect control over.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Tested-by: Kees Cook <keescook@chromium.org>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

I think your SOB should come last:

...
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Pls check whole set.


> +#ifdef CONFIG_X86_USER_SHADOW_STACK
> +int ssp_active(struct task_struct *target, const struct user_regset *regset)
> +{
> +	if (target->thread.features & ARCH_SHSTK_SHSTK)
> +		return regset->n;
> +
> +	return 0;
> +}
> +
> +int ssp_get(struct task_struct *target, const struct user_regset *regset,
> +	    struct membuf to)
> +{
> +	struct fpu *fpu = &target->thread.fpu;
> +	struct cet_user_state *cetregs;
> +
> +	if (!boot_cpu_has(X86_FEATURE_USER_SHSTK))

check_for_deprecated_apis: WARNING: arch/x86/kernel/fpu/regset.c:193: Do not use boot_cpu_has() - use cpu_feature_enabled() instead.

Check your whole set pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
