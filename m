Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2F9369037
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 12:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhDWKUE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 06:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhDWKUD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2021 06:20:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB49C061574
        for <linux-arch@vger.kernel.org>; Fri, 23 Apr 2021 03:19:25 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y4so36542294lfl.10
        for <linux-arch@vger.kernel.org>; Fri, 23 Apr 2021 03:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DfoarHN8kwAUXeJoV8igp0IS84dt9ibxv9mR8xJU6Xk=;
        b=N4gxmLjoyMwwBm8WYEh44Z64BgAVbj41cZbOESofj5OkvI9ZZNkBsWbN2EDbevRvIy
         SBclkE6NrLyeXaXxoCG7xRpEGTV3F80TvvhzcXx5GYtgOE3GRgNbTSOJQQJMQrGPLFQ3
         7z+kyYkp8wabzPudml5JER5PLLJ9mZgoWXVDHULOcuxarasrGsceUwAPveDoNeShbunk
         WJO2YCDV3yZsQW0JoI9rNLcNuj877vaZ1qYvbVFsjhJDVB3AaNSzJn5zQYlZEQtxI6u0
         uiMmSH80CAutXLRmfstPIss9Ukeru9YM3KuREfO3YgCNPokRpPmsUamLXSPupKY38QlE
         e2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DfoarHN8kwAUXeJoV8igp0IS84dt9ibxv9mR8xJU6Xk=;
        b=PqlJMZS2XEOXoDOXcwqmzAVFfeomQuT6djZbmADI/oiaobJjE0xJypfjNCWILIPVsc
         no+A5Av9KuqrDgffiN+r8+yQMVdsaJCPDtNEadaqS+yc4+cvUNjYVyuOp/0uwKJleK3u
         YHn1TzA3j1sy67+rTy0dsrI05/0USXsWAG8dBQGI/SPdZs8Yws+s8gfjVtBO2cPxU4nh
         WjJ3F543A/Jn9ridLUsiT51pya0kAt1mDH/oySWGmkbNd/QlRFEzbF2W3gV3acpsYHeC
         QwpmLwknQdRG+FSZ6Nq2BqXDM01JU6tykTvWQbsURzEG52l6WvM0LHIbBLUGIpCrqNVB
         N58g==
X-Gm-Message-State: AOAM531a7hqRSopevvsLty42N2mMfIWtG4HZDgwioS5H1gluGUaqKhDy
        mqth7r2uSIWiEgOwM7cSC0IQMw==
X-Google-Smtp-Source: ABdhPJy+j0A4mCMCy6alk/6PYASiRWqO6EYd0pBeEvxN9kQ+2U6i0rK8HvK+JgE0lqpTegscpzOeVA==
X-Received: by 2002:a19:f615:: with SMTP id x21mr2374637lfe.540.1619173164189;
        Fri, 23 Apr 2021 03:19:24 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c15sm509104lfk.153.2021.04.23.03.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 03:19:23 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3260D10257F; Fri, 23 Apr 2021 13:19:25 +0300 (+03)
Date:   Fri, 23 Apr 2021 13:19:25 +0300
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
Subject: Re: [PATCH v25 18/30] mm/mmap: Add shadow stack pages to memory
 accounting
Message-ID: <20210423101925.u5srn6vpyxxgvpso@box.shutemov.name>
References: <20210415221419.31835-1-yu-cheng.yu@intel.com>
 <20210415221419.31835-19-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415221419.31835-19-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 15, 2021 at 03:14:07PM -0700, Yu-cheng Yu wrote:
> Account shadow stack pages to stack memory.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
> v25:
> - Remove #ifdef CONFIG_ARCH_HAS_SHADOW_STACK for is_shadow_stack_mapping().
> v24:
> - Change arch_shadow_stack_mapping() to is_shadow_stack_mapping().
> - Change VM_SHSTK to VM_SHADOW_STACK.
> 
>  arch/x86/include/asm/pgtable.h | 3 +++
>  arch/x86/mm/pgtable.c          | 5 +++++
>  include/linux/pgtable.h        | 9 +++++++++
>  mm/mmap.c                      | 5 +++++
>  4 files changed, 22 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index da5dea417663..7f324edaedfa 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1692,6 +1692,9 @@ static inline bool arch_faults_on_old_pte(void)
>  #define maybe_mkwrite maybe_mkwrite
>  extern pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma);
>  
> +#define is_shadow_stack_mapping is_shadow_stack_mapping
> +extern bool is_shadow_stack_mapping(vm_flags_t vm_flags);
> +
>  #endif	/* __ASSEMBLY__ */
>  
>  #endif /* _ASM_X86_PGTABLE_H */
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index e778dbbef3d8..69c0ef583c55 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -897,3 +897,8 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>  
>  #endif /* CONFIG_X86_64 */
>  #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
> +
> +bool is_shadow_stack_mapping(vm_flags_t vm_flags)
> +{
> +	return (vm_flags & VM_SHADOW_STACK);

Nit: parentheses are redundant.

> +}
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 5e772392a379..45b601fa1a1c 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1446,6 +1446,15 @@ static inline bool arch_has_pfn_modify_check(void)
>  }
>  #endif /* !_HAVE_ARCH_PFN_MODIFY_ALLOWED */
>  
> +#ifdef CONFIG_MMU
> +#ifndef is_shadow_stack_mapping
> +static inline bool is_shadow_stack_mapping(vm_flags_t vm_flags)
> +{
> +	return false;
> +}
> +#endif
> +#endif /* CONFIG_MMU */

What the purpose #ifdef CONFIG_MMU? Looks redundant.

Otherwise: 

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

> +
>  /*
>   * Architecture PAGE_KERNEL_* fallbacks
>   *
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 3f287599a7a3..d77fb39b6ab5 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1718,6 +1718,9 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
>  	if (file && is_file_hugepages(file))
>  		return 0;
>  
> +	if (is_shadow_stack_mapping(vm_flags))
> +		return 1;
> +
>  	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
>  }
>  
> @@ -3387,6 +3390,8 @@ void vm_stat_account(struct mm_struct *mm, vm_flags_t flags, long npages)
>  		mm->stack_vm += npages;
>  	else if (is_data_mapping(flags))
>  		mm->data_vm += npages;
> +	else if (is_shadow_stack_mapping(flags))
> +		mm->stack_vm += npages;
>  }
>  
>  static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
> -- 
> 2.21.0
> 
> 

-- 
 Kirill A. Shutemov
