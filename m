Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F67E6B4D77
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 17:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjCJQr5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 11:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCJQrj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 11:47:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A3E11CD58;
        Fri, 10 Mar 2023 08:45:22 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6790E1EC0554;
        Fri, 10 Mar 2023 17:44:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678466698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TIJaXRtNR2Oz/UBISlYbA7F6Z6RSSveXZRo1kMuPhBM=;
        b=qIfhFPqzveKn5qUOw2mhgMxzUd7jx+rQ6vBdqwd4apDSOYq/toJ8ve8juYrugBBthx/n8K
        A2vf5jE4YMcgga/Is1A3VK2MDImmjwOoPgukBDLlD0KRHuHmiBo0FQ75XQ7Updh7Mwd8yL
        IIJhz1nNm4bMMT1wxtLaX8WbPOucsrU=
Date:   Fri, 10 Mar 2023 17:44:54 +0100
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
        david@redhat.com, debug@rivosinc.com
Subject: Re: [PATCH v7 34/41] x86/shstk: Support WRSS for userspace
Message-ID: <ZAtehgwB5/jGL9dC@zn.tnic>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-35-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-35-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 02:29:50PM -0800, Rick Edgecombe wrote:
> For the current shadow stack implementation, shadow stacks contents can't
> easily be provisioned with arbitrary data. This property helps apps
> protect themselves better, but also restricts any potential apps that may
> want to do exotic things at the expense of a little security.
> 
> The x86 shadow stack feature introduces a new instruction, WRSS, which
> can be enabled to write directly to shadow stack permissioned memory from

s/permissioned //

By now it is clear that shadow stack memory is a special thing anyway.

> userspace. Allow it to get enabled via the prctl interface.
> 
> Only enable the userspace WRSS instruction, which allows writes to
> userspace shadow stacks from userspace. Do not allow it to be enabled
> independently of shadow stack, as HW does not support using WRSS when
> shadow stack is disabled.
> 
> From a fault handler perspective, WRSS will behave very similar to WRUSS,
> which is treated like a user access from a #PF err code perspective.

...

> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
> index 65ec1965cd28..2d3b35c957ad 100644
> --- a/arch/x86/include/asm/msr.h
> +++ b/arch/x86/include/asm/msr.h
> @@ -310,6 +310,17 @@ void msrs_free(struct msr *msrs);
>  int msr_set_bit(u32 msr, u8 bit);
>  int msr_clear_bit(u32 msr, u8 bit);
>  
> +/* Helper that can never get accidentally un-inlined. */
> +#define set_clr_bits_msrl(msr, set, clear)	do {	\

Uff, pls kill this thing.

Our MSR interfaces universe is already insane and arch/x86/lib/msr.c
already has similar attempts to what you're doing here in addition to
all the other gunk in msr.h.

I highly doubt this can't be done the usual way, lemme see...

> +	u64 __val, __new_val, __msr = msr;		\
> +							\
> +	rdmsrl(__msr, __val);				\
> +	__new_val = (__val & ~(clear)) | (set);		\
> +							\
> +	if (__new_val != __val)				\
> +		wrmsrl(__msr, __new_val);		\
> +} while (0)
> +
>  #ifdef CONFIG_SMP
>  int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
>  int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
> diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
> index 7dfd9dc00509..e31495668056 100644
> --- a/arch/x86/include/uapi/asm/prctl.h
> +++ b/arch/x86/include/uapi/asm/prctl.h
> @@ -28,5 +28,6 @@
>  
>  /* ARCH_SHSTK_ features bits */
>  #define ARCH_SHSTK_SHSTK		(1ULL <<  0)
> +#define ARCH_SHSTK_WRSS			(1ULL <<  1)
>  
>  #endif /* _ASM_X86_PRCTL_H */
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index 0a3decab70ee..009cb3fa0ae5 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -363,6 +363,36 @@ void shstk_free(struct task_struct *tsk)
>  	unmap_shadow_stack(shstk->base, shstk->size);
>  }
>  
> +static int wrss_control(bool enable)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Only enable wrss if shadow stack is enabled. If shadow stack is not

"WRSS". Insns in all caps pls.

> +	 * enabled, wrss will already be disabled, so don't bother clearing it

Ditto.

> +	 * when disabling.
> +	 */
> +	if (!features_enabled(ARCH_SHSTK_SHSTK))
> +		return -EPERM;
> +
> +	/* Already enabled/disabled? */
> +	if (features_enabled(ARCH_SHSTK_WRSS) == enable)
> +		return 0;
> +
> +	fpregs_lock_and_load();
> +	if (enable) {
> +		set_clr_bits_msrl(MSR_IA32_U_CET, CET_WRSS_EN, 0);
> +		features_set(ARCH_SHSTK_WRSS);
> +	} else {
> +		set_clr_bits_msrl(MSR_IA32_U_CET, 0, CET_WRSS_EN);
> +		features_clr(ARCH_SHSTK_WRSS);
> +	}
> +	fpregs_unlock();

Yes, doing it the "usual" way is more readable because it is a common
code pattern which one encounters all around arch/x86/.

Diff ontop:

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 009cb3fa0ae5..914feff26b23 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -365,6 +365,8 @@ void shstk_free(struct task_struct *tsk)
 
 static int wrss_control(bool enable)
 {
+	u64 msrval;
+
 	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
 		return -EOPNOTSUPP;
 
@@ -381,13 +383,22 @@ static int wrss_control(bool enable)
 		return 0;
 
 	fpregs_lock_and_load();
+	rdmsrl(MSR_IA32_U_CET, msrval);
+
 	if (enable) {
-		set_clr_bits_msrl(MSR_IA32_U_CET, CET_WRSS_EN, 0);
 		features_set(ARCH_SHSTK_WRSS);
+		msrval |= CET_WRSS_EN;
 	} else {
-		set_clr_bits_msrl(MSR_IA32_U_CET, 0, CET_WRSS_EN);
 		features_clr(ARCH_SHSTK_WRSS);
+		if (!(msrval & CET_WRSS_EN))
+			goto unlock;
+
+		msrval &= ~CET_WRSS_EN;
 	}
+
+	wrmsrl(MSR_IA32_U_CET, msrval);
+
+unlock:
 	fpregs_unlock();
 
 	return 0;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
