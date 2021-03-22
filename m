Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29AC343E9C
	for <lists+linux-arch@lfdr.de>; Mon, 22 Mar 2021 11:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhCVK5c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Mar 2021 06:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhCVK5Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Mar 2021 06:57:24 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97517C061762
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 03:57:23 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id o126so11033190lfa.0
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cVr1sX6u9OvOpr4j5MVGPdeMSVsRDw26Oh3Yu5epGx0=;
        b=ow55ypOvBq7E09U12yfhRBcRicdeKkGdFg8cXxMbuaLfv5/KuKTp6sw6xiZAyAaqd8
         Jo7YZ+mzz7iPBNJWzffewsliAV9XY1EnmLgyyNRkIrXWlOz0d1z/iXI5POBSPu83hNEu
         mgVBs2wOYrssur4t2FpRZKnaiLpCNaI9drlSZlPZcN+k7muGp7jIe/qx4n07o/qMR3bs
         uj2fpJ6vHTvAJYOHwOK7yM+q56Ifz89dKALXekBVxkV74irPrXhpe6mXkAP3yfSpmtbD
         1Fbw8b3Khqu4HNPVGB14/JbGLb6gneHV4LZEm+qiRgD7stgdaeqg1p4D/+Cvp6abiVWC
         D8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cVr1sX6u9OvOpr4j5MVGPdeMSVsRDw26Oh3Yu5epGx0=;
        b=D8jck3A2/GdaMvixWzBMOZt6Nxc++0FCR9qxilOAXmqpboNbqCM4qUHaeSxsM1mrJj
         lIilD1lrMc2fNfJ4V8v5aMUyBavXINxGZ6UoWL7I7mzzRmkaFrLySfd7N6zaufwQMMnc
         6CoTVsOG1PlF/xdUzupf/o0is5aJGQam+aRA3riqBlXK8kpVFm56N59wXl71fNTevs6O
         8VDf6Ql9TRoANFeEAU5bUodCuF6iFvACDmp92ecwui6uZJc8jZ9TDAH2bYHXCOwKMr+n
         ROqEzACHRHL4bgA2Dwo5Y3qBds92ltj7irZHF46UWUWzUYePrB9jW4p/5hyntMGx5qU/
         bKnA==
X-Gm-Message-State: AOAM531y0pbtNDaXUj1oYdf8blJMJsKUYiSVQIbly8qyMilxHDYgpNY7
        FkgDvIPjINc6yFAkv5W2Iz5OHg==
X-Google-Smtp-Source: ABdhPJzmQMsz7WtlL2kKU9WbwE31eqU1Nt4u/UUp1SHPGJjOfkOYnfU7tZTIeNg6TnAa9jMh5ZQnYQ==
X-Received: by 2002:ac2:5974:: with SMTP id h20mr8866285lfp.554.1616410642003;
        Mon, 22 Mar 2021 03:57:22 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n5sm1539209lfh.173.2021.03.22.03.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:57:21 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 19A76101DEB; Mon, 22 Mar 2021 13:57:29 +0300 (+03)
Date:   Mon, 22 Mar 2021 13:57:29 +0300
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
Subject: Re: [PATCH v23 18/28] mm/mmap: Add shadow stack pages to memory
 accounting
Message-ID: <20210322105729.24rt4nwc3blipxsr@box>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-19-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316151054.5405-19-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 08:10:44AM -0700, Yu-cheng Yu wrote:
> Account shadow stack pages to stack memory.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/mm/pgtable.c   |  7 +++++++
>  include/linux/pgtable.h | 11 +++++++++++
>  mm/mmap.c               |  5 +++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 0f4fbf51a9fc..948d28c29964 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -895,3 +895,10 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>  
>  #endif /* CONFIG_X86_64 */
>  #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
> +
> +#ifdef CONFIG_ARCH_HAS_SHADOW_STACK
> +bool arch_shadow_stack_mapping(vm_flags_t vm_flags)
> +{
> +	return (vm_flags & VM_SHSTK);
> +}
> +#endif
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index cbd98484c4f1..487c08df4365 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1470,6 +1470,17 @@ static inline pmd_t arch_maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma
>  #endif /* CONFIG_ARCH_MAYBE_MKWRITE */
>  #endif /* CONFIG_MMU */
>  
> +#ifdef CONFIG_MMU
> +#ifdef CONFIG_ARCH_HAS_SHADOW_STACK
> +bool arch_shadow_stack_mapping(vm_flags_t vm_flags);
> +#else
> +static inline bool arch_shadow_stack_mapping(vm_flags_t vm_flags)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_ARCH_HAS_SHADOW_STACK */
> +#endif /* CONFIG_MMU */
> +
>  /*
>   * Architecture PAGE_KERNEL_* fallbacks
>   *
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 3f287599a7a3..2ac67882ace2 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1718,6 +1718,9 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
>  	if (file && is_file_hugepages(file))
>  		return 0;
>  
> +	if (arch_shadow_stack_mapping(vm_flags))
> +		return 1;
> +

What's wrong with testing (vm_flags & VM_SHSTK) here? VM_SHSTK is 0 on
non-x86.

>  	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
>  }
>  
> @@ -3387,6 +3390,8 @@ void vm_stat_account(struct mm_struct *mm, vm_flags_t flags, long npages)
>  		mm->stack_vm += npages;
>  	else if (is_data_mapping(flags))
>  		mm->data_vm += npages;
> +	else if (arch_shadow_stack_mapping(flags))
> +		mm->stack_vm += npages;

Ditto.

>  }
>  
>  static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
> -- 
> 2.21.0
> 

-- 
 Kirill A. Shutemov
