Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB28302A37
	for <lists+linux-arch@lfdr.de>; Mon, 25 Jan 2021 19:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbhAYS2A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Jan 2021 13:28:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38444 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbhAYS16 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Jan 2021 13:27:58 -0500
Received: from zn.tnic (p200300ec2f09db000456e0102ed32bc5.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:db00:456:e010:2ed3:2bc5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF1F61EC0104;
        Mon, 25 Jan 2021 19:27:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611599234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QN3ei/A8mfrH9ATVg5ntkb1LsnqB0BMG6fj7B9jab8Y=;
        b=sgo0SEzlpyG+vZTbZ5zKg1uAiSwR4t01ASxw76IKDmIUwWEuBoa5rCNc5ZmAxln/A6motI
        76ImTK0R6xY4xOzkkLZQ1FTGA+BIxjbxG04UAx6e6J4emK+UJGgciuRNxNxebOQEVvqkHx
        02hyznf75NMUbtjLjxEu5EzAmOcIPPM=
Date:   Mon, 25 Jan 2021 19:27:09 +0100
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
Subject: Re: [PATCH v17 11/26] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Message-ID: <20210125182709.GC23290@zn.tnic>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-12-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201229213053.16395-12-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 29, 2020 at 01:30:38PM -0800, Yu-cheng Yu wrote:
> When Shadow Stack is introduced, [R/O + _PAGE_DIRTY] PTE is reserved for
> shadow stack.  Copy-on-write PTEs have [R/O + _PAGE_COW].
> 
> When a PTE goes from [R/W + _PAGE_DIRTY] to [R/O + _PAGE_COW], it could
> become a transient shadow stack PTE in two cases:
> 
> The first case is that some processors can start a write but end up seeing
> a read-only PTE by the time they get to the Dirty bit, creating a transient
> shadow stack PTE.  However, this will not occur on processors supporting
> Shadow Stack, therefore we don't need a TLB flush here.

Who's "we"?

> The second case is that when the software, without atomic, tests & replaces

"... when _PAGE_DIRTY is replaced with _PAGE_COW non-atomically, a transient
shadow stack PTE can be created, as a result."

> _PAGE_DIRTY with _PAGE_COW, a transient shadow stack PTE can exist.
> This is prevented with cmpxchg.
> 
> Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided many
> insights to the issue.  Jann Horn provided the cmpxchg solution.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/include/asm/pgtable.h | 52 ++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 666c25ab9564..1c84f1ba32b9 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1226,6 +1226,32 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>  				      unsigned long addr, pte_t *ptep)
>  {
> +	/*
> +	 * Some processors can start a write, but end up seeing a read-only
> +	 * PTE by the time they get to the Dirty bit.  In this case, they
> +	 * will set the Dirty bit, leaving a read-only, Dirty PTE which
> +	 * looks like a shadow stack PTE.
> +	 *
> +	 * However, this behavior has been improved

Improved how?

> and will not occur on
> +	 * processors supporting Shadow Stack.  Without this guarantee, a

Which guarantee? That it won't happen on CPUs which support SHSTK?

> +	 * transition to a non-present PTE and flush the TLB would be

s/flush the TLB/TLB flush/

> +	 * needed.
> +	 *
> +	 * When changing a writable PTE to read-only and if the PTE has
> +	 * _PAGE_DIRTY set, move that bit to _PAGE_COW so that the PTE is
> +	 * not a shadow stack PTE.
> +	 */

This sentence doesn't belong here as it refers to what pte_wrprotect()
does. You could expand the comment in pte_wrprotect() with this here as
it is better.

> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		pte_t old_pte, new_pte;
> +
> +		do {
> +			old_pte = READ_ONCE(*ptep);
> +			new_pte = pte_wrprotect(old_pte);

Maybe I'm missing something but those two can happen outside of the
loop, no? Or is *ptep somehow changing concurrently while the loop is
doing the CMPXCHG and you need to recreate it each time?

IOW, you can generate upfront and do the empty loop...

> +
> +		} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
> +
> +		return;
> +	}
>  	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
>  }
>  
> @@ -1282,6 +1308,32 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
>  static inline void pmdp_set_wrprotect(struct mm_struct *mm,
>  				      unsigned long addr, pmd_t *pmdp)
>  {
> +	/*
> +	 * Some processors can start a write, but end up seeing a read-only
> +	 * PMD by the time they get to the Dirty bit.  In this case, they
> +	 * will set the Dirty bit, leaving a read-only, Dirty PMD which
> +	 * looks like a Shadow Stack PMD.
> +	 *
> +	 * However, this behavior has been improved and will not occur on
> +	 * processors supporting Shadow Stack.  Without this guarantee, a
> +	 * transition to a non-present PMD and flush the TLB would be
> +	 * needed.
> +	 *
> +	 * When changing a writable PMD to read-only and if the PMD has
> +	 * _PAGE_DIRTY set, move that bit to _PAGE_COW so that the PMD is
> +	 * not a shadow stack PMD.
> +	 */

Same comments as above.

> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		pmd_t old_pmd, new_pmd;
> +
> +		do {
> +			old_pmd = READ_ONCE(*pmdp);
> +			new_pmd = pmd_wrprotect(old_pmd);
> +
> +		} while (!try_cmpxchg((pmdval_t *)pmdp, (pmdval_t *)&old_pmd, pmd_val(new_pmd)));
> +
> +		return;
> +	}
>  	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
>  }
>  
> -- 
> 2.21.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
