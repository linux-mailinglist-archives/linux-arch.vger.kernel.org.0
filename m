Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D6E343E86
	for <lists+linux-arch@lfdr.de>; Mon, 22 Mar 2021 11:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhCVKzz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Mar 2021 06:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhCVKzZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Mar 2021 06:55:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E639C061762
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 03:55:24 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u10so20446444lju.7
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 03:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D+PcY8fizKyI1pa8vyAaI0Fu5ahvlZoOnbR8AqNaIGM=;
        b=cNdFZe9aFiClr44vhnMkdDn4A4PRwCmXoJ8KEm1xluKWbN8IGn8mR3MlZg3J6rbUh5
         pw68llA/oheOVpyvb+bbJ0sh4EVoe/nmWmGnzNtopCABnUJ7EQgOPtQSFTwM0Kzx8k+M
         +1mtp/2DwiZq5luOFZ3V/g01ge3sXb9SouwkCD0JH2lHd7gq1I7t86xU+J19KJyHmhmH
         LYNjOzP/9DVag/uyi8sMESQt8u8P6n+9arqOVmypRXuc6uC+TA53JscZSw5Cedl0Skih
         Uj5uIS/3Q3i8PmxUzCy71C2yDXfONCcAgKBAsNjfZlR3dTNNB6tHQ8+1nQKyAoEnlb/S
         6OWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D+PcY8fizKyI1pa8vyAaI0Fu5ahvlZoOnbR8AqNaIGM=;
        b=gzehp6H8kZ+CtR+LedRCh3hAMpnDcYVHa0JtOFqadGl9uvDLwI8X3UaRQaZM011EBT
         9tP4gHpUgYYAx/84rJT4NAJgrPELmfhIXJZ7hnj8fvXSRXxdt7F2dRasbYWVyabi1Ioq
         biUS9KMjOuHOddEGA/l3VJeKpE4GySr0ekNszX/CRlLL9yLcFJ8F++oed7GRS9KlzXaN
         zHUEbCn1+Aj8piL1DiKW63BdS2npxedHyUJ11svnF5Y0QzUIKfkxwImwlZSmPx2w8NlY
         7FkbiiHJYYxOLh/5R8v9WZzC369UVnb0gghYyXjeUg3BsGFcgQAY/vpwPxm/47BVd0Mz
         8Z0w==
X-Gm-Message-State: AOAM531MvGB6gOshf+OC+EVeT4vMal1VeERf3BQP1z3mBiJa6cYAgEYj
        ZRBRfVXq+mVND/hTMohcSBspYw==
X-Google-Smtp-Source: ABdhPJxf/OAQj9ADevnB8ESViQBvohbq91TGiPa/7o4CoF/N6TtVkgXQQlUwXU07vQ7ubVRc+vrblQ==
X-Received: by 2002:a2e:2a44:: with SMTP id q65mr9601149ljq.238.1616410523121;
        Mon, 22 Mar 2021 03:55:23 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e9sm1905215ljj.52.2021.03.22.03.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:55:22 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 36E96101DEB; Mon, 22 Mar 2021 13:55:30 +0300 (+03)
Date:   Mon, 22 Mar 2021 13:55:30 +0300
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
Subject: Re: [PATCH v23 17/28] mm: Add guard pages around a shadow stack.
Message-ID: <20210322105530.pbmfrg6rhywct5ft@box>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-18-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316151054.5405-18-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 08:10:43AM -0700, Yu-cheng Yu wrote:
> INCSSP(Q/D) increments shadow stack pointer and 'pops and discards' the
> first and the last elements in the range, effectively touches those memory
> areas.
> 
> The maximum moving distance by INCSSPQ is 255 * 8 = 2040 bytes and
> 255 * 4 = 1020 bytes by INCSSPD.  Both ranges are far from PAGE_SIZE.
> Thus, putting a gap page on both ends of a shadow stack prevents INCSSP,
> CALL, and RET from going beyond.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/include/asm/page_64_types.h | 10 ++++++++++
>  include/linux/mm.h                   | 24 ++++++++++++++++++++----
>  2 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
> index 64297eabad63..23e3d880ce6c 100644
> --- a/arch/x86/include/asm/page_64_types.h
> +++ b/arch/x86/include/asm/page_64_types.h
> @@ -115,4 +115,14 @@
>  #define KERNEL_IMAGE_SIZE	(512 * 1024 * 1024)
>  #endif
>  
> +/*
> + * Shadow stack pointer is moved by CALL, RET, and INCSSP(Q/D).  INCSSPQ
> + * moves shadow stack pointer up to 255 * 8 = ~2 KB (~1KB for INCSSPD) and
> + * touches the first and the last element in the range, which triggers a
> + * page fault if the range is not in a shadow stack.  Because of this,
> + * creating 4-KB guard pages around a shadow stack prevents these
> + * instructions from going beyond.
> + */
> +#define ARCH_SHADOW_STACK_GUARD_GAP PAGE_SIZE
> +
>  #endif /* _ASM_X86_PAGE_64_DEFS_H */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index af805ffde48e..9890e9f5a5e0 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2619,6 +2619,10 @@ extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
>  int __must_check write_one_page(struct page *page);
>  void task_dirty_inc(struct task_struct *tsk);
>  
> +#ifndef ARCH_SHADOW_STACK_GUARD_GAP
> +#define ARCH_SHADOW_STACK_GUARD_GAP 0
> +#endif
> +
>  extern unsigned long stack_guard_gap;
>  /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
>  extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
> @@ -2651,9 +2655,15 @@ static inline struct vm_area_struct * find_vma_intersection(struct mm_struct * m
>  static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
>  {
>  	unsigned long vm_start = vma->vm_start;
> +	unsigned long gap = 0;
>  
> -	if (vma->vm_flags & VM_GROWSDOWN) {
> -		vm_start -= stack_guard_gap;
> +	if (vma->vm_flags & VM_GROWSDOWN)
> +		gap = stack_guard_gap;
> +	else if (vma->vm_flags & VM_SHSTK)
> +		gap = ARCH_SHADOW_STACK_GUARD_GAP;

Looks too x86-centric for generic code.

Maybe we can have a helper that would return gap for the given VMA?
The generic version of the helper would only return stack_guard_gap for
VM_GROWSDOWN. Arch code would override it to handle VM_SHSTK case too.

Similar can be done in vm_end_gap().

> +
> +	if (gap != 0) {
> +		vm_start -= gap;
>  		if (vm_start > vma->vm_start)
>  			vm_start = 0;
>  	}
> @@ -2663,9 +2673,15 @@ static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
>  static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
>  {
>  	unsigned long vm_end = vma->vm_end;
> +	unsigned long gap = 0;
> +
> +	if (vma->vm_flags & VM_GROWSUP)
> +		gap = stack_guard_gap;
> +	else if (vma->vm_flags & VM_SHSTK)
> +		gap = ARCH_SHADOW_STACK_GUARD_GAP;
>  
> -	if (vma->vm_flags & VM_GROWSUP) {
> -		vm_end += stack_guard_gap;
> +	if (gap != 0) {
> +		vm_end += gap;
>  		if (vm_end < vma->vm_end)
>  			vm_end = -PAGE_SIZE;
>  	}
> -- 
> 2.21.0
> 

-- 
 Kirill A. Shutemov
