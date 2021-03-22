Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3835343FAE
	for <lists+linux-arch@lfdr.de>; Mon, 22 Mar 2021 12:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhCVL10 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Mar 2021 07:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhCVL1I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Mar 2021 07:27:08 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D3AC061756
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 04:27:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g8so13542789lfv.12
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 04:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wfahuc/4FrKDMvX9RZ/+E+DVaHu+EE7CL6DE9+//ml0=;
        b=W/0O2nsBYq5ZzI5Y2K6tiA0U+Vcf5xqBG9/hGbwF73UE5fdrI6KzNreiefIsogp+qj
         cXSg85GgCuXFHCjemkKuoi7erPMcQiHreiV5s5uWVTpcSYsH96Z99CYlCJhhRRjaoxSN
         yTLRstwNrVDeuegg+v/xLsx3QsEJCa8ExQN2izI84K4rkQVXdWcWnh/z7EgLx+d2Gj4v
         KlLnpCsgCwRuVJI0aj/tFBp+YTkjQx0FW2CH2rIpZNSPE+ktNfEdni1/QLDfZ1W1BdAJ
         EMzt3I++yezG517Cs6AuXcooYDevc+dkbOTnHC341yzM0ARPNOKj445LyePnX0To7wF9
         m2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wfahuc/4FrKDMvX9RZ/+E+DVaHu+EE7CL6DE9+//ml0=;
        b=Cx1LA2LOucPAbH4IaLQZ1j/I6mLx5D2xU7XNGu2I2U0M3CqDqxJX2B1A/iBcRKvcLn
         UIwZskjqwz2jPPym11ICqeAL9c4FDmeO2U/fhl6o9/cKKbfuXrTQ7pPV1VZXLPm9prX/
         RQ4sq/fcgwLAGAqPb9UQRMBvc85PvgsP1mWmulZncJ85Cj2i4mXhUB+/qxNDuQWWwOfx
         BoJbI3MfmJLM5XBbmzAb9iCwwYGzTriNjYet2BCiKkU47LEj7JdcB2/8N6HQixL5TlDe
         MvNI3kJ/7jIBx7msQlakErgFunGLLEjYHOAqoa1wjClU5kLYLvgK0Qmn//OulevXFYqW
         PASQ==
X-Gm-Message-State: AOAM5328Zyo5o6jkQspj7adGcB8D0PJTIjl2wQRIvvk+/yctMEj9Xp6V
        ofxkPq/MGK7O5ahYPgGuI9dH5g==
X-Google-Smtp-Source: ABdhPJy4IdxcKDpK5GSmJnFhB/DWMG+MxhYZnGmWYx03PQEDC8gCv+MgnJiU2/rBF1HiU8PkWfw01Q==
X-Received: by 2002:a19:521a:: with SMTP id m26mr8825738lfb.56.1616412425904;
        Mon, 22 Mar 2021 04:27:05 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e15sm1541510lfs.83.2021.03.22.04.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:27:05 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A8293101DEB; Mon, 22 Mar 2021 14:27:12 +0300 (+03)
Date:   Mon, 22 Mar 2021 14:27:12 +0300
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
Subject: Re: [PATCH v23 28/28] mm: Introduce PROT_SHSTK for shadow stack
Message-ID: <20210322112712.di6vthmgrvu5znhv@box>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-29-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316151054.5405-29-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 08:10:54AM -0700, Yu-cheng Yu wrote:
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
> existing APIs.  The x86-specific PROT_SHSTK is translated to VM_SHSTK and
> a shadow stack mapping is created without reinventing the wheel.  There are
> potential pitfalls though.  The most obvious one would be using this as a
> bypass to shadow stack protection.  However, the attacker would have to get
> to the syscall first.
> 
> [1] https://lore.kernel.org/lkml/20200828121624.108243-1-hjl.tools@gmail.com/
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/include/asm/mman.h      | 57 +++++++++++++++++++++++++++++++-
>  arch/x86/include/uapi/asm/mman.h |  1 +
>  include/linux/mm.h               |  1 +
>  mm/mmap.c                        |  8 ++++-
>  4 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mman.h b/arch/x86/include/asm/mman.h
> index 629f6c81263a..bd94e30b5d34 100644
> --- a/arch/x86/include/asm/mman.h
> +++ b/arch/x86/include/asm/mman.h
> @@ -20,11 +20,66 @@
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
> +#endif
> +
> +static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> +						   unsigned long pkey)
> +{
> +	unsigned long vm_prot_bits = pkey_vm_prot_bits(prot, pkey);
> +
> +	if (!(prot & PROT_WRITE) && (prot & PROT_SHSTK))
> +		vm_prot_bits |= VM_SHSTK;
> +
> +	return vm_prot_bits;
> +}
> +
> +#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> +
> +#ifdef CONFIG_X86_CET
> +static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
> +{
> +	unsigned long valid = PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM;
> +
> +	if (prot & ~(valid | PROT_SHSTK))

Why PROT_SHSTK is not part of valid?

> +		return false;
> +
> +	if (prot & PROT_SHSTK) {
> +		struct vm_area_struct *vma;
> +
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
> +
> +		vma = find_vma(current->mm, addr);
> +		if (!vma)
> +			return false;

NAK.

This is racy. arch_validate_prot() called outside of mmap_lock and the vma
may be freed or modified under us.

do_mprotect_pkey() already calls find_vma() with the right locking. Maybe
re-strucure do_mprotect_pkey() to call arch_validate_prot() after
find_vma() and pass down the vma?

> +
> +		/*
> +		 * Shadow stack cannot be backed by a file or shared.
> +		 */
> +		if (vma->vm_file || (vma->vm_flags & VM_SHARED))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +#define arch_validate_prot arch_validate_prot
>  #endif
>  
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
> index e178be052419..40c4b0fe7cc4 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -342,6 +342,7 @@ extern unsigned int kobjsize(const void *objp);
>  
>  #if defined(CONFIG_X86)
>  # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
> +# define VM_ARCH_CLEAR	VM_SHSTK
>  #elif defined(CONFIG_PPC)
>  # define VM_SAO		VM_ARCH_1	/* Strong Access Ordering (powerpc) */
>  #elif defined(CONFIG_PARISC)
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 99077171010b..934cb3cbe952 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1481,6 +1481,12 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  		struct inode *inode = file_inode(file);
>  		unsigned long flags_mask;
>  
> +		/*
> +		 * Call stack cannot be backed by a file.
> +		 */
> +		if (vm_flags & VM_SHSTK)
> +			return -EINVAL;
> +
>  		if (!file_mmap_ok(file, inode, pgoff, len))
>  			return -EOVERFLOW;
>  
> @@ -1545,7 +1551,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  	} else {
>  		switch (flags & MAP_TYPE) {
>  		case MAP_SHARED:
> -			if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
> +			if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP|VM_SHSTK))
>  				return -EINVAL;
>  			/*
>  			 * Ignore pgoff.
> -- 
> 2.21.0
> 

-- 
 Kirill A. Shutemov
