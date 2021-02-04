Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04B430FE96
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 21:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbhBDUhj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 15:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240108AbhBDU2Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 15:28:16 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A335DC0613D6
        for <linux-arch@vger.kernel.org>; Thu,  4 Feb 2021 12:27:36 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id s15so2364213plr.9
        for <linux-arch@vger.kernel.org>; Thu, 04 Feb 2021 12:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/KkzilzXEisJddaLgkjR4cjm+2gZx2aIAgczeuG3frI=;
        b=SQnBGiEH7SyjfxJqdii1BqfZaqzWi1I4ROQ+T9GW6ajXhOT3uDA3RK4TvfKWUbUWhy
         MIj0IL32FR9WV3RHADy1VD4Q77Q6mNKUCLqwwws+lNkcfFqSMvCOp0kEeObfoGsW907m
         zujxwsHELU1cNG7gpww149IJuWidCm5N4ZGL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/KkzilzXEisJddaLgkjR4cjm+2gZx2aIAgczeuG3frI=;
        b=OTgmqwUoObGcK0PPxzGrjeF2c8iO/shwLPMVZ31gDYD34zo+yv3RhhChlsapEZURsU
         5gpyUvh2I+pRQKzUvCW5SSWr7gNJ4p03hn23NAZeOLcVirMqck6Ckx1IUupyyRUhsgsP
         vuMlO4P3kBGoVQXxOo0g4N9boK+bRX3Iqop7Mn4Bzb+2wBmnXI2ufbJsqiYEJ1FaFs/W
         pc1CNT85ggJzuAsndjPZXy2Yj8NQj4sboCcg6GpEtxa11qKtJI1/D/PenBxVXiU0wf3c
         MZSGGIkw/kNJp687rODoJy8qFrBUPKw26OdFppVH+rF79QXAvMpVqUcLJHy98or1QCwR
         HrHQ==
X-Gm-Message-State: AOAM532V26pY+A/Ez7TDjJxYBZXFnmjf6OfBIDDv014Twu+S8BQeZ9RY
        kXsYVfHx3ut27V3opjUg5sazKw==
X-Google-Smtp-Source: ABdhPJyj8hnNU5LEzeZQ1jHOEtqoFt0d6CyhuA9vknTPXqFjOzzNcOwB9CQKOQdvjeVU2Ogq22aWeA==
X-Received: by 2002:a17:90a:c902:: with SMTP id v2mr720901pjt.144.1612470456119;
        Thu, 04 Feb 2021 12:27:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q2sm6995012pfg.190.2021.02.04.12.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:27:34 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:27:34 -0800
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
Subject: Re: [PATCH v19 18/25] mm: Update can_follow_write_pte() for shadow
 stack
Message-ID: <202102041226.D3E2B437@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-19-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-19-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:40PM -0800, Yu-cheng Yu wrote:
> Can_follow_write_pte() ensures a read-only page is COWed by checking the
> FOLL_COW flag, and uses pte_dirty() to validate the flag is still valid.
> 
> Like a writable data page, a shadow stack page is writable, and becomes
> read-only during copy-on-write, but it is always dirty.  Thus, in the
> can_follow_write_pte() check, it belongs to the writable page case and
> should be excluded from the read-only page pte_dirty() check.  Apply
> the same changes to can_follow_write_pmd().

Does this need the vma passed down? Should it just pass vm_flags? I
suppose it doesn't really matter, though.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  mm/gup.c         | 8 +++++---
>  mm/huge_memory.c | 8 +++++---
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index e4c224cd9661..66ab67626f57 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -357,10 +357,12 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
>   * FOLL_FORCE can write to even unwritable pte's, but only
>   * after we've gone through a COW cycle and they are dirty.
>   */
> -static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
> +static inline bool can_follow_write_pte(pte_t pte, unsigned int flags,
> +					struct vm_area_struct *vma)
>  {
>  	return pte_write(pte) ||
> -		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte));
> +		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte) &&
> +				  !arch_shadow_stack_mapping(vma->vm_flags));
>  }
>  
>  static struct page *follow_page_pte(struct vm_area_struct *vma,
> @@ -403,7 +405,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>  	}
>  	if ((flags & FOLL_NUMA) && pte_protnone(pte))
>  		goto no_page;
> -	if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags)) {
> +	if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags, vma)) {
>  		pte_unmap_unlock(ptep, ptl);
>  		return NULL;
>  	}
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index bfec65c9308b..eb64e2b56bc9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1337,10 +1337,12 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
>   * FOLL_FORCE can write to even unwritable pmd's, but only
>   * after we've gone through a COW cycle and they are dirty.
>   */
> -static inline bool can_follow_write_pmd(pmd_t pmd, unsigned int flags)
> +static inline bool can_follow_write_pmd(pmd_t pmd, unsigned int flags,
> +					struct vm_area_struct *vma)
>  {
>  	return pmd_write(pmd) ||
> -	       ((flags & FOLL_FORCE) && (flags & FOLL_COW) && pmd_dirty(pmd));
> +	       ((flags & FOLL_FORCE) && (flags & FOLL_COW) && pmd_dirty(pmd) &&
> +				  !arch_shadow_stack_mapping(vma->vm_flags));
>  }
>  
>  struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
> @@ -1353,7 +1355,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
>  
>  	assert_spin_locked(pmd_lockptr(mm, pmd));
>  
> -	if (flags & FOLL_WRITE && !can_follow_write_pmd(*pmd, flags))
> +	if (flags & FOLL_WRITE && !can_follow_write_pmd(*pmd, flags, vma))
>  		goto out;
>  
>  	/* Avoid dumping huge zero page */
> -- 
> 2.21.0
> 
> 

-- 
Kees Cook
