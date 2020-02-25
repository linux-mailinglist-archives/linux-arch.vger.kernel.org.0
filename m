Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E077B16EFCA
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 21:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbgBYULO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 15:11:14 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46685 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbgBYULN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 15:11:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id k29so114336pfp.13
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 12:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=81meCRrUd7FkyT9G9NN+yX4/OPtkzRjFPOeZBX9Bs6g=;
        b=dfWRdqyGZUBC0WYr813Wit4XuNySCIYQYI7uwQeBtD1+p62LdSaeOa/XYxguHnyqTG
         YI9ua5i3FpeOwDCAABc4Q4vXBEcTAv3OUnJczyjKgQbNtigSlxM3Ur+Puwyx3aOprLMP
         RX+0xUGtLeAHXo+MWGokm5cRYVMrwOUJ4xlFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=81meCRrUd7FkyT9G9NN+yX4/OPtkzRjFPOeZBX9Bs6g=;
        b=bD0l5gabdNXtf95CJnG6ngJbW8Zqs/hZBUGelZUBR1ofA6j3ywYmqNwv4YOB0V6bG1
         wmXiCIUGy5DxGxgTQSmkYzlgkP8/UNlCUsG4h7ywVm7Ly/h//OzQ80aWVHtUyPcSakLK
         iHA+8yLGPMS1R2S2qu4K8ZKVeBXi0M/2pmj2kEDxZA3WQ19/Jfioqq5P6lg6vcoNAuKt
         mPbVGyDGFGIZecXaiWslML0iX+ua5dog4MEKfeMQFxjhRGI+RGsgTIn7M137h9lJ1kdC
         m2Rj0nPPG8UE93WF6Xooe7c/DeWnz6qu+uBwV+MUVb5f6vIlVUDLBLkcG1GRL4fJNZ5x
         i3xQ==
X-Gm-Message-State: APjAAAXiZbh/1bYz3Jg1cbDauuPuc/3Gc1wZYtQV0/q8jrq6Rw68GSU6
        7F8IWiRcyqv1qb21MmTxzxqmDA==
X-Google-Smtp-Source: APXvYqyQ3YSUXoahHHRKuSddjeb4Zh7NvSdcT1SPZAvErg+AuOzuJXA1Bi+uG2m6xS0+k4tS2i+PGA==
X-Received: by 2002:a65:6459:: with SMTP id s25mr255868pgv.74.1582661473165;
        Tue, 25 Feb 2020 12:11:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v25sm17783531pfe.147.2020.02.25.12.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:11:12 -0800 (PST)
Date:   Tue, 25 Feb 2020 12:11:11 -0800
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
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Subject: Re: [RFC PATCH v9 07/27] Add guard pages around a Shadow Stack.
Message-ID: <202002251209.A2079ECA4@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-8-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-8-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:15AM -0800, Yu-cheng Yu wrote:
> INCSSPD/INCSSPQ instruction is used to unwind a Shadow Stack (SHSTK).  It
> performs 'pop and discard' of the first and last element from SHSTK in the
> range specified in the operand.  The maximum value of the operand is 255,
> and the maximum moving distance of the SHSTK pointer is 255 * 4 for
> INCSSPD, 255 * 8 for INCSSPQ.
> 
> Since SHSTK has a fixed size, creating a guard page above prevents
> INCSSP/RET from moving beyond.  Likewise, creating a guard page below
> prevents CALL from underflowing the SHSTK.

This commit log doesn't really explain why the code changes below are
needed? stack_guard_gap is configurable at boot, etc. This appears to be
limiting it? I don't follow this change...

-Kees

> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  include/linux/mm.h | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b5145fbe102e..75de07674649 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2464,9 +2464,15 @@ static inline struct vm_area_struct * find_vma_intersection(struct mm_struct * m
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
> +		gap = PAGE_SIZE;
> +
> +	if (gap != 0) {
> +		vm_start -= gap;
>  		if (vm_start > vma->vm_start)
>  			vm_start = 0;
>  	}
> @@ -2476,9 +2482,15 @@ static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
>  static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
>  {
>  	unsigned long vm_end = vma->vm_end;
> +	unsigned long gap = 0;
> +
> +	if (vma->vm_flags & VM_GROWSUP)
> +		gap = stack_guard_gap;
> +	else if (vma->vm_flags & VM_SHSTK)
> +		gap = PAGE_SIZE;
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
Kees Cook
