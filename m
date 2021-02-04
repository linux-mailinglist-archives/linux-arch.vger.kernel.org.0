Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EF930FE06
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 21:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbhBDUTy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 15:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239101AbhBDUTu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 15:19:50 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1166CC06178A
        for <linux-arch@vger.kernel.org>; Thu,  4 Feb 2021 12:19:10 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id s24so2343733pjp.5
        for <linux-arch@vger.kernel.org>; Thu, 04 Feb 2021 12:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wekNHqIxrVlz8U/v5ZYQ5Av1yTsUCmfVrKprauQpISo=;
        b=HXf8yeQvUhwG/a4srBf4G3FhtpIwikgbpxxSCk80nXB0A/W7+bgZojV7SValiuJ1jl
         iTrlhVfWE0bShtvDvgB1/zw/CCj0d8er+EnSNVxGmaHqrHWhUAlyiNc4rBvalLKz30Qb
         OGsHefqRNS2KTxPjpaAVoJMtL6hADk7eG4ZTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wekNHqIxrVlz8U/v5ZYQ5Av1yTsUCmfVrKprauQpISo=;
        b=GV+eXkiamj6j7VGTPm+5uEIYugwL2Up6jnDd4R/7MTuLDiK+I7bGDsmJrR3o0s4Ere
         yqZidTlS+mTD2C2sT6htf6Eo2Qjlh2w1yMkQR4ZoG5Z9n74DL1F3ggJ0LTsv7RgZRPts
         dJM71HzuTbDluul5Cc6fvn2op60hcFh+fkgOtmSELqFxrrU9Vzo0ajW4e+iuafP1o61S
         mSS++R0tme2Tfb+J40P/kfmOHW5Mii+xEbMDGRm28FgrW5rp/3i+uX0TPEhosTq7M8IW
         ASD6ut72FWydBU4K4pj1J5tXVlNtABW6Ya7U+l32yHcL2JbmKwOoCT8OD3piadTKF9/I
         DYrg==
X-Gm-Message-State: AOAM533d9njhB6YkWAm92NLjFrJGY4cBeT1e3hcagw9X772/fspnFcqQ
        MHKPqntqUpjx66kACSv48xaOqw==
X-Google-Smtp-Source: ABdhPJwG9/Si8KnP2KY9m7DfM2n3R/TuV3JbvQ5TY00+UkgxAs7ibh3zMQzaH67Hh/qxgs27c0hfCg==
X-Received: by 2002:a17:90a:6549:: with SMTP id f9mr677628pjs.17.1612469949403;
        Thu, 04 Feb 2021 12:19:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y21sm6998730pfp.208.2021.02.04.12.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:19:08 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:19:07 -0800
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v19 08/25] x86/mm: Introduce _PAGE_COW
Message-ID: <202102041215.B54FCA552F@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-9-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-9-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:30PM -0800, Yu-cheng Yu wrote:
> There is essentially no room left in the x86 hardware PTEs on some OSes
> (not Linux).  That left the hardware architects looking for a way to
> represent a new memory type (shadow stack) within the existing bits.
> They chose to repurpose a lightly-used state: Write=0, Dirty=1.
> 
> The reason it's lightly used is that Dirty=1 is normally set by hardware
> and cannot normally be set by hardware on a Write=0 PTE.  Software must
> normally be involved to create one of these PTEs, so software can simply
> opt to not create them.
> 
> In places where Linux normally creates Write=0, Dirty=1, it can use the
> software-defined _PAGE_COW in place of the hardware _PAGE_DIRTY.  In other
> words, whenever Linux needs to create Write=0, Dirty=1, it instead creates
> Write=0, Cow=1, except for shadow stack, which is Write=0, Dirty=1.  This
> clearly separates shadow stack from other data, and results in the
> following:
> 
> (a) A modified, copy-on-write (COW) page: (Write=0, Cow=1)
> (b) A R/O page that has been COW'ed: (Write=0, Cow=1)
>     The user page is in a R/O VMA, and get_user_pages() needs a writable
>     copy.  The page fault handler creates a copy of the page and sets
>     the new copy's PTE as Write=0 and Cow=1.
> (c) A shadow stack PTE: (Write=0, Dirty=1)
> (d) A shared shadow stack PTE: (Write=0, Cow=1)
>     When a shadow stack page is being shared among processes (this happens
>     at fork()), its PTE is made Dirty=0, so the next shadow stack access
>     causes a fault, and the page is duplicated and Dirty=1 is set again.
>     This is the COW equivalent for shadow stack pages, even though it's
>     copy-on-access rather than copy-on-write.
> (e) A page where the processor observed a Write=1 PTE, started a write, set
>     Dirty=1, but then observed a Write=0 PTE.  That's possible today, but
>     will not happen on processors that support shadow stack.

What happens for "e" with/without CET? It sounds like direct writes to
such pages will be (correctly) rejected by the MMU?

> 
> Define _PAGE_COW and update pte_*() helpers and apply the same changes to
> pmd and pud.
> 
> After this, there are six free bits left in the 64-bit PTE, and no more
> free bits in the 32-bit PTE (except for PAE) and Shadow Stack is not
> implemented for the 32-bit kernel.

Are there selftests to validate this change?

I think it might be useful to more clearly describe what is considered
"dirty" and "writeable" in comments above the pte_helpers.

-Kees

> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/pgtable.h       | 125 ++++++++++++++++++++++++---
>  arch/x86/include/asm/pgtable_types.h |  42 ++++++++-
>  2 files changed, 154 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index a02c67291cfc..4b0ec61510dc 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -121,9 +121,9 @@ extern pmdval_t early_pmd_flags;
>   * The following only work if pte_present() is true.
>   * Undefined behaviour if not..
>   */
> -static inline int pte_dirty(pte_t pte)
> +static inline bool pte_dirty(pte_t pte)
>  {
> -	return pte_flags(pte) & _PAGE_DIRTY;
> +	return pte_flags(pte) & _PAGE_DIRTY_BITS;
>  }
>  
>  
> @@ -160,9 +160,9 @@ static inline int pte_young(pte_t pte)
>  	return pte_flags(pte) & _PAGE_ACCESSED;
>  }
>  
> -static inline int pmd_dirty(pmd_t pmd)
> +static inline bool pmd_dirty(pmd_t pmd)
>  {
> -	return pmd_flags(pmd) & _PAGE_DIRTY;
> +	return pmd_flags(pmd) & _PAGE_DIRTY_BITS;
>  }
>  
>  static inline int pmd_young(pmd_t pmd)
> @@ -170,9 +170,9 @@ static inline int pmd_young(pmd_t pmd)
>  	return pmd_flags(pmd) & _PAGE_ACCESSED;
>  }
>  
> -static inline int pud_dirty(pud_t pud)
> +static inline bool pud_dirty(pud_t pud)
>  {
> -	return pud_flags(pud) & _PAGE_DIRTY;
> +	return pud_flags(pud) & _PAGE_DIRTY_BITS;
>  }
>  
>  static inline int pud_young(pud_t pud)
> @@ -182,7 +182,14 @@ static inline int pud_young(pud_t pud)
>  
>  static inline int pte_write(pte_t pte)
>  {
> -	return pte_flags(pte) & _PAGE_RW;
> +	/*
> +	 * If _PAGE_DIRTY is set, the PTE must either have _PAGE_RW or be
> +	 * a shadow stack PTE, which is logically writable.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK))
> +		return pte_flags(pte) & (_PAGE_RW | _PAGE_DIRTY);
> +	else
> +		return pte_flags(pte) & _PAGE_RW;
>  }
>  
>  static inline int pte_huge(pte_t pte)
> @@ -333,7 +340,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
>  
>  static inline pte_t pte_mkclean(pte_t pte)
>  {
> -	return pte_clear_flags(pte, _PAGE_DIRTY);
> +	return pte_clear_flags(pte, _PAGE_DIRTY_BITS);
>  }
>  
>  static inline pte_t pte_mkold(pte_t pte)
> @@ -343,6 +350,18 @@ static inline pte_t pte_mkold(pte_t pte)
>  
>  static inline pte_t pte_wrprotect(pte_t pte)
>  {
> +	/*
> +	 * Blindly clearing _PAGE_RW might accidentally create
> +	 * a shadow stack PTE (RW=0, Dirty=1).  Move the hardware
> +	 * dirty value to the software bit.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		if (pte_flags(pte) & _PAGE_DIRTY) {
> +			pte = pte_clear_flags(pte, _PAGE_DIRTY);
> +			pte = pte_set_flags(pte, _PAGE_COW);
> +		}
> +	}
> +
>  	return pte_clear_flags(pte, _PAGE_RW);
>  }
>  
> @@ -353,6 +372,18 @@ static inline pte_t pte_mkexec(pte_t pte)
>  
>  static inline pte_t pte_mkdirty(pte_t pte)
>  {
> +	pteval_t dirty = _PAGE_DIRTY;
> +
> +	/* Avoid creating (HW)Dirty=1, Write=0 PTEs */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !pte_write(pte))
> +		dirty = _PAGE_COW;
> +
> +	return pte_set_flags(pte, dirty | _PAGE_SOFT_DIRTY);
> +}
> +
> +static inline pte_t pte_mkwrite_shstk(pte_t pte)
> +{
> +	pte = pte_clear_flags(pte, _PAGE_COW);
>  	return pte_set_flags(pte, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
>  }
>  
> @@ -363,6 +394,13 @@ static inline pte_t pte_mkyoung(pte_t pte)
>  
>  static inline pte_t pte_mkwrite(pte_t pte)
>  {
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		if (pte_flags(pte) & _PAGE_COW) {
> +			pte = pte_clear_flags(pte, _PAGE_COW);
> +			pte = pte_set_flags(pte, _PAGE_DIRTY);
> +		}
> +	}
> +
>  	return pte_set_flags(pte, _PAGE_RW);
>  }
>  
> @@ -434,16 +472,40 @@ static inline pmd_t pmd_mkold(pmd_t pmd)
>  
>  static inline pmd_t pmd_mkclean(pmd_t pmd)
>  {
> -	return pmd_clear_flags(pmd, _PAGE_DIRTY);
> +	return pmd_clear_flags(pmd, _PAGE_DIRTY_BITS);
>  }
>  
>  static inline pmd_t pmd_wrprotect(pmd_t pmd)
>  {
> +	/*
> +	 * Blindly clearing _PAGE_RW might accidentally create
> +	 * a shadow stack PMD (RW=0, Dirty=1).  Move the hardware
> +	 * dirty value to the software bit.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		if (pmd_flags(pmd) & _PAGE_DIRTY) {
> +			pmd = pmd_clear_flags(pmd, _PAGE_DIRTY);
> +			pmd = pmd_set_flags(pmd, _PAGE_COW);
> +		}
> +	}
> +
>  	return pmd_clear_flags(pmd, _PAGE_RW);
>  }
>  
>  static inline pmd_t pmd_mkdirty(pmd_t pmd)
>  {
> +	pmdval_t dirty = _PAGE_DIRTY;
> +
> +	/* Avoid creating (HW)Dirty=1, Write=0 PMDs */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !(pmd_flags(pmd) & _PAGE_RW))
> +		dirty = _PAGE_COW;
> +
> +	return pmd_set_flags(pmd, dirty | _PAGE_SOFT_DIRTY);
> +}
> +
> +static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
> +{
> +	pmd = pmd_clear_flags(pmd, _PAGE_COW);
>  	return pmd_set_flags(pmd, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
>  }
>  
> @@ -464,6 +526,13 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
>  
>  static inline pmd_t pmd_mkwrite(pmd_t pmd)
>  {
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		if (pmd_flags(pmd) & _PAGE_COW) {
> +			pmd = pmd_clear_flags(pmd, _PAGE_COW);
> +			pmd = pmd_set_flags(pmd, _PAGE_DIRTY);
> +		}
> +	}
> +
>  	return pmd_set_flags(pmd, _PAGE_RW);
>  }
>  
> @@ -488,17 +557,35 @@ static inline pud_t pud_mkold(pud_t pud)
>  
>  static inline pud_t pud_mkclean(pud_t pud)
>  {
> -	return pud_clear_flags(pud, _PAGE_DIRTY);
> +	return pud_clear_flags(pud, _PAGE_DIRTY_BITS);
>  }
>  
>  static inline pud_t pud_wrprotect(pud_t pud)
>  {
> +	/*
> +	 * Blindly clearing _PAGE_RW might accidentally create
> +	 * a shadow stack PUD (RW=0, Dirty=1).  Move the hardware
> +	 * dirty value to the software bit.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		if (pud_flags(pud) & _PAGE_DIRTY) {
> +			pud = pud_clear_flags(pud, _PAGE_DIRTY);
> +			pud = pud_set_flags(pud, _PAGE_COW);
> +		}
> +	}
> +
>  	return pud_clear_flags(pud, _PAGE_RW);
>  }
>  
>  static inline pud_t pud_mkdirty(pud_t pud)
>  {
> -	return pud_set_flags(pud, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
> +	pudval_t dirty = _PAGE_DIRTY;
> +
> +	/* Avoid creating (HW)Dirty=1, Write=0 PUDs */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !(pud_flags(pud) & _PAGE_RW))
> +		dirty = _PAGE_COW;
> +
> +	return pud_set_flags(pud, dirty | _PAGE_SOFT_DIRTY);
>  }
>  
>  static inline pud_t pud_mkdevmap(pud_t pud)
> @@ -518,6 +605,13 @@ static inline pud_t pud_mkyoung(pud_t pud)
>  
>  static inline pud_t pud_mkwrite(pud_t pud)
>  {
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		if (pud_flags(pud) & _PAGE_COW) {
> +			pud = pud_clear_flags(pud, _PAGE_COW);
> +			pud = pud_set_flags(pud, _PAGE_DIRTY);
> +		}
> +	}
> +
>  	return pud_set_flags(pud, _PAGE_RW);
>  }
>  
> @@ -1131,7 +1225,14 @@ extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
>  #define pmd_write pmd_write
>  static inline int pmd_write(pmd_t pmd)
>  {
> -	return pmd_flags(pmd) & _PAGE_RW;
> +	/*
> +	 * If _PAGE_DIRTY is set, then the PMD must either have _PAGE_RW or
> +	 * be a shadow stack PMD, which is logically writable.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK))
> +		return pmd_flags(pmd) & (_PAGE_RW | _PAGE_DIRTY);
> +	else
> +		return pmd_flags(pmd) & _PAGE_RW;
>  }
>  
>  #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index b8b79d618bbc..437d7ff0ae80 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -23,7 +23,8 @@
>  #define _PAGE_BIT_SOFTW2	10	/* " */
>  #define _PAGE_BIT_SOFTW3	11	/* " */
>  #define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */
> -#define _PAGE_BIT_SOFTW4	58	/* available for programmer */
> +#define _PAGE_BIT_SOFTW4	57	/* available for programmer */
> +#define _PAGE_BIT_SOFTW5	58	/* available for programmer */
>  #define _PAGE_BIT_PKEY_BIT0	59	/* Protection Keys, bit 1/4 */
>  #define _PAGE_BIT_PKEY_BIT1	60	/* Protection Keys, bit 2/4 */
>  #define _PAGE_BIT_PKEY_BIT2	61	/* Protection Keys, bit 3/4 */
> @@ -36,6 +37,15 @@
>  #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
>  #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
>  
> +/*
> + * Indicates a copy-on-write page.
> + */
> +#ifdef CONFIG_X86_CET
> +#define _PAGE_BIT_COW		_PAGE_BIT_SOFTW5 /* copy-on-write */
> +#else
> +#define _PAGE_BIT_COW		0
> +#endif
> +
>  /* If _PAGE_BIT_PRESENT is clear, we use these: */
>  /* - if the user mapped it with PROT_NONE; pte_present gives true */
>  #define _PAGE_BIT_PROTNONE	_PAGE_BIT_GLOBAL
> @@ -117,6 +127,36 @@
>  #define _PAGE_DEVMAP	(_AT(pteval_t, 0))
>  #endif
>  
> +/*
> + * The hardware requires shadow stack to be read-only and Dirty.
> + * _PAGE_COW is a software-only bit used to separate copy-on-write PTEs
> + * from shadow stack PTEs:
> + * (a) A modified, copy-on-write (COW) page: (Write=0, Cow=1)
> + * (b) A R/O page that has been COW'ed: (Write=0, Cow=1)
> + *     The user page is in a R/O VMA, and get_user_pages() needs a
> + *     writable copy.  The page fault handler creates a copy of the page
> + *     and sets the new copy's PTE as Write=0, Cow=1.
> + * (c) A shadow stack PTE: (Write=0, Dirty=1)
> + * (d) A shared (copy-on-access) shadow stack PTE: (Write=0, Cow=1)
> + *     When a shadow stack page is being shared among processes (this
> + *     happens at fork()), its PTE is cleared of _PAGE_DIRTY, so the next
> + *     shadow stack access causes a fault, and the page is duplicated and
> + *     _PAGE_DIRTY is set again.  This is the COW equivalent for shadow
> + *     stack pages, even though it's copy-on-access rather than
> + *     copy-on-write.
> + * (e) A page where the processor observed a Write=1 PTE, started a write,
> + *     set Dirty=1, but then observed a Write=0 PTE (changed by another
> + *     thread).  That's possible today, but will not happen on processors
> + *     that support shadow stack.
> + */
> +#ifdef CONFIG_X86_CET
> +#define _PAGE_COW	(_AT(pteval_t, 1) << _PAGE_BIT_COW)
> +#else
> +#define _PAGE_COW	(_AT(pteval_t, 0))
> +#endif
> +
> +#define _PAGE_DIRTY_BITS (_PAGE_DIRTY | _PAGE_COW)
> +
>  #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
>  
>  /*
> -- 
> 2.21.0
> 

-- 
Kees Cook
