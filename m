Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9F8816EFB7
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 21:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbgBYUEW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 15:04:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42265 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbgBYUEW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 15:04:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so111462pfz.9
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 12:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BpgzSDf6JhhZfg51iKdhAMMJbNC3r3UORVH5eKhoGB8=;
        b=P8MDT0cC5XXhSyYyx5TXU139qSIZ/xhuoGwRng4lZAmicF++O+72wdGpXydxjjkgFa
         H4vkNdlhIhv5JR6vbLSURhaY9tLDlh6H0DsHibawIoSvdFOEeNyiXIv50fTJxqAVYNNd
         6cAG3sXIgbEYIb7BLdbgbbget3GIHMemSl1aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BpgzSDf6JhhZfg51iKdhAMMJbNC3r3UORVH5eKhoGB8=;
        b=ha7v/TZ8KGJvQevPqXmtaBtjApJ6rBBqLm1vztjzpDPk0ch1UJGmbrqYRf4E+NtFb2
         EoJNpDGmxxoEnejplFtyDtEEo+x1RXLlkhLZF8VW6QxEj3syrB1XjgogETffzBIj0sB4
         RHQyEJmNdv73/9JooYGV31K9UOxXBs1QRi4UoZMNOYzc+bF3RGP8dhv5RKJmWnBXXK44
         swGdy+cRAwp+p22P7OG55E/VUeYVocZBY7bG7SRShF1GEMaoetIRExNsqsJW2LFn7RtN
         yXjMjvPS7hGgVJNBbCbe/yEI53hpFXSkcGz/UxxihixCMHYB3PT/R93Z/W5eemKc6Yv0
         bvmA==
X-Gm-Message-State: APjAAAUhFqM3lHC/Ft8RBR9OQ8EsorHZ+pwpdzwqomuRJdXyw9NDJm6l
        hrZTt05azrC60lW+Mapura3UTA==
X-Google-Smtp-Source: APXvYqzTnsAiIZPOowEHcZB0wbT1W7YT7argEgciEcgKnK9iDdlzqhQbhsBMCk6QBQAjW+qazXItWQ==
X-Received: by 2002:a62:37c7:: with SMTP id e190mr377399pfa.165.1582661060202;
        Tue, 25 Feb 2020 12:04:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y18sm18433773pfe.19.2020.02.25.12.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:04:19 -0800 (PST)
Date:   Tue, 25 Feb 2020 12:04:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Subject: Re: [RFC PATCH v9 03/27] x86/fpu/xstate: Introduce CET MSR XSAVES
 supervisor states
Message-ID: <202002251204.BFA4DC797@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-4-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:11AM -0800, Yu-cheng Yu wrote:
> Control-flow Enforcement Technology (CET) adds five MSRs.  Introduce them
> and their XSAVES supervisor states:
> 
>     MSR_IA32_U_CET (user-mode CET settings),
>     MSR_IA32_PL3_SSP (user-mode Shadow Stack pointer),
>     MSR_IA32_PL0_SSP (kernel-mode Shadow Stack pointer),
>     MSR_IA32_PL1_SSP (Privilege Level 1 Shadow Stack pointer),
>     MSR_IA32_PL2_SSP (Privilege Level 2 Shadow Stack pointer).
> 
> v6:
> - Remove __packed from struct cet_user_state, struct cet_kernel_state.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/include/asm/fpu/types.h            | 22 ++++++++++++++++++
>  arch/x86/include/asm/fpu/xstate.h           |  5 +++--
>  arch/x86/include/asm/msr-index.h            | 18 +++++++++++++++
>  arch/x86/include/uapi/asm/processor-flags.h |  2 ++
>  arch/x86/kernel/fpu/xstate.c                | 25 +++++++++++++++++++--
>  5 files changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
> index f098f6cab94b..d7ef4d9c7ad5 100644
> --- a/arch/x86/include/asm/fpu/types.h
> +++ b/arch/x86/include/asm/fpu/types.h
> @@ -114,6 +114,9 @@ enum xfeature {
>  	XFEATURE_Hi16_ZMM,
>  	XFEATURE_PT_UNIMPLEMENTED_SO_FAR,
>  	XFEATURE_PKRU,
> +	XFEATURE_RESERVED,
> +	XFEATURE_CET_USER,
> +	XFEATURE_CET_KERNEL,
>  
>  	XFEATURE_MAX,
>  };
> @@ -128,6 +131,8 @@ enum xfeature {
>  #define XFEATURE_MASK_Hi16_ZMM		(1 << XFEATURE_Hi16_ZMM)
>  #define XFEATURE_MASK_PT		(1 << XFEATURE_PT_UNIMPLEMENTED_SO_FAR)
>  #define XFEATURE_MASK_PKRU		(1 << XFEATURE_PKRU)
> +#define XFEATURE_MASK_CET_USER		(1 << XFEATURE_CET_USER)
> +#define XFEATURE_MASK_CET_KERNEL	(1 << XFEATURE_CET_KERNEL)
>  
>  #define XFEATURE_MASK_FPSSE		(XFEATURE_MASK_FP | XFEATURE_MASK_SSE)
>  #define XFEATURE_MASK_AVX512		(XFEATURE_MASK_OPMASK \
> @@ -229,6 +234,23 @@ struct pkru_state {
>  	u32				pad;
>  } __packed;
>  
> +/*
> + * State component 11 is Control-flow Enforcement user states
> + */
> +struct cet_user_state {
> +	u64 user_cet;			/* user control-flow settings */
> +	u64 user_ssp;			/* user shadow stack pointer */
> +};
> +
> +/*
> + * State component 12 is Control-flow Enforcement kernel states
> + */
> +struct cet_kernel_state {
> +	u64 kernel_ssp;			/* kernel shadow stack */
> +	u64 pl1_ssp;			/* privilege level 1 shadow stack */
> +	u64 pl2_ssp;			/* privilege level 2 shadow stack */
> +};
> +
>  struct xstate_header {
>  	u64				xfeatures;
>  	u64				xcomp_bv;
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index 9ebfdd543576..952d2515dae4 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -33,13 +33,14 @@
>  				       XFEATURE_MASK_BNDCSR)
>  
>  /* All currently supported supervisor features */
> -#define SUPPORTED_XFEATURES_MASK_SUPERVISOR (0)
> +#define SUPPORTED_XFEATURES_MASK_SUPERVISOR (XFEATURE_MASK_CET_USER)
>  
>  /*
>   * Unsupported supervisor features. When a supervisor feature in this mask is
>   * supported in the future, move it to the supported supervisor feature mask.
>   */
> -#define UNSUPPORTED_XFEATURES_MASK_SUPERVISOR (XFEATURE_MASK_PT)
> +#define UNSUPPORTED_XFEATURES_MASK_SUPERVISOR (XFEATURE_MASK_PT | \
> +					       XFEATURE_MASK_CET_KERNEL)
>  
>  /* All supervisor states including supported and unsupported states. */
>  #define ALL_XFEATURES_MASK_SUPERVISOR (SUPPORTED_XFEATURES_MASK_SUPERVISOR | \
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 084e98da04a7..114e77f5bb6b 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -872,4 +872,22 @@
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
> +#define MSR_IA32_CET_SHSTK_EN		0x0000000000000001ULL
> +#define MSR_IA32_CET_WRSS_EN		0x0000000000000002ULL
> +#define MSR_IA32_CET_ENDBR_EN		0x0000000000000004ULL
> +#define MSR_IA32_CET_LEG_IW_EN		0x0000000000000008ULL
> +#define MSR_IA32_CET_NO_TRACK_EN	0x0000000000000010ULL
> +#define MSR_IA32_CET_WAIT_ENDBR	0x00000000000000800UL
> +#define MSR_IA32_CET_BITMAP_MASK	0xfffffffffffff000ULL
> +
>  #endif /* _ASM_X86_MSR_INDEX_H */
> diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
> index bcba3c643e63..a8df907e8017 100644
> --- a/arch/x86/include/uapi/asm/processor-flags.h
> +++ b/arch/x86/include/uapi/asm/processor-flags.h
> @@ -130,6 +130,8 @@
>  #define X86_CR4_SMAP		_BITUL(X86_CR4_SMAP_BIT)
>  #define X86_CR4_PKE_BIT		22 /* enable Protection Keys support */
>  #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
> +#define X86_CR4_CET_BIT		23 /* enable Control-flow Enforcement */
> +#define X86_CR4_CET		_BITUL(X86_CR4_CET_BIT)
>  
>  /*
>   * x86-64 Task Priority Register, CR8
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 04f7c6b8dbbc..ec08a2b6feca 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -38,6 +38,9 @@ static const char *xfeature_names[] =
>  	"Processor Trace (unused)"	,
>  	"Protection Keys User registers",
>  	"unknown xstate feature"	,
> +	"Control-flow User registers"	,
> +	"Control-flow Kernel registers"	,
> +	"unknown xstate feature"	,
>  };
>  
>  static short xsave_cpuid_features[] __initdata = {
> @@ -51,6 +54,9 @@ static short xsave_cpuid_features[] __initdata = {
>  	X86_FEATURE_AVX512F,
>  	X86_FEATURE_INTEL_PT,
>  	X86_FEATURE_PKU,
> +	-1,		   /* Unused */
> +	X86_FEATURE_SHSTK, /* XFEATURE_CET_USER */
> +	X86_FEATURE_SHSTK, /* XFEATURE_CET_KERNEL */
>  };
>  
>  /*
> @@ -316,6 +322,8 @@ static void __init print_xstate_features(void)
>  	print_xstate_feature(XFEATURE_MASK_ZMM_Hi256);
>  	print_xstate_feature(XFEATURE_MASK_Hi16_ZMM);
>  	print_xstate_feature(XFEATURE_MASK_PKRU);
> +	print_xstate_feature(XFEATURE_MASK_CET_USER);
> +	print_xstate_feature(XFEATURE_MASK_CET_KERNEL);
>  }
>  
>  /*
> @@ -563,6 +571,8 @@ static void check_xstate_against_struct(int nr)
>  	XCHECK_SZ(sz, nr, XFEATURE_ZMM_Hi256, struct avx_512_zmm_uppers_state);
>  	XCHECK_SZ(sz, nr, XFEATURE_Hi16_ZMM,  struct avx_512_hi16_state);
>  	XCHECK_SZ(sz, nr, XFEATURE_PKRU,      struct pkru_state);
> +	XCHECK_SZ(sz, nr, XFEATURE_CET_USER,   struct cet_user_state);
> +	XCHECK_SZ(sz, nr, XFEATURE_CET_KERNEL, struct cet_kernel_state);
>  
>  	/*
>  	 * Make *SURE* to add any feature numbers in below if
> @@ -770,8 +780,19 @@ void __init fpu__init_system_xstate(void)
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
> +			    !boot_cpu_has(xsave_cpuid_features[i]))
> +				xfeatures_mask_all &= ~BIT_ULL(i);
> +		}
>  	}
>  
>  	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
> -- 
> 2.21.0
> 

-- 
Kees Cook
