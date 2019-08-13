Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A11A8C495
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2019 01:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfHMXCZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 19:02:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:63294 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfHMXCY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 19:02:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 16:02:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="260271269"
Received: from ray.jf.intel.com (HELO [10.7.201.140]) ([10.7.201.140])
  by orsmga001.jf.intel.com with ESMTP; 13 Aug 2019 16:02:22 -0700
Subject: Re: [PATCH v8 11/27] x86/mm: Introduce _PAGE_DIRTY_SW
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Dave Martin <Dave.Martin@arm.com>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
 <20190813205225.12032-12-yu-cheng.yu@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
Message-ID: <dac2d62b-9045-4767-87dd-eac12e7abafd@intel.com>
Date:   Tue, 13 Aug 2019 16:02:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813205225.12032-12-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +#if defined(CONFIG_X86_INTEL_SHADOW_STACK_USER)
> +static inline pte_t pte_move_flags(pte_t pte, pteval_t from, pteval_t to)
> +{
> +	if (pte_flags(pte) & from)
> +		pte = pte_set_flags(pte_clear_flags(pte, from), to);
> +	return pte;

Why is this conditional on the compile option and not a runtime check?

> +}
> +#else
> +static inline pte_t pte_move_flags(pte_t pte, pteval_t from, pteval_t to)
> +{
> +	return pte;
> +}
> +#endif

Why do we need this function?  It's not mentioned in the changelog or
commented.

>  static inline pte_t pte_mkclean(pte_t pte)
>  {
> -	return pte_clear_flags(pte, _PAGE_DIRTY);
> +	return pte_clear_flags(pte, _PAGE_DIRTY_BITS);
>  }
>  
>  static inline pte_t pte_mkold(pte_t pte)
> @@ -322,6 +336,7 @@ static inline pte_t pte_mkold(pte_t pte)
>  
>  static inline pte_t pte_wrprotect(pte_t pte)
>  {
> +	pte = pte_move_flags(pte, _PAGE_DIRTY_HW, _PAGE_DIRTY_SW);
>  	return pte_clear_flags(pte, _PAGE_RW);
>  }

Please comment what this is doing and why.

> @@ -332,9 +347,24 @@ static inline pte_t pte_mkexec(pte_t pte)
>  
>  static inline pte_t pte_mkdirty(pte_t pte)
>  {
> +	pteval_t dirty = (!IS_ENABLED(CONFIG_X86_INTEL_SHADOW_STACK_USER) ||
> +			   pte_write(pte)) ? _PAGE_DIRTY_HW:_PAGE_DIRTY_SW;

This is *really* hard for me to read and parse.  How about:

	pte_t dirty = _PAGE_DIRTY_HW;

	/*
	 * When Shadow Stacks are enabled, read-only PTEs can
	 * not have the hardware dirty bit set and must use
	 * the software bit.
	 */
	if (IS_ENABLED(CONFIG_X86_INTEL_SHADOW_STACK_USER) &&
	    !pte_write(pte))
		dirty = _PAGE_DIRTY_SW;


> +	return pte_set_flags(pte, dirty | _PAGE_SOFT_DIRTY);
> +}
> +
> +#ifdef CONFIG_ARCH_HAS_SHSTK
> +static inline pte_t pte_mkdirty_shstk(pte_t pte)
> +{
> +	pte = pte_clear_flags(pte, _PAGE_DIRTY_SW);
>  	return pte_set_flags(pte, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
>  }

Why does the _PAGE_DIRTY_SW *HAVE* to be cleared on shstk pages?

> +static inline bool pte_dirty_hw(pte_t pte)
> +{
> +	return pte_flags(pte) & _PAGE_DIRTY_HW;
> +}
> +#endif

Why are these #ifdef'd?

>  static inline pte_t pte_mkyoung(pte_t pte)
>  {
>  	return pte_set_flags(pte, _PAGE_ACCESSED);
> @@ -342,6 +372,7 @@ static inline pte_t pte_mkyoung(pte_t pte)
>  
>  static inline pte_t pte_mkwrite(pte_t pte)
>  {
> +	pte = pte_move_flags(pte, _PAGE_DIRTY_SW, _PAGE_DIRTY_HW);
>  	return pte_set_flags(pte, _PAGE_RW);
>  }

It also isn't clear to me why this *must* move bits here.  Its doubly
unclear why you would need to do this on systems when shadow stacks are
compiled in but disabled.

<snip>

Same comments for pmds and puds.

> -
>  /* mprotect needs to preserve PAT bits when updating vm_page_prot */
>  #define pgprot_modify pgprot_modify
>  static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
> @@ -1178,6 +1254,19 @@ static inline int pmd_write(pmd_t pmd)
>  	return pmd_flags(pmd) & _PAGE_RW;
>  }
>  
> +static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
> +{
> +	pmdval_t val = pmd_val(pmd), oldval = val;
> +
> +	val &= _HPAGE_CHG_MASK;
> +	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
> +	val = flip_protnone_guard(oldval, val, PHYSICAL_PMD_PAGE_MASK);
> +	if ((pmd_write(pmd) && !(pgprot_val(newprot) & _PAGE_RW)))
> +		return pmd_move_flags(__pmd(val), _PAGE_DIRTY_HW,
> +				      _PAGE_DIRTY_SW);
> +	return __pmd(val);
> +}

Why was this function moved?  This makes it really hard to review what
you changed

I'm going to stop reading this code now.  It needs a lot more care and
feeding to make it reviewable.  Please go back, double-check your
changelogs and flesh them out, then please try to make the code more
readable and understandable by commenting it.

Please take all of the compile-time checks and ask yourself whether they
need to be or *can* be runtime checks.  Consider what the overhead is of
non-shadowstack systems running shadowstack-required code.

Please also reconcile the supervisor XSAVE portion of your patches with
the ones that Fenghua has been sending around.  I've given quite a bit
of feedback to improve those.  Please consolidate and agree on a common
set of patches with him.
