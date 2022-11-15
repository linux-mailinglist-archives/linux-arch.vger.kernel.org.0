Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E862A22D
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 20:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiKOTs4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 14:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKOTsz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 14:48:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE8D6324;
        Tue, 15 Nov 2022 11:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xlZK7ixb9eDv0NnUzA/tcBUDo9QZE/9z6fJXN19/1EE=; b=GAQtEixzjzqp4t8ZQiSG1c5yxh
        PlgdlqTkL2+L6WzsBok6UQ0hlpVHEz8MixpFZcb91eViJh0nbS3sPFFKC7wmyChTaOm/sOSSdz/GH
        lBZjxaTow1wle+M6ybQTDZ1oToK0pZS/bGCiu2HIq0A+z2nVkUOppHvc0HUuFzfqJKAiWfHCuEr3Q
        VPzxi/kWvDYxO24Yiu17OUvZr9b8a6rndDCuUai/T7LBWVKNWy5ieoNGIQgginJ24zieFKR3PK5hX
        zjsA7Y7lXKbDpdzL6SnPnpW/EZfQ6OlZq7Yfb0TBn+AZ6qZTO0ad5WAX6xyPJi1MnJoQ4yLFybg9I
        x50yOzIw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov1v8-00Ga1G-Q6; Tue, 15 Nov 2022 19:48:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FD9E300209;
        Tue, 15 Nov 2022 13:04:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 366132015BE8A; Tue, 15 Nov 2022 13:04:15 +0100 (CET)
Date:   Tue, 15 Nov 2022 13:04:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v3 18/37] mm: Add guard pages around a shadow stack.
Message-ID: <Y3OAP3E3UQShJ22N@hirez.programming.kicks-ass.net>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-19-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104223604.29615-19-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 04, 2022 at 03:35:45PM -0700, Rick Edgecombe wrote:

> diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
> index c90c20904a60..66da1f3298b0 100644
> --- a/arch/x86/mm/mmap.c
> +++ b/arch/x86/mm/mmap.c
> @@ -248,3 +248,26 @@ bool pfn_modify_allowed(unsigned long pfn, pgprot_t prot)
>  		return false;
>  	return true;
>  }
> +
> +unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
> +{
> +	if (vma->vm_flags & VM_GROWSDOWN)
> +		return stack_guard_gap;
> +
> +	/*
> +	 * Shadow stack pointer is moved by CALL, RET, and INCSSP(Q/D).

Can we perhaps write this like:	INCSPP[QD] ? The () notation makes it
look like a function.

> +	 * INCSSPQ moves shadow stack pointer up to 255 * 8 = ~2 KB
> +	 * (~1KB for INCSSPD) and touches the first and the last element
> +	 * in the range, which triggers a page fault if the range is not
> +	 * in a shadow stack. Because of this, creating 4-KB guard pages
> +	 * around a shadow stack prevents these instructions from going
> +	 * beyond.
> +	 *
> +	 * Creation of VM_SHADOW_STACK is tightly controlled, so a vma
> +	 * can't be both VM_GROWSDOWN and VM_SHADOW_STACK
> +	 */
> +	if (vma->vm_flags & VM_SHADOW_STACK)
> +		return PAGE_SIZE;
> +
> +	return 0;
> +}
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5d9536fa860a..0a3f7e2b32df 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2832,15 +2832,16 @@ struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
>  	return mtree_load(&mm->mm_mt, addr);
>  }
>  
> +unsigned long stack_guard_start_gap(struct vm_area_struct *vma);
> +
>  static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
>  {
> +	unsigned long gap = stack_guard_start_gap(vma);
>  	unsigned long vm_start = vma->vm_start;
>  
> -	if (vma->vm_flags & VM_GROWSDOWN) {
> -		vm_start -= stack_guard_gap;
> -		if (vm_start > vma->vm_start)
> -			vm_start = 0;
> -	}
> +	vm_start -= gap;
> +	if (vm_start > vma->vm_start)
> +		vm_start = 0;
>  	return vm_start;
>  }
>  
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 2def55555e05..f67606fbc464 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -281,6 +281,13 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>  	return origbrk;
>  }
>  
> +unsigned long __weak stack_guard_start_gap(struct vm_area_struct *vma)
> +{
> +	if (vma->vm_flags & VM_GROWSDOWN)
> +		return stack_guard_gap;
> +	return 0;
> +}

I'm thinking perhaps this wants to be an inline function?
