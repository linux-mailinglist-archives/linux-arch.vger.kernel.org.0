Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4417B37A609
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 13:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhEKLuC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 May 2021 07:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbhEKLuA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 May 2021 07:50:00 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A984AC06174A
        for <linux-arch@vger.kernel.org>; Tue, 11 May 2021 04:48:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x19so28225063lfa.2
        for <linux-arch@vger.kernel.org>; Tue, 11 May 2021 04:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OxdoaKPOQuUdKzkVcLxQZyyXBdgyHiRS3tUGaZINUts=;
        b=pu5+cwzEKuzc6EKXsqJ7EaWSkxB7rCn6gNQ30VMCpZCLAPn9ir6RnzaGipRTyxVm+K
         pSnBAdAG4NNgwEkwdQTxjhsKwtxFqJ99SznjFTuhezxvdIHgaI6BBv3p+8p0XsHszG+V
         RQaHASxm9Et0cxJy0qUKzFBFViubxluBaNVVg45aQybB/7wIbjaw1IMMvZVohB06z+O9
         3s8uL1JLKzVYvB1RZkPBju2l4gzFHKeK2tL7LkbfaYQ8lrlvI566AMHvwhvFVbRBso9Z
         tDguC2zPMdW7HGa4bDpl5xh98LNl9ydjJwxQSDPvWhWqmX6vFAPsI2/5z5P21MbGsP3t
         13iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OxdoaKPOQuUdKzkVcLxQZyyXBdgyHiRS3tUGaZINUts=;
        b=BhntXSQtFJTzd3h2/3BiPzRLXSmIzdcpKI2Hvo78RdBBadfj2saxUcYg7NeRkcZFJl
         HU/l8HVqivdW5PEwaBSSJ9bYHZlNLe2TWiZFsYs3HyHWxUyfrFKeAx5/eVx9QqmgOiz0
         uwVXcINqiSaf5j3G2MfAIR5n5w1hZW0+wNp3wvDgnFDLimVPpTTjb34MuOcjYUokANbI
         jFt4fymuQpTKkPgFB6eDDdxgATYpoUeUv/sjBG6ZZrfWGcqVWsx/JhO5JuYEiY/RRVJQ
         FO5OzA1ua0lKQMSZlAnPtfln4JeCbGtr7wxDvFLz2lnm81qraxLg2F9v7bNEdCdv/qkq
         2AbQ==
X-Gm-Message-State: AOAM531PZFyiv+WXDe/00D1EvLFsprfPff7RIa8r66xDt1B2Sv7ypjGf
        nceNUvFrZOMaiGB8xtSgRffNuw==
X-Google-Smtp-Source: ABdhPJydVEzMQLCZSWLjQHEgnr+jpAeuIOL0TV29D90uqoPSgdYZuwn5zByK9Fy6Y0UQztu1N5pypA==
X-Received: by 2002:a05:6512:b8e:: with SMTP id b14mr20299532lfv.404.1620733732151;
        Tue, 11 May 2021 04:48:52 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x19sm2604242lfa.22.2021.05.11.04.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 04:48:51 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 40BD0102615; Tue, 11 May 2021 14:48:52 +0300 (+03)
Date:   Tue, 11 May 2021 14:48:52 +0300
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
Subject: Re: [PATCH v26 30/30] mm: Introduce PROT_SHADOW_STACK for shadow
 stack
Message-ID: <20210511114852.5wm6a5z72xjlqc4c@box>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-31-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427204315.24153-31-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 27, 2021 at 01:43:15PM -0700, Yu-cheng Yu wrote:
> There are three possible options to create a shadow stack allocation API:
> an arch_prctl, a new syscall, or adding PROT_SHADOW_STACK to mmap() and
> mprotect().  Each has its advantages and compromises.
> 
> An arch_prctl() is the least intrusive.  However, the existing x86
> arch_prctl() takes only two parameters.  Multiple parameters must be
> passed in a memory buffer.  There is a proposal to pass more parameters in
> registers [1], but no active discussion on that.
> 
> A new syscall minimizes compatibility issues and offers an extensible frame
> work to other architectures, but this will likely result in some overlap of
> mmap()/mprotect().
> 
> The introduction of PROT_SHADOW_STACK to mmap()/mprotect() takes advantage
> of existing APIs.  The x86-specific PROT_SHADOW_STACK is translated to
> VM_SHADOW_STACK and a shadow stack mapping is created without reinventing
> the wheel.  There are potential pitfalls though.  The most obvious one
> would be using this as a bypass to shadow stack protection.  However, the
> attacker would have to get to the syscall first.
> 
> [1] https://lore.kernel.org/lkml/20200828121624.108243-1-hjl.tools@gmail.com/
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
> v26:
> - Change PROT_SHSTK to PROT_SHADOW_STACK.
> - Remove (vm_flags & VM_SHARED) check, since it is covered by
>   !vma_is_anonymous().
> 
> v24:
> - Update arch_calc_vm_prot_bits(), leave PROT* checking to
>   arch_validate_prot().
> - Update arch_validate_prot(), leave vma flags checking to
>   arch_validate_flags().
> - Add arch_validate_flags().
> 
>  arch/x86/include/asm/mman.h      | 60 +++++++++++++++++++++++++++++++-
>  arch/x86/include/uapi/asm/mman.h |  2 ++
>  include/linux/mm.h               |  1 +
>  3 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/mman.h b/arch/x86/include/asm/mman.h
> index 629f6c81263a..fbb90f1b02c0 100644
> --- a/arch/x86/include/asm/mman.h
> +++ b/arch/x86/include/asm/mman.h
> @@ -20,11 +20,69 @@
>  		((vm_flags) & VM_PKEY_BIT2 ? _PAGE_PKEY_BIT2 : 0) |	\
>  		((vm_flags) & VM_PKEY_BIT3 ? _PAGE_PKEY_BIT3 : 0))
>  
> -#define arch_calc_vm_prot_bits(prot, key) (		\
> +#define pkey_vm_prot_bits(prot, key) (			\
>  		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
>  		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
>  		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
>  		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
> +#else
> +#define pkey_vm_prot_bits(prot, key) (0)
>  #endif
>  
> +static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> +						   unsigned long pkey)
> +{
> +	unsigned long vm_prot_bits = pkey_vm_prot_bits(prot, pkey);
> +
> +	if (prot & PROT_SHADOW_STACK)
> +		vm_prot_bits |= VM_SHADOW_STACK;
> +
> +	return vm_prot_bits;
> +}
> +
> +#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> +
> +#ifdef CONFIG_X86_SHADOW_STACK
> +static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
> +{
> +	unsigned long valid = PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM |
> +			      PROT_SHADOW_STACK;
> +
> +	if (prot & ~valid)
> +		return false;
> +
> +	if (prot & PROT_SHADOW_STACK) {
> +		if (!current->thread.cet.shstk_size)
> +			return false;
> +
> +		/*
> +		 * A shadow stack mapping is indirectly writable by only
> +		 * the CALL and WRUSS instructions, but not other write
> +		 * instructions).  PROT_SHADOW_STACK and PROT_WRITE are
> +		 * mutually exclusive.
> +		 */
> +		if (prot & PROT_WRITE)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +#define arch_validate_prot arch_validate_prot
> +
> +static inline bool arch_validate_flags(struct vm_area_struct *vma, unsigned long vm_flags)
> +{
> +	/*
> +	 * Shadow stack must be anonymous and not shared.
> +	 */
> +	if ((vm_flags & VM_SHADOW_STACK) && !vma_is_anonymous(vma))
> +		return false;
> +
> +	return true;
> +}
> +
> +#define arch_validate_flags(vma, vm_flags) arch_validate_flags(vma, vm_flags)
> +
> +#endif /* CONFIG_X86_SHADOW_STACK */
> +
>  #endif /* _ASM_X86_MMAN_H */
> diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
> index f28fa4acaeaf..4c36b263cf0a 100644
> --- a/arch/x86/include/uapi/asm/mman.h
> +++ b/arch/x86/include/uapi/asm/mman.h
> @@ -4,6 +4,8 @@
>  
>  #define MAP_32BIT	0x40		/* only give out 32bit addresses */
>  
> +#define PROT_SHADOW_STACK	0x10	/* shadow stack pages */
> +
>  #include <asm-generic/mman.h>
>  
>  #endif /* _UAPI_ASM_X86_MMAN_H */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ccec5cc399b..9a7652eea207 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -342,6 +342,7 @@ extern unsigned int kobjsize(const void *objp);
>  
>  #if defined(CONFIG_X86)
>  # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
> +# define VM_ARCH_CLEAR	VM_SHADOW_STACK

Nit: you can put VM_SHADOW_STACK directly into VM_FLAGS_CLEAR. It's
already conditinal on the feature enabled and VM_NONE otherwise.

Up to you.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
