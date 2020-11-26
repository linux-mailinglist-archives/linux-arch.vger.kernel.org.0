Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434912C528D
	for <lists+linux-arch@lfdr.de>; Thu, 26 Nov 2020 12:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbgKZLCS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Nov 2020 06:02:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44948 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729663AbgKZLCR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Nov 2020 06:02:17 -0500
Received: from zn.tnic (p200300ec2f0c90002c8516e75060f16f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9000:2c85:16e7:5060:f16f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 864301EC04CC;
        Thu, 26 Nov 2020 12:02:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606388535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=thPwP/sRGoGF+5wJi3jAB2qEXFSTTtsRS5IciU/FKjE=;
        b=pcm6mB5+9r0Oi78iZwGK6chAYEl3nP9AOEKBkZfQT5sioFIkiPiyR8uzRCUIRftvxb6ibJ
        tOyCIem2q0U6MWKIEJUG1eqjzj3/R111C2RXSrsgkQZ9SOtNLTWotnQheFk45xhycOPV8q
        0EbKNo0zrfri2cdGiAR2H2Q2W4KiAXg=
Date:   Thu, 26 Nov 2020 12:02:15 +0100
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
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v15 03/26] x86/fpu/xstate: Introduce CET MSR XSAVES
 supervisor states
Message-ID: <20201126110215.GD31565@zn.tnic>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201110162211.9207-4-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 10, 2020 at 08:21:48AM -0800, Yu-cheng Yu wrote:
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 972a34d93505..6f05ab2a1fa4 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -922,4 +922,24 @@
>  #define MSR_VM_IGNNE                    0xc0010115
>  #define MSR_VM_HSAVE_PA                 0xc0010117
>  
> +/* Control-flow Enforcement Technology MSRs */
> +#define MSR_IA32_U_CET		0x6a0 /* user mode cet setting */
> +#define MSR_IA32_S_CET		0x6a2 /* kernel mode cet setting */
> +#define MSR_IA32_PL0_SSP	0x6a4 /* kernel shstk pointer */
> +#define MSR_IA32_PL1_SSP	0x6a5 /* ring-1 shstk pointer */
> +#define MSR_IA32_PL2_SSP	0x6a6 /* ring-2 shstk pointer */
> +#define MSR_IA32_PL3_SSP	0x6a7 /* user shstk pointer */
> +#define MSR_IA32_INT_SSP_TAB	0x6a8 /* exception shstk table */
> +
> +/* MSR_IA32_U_CET and MSR_IA32_S_CET bits */

Pls put the bit defines under the MSRs they belong to.

> +#define CET_SHSTK_EN		BIT_ULL(0)
> +#define CET_WRSS_EN		BIT_ULL(1)
> +#define CET_ENDBR_EN		BIT_ULL(2)
> +#define CET_LEG_IW_EN		BIT_ULL(3)
> +#define CET_NO_TRACK_EN		BIT_ULL(4)
> +#define CET_SUPPRESS_DISABLE	BIT_ULL(5)
> +#define CET_RESERVED		(BIT_ULL(6) | BIT_ULL(7) | BIT_ULL(8) | BIT_ULL(9))
> +#define CET_SUPPRESS		BIT_ULL(10)
> +#define CET_WAIT_ENDBR		BIT_ULL(11)

...

>  	 * Clear XSAVE features that are disabled in the normal CPUID.
>  	 */
>  	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
> -		if (!boot_cpu_has(xsave_cpuid_features[i]))
> -			xfeatures_mask_all &= ~BIT_ULL(i);
> +		if (xsave_cpuid_features[i] == X86_FEATURE_SHSTK) {
> +			/*
> +			 * X86_FEATURE_SHSTK and X86_FEATURE_IBT share
> +			 * same states, but can be enabled separately.
> +			 */
> +			if (!boot_cpu_has(X86_FEATURE_SHSTK) &&
> +			    !boot_cpu_has(X86_FEATURE_IBT))
> +				xfeatures_mask_all &= ~BIT_ULL(i);
> +		} else {
> +			if ((xsave_cpuid_features[i] == -1) ||
			     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

That is a new check. I guess it could be done first to simplify the
code:

	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
		if (xsave_cpuid_features[i] == -1) {
			xfeatures_mask_all &= ~BIT_ULL(i);
			continue;
		}

		/* the rest of the bla */

Yes?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
