Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A1135A207
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 17:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhDIPcF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 11:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhDIPcE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2021 11:32:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326AEC061762
        for <linux-arch@vger.kernel.org>; Fri,  9 Apr 2021 08:31:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g8so10307387lfv.12
        for <linux-arch@vger.kernel.org>; Fri, 09 Apr 2021 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N/anldwvTE8JiwYoi+CFb0zDLJgVaul+of7NRgtf6uM=;
        b=L/g+dUL3VxLisPEfWcvegwi75OSGO8+Y2ESkFHKHtdm/FJ3KwHf3WyBvNQuBQUe6rK
         gmCszXDYq7J1ZtnXhsTfuZEwEIgDDO7ZIaqqN7x8SJZ+mKkxZV0a7YD856zUPVH4rC0f
         ws0pP0X7wcOUy1pWWfUdYeSsuH0EG1b3K5SkFuD0SUcOXg3wOKJmopOi3jZqWAOVNeC7
         3eJh1iLvmnlJPS6EDZe9uoFw8pCHYnYMAzmVg/ApXr/iLJJe0F6iS3GVGKtWo2i+PYEZ
         vHuJ1D+eXoE46MtRGDezJVhqeUXXA/J/AuP4CvMG+vWWExbT8HwY/VYnAaqolfnmOInP
         Bpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N/anldwvTE8JiwYoi+CFb0zDLJgVaul+of7NRgtf6uM=;
        b=W6GI2LYp/Oa77C9QXoQMc4HOOUKbvZTBS6f1REe5JoYZAgJMrgQY61/PhDp462WnlM
         lpPuJe65uDNHdadOV5O50BPQGN9Os6rTTBgh67ZomgAAd9SV0P7yP6GELO56grw7BxK4
         p7IwgUrkV5Q2GoQy3VD8/Z+oURYIZuMTX+x1sadU5LfqUWYDCvv0uXSxpZihr/DCw0Ol
         c0WynKXaFE8EOQlJWZI5wpkO0RCncxBAGT4LLkcmCB+mazJXlx6aCxOTM+oOVezMtU9d
         5riV+K/90QLUhMlnExeyOicwKEeP685bYyVlxz2+nbRZzlJxHm2OS0gw6F4a5AoseeqP
         GVRA==
X-Gm-Message-State: AOAM530g6O3OPs5fp7sJAR7pR8hD2MEJ6Z2BjNi7oSIjYIxZaY/7hg2l
        VHfIVoYUa0c6rM0p7SzJegF5Og==
X-Google-Smtp-Source: ABdhPJwYX6z9aGP1PXbuviqGTBPyv46KjTBYphTybXFc7ge+WtCz+ZQSUUKUTI90Zz3uE7HXZu0jww==
X-Received: by 2002:ac2:53af:: with SMTP id j15mr3242187lfh.74.1617982307528;
        Fri, 09 Apr 2021 08:31:47 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s23sm298175lfs.246.2021.04.09.08.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:31:47 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 98ED8102498; Fri,  9 Apr 2021 18:31:46 +0300 (+03)
Date:   Fri, 9 Apr 2021 18:31:46 +0300
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
Subject: Re: [PATCH v24 19/30] mm: Update can_follow_write_pte() for shadow
 stack
Message-ID: <20210409153146.ib2xsn7n2q4ixpde@box.shutemov.name>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
 <20210401221104.31584-20-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401221104.31584-20-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 01, 2021 at 03:10:53PM -0700, Yu-cheng Yu wrote:
> Can_follow_write_pte() ensures a read-only page is COWed by checking the
> FOLL_COW flag, and uses pte_dirty() to validate the flag is still valid.
> 
> Like a writable data page, a shadow stack page is writable, and becomes
> read-only during copy-on-write, but it is always dirty.  Thus, in the
> can_follow_write_pte() check, it belongs to the writable page case and
> should be excluded from the read-only page pte_dirty() check.  Apply
> the same changes to can_follow_write_pmd().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
> v24:
> - Change arch_shadow_stack_mapping() to is_shadow_stack_mapping().
> 
>  mm/gup.c         | 8 +++++---
>  mm/huge_memory.c | 8 +++++---
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index e40579624f10..c313cc988865 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -356,10 +356,12 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
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
> +				  !is_shadow_stack_mapping(vma->vm_flags));

It's getting too ugly. I think it deserve to be rewritten. What about:

	if (pte_write(pte))
		return true;
	if ((flags & (FOLL_FORCE | FOLL_COW)) != (FOLL_FORCE | FOLL_COW))
		return false;
	if (!pte_dirty(pte))
		return false;
	if (is_shadow_stack_mapping(vma->vm_flags))
		return false;
	return true;

?

-- 
 Kirill A. Shutemov
