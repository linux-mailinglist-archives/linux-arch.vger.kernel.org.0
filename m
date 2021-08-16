Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3965A3EDA72
	for <lists+linux-arch@lfdr.de>; Mon, 16 Aug 2021 18:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhHPQBf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Aug 2021 12:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhHPQBf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Aug 2021 12:01:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DBEC061764;
        Mon, 16 Aug 2021 09:01:03 -0700 (PDT)
Received: from zn.tnic (p200300ec2f08b5007042c35e67cc1097.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:b500:7042:c35e:67cc:1097])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E82191EC03D5;
        Mon, 16 Aug 2021 18:00:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629129658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fWWTWO1JV4RsH463+53B7fbAW0qIhoTlvqX4vBT05vw=;
        b=BRIM2XbGCS8PHu4uS9LjB3oJPIwmGugzEX2I9WKF3Kk3KgHt7XBxSQY7R/h21OIthbEVbt
        DxcGj5ZGjnftTImnuk4LNOX/n4WudjZC4XiRhQdco5iHZwIha2bu0OFEbAvx4QipOjrqtA
        ris5Up7VSOO60XbJjm+5MKqK4cEzRHg=
Date:   Mon, 16 Aug 2021 18:01:37 +0200
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
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v28 12/32] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Message-ID: <YRqL4QyYPaCXSmi+@zn.tnic>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-13-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210722205219.7934-13-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 22, 2021 at 01:51:59PM -0700, Yu-cheng Yu wrote:
> When Shadow Stack is introduced, [R/O + _PAGE_DIRTY] PTE is reserved for
> shadow stack.  Copy-on-write PTEs have [R/O + _PAGE_COW].
> 
> When a PTE goes from [R/W + _PAGE_DIRTY] to [R/O + _PAGE_COW], it could
> become a transient shadow stack PTE in two cases:
> 
> The first case is that some processors can start a write but end up seeing
> a read-only PTE by the time they get to the Dirty bit, creating a transient
> shadow stack PTE.  However, this will not occur on processors supporting
> Shadow Stack, and a TLB flush is not necessary.
> 
> The second case is that when _PAGE_DIRTY is replaced with _PAGE_COW non-
> atomically, a transient shadow stack PTE can be created as a result.
> Thus, prevent that with cmpxchg.
> 
> Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided many
> insights to the issue.  Jann Horn provided the cmpxchg solution.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/include/asm/pgtable.h | 36 ++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index cf7316e968df..df4ce715560a 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1278,6 +1278,24 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>  				      unsigned long addr, pte_t *ptep)
>  {
> +	/*
> +	 * If Shadow Stack is enabled, pte_wrprotect() moves _PAGE_DIRTY
> +	 * to _PAGE_COW (see comments at pte_wrprotect()).
> +	 * When a thread reads a RW=1, Dirty=0 PTE and before changing it
> +	 * to RW=0, Dirty=0, another thread could have written to the page
> +	 * and the PTE is RW=1, Dirty=1 now.  Use try_cmpxchg() to detect
> +	 * PTE changes and update old_pte, then try again.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		pte_t old_pte, new_pte;
> +
> +		old_pte = READ_ONCE(*ptep);
> +		do {
> +			new_pte = pte_wrprotect(old_pte);
> +		} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
> +
> +		return;
> +	}
>  	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
>  }
>  
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

Why is that try_cmpxchg() call doing casting to its operands instead of
like the pte one above?

I.e., why aren't you doing here the same thing as above:

		...
		} while (!try_cmpxchg(&pmdp->pmd, &old_pmd.pmd, new_pmd.pmd));

?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
