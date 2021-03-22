Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA03343D96
	for <lists+linux-arch@lfdr.de>; Mon, 22 Mar 2021 11:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCVKPI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Mar 2021 06:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhCVKO5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Mar 2021 06:14:57 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059CFC061762
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 03:14:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g8so13214857lfv.12
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rVYaAi1eY1kPyS3/JwBek8GPGY1ptAf+8QB+EHmsqAU=;
        b=0xAxeaYtjCj0z4GR/m+iCT1B87INTUY//rqJ+VAahUIwsVg8ZAvYyLV/C73kwEny9I
         5bmP+Ze/gAocr73JJ11cXkYyXb0/Gf3Zd+r4R3eA58TMDA1eiMWU+rMh1/olatKyJLjo
         4QKYJ/75INlA0ttbJG3z39uP+Gil0Esyvd0LSgK5Tvb012/4yqglr2y7lQCQCcZcuLcr
         HPKJqoA+/yI/PbJGB9nlNL9opAR7qW1DeNwoWJ9I18hjVB4+THSiBNsRwIPj7IuDMhNl
         fGocd8edYDD+GUhQKbrV1adoAPW9vMeyJWE2vDTyiWsTDO41apCkiT/tXVhgWd0t5/6t
         VLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rVYaAi1eY1kPyS3/JwBek8GPGY1ptAf+8QB+EHmsqAU=;
        b=TsfP0rRhUgY/5+u568GhpbcMLkGp6xeNp5Zn2+xkKIBcofzHk1dMbQLQqgweQQPpil
         4J0yq5D6fnKFBtaGOQiH3BtJEmK8TxOPRlfrnrucOwkLvhAKXDjmhZb/vrofIxwSOc6U
         ecrcqAyrhZET6tG7Gvt2judMhNpmJw6wxHGIafiZTGdFrdjPP61HNlcYd6SC6vjDwJNc
         pGFX5bZf80Pm4GkNMArJOxLRiSE9ualUAd056UdsgQNfYSrUbS6egSQhs0WlDpypeff+
         nTzFxsN28QlQDw7UGVRg0h2WSQNBoHlQneWf1Shszd6T/g7W8xlcD6ge/zDYqoIx7sgd
         RavQ==
X-Gm-Message-State: AOAM533bvSGbnBzmuvWIMXIewoHzhvh/+zmJB2lFITWNqCq/hBQWYK+s
        WNUgDZaJ5xuUWGNdtUxg793s9g==
X-Google-Smtp-Source: ABdhPJxKaAEo8nt6OXdUuX61A1wui+fxNSys6+2rWR6UBxN18woKeXmAqW98QKT5Ba+bYjAcU7cKIw==
X-Received: by 2002:a05:6512:348c:: with SMTP id v12mr8454102lfr.271.1616408095388;
        Mon, 22 Mar 2021 03:14:55 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z10sm1523041lfe.114.2021.03.22.03.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:14:54 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 23BA8101DEB; Mon, 22 Mar 2021 13:15:02 +0300 (+03)
Date:   Mon, 22 Mar 2021 13:15:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v23 12/28] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Message-ID: <20210322101502.b5hdy3qgyh6hf3sr@box>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-13-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316151054.5405-13-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 08:10:38AM -0700, Yu-cheng Yu wrote:
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
> ---
>  arch/x86/include/asm/pgtable.h | 36 ++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index e1739f590ca6..46d9394b884f 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1306,6 +1306,24 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
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

I think this is wrong. You need to update old_pte on every loop iteration,
otherwise you can get in to endless loop.

The same issue for pmdp_set_wrprotect().

> +
> +		return;
> +	}
>  	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
>  }
>  
> @@ -1350,6 +1368,24 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
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
 Kirill A. Shutemov
