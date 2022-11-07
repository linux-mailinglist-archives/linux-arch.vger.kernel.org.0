Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8C761FCAF
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 19:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiKGSFK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 13:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbiKGSEt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 13:04:49 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AD224F26;
        Mon,  7 Nov 2022 10:00:43 -0800 (PST)
Received: from zn.tnic (p200300ea9733e71f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e71f:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 49F851EC059D;
        Mon,  7 Nov 2022 19:00:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667844042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UkSYnjmUQupdoESl0cYE22dAydPPeLNDAdR5Iz0pnhU=;
        b=bXNIbKBf++r6UJZ1YxkMPFeTEsnxN+C6+C+eLrtUPptX7sJ1W2m3VuISpp81WPCK4PTYdm
        mK9DduVUBLvg9bqJuQ6msgSIq572Li4j8FEI7OJElPzWdein5uvqIVmWrwPB6EpjLMZqtf
        Xphdp9jPHy+GLhx1wExdY8rJG2XIe+E=
Date:   Mon, 7 Nov 2022 19:00:37 +0100
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v3 04/37] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Message-ID: <Y2lHxb5BnbQi499s@zn.tnic>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-5-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221104223604.29615-5-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 04, 2022 at 03:35:31PM -0700, Rick Edgecombe wrote:
>  static __always_inline void setup_cet(struct cpuinfo_x86 *c)
>  {
> -	u64 msr = CET_ENDBR_EN;
> +	bool kernel_ibt = HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT);
> +	bool user_shstk;
> +	u64 msr = 0;
>  
> -	if (!HAS_KERNEL_IBT ||
> -	    !cpu_feature_enabled(X86_FEATURE_IBT))
> +	/*
> +	 * Enable user shadow stack only if the Linux defined user shadow stack
> +	 * cap was not cleared by command line.
> +	 */
> +	user_shstk = cpu_feature_enabled(X86_FEATURE_SHSTK) &&
> +		     IS_ENABLED(CONFIG_X86_USER_SHADOW_STACK) &&
> +		     !test_bit(X86_FEATURE_USER_SHSTK, (unsigned long *)cpu_caps_cleared);

Huh, why poke at cpu_caps_cleared? 

Look below:

> +	if (!kernel_ibt && !user_shstk)
>  		return;
>  
> +	if (user_shstk)
> +		set_cpu_cap(c, X86_FEATURE_USER_SHSTK);
> +
> +	if (kernel_ibt)
> +		msr = CET_ENDBR_EN;
> +
>  	wrmsrl(MSR_IA32_S_CET, msr);
>  	cr4_set_bits(X86_CR4_CET);
>  
> -	if (!ibt_selftest()) {
> +	if (kernel_ibt && !ibt_selftest()) {
>  		pr_err("IBT selftest: Failed!\n");
>  		setup_clear_cpu_cap(X86_FEATURE_IBT);
>  		return;
>  	}
>  }
> +#else /* CONFIG_X86_CET */
> +static inline void setup_cet(struct cpuinfo_x86 *c) {}
> +#endif
>  
>  __noendbr void cet_disable(void)
>  {
> -	if (cpu_feature_enabled(X86_FEATURE_IBT))
> -		wrmsrl(MSR_IA32_S_CET, 0);
> +	if (!(cpu_feature_enabled(X86_FEATURE_IBT) ||
> +	      cpu_feature_enabled(X86_FEATURE_SHSTK)))
> +		return;
> +
> +	wrmsrl(MSR_IA32_S_CET, 0);
> +	wrmsrl(MSR_IA32_U_CET, 0);

Here you need to do

	setup_clear_cpu_cap(X86_FEATURE_IBT);
	setup_clear_cpu_cap(X86_FEATURE_SHSTK);

and then the cpu_feature_enabled() test above alone should suffice.

But, before you do that, I'd like to ask you to update your patchset
ontop of tip/master because the conflicts are getting non-trivial. This
one doesn't even want to apply with a large fuzz:

$ patch -p1 --dry-run -F20 -i /tmp/new
checking file arch/x86/kernel/cpu/common.c
Hunk #1 FAILED at 596.
1 out of 1 hunk FAILED

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
