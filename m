Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28CE3E4A2E
	for <lists+linux-arch@lfdr.de>; Mon,  9 Aug 2021 18:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhHIQq3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Aug 2021 12:46:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55004 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232861AbhHIQq2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Aug 2021 12:46:28 -0400
Received: from zn.tnic (p200300ec2f26f300329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:f300:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 83DB51EC0464;
        Mon,  9 Aug 2021 18:46:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628527561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XUOqf8vqF/dog7RebfDNzatspRq8VZL8GzGgGP6c24Q=;
        b=YFl6VNfrMwgbU+encJCbFTp5uVXnTZhWTKeoZRrz8sHdCYD50Km7numnyXlX6tcSSf2Lmc
        XE+GvgRwFHo3EHlF0dj7g/Prgxv5ehPMlHHNwrjWNlBlqB/+dR7XzK3Bdm9C2YzzKmfS2u
        Kw5HjQAZ9hceYx5fy61aD1cYtAdjKRg=
Date:   Mon, 9 Aug 2021 18:46:45 +0200
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
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v28 05/32] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
Message-ID: <YRFb9eShKnKckDQp@zn.tnic>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210722205219.7934-6-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 22, 2021 at 01:51:52PM -0700, Yu-cheng Yu wrote:
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index a7c413432b33..b529f42ddaae 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -939,4 +939,23 @@
>  #define MSR_VM_IGNNE                    0xc0010115
>  #define MSR_VM_HSAVE_PA                 0xc0010117
>  
> +/* Control-flow Enforcement Technology MSRs */
> +#define MSR_IA32_U_CET		0x000006a0 /* user mode cet setting */
> +#define MSR_IA32_S_CET		0x000006a2 /* kernel mode cet setting */
> +#define CET_SHSTK_EN		BIT_ULL(0)
> +#define CET_WRSS_EN		BIT_ULL(1)
> +#define CET_ENDBR_EN		BIT_ULL(2)
> +#define CET_LEG_IW_EN		BIT_ULL(3)
> +#define CET_NO_TRACK_EN		BIT_ULL(4)
> +#define CET_SUPPRESS_DISABLE	BIT_ULL(5)
> +#define CET_RESERVED		(BIT_ULL(6) | BIT_ULL(7) | BIT_ULL(8) | BIT_ULL(9))
> +#define CET_SUPPRESS		BIT_ULL(10)
> +#define CET_WAIT_ENDBR		BIT_ULL(11)
> +
> +#define MSR_IA32_PL0_SSP	0x000006a4 /* kernel shadow stack pointer */
> +#define MSR_IA32_PL1_SSP	0x000006a5 /* ring-1 shadow stack pointer */
> +#define MSR_IA32_PL2_SSP	0x000006a6 /* ring-2 shadow stack pointer */
> +#define MSR_IA32_PL3_SSP	0x000006a7 /* user shadow stack pointer */
> +#define MSR_IA32_INT_SSP_TAB	0x000006a8 /* exception shadow stack table */
> +
>  #endif /* _ASM_X86_MSR_INDEX_H */

Merge the following hunk ontop of yours pls:

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index b529f42ddaae..14ce136bcfa8 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -362,6 +362,26 @@
 
 
 #define MSR_CORE_PERF_LIMIT_REASONS	0x00000690
+
+/* Control-flow Enforcement Technology MSRs */
+#define MSR_IA32_U_CET			0x000006a0 /* user mode cet setting */
+#define MSR_IA32_S_CET			0x000006a2 /* kernel mode cet setting */
+#define CET_SHSTK_EN			BIT_ULL(0)
+#define CET_WRSS_EN			BIT_ULL(1)
+#define CET_ENDBR_EN			BIT_ULL(2)
+#define CET_LEG_IW_EN			BIT_ULL(3)
+#define CET_NO_TRACK_EN			BIT_ULL(4)
+#define CET_SUPPRESS_DISABLE		BIT_ULL(5)
+#define CET_RESERVED			(BIT_ULL(6) | BIT_ULL(7) | BIT_ULL(8) | BIT_ULL(9))
+#define CET_SUPPRESS			BIT_ULL(10)
+#define CET_WAIT_ENDBR			BIT_ULL(11)
+
+#define MSR_IA32_PL0_SSP		0x000006a4 /* kernel shadow stack pointer */
+#define MSR_IA32_PL1_SSP		0x000006a5 /* ring-1 shadow stack pointer */
+#define MSR_IA32_PL2_SSP		0x000006a6 /* ring-2 shadow stack pointer */
+#define MSR_IA32_PL3_SSP		0x000006a7 /* user shadow stack pointer */
+#define MSR_IA32_INT_SSP_TAB		0x000006a8 /* exception shadow stack table */
+
 #define MSR_GFX_PERF_LIMIT_REASONS	0x000006B0
 #define MSR_RING_PERF_LIMIT_REASONS	0x000006B1
 
@@ -939,23 +959,4 @@
 #define MSR_VM_IGNNE                    0xc0010115
 #define MSR_VM_HSAVE_PA                 0xc0010117
 
-/* Control-flow Enforcement Technology MSRs */
-#define MSR_IA32_U_CET		0x000006a0 /* user mode cet setting */
-#define MSR_IA32_S_CET		0x000006a2 /* kernel mode cet setting */
-#define CET_SHSTK_EN		BIT_ULL(0)
-#define CET_WRSS_EN		BIT_ULL(1)
-#define CET_ENDBR_EN		BIT_ULL(2)
-#define CET_LEG_IW_EN		BIT_ULL(3)
-#define CET_NO_TRACK_EN		BIT_ULL(4)
-#define CET_SUPPRESS_DISABLE	BIT_ULL(5)
-#define CET_RESERVED		(BIT_ULL(6) | BIT_ULL(7) | BIT_ULL(8) | BIT_ULL(9))
-#define CET_SUPPRESS		BIT_ULL(10)
-#define CET_WAIT_ENDBR		BIT_ULL(11)
-
-#define MSR_IA32_PL0_SSP	0x000006a4 /* kernel shadow stack pointer */
-#define MSR_IA32_PL1_SSP	0x000006a5 /* ring-1 shadow stack pointer */
-#define MSR_IA32_PL2_SSP	0x000006a6 /* ring-2 shadow stack pointer */
-#define MSR_IA32_PL3_SSP	0x000006a7 /* user shadow stack pointer */
-#define MSR_IA32_INT_SSP_TAB	0x000006a8 /* exception shadow stack table */
-
 #endif /* _ASM_X86_MSR_INDEX_H */


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
