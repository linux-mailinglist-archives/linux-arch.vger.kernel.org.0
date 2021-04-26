Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D0836AC68
	for <lists+linux-arch@lfdr.de>; Mon, 26 Apr 2021 08:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhDZGx0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Apr 2021 02:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhDZGxZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Apr 2021 02:53:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEB5C06175F
        for <linux-arch@vger.kernel.org>; Sun, 25 Apr 2021 23:52:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 4so26756563lfp.11
        for <linux-arch@vger.kernel.org>; Sun, 25 Apr 2021 23:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vSMB9b06mxY/vpzupY2c4eRnFMLlF0PHvUHRcvumkgg=;
        b=UTW/TxvcFWW0wd0jUtmc5bZHz+RBqjHyTKfhjGUfNJ0gMZGF5u/r39dSd0sCnXiM0F
         mWUx3Bo5Wox/miXa7Y+8FPKV4FlUkLgJbx7sC8A35/ULd2MMQ5HC7zZbqQCHjBRxLW/U
         JKAB2yloQb7jDw3yMLK9Vm6Q2Ol+VqIDTXSzzp5gJx5/JCDaRhZsv3V8po/CE0o0gRoA
         3rMRrMkGVPKPzAT3EgSKbTOlxehU6MaG86dYf8aNvHscerYlCcRKrzhmQoYZjtypHyrH
         DMSnK6hBwONDGCMzBS7cjZL5iZnrmcT7mLNALBKyM6BaaQi14YNuJxL+v0KOMSlUMNTd
         zr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vSMB9b06mxY/vpzupY2c4eRnFMLlF0PHvUHRcvumkgg=;
        b=s3yGo6Sfc+aIxLkmVy7myId+F4ENi1Om/ts5oF1Dzf5xqnSpYHS69/Ujmud+pfcnyg
         t3EJQB9pQ9eNztZGgZTQ3hlZcH2nkHIcI0HaZ7Nv4b6wzLrF05epSXuvZQKzEGbbW0Q6
         kAJwlX7MwjwFb0/GzrXk+/0jI+CIeHLKJODcNctj2Syq8fnK8mUtAukGYY9rLlrGyQvl
         B2IWPHgqIILkvHZW6tmi7MpShqHSNN7LjX6OhjJRC1PiNBswKMubDhVOFBBD/ZtRcqhw
         FcXKugwoLN/nok+myiLT1SxTx3DTaf1m2x5HgoOug7QsNCT5lTqPK4/ZRsfZBBy59DoI
         gCbQ==
X-Gm-Message-State: AOAM532ytUL/CD86ANsUn4y/ASELQzu+1xNlhEA7MFErsMJvIjEA0dS/
        L9Pu1UjMGxYvTeJSpOexob8leg==
X-Google-Smtp-Source: ABdhPJw+9dvYBRmAGSJb4PMciQ6ryoUSVfD6TH4Et3dNdEWA5/MZDD+GpUEvmSX2bX+W85Wbs42Nfg==
X-Received: by 2002:ac2:5f1b:: with SMTP id 27mr11685539lfq.425.1619419960641;
        Sun, 25 Apr 2021 23:52:40 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v3sm285203lfo.257.2021.04.25.23.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 23:52:39 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 973ED1026AB; Mon, 26 Apr 2021 09:52:43 +0300 (+03)
Date:   Mon, 26 Apr 2021 09:52:43 +0300
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
Subject: Re: [PATCH v25 30/30] mm: Introduce PROT_SHSTK for shadow stack
Message-ID: <20210426065243.ozh6doz6q5xonrqe@box.shutemov.name>
References: <20210415221419.31835-1-yu-cheng.yu@intel.com>
 <20210415221419.31835-31-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415221419.31835-31-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 15, 2021 at 03:14:19PM -0700, Yu-cheng Yu wrote:
> There are three possible options to create a shadow stack allocation API:
> an arch_prctl, a new syscall, or adding PROT_SHSTK to mmap()/mprotect().
> Each has its advantages and compromises.
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
> The introduction of PROT_SHSTK to mmap()/mprotect() takes advantage of

Maybe PROT_SHADOW_STACK?

> existing APIs.  The x86-specific PROT_SHSTK is translated to
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
> v24:
> - Update arch_calc_vm_prot_bits(), leave PROT* checking to
>   arch_validate_prot().
> - Update arch_validate_prot(), leave vma flags checking to
>   arch_validate_flags().
> - Add arch_validate_flags().
> 
>  arch/x86/include/asm/mman.h      | 59 +++++++++++++++++++++++++++++++-
>  arch/x86/include/uapi/asm/mman.h |  1 +
>  include/linux/mm.h               |  1 +
>  3 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/mman.h b/arch/x86/include/asm/mman.h
> index 629f6c81263a..1821c179f35d 100644
> --- a/arch/x86/include/asm/mman.h
> +++ b/arch/x86/include/asm/mman.h
> @@ -20,11 +20,68 @@
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
> +	if (prot & PROT_SHSTK)
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
> +			      PROT_SHSTK;
> +
> +	if (prot & ~valid)
> +		return false;
> +
> +	if (prot & PROT_SHSTK) {
> +		if (!current->thread.cet.shstk_size)
> +			return false;
> +
> +		/*
> +		 * A shadow stack mapping is indirectly writable by only
> +		 * the CALL and WRUSS instructions, but not other write
> +		 * instructions).  PROT_SHSTK and PROT_WRITE are mutually
> +		 * exclusive.
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
> +static inline bool arch_validate_flags(unsigned long vm_flags, bool is_anon)
> +{
> +	if (vm_flags & VM_SHADOW_STACK) {
> +		if ((vm_flags & VM_SHARED) || !is_anon)

VM_SHARED check is redundant. vma_is_anonymous() should be enough.
Anonymous shared mappings would fail vma_is_anonymous().

> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +#define arch_validate_flags(vm_flags, is_anon) arch_validate_flags(vm_flags, is_anon)
> +
> +#endif /* CONFIG_X86_SHADOW_STACK */
> +
>  #endif /* _ASM_X86_MMAN_H */
> diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
> index 3ce1923e6ed9..39bb7db344a6 100644
> --- a/arch/x86/include/uapi/asm/mman.h
> +++ b/arch/x86/include/uapi/asm/mman.h
> @@ -4,6 +4,7 @@
>  
>  #define MAP_32BIT	0x40		/* only give out 32bit addresses */
>  
> +#define PROT_SHSTK	0x10		/* shadow stack pages */
>  
>  #include <asm-generic/mman.h>
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ccec5cc399b..9a7652eea207 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -342,6 +342,7 @@ extern unsigned int kobjsize(const void *objp);
>  
>  #if defined(CONFIG_X86)
>  # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
> +# define VM_ARCH_CLEAR	VM_SHADOW_STACK
>  #elif defined(CONFIG_PPC)
>  # define VM_SAO		VM_ARCH_1	/* Strong Access Ordering (powerpc) */
>  #elif defined(CONFIG_PARISC)
> -- 
> 2.21.0
> 
> 

-- 
 Kirill A. Shutemov
