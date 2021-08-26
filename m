Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFD33F85BA
	for <lists+linux-arch@lfdr.de>; Thu, 26 Aug 2021 12:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241403AbhHZKm7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Aug 2021 06:42:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60006 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241651AbhHZKm4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Aug 2021 06:42:56 -0400
Received: from zn.tnic (p200300ec2f131000e9f5f92baa539bd3.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:1000:e9f5:f92b:aa53:9bd3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9EDD51EC059F;
        Thu, 26 Aug 2021 12:42:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629974522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/+zhsnMCrl4A1n84q3D+HixyM8NtGVeoOXJJaRfniYk=;
        b=c5jpgK1MuWlgU05fahpkc1I9eMRr/FOkjedaTw9QY/zCUba7rQd7eEX53TDqwO6Y6qKXWo
        hBHX2exznBaT3SXIjGxWc1w+FlzKFNm26E8tQXEj7Jshs/5Zy9aH364EXKZqXh7cIDlJHj
        /t4AWf7oZRi4ov8NimScmrn48Z12fNQ=
Date:   Thu, 26 Aug 2021 12:42:39 +0200
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
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v29 12/32] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Message-ID: <YSdwH1T7g5B3E9ZH@zn.tnic>
References: <20210820181201.31490-1-yu-cheng.yu@intel.com>
 <20210820181201.31490-13-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820181201.31490-13-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 20, 2021 at 11:11:41AM -0700, Yu-cheng Yu wrote:
> @@ -1322,6 +1340,24 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
>  static inline void pmdp_set_wrprotect(struct mm_struct *mm,
>  				      unsigned long addr, pmd_t *pmdp)
>  {
> +	/*
> +	 * If Shadow Stack is enabled, pmd_wrprotect() moves _PAGE_DIRTY
> +	 * to _PAGE_COW (see comments at pmd_wrprotect()).
> +	 * When a thread reads a RW=1, Dirty=0 PMD and before changing it
> +	 * to RW=0, Dirty=0, another thread could have written to the page
> +	 * and the PMD is RW=1, Dirty=1 now.  Use try_cmpxchg() to detect
> +	 * PMD changes and update old_pmd, then try again.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		pmd_t old_pmd, new_pmd;
> +
> +		old_pmd = READ_ONCE(*pmdp);
> +		do {
> +			new_pmd = pmd_wrprotect(old_pmd);
> +		} while (!try_cmpxchg((pmdval_t *)pmdp, (pmdval_t *)&old_pmd, pmd_val(new_pmd)));

From the previous thread:

> If !(CONFIG_PGTABLE_LEVELS > 2), we don't have pmd_t.pmd.

So I guess you can do this, in line with how the pmd folding is done in
the rest of the mm headers. There's no need to make this more complex
than it is just so that 32-bit !PAE builds but where CET is not even
enabled.

---
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index df4ce715560a..7c0542997790 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1340,6 +1340,7 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pmd_t *pmdp)
 {
+#if CONFIG_PGTABLE_LEVELS > 2
 	/*
 	 * If Shadow Stack is enabled, pmd_wrprotect() moves _PAGE_DIRTY
 	 * to _PAGE_COW (see comments at pmd_wrprotect()).
@@ -1354,10 +1355,11 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 		old_pmd = READ_ONCE(*pmdp);
 		do {
 			new_pmd = pmd_wrprotect(old_pmd);
-		} while (!try_cmpxchg((pmdval_t *)pmdp, (pmdval_t *)&old_pmd, pmd_val(new_pmd)));
+		} while (!try_cmpxchg(&pmdp->pmd, &old_pmd.pmd, new_pmd.pmd));
 
 		return;
 	}
+#endif
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
 }
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
