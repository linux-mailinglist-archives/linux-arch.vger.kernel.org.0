Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA9916EFF6
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 21:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbgBYUU7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 15:20:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33022 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731565AbgBYUU4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 15:20:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id n7so160998pfn.0
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 12:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ecJrZE+nb+9iK7EjMFn0xNjndpxhw1cdayIgSB3p5i8=;
        b=HA1uGf3r8tIBz9DDwSzjRJMkmRPyGd9/avhP2uEX/NxJygCGRTKk/EQ1Z5CmtdqPfO
         5hy2hidxEgUEkl5+IbfO5oQtv4SSwMKQSUkKZMfpoiu8ZjAZ/6EchH/Ejm5Yybk3Rzmq
         VVcP/8ccmwrbA1YOA7oxD7hk2BXgpQievVnGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ecJrZE+nb+9iK7EjMFn0xNjndpxhw1cdayIgSB3p5i8=;
        b=FqyZS2Qi+21CEWUR+vuPnNQ9n6ONpfrbT8IExBTnOcxGfSjUG52sHqLipHev4abICb
         +xPY77iTRUcJvoIzrFgb+cnbhtjh0O7sRG5HU6weVQukUDUj+jbUGx0dvobo8NJ6JkSW
         ZquGgbGC8/mmOYOUTGQHwoBKj4rkIoC587qrY+IvyAaDJS6K0N+7WgTbKQys8JyL4ejf
         megz99qq08LgwIldbZ9W5M1QFwsWSpM5aLLuA4uPvCA1M8Xwxz0yEcVSAOsYuXWJMIj8
         FeuGNjET3AGxeASp7rY8ICYUaNt+JgqamF2EOxosPm6Lzn2/LRw9DmbsRlsJF1CsozDK
         BaCA==
X-Gm-Message-State: APjAAAU+8zXU/pSPEmk/Z+45Xf9NU+8fwOZuMKMf8kFkJgbME/HWy98i
        4RwBGopCTNzYteh7yBFaZdjfZQ==
X-Google-Smtp-Source: APXvYqwJvfQlrirjHI6xgTtbxSOCIrU4Jtz0j81lsjqWsZzac3ADW2cwxETxU0v3Bz3oRNLDq+nsrw==
X-Received: by 2002:a65:56c4:: with SMTP id w4mr260251pgs.45.1582662054592;
        Tue, 25 Feb 2020 12:20:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i2sm3881450pjs.21.2020.02.25.12.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:20:53 -0800 (PST)
Date:   Tue, 25 Feb 2020 12:20:52 -0800
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
Subject: Re: [RFC PATCH v9 14/27] mm: Handle Shadow Stack page fault
Message-ID: <202002251218.F919026@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-15-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-15-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:22AM -0800, Yu-cheng Yu wrote:
> When a task does fork(), its Shadow Stack (SHSTK) must be duplicated for
> the child.  This patch implements a flow similar to copy-on-write of an
> anonymous page, but for SHSTK.
> 
> A SHSTK PTE must be RO and Dirty.  This Dirty bit requirement is used to
> effect the copying.  In copy_one_pte(), clear the Dirty bit from a SHSTK
> PTE to cause a page fault upon the next SHSTK access.  At that time, fix
> the PTE and copy/re-use the page.

Just to confirm, during the fork, it's really not a SHSTK for a moment
(it's still RO, but not dirty). Can other racing threads muck this up,
or is this bit removed only on the copied side?

-Kees

> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/mm/pgtable.c         | 15 +++++++++++++++
>  include/asm-generic/pgtable.h | 17 +++++++++++++++++
>  mm/memory.c                   |  7 ++++++-
>  3 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 7bd2c3a52297..2eb33794c08d 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -872,3 +872,18 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>  
>  #endif /* CONFIG_X86_64 */
>  #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
> +
> +#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> +inline bool arch_copy_pte_mapping(vm_flags_t vm_flags)
> +{
> +	return (vm_flags & VM_SHSTK);
> +}
> +
> +inline pte_t pte_set_vma_features(pte_t pte, struct vm_area_struct *vma)
> +{
> +	if (vma->vm_flags & VM_SHSTK)
> +		return pte_mkdirty_shstk(pte);
> +	else
> +		return pte;
> +}
> +#endif /* CONFIG_X86_INTEL_SHADOW_STACK_USER */
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index 798ea36a0549..9cb2f9ba5895 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -1190,6 +1190,23 @@ static inline bool arch_has_pfn_modify_check(void)
>  }
>  #endif /* !_HAVE_ARCH_PFN_MODIFY_ALLOWED */
>  
> +#ifdef CONFIG_MMU
> +#ifndef CONFIG_ARCH_HAS_SHSTK
> +static inline bool arch_copy_pte_mapping(vm_flags_t vm_flags)
> +{
> +	return false;
> +}
> +
> +static inline pte_t pte_set_vma_features(pte_t pte, struct vm_area_struct *vma)
> +{
> +	return pte;
> +}
> +#else
> +bool arch_copy_pte_mapping(vm_flags_t vm_flags);
> +pte_t pte_set_vma_features(pte_t pte, struct vm_area_struct *vma);
> +#endif
> +#endif /* CONFIG_MMU */
> +
>  /*
>   * Architecture PAGE_KERNEL_* fallbacks
>   *
> diff --git a/mm/memory.c b/mm/memory.c
> index 45442d9a4f52..6daa28614327 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -772,7 +772,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  	 * If it's a COW mapping, write protect it both
>  	 * in the parent and the child
>  	 */
> -	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
> +	if ((is_cow_mapping(vm_flags) && pte_write(pte)) ||
> +	    arch_copy_pte_mapping(vm_flags)) {
>  		ptep_set_wrprotect(src_mm, addr, src_pte);
>  		pte = pte_wrprotect(pte);
>  	}
> @@ -2417,6 +2418,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
>  	flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
>  	entry = pte_mkyoung(vmf->orig_pte);
>  	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> +	entry = pte_set_vma_features(entry, vma);
>  	if (ptep_set_access_flags(vma, vmf->address, vmf->pte, entry, 1))
>  		update_mmu_cache(vma, vmf->address, vmf->pte);
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
> @@ -2504,6 +2506,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
>  		entry = mk_pte(new_page, vma->vm_page_prot);
>  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> +		entry = pte_set_vma_features(entry, vma);
>  		/*
>  		 * Clear the pte entry and flush it first, before updating the
>  		 * pte with the new entry. This will avoid a race condition
> @@ -3023,6 +3026,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	pte = mk_pte(page, vma->vm_page_prot);
>  	if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page, NULL)) {
>  		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
> +		pte = pte_set_vma_features(pte, vma);
>  		vmf->flags &= ~FAULT_FLAG_WRITE;
>  		ret |= VM_FAULT_WRITE;
>  		exclusive = RMAP_EXCLUSIVE;
> @@ -3165,6 +3169,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	entry = mk_pte(page, vma->vm_page_prot);
>  	if (vma->vm_flags & VM_WRITE)
>  		entry = pte_mkwrite(pte_mkdirty(entry));
> +	entry = pte_set_vma_features(entry, vma);
>  
>  	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>  			&vmf->ptl);
> -- 
> 2.21.0
> 
> 

-- 
Kees Cook
