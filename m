Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF3C716EFE4
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 21:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbgBYUOh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 15:14:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35585 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgBYUOh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 15:14:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id i19so147344pfa.2
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 12:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BTTLmTlutCOGMTV3ONbR2Fs2QQVUcjN96p4jAbuK95s=;
        b=QB9/2Oh/cWiLYN8wCN3MJFPiDTfRIJ4E1pxfixTeHiURbdkz67+jdzh8PFJTTfyAyu
         D3dwetUzQ2S8grF3unLt2EOypBpGybAQh2kB2M2KTKe1PtTjL8Om5GSjQE5+wg8CNBvd
         kIY+aXUTNgORVkBwei2THalxhJyNF6vj4dofg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BTTLmTlutCOGMTV3ONbR2Fs2QQVUcjN96p4jAbuK95s=;
        b=ggT2ufH4YN/c0rN6F2piSu/hycMjD37rTZeK8b0rDP55e7DHzKkxJUgoa4LQHm23gQ
         +qfRUbUlCiw2uKz6K5vKvb1IIfudOdLs3jM3SrOgiUCRSI4SMBr4v22x2Mrj/uDTHIKg
         sFQB9f+HAZg743FfuwR4RujVeUBjzoaaiEai+lzFPkPQaLoRJQQiHvC+Eq2iOrO7/HY8
         dtenyzvxuth9Xfjy/hWG6G4r5TyNyB6IDeIFm2sjR2BtV4Tx86NvyyGnpQblc8RhFDpY
         v3Q2EBLEkN9+Co33D2QPqmAr2mGfv7+DZCpR5gGhuJrdmBNzVIoFsGvm7cSOrKq0VFap
         c9tA==
X-Gm-Message-State: APjAAAU1sk5rIpDM1ODGptI3C6sQ2L9JFHN9PEPGItIRgQAMLczoJm6R
        RNhKuLyeuEfoFs/Vi91zFvQeQQ==
X-Google-Smtp-Source: APXvYqzQRJ5UsCLDvhXrdE0i7Rc00jqGyfX6QsU0LmkGz7BPlioCLt8NE2IkhrABklXhz2sOHBeagQ==
X-Received: by 2002:a62:6d01:: with SMTP id i1mr448865pfc.94.1582661676706;
        Tue, 25 Feb 2020 12:14:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i14sm4258972pgh.14.2020.02.25.12.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:14:35 -0800 (PST)
Date:   Tue, 25 Feb 2020 12:14:34 -0800
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
Subject: Re: [RFC PATCH v9 12/27] x86/mm: Modify ptep_set_wrprotect and
 pmdp_set_wrprotect for _PAGE_DIRTY_SW
Message-ID: <202002251214.8B2063AA87@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-13-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-13-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:20AM -0800, Yu-cheng Yu wrote:
> When Shadow Stack (SHSTK) is enabled, the [R/O + PAGE_DIRTY_HW] setting is
> reserved only for SHSTK.  Non-Shadow Stack R/O PTEs are
> [R/O + PAGE_DIRTY_SW].
> 
> When a PTE goes from [R/W + PAGE_DIRTY_HW] to [R/O + PAGE_DIRTY_SW], it
> could become a transient SHSTK PTE in two cases.
> 
> The first case is that some processors can start a write but end up seeing
> a read-only PTE by the time they get to the Dirty bit, creating a transient
> SHSTK PTE.  However, this will not occur on processors supporting SHSTK
> therefore we don't need a TLB flush here.
> 
> The second case is that when the software, without atomic, tests & replaces
> PAGE_DIRTY_HW with PAGE_DIRTY_SW, a transient SHSTK PTE can exist.  This is
> prevented with cmpxchg.
> 
> Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided many
> insights to the issue.  Jann Horn provided the cmpxchg solution.
> 
> v9:
> - Change compile-time conditionals to runtime checks.
> - Fix parameters of try_cmpxchg(): change pte_t/pmd_t to
>   pte_t.pte/pmd_t.pmd.
> 
> v4:
> - Implement try_cmpxchg().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/include/asm/pgtable.h | 66 ++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 2733e7ec16b3..43cb27379208 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1253,6 +1253,39 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>  				      unsigned long addr, pte_t *ptep)
>  {
> +	/*
> +	 * Some processors can start a write, but end up seeing a read-only
> +	 * PTE by the time they get to the Dirty bit.  In this case, they
> +	 * will set the Dirty bit, leaving a read-only, Dirty PTE which
> +	 * looks like a Shadow Stack PTE.
> +	 *
> +	 * However, this behavior has been improved and will not occur on
> +	 * processors supporting Shadow Stack.  Without this guarantee, a
> +	 * transition to a non-present PTE and flush the TLB would be
> +	 * needed.
> +	 *
> +	 * When changing a writable PTE to read-only and if the PTE has
> +	 * _PAGE_DIRTY_HW set, we move that bit to _PAGE_DIRTY_SW so that
> +	 * the PTE is not a valid Shadow Stack PTE.
> +	 */
> +#ifdef CONFIG_X86_64
> +	if (static_cpu_has(X86_FEATURE_SHSTK)) {
> +		pte_t new_pte, pte = READ_ONCE(*ptep);
> +
> +		do {
> +			/*
> +			 * This is the same as moving _PAGE_DIRTY_HW
> +			 * to _PAGE_DIRTY_SW.
> +			 */
> +			new_pte = pte_wrprotect(pte);
> +			new_pte.pte |= (new_pte.pte & _PAGE_DIRTY_HW) >>
> +					_PAGE_BIT_DIRTY_HW << _PAGE_BIT_DIRTY_SW;
> +			new_pte.pte &= ~_PAGE_DIRTY_HW;
> +		} while (!try_cmpxchg(&ptep->pte, &pte.pte, new_pte.pte));
> +
> +		return;
> +	}
> +#endif
>  	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
>  }
>  
> @@ -1303,6 +1336,39 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
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
> +	 * _PAGE_DIRTY_HW set, we move that bit to _PAGE_DIRTY_SW so that
> +	 * the PMD is not a valid Shadow Stack PMD.
> +	 */
> +#ifdef CONFIG_X86_64
> +	if (static_cpu_has(X86_FEATURE_SHSTK)) {
> +		pmd_t new_pmd, pmd = READ_ONCE(*pmdp);
> +
> +		do {
> +			/*
> +			 * This is the same as moving _PAGE_DIRTY_HW
> +			 * to _PAGE_DIRTY_SW.
> +			 */
> +			new_pmd = pmd_wrprotect(pmd);
> +			new_pmd.pmd |= (new_pmd.pmd & _PAGE_DIRTY_HW) >>
> +					_PAGE_BIT_DIRTY_HW << _PAGE_BIT_DIRTY_SW;
> +			new_pmd.pmd &= ~_PAGE_DIRTY_HW;
> +		} while (!try_cmpxchg(&pmdp->pmd, &pmd.pmd, new_pmd.pmd));
> +
> +		return;
> +	}
> +#endif
>  	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
>  }
>  
> -- 
> 2.21.0
> 

-- 
Kees Cook
