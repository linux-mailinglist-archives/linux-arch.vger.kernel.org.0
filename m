Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D7335A213
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 17:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhDIPeh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 11:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIPeg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2021 11:34:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DE2C061761
        for <linux-arch@vger.kernel.org>; Fri,  9 Apr 2021 08:34:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g8so10320345lfv.12
        for <linux-arch@vger.kernel.org>; Fri, 09 Apr 2021 08:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U7W2zOO2xjLYVvabtgbkl9/yC/jywr+n7bzYgDZAEXM=;
        b=GLSGHdRI9yh0cnabzROu7oCFA+D4zBD6sTCDKFyVNB6zILTCgxVqS9aD3XNoIlirKn
         qBPHgUvbOuPFVfUnF4RB3dCehyGhNA81bOZ+fKoXWmU9lMDkwXyy3f14Kt6QvZbU1xQX
         DGge9k2KVhgrdaHdCVDKaGFHTG2oS7jjKw+AElJKr21l/KD2vrlTBuBIUbX4ZoInDVSY
         5qtdrQ/ZdZ8uc6JH3colccCctI58j638rVtdtTArNu3RwJ6dx51icuy5b4K5+oqzdqtq
         opppDijvJX9YbZn2n2YjfPXbKxdTwNq5oB7FKd3YWfFx7nzfb+5Q8PQF9Wnta11BxMXg
         nCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U7W2zOO2xjLYVvabtgbkl9/yC/jywr+n7bzYgDZAEXM=;
        b=BtaPl+uyBcPUxLXK+4MJEn4g6wR6tcKQTGoOBiYiabRJZJYL/AnET4U3h5jlFiZZ/K
         DcNgFshtaSLungbzKKqrGvEurFdofOV9kdKVfka5kCE1299NAe2P0qk2abybu4t+3qVy
         BUTHB8dZBOy7gMB4EghYGlmJJLgiAOn6K+cb6remwWvfqP9G1Q4B1L+rW7S/+q+zqw3l
         RLH6/oyUqrIQDDbCCmGkEb2gO/q3e267mtunPFA7Mh6X+hhwkKFGNjyJRjsAyT6r6ueY
         imsEGBEuDchnm7Bw5hEVCnrMG5CCet1/J/ntR4sRC3nEU1g13W68Wvqm5ixY7cC1zdP2
         RfdA==
X-Gm-Message-State: AOAM532l3bj/Cl2FahI4tbMSfnCLSbs8Zu/nuqL22P/Vd4v72jxxaj1w
        g2LKjw81hpCygzAt4Q3RNkmqbQ==
X-Google-Smtp-Source: ABdhPJyFm+ZMRTY3RQ+tIN+xhbECgPZpQWAhR2FzAkfeHi3To00sdzemqkeeTLDi9+YbF4tv9TmJBw==
X-Received: by 2002:a05:6512:2343:: with SMTP id p3mr10321124lfu.538.1617982461808;
        Fri, 09 Apr 2021 08:34:21 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l15sm290367ljg.66.2021.04.09.08.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:34:21 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BAAF2102498; Fri,  9 Apr 2021 18:34:20 +0300 (+03)
Date:   Fri, 9 Apr 2021 18:34:20 +0300
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
        Haitao Huang <haitao.huang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v24 20/30] mm/mprotect: Exclude shadow stack from
 preserve_write
Message-ID: <20210409153420.h6ybujbz7jyhyurb@box.shutemov.name>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
 <20210401221104.31584-21-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401221104.31584-21-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 01, 2021 at 03:10:54PM -0700, Yu-cheng Yu wrote:
> In change_pte_range(), when a PTE is changed for prot_numa, _PAGE_RW is
> preserved to avoid the additional write fault after the NUMA hinting fault.
> However, pte_write() now includes both normal writable and shadow stack
> (RW=0, Dirty=1) PTEs, but the latter does not have _PAGE_RW and has no need
> to preserve it.
> 
> Exclude shadow stack from preserve_write test, and apply the same change to
> change_huge_pmd().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
> v24:
> - Change arch_shadow_stack_mapping() to is_shadow_stack_mapping().
> 
>  mm/huge_memory.c | 7 ++++++-
>  mm/mprotect.c    | 9 ++++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 65fc0aedd577..1d41138c4f74 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1812,12 +1812,17 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
>  	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
>  	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
> +	bool shstk = is_shadow_stack_mapping(vma->vm_flags);
>  
>  	ptl = __pmd_trans_huge_lock(pmd, vma);
>  	if (!ptl)
>  		return 0;
>  
> -	preserve_write = prot_numa && pmd_write(*pmd);
> +	/*
> +	 * Preserve only normal writable huge PMD, but not shadow
> +	 * stack (RW=0, Dirty=1).
> +	 */
> +	preserve_write = prot_numa && pmd_write(*pmd) && !shstk;

New variable seems unnecessary. What about just:

	if (is_shadow_stack_mapping(vma->vm_flags))
		preserve_write = false;

?

>  	ret = 1;
>  
>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index c1ce78d688b6..550448dc5ff1 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -75,7 +75,14 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  		oldpte = *pte;
>  		if (pte_present(oldpte)) {
>  			pte_t ptent;
> -			bool preserve_write = prot_numa && pte_write(oldpte);
> +			bool shstk = is_shadow_stack_mapping(vma->vm_flags);
> +			bool preserve_write;
> +
> +			/*
> +			 * Preserve only normal writable PTE, but not shadow
> +			 * stack (RW=0, Dirty=1).
> +			 */
> +			preserve_write = prot_numa && pte_write(oldpte) && !shstk;

Ditto.

>  
>  			/*
>  			 * Avoid trapping faults against the zero or KSM
> -- 
> 2.21.0
> 
> 

-- 
 Kirill A. Shutemov
