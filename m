Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD21243B29
	for <lists+linux-arch@lfdr.de>; Thu, 13 Aug 2020 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHMOB3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Aug 2020 10:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgHMOBO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Aug 2020 10:01:14 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED08C061757
        for <linux-arch@vger.kernel.org>; Thu, 13 Aug 2020 07:01:13 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cs12so2658416qvb.2
        for <linux-arch@vger.kernel.org>; Thu, 13 Aug 2020 07:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4M0yEUs2X0XdWiss3sgAINxEgR1N8B5fv9L5qekNWHg=;
        b=OCjVpMjnkrAb5EAPnWt4LlUNXLV3bnCmuw4Vt67WcHECsrNjMyUn8aqZ8ujmBIw3ia
         vKKLCxmF7yOPpymjj89bhInZY46qwTEHG8nv3ynAIqQrZKPwHI0q4eLDKsGwgwJ7OTTT
         w8sBqJixDMHA+WFpFbr2pgnHeX3Dmp64Qho2shfP2a3mL/CJjltze82u8NutKa16v91Y
         hz3T28J9De8yobVatxsSXnkZt6e3ZTVaCZTfQbAccf7YB4gq/p3dUlGotX/OxzHAsfp0
         TVWuBWtiINJxhzNSQHIQHPIvvhK5vP16gPUSAsJ6kzes1QdLieK84GWdATVB0GGeq/Ju
         DRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4M0yEUs2X0XdWiss3sgAINxEgR1N8B5fv9L5qekNWHg=;
        b=gORpC8NArQCrgn0YSCAERT+zXn/3OC4IseWqYWMtjtJRGn9q53VkMexcxxqSTYXkdN
         dHnEiA16jzNWB/+O3TquZvbYCe3gXk9b2iuEgCqPf29KhkWFOap7FcXQwfIiRsZucFlV
         ZVN3e3XqLh8MEXqD37SmAlkB3NKaKOLMswhLMwIyemLHY2K5YfHZXjp4PEMG++kMuLbO
         RMBinTX1nf5WQM/X0TQYKXcJj6QmojZYGXqxSLPQCRKTSkkewARhuwZ55m3jXRIlUTw3
         fiU8ajPexqzTNuFIHLCXFEfPWlNALXL2eKW8OgPPzIviPsVf1IiATFfZKR80sZghpQzD
         LCVA==
X-Gm-Message-State: AOAM533ZfblaUoyyTvvy07l1SVhK6BN7Y95DkaJO2QebKb+Fbi5YewgS
        TvGHyNrnC9IUk+1V29s+uczzLg==
X-Google-Smtp-Source: ABdhPJy3v1PqS6fHdXgUN3nKx7lADvGCuAEIjG/Hxusy/qOVo3uxjKYDIF6aafl3Uqv+iLsoKfttBQ==
X-Received: by 2002:a0c:f7c8:: with SMTP id f8mr4707613qvo.241.1597327271855;
        Thu, 13 Aug 2020 07:01:11 -0700 (PDT)
Received: from ?IPv6:2804:7f0:8283:9fb9:2485:8bda:7d2b:129a? ([2804:7f0:8283:9fb9:2485:8bda:7d2b:129a])
        by smtp.gmail.com with ESMTPSA id a3sm6401222qtj.21.2020.08.13.07.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 07:01:11 -0700 (PDT)
Subject: Re: [PATCH v7 22/29] arm64: mte: ptrace: Add
 PTRACE_{PEEK,POKE}MTETAGS support
To:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Hayward <Alan.Hayward@arm.com>,
        Omair Javaid <omair.javaid@linaro.org>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-23-catalin.marinas@arm.com>
From:   Luis Machado <luis.machado@linaro.org>
Message-ID: <95f0294b-93fb-bc5e-5ae5-fd3ada2dc7ce@linaro.org>
Date:   Thu, 13 Aug 2020 11:01:06 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715170844.30064-23-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Catalin,

There has been changes to GDB's/LLDB's side to incorporate a tag type 
into the peek/poke requests. This is an attempt to anticipate required 
support for other tag types, like CHERI's tags. Those are somewhat 
different from MTE's tags.

The core file design for storing tags, which is in progress and 
currently in my court, is also taking into account other types of tags.

Given the above, should we consider passing a type to the kernel ptrace 
requests as well?

Also, since the ptrace requests would have to handle different types of 
tags, should we rename PEEKMTETAGS/POKEMTETAGS to PEEKTAGS/POKETAGS 
instead and make those requests generic?

Regards,
Luis

On 7/15/20 2:08 PM, Catalin Marinas wrote:
> Add support for bulk setting/getting of the MTE tags in a tracee's
> address space at 'addr' in the ptrace() syscall prototype. 'data' points
> to a struct iovec in the tracer's address space with iov_base
> representing the address of a tracer's buffer of length iov_len. The
> tags to be copied to/from the tracer's buffer are stored as one tag per
> byte.
> 
> On successfully copying at least one tag, ptrace() returns 0 and updates
> the tracer's iov_len with the number of tags copied. In case of error,
> either -EIO or -EFAULT is returned, trying to follow the ptrace() man
> page.
> 
> Note that the tag copying functions are not performance critical,
> therefore they lack optimisations found in typical memory copy routines.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Alan Hayward <Alan.Hayward@arm.com>
> Cc: Luis Machado <luis.machado@linaro.org>
> Cc: Omair Javaid <omair.javaid@linaro.org>
> ---
> 
> Notes:
>      v4:
>      - Following the change to only clear the tags in a page if it is mapped
>        to user with PROT_MTE, ptrace() now will refuse to access tags in
>        pages not previously mapped with PROT_MTE (PG_mte_tagged set). This is
>        primarily to avoid leaking uninitialised tags to user via ptrace().
>      - Fix SYM_FUNC_END argument typo.
>      - Rename MTE_ALLOC_* to MTE_GRANULE_*.
>      - Use uao_user_alternative for the user access in case we ever want to
>        call mte_copy_tags_* with a kernel buffer. It also matches the other
>        uaccess routines in the kernel.
>      - Simplify arch_ptrace() slightly.
>      - Reorder down_write_killable() with access_ok() in
>        __access_remote_tags().
>      - Handle copy length 0 in mte_copy_tags_{to,from}_user().
>      - Use put_user() instead of __put_user().
>      
>      New in v3.
> 
>   arch/arm64/include/asm/mte.h         |  17 ++++
>   arch/arm64/include/uapi/asm/ptrace.h |   3 +
>   arch/arm64/kernel/mte.c              | 139 +++++++++++++++++++++++++++
>   arch/arm64/kernel/ptrace.c           |   7 ++
>   arch/arm64/lib/mte.S                 |  53 ++++++++++
>   5 files changed, 219 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 1a919905295b..7ea0c0e526d1 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -5,6 +5,11 @@
>   #ifndef __ASM_MTE_H
>   #define __ASM_MTE_H
>   
> +#define MTE_GRANULE_SIZE	UL(16)
> +#define MTE_GRANULE_MASK	(~(MTE_GRANULE_SIZE - 1))
> +#define MTE_TAG_SHIFT		56
> +#define MTE_TAG_SIZE		4
> +
>   #ifndef __ASSEMBLY__
>   
>   #include <linux/page-flags.h>
> @@ -12,6 +17,10 @@
>   #include <asm/pgtable-types.h>
>   
>   void mte_clear_page_tags(void *addr);
> +unsigned long mte_copy_tags_from_user(void *to, const void __user *from,
> +				      unsigned long n);
> +unsigned long mte_copy_tags_to_user(void __user *to, void *from,
> +				    unsigned long n);
>   
>   #ifdef CONFIG_ARM64_MTE
>   
> @@ -25,6 +34,8 @@ void mte_thread_switch(struct task_struct *next);
>   void mte_suspend_exit(void);
>   long set_mte_ctrl(struct task_struct *task, unsigned long arg);
>   long get_mte_ctrl(struct task_struct *task);
> +int mte_ptrace_copy_tags(struct task_struct *child, long request,
> +			 unsigned long addr, unsigned long data);
>   
>   #else
>   
> @@ -54,6 +65,12 @@ static inline long get_mte_ctrl(struct task_struct *task)
>   {
>   	return 0;
>   }
> +static inline int mte_ptrace_copy_tags(struct task_struct *child,
> +				       long request, unsigned long addr,
> +				       unsigned long data)
> +{
> +	return -EIO;
> +}
>   
>   #endif
>   
> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> index 06413d9f2341..758ae984ff97 100644
> --- a/arch/arm64/include/uapi/asm/ptrace.h
> +++ b/arch/arm64/include/uapi/asm/ptrace.h
> @@ -76,6 +76,9 @@
>   /* syscall emulation path in ptrace */
>   #define PTRACE_SYSEMU		  31
>   #define PTRACE_SYSEMU_SINGLESTEP  32
> +/* MTE allocation tag access */
> +#define PTRACE_PEEKMTETAGS	  33
> +#define PTRACE_POKEMTETAGS	  34
>   
>   #ifndef __ASSEMBLY__
>   
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index e80c49af74af..0a8b90afe9d7 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -4,14 +4,18 @@
>    */
>   
>   #include <linux/bitops.h>
> +#include <linux/kernel.h>
>   #include <linux/mm.h>
>   #include <linux/prctl.h>
>   #include <linux/sched.h>
> +#include <linux/sched/mm.h>
>   #include <linux/string.h>
>   #include <linux/thread_info.h>
> +#include <linux/uio.h>
>   
>   #include <asm/cpufeature.h>
>   #include <asm/mte.h>
> +#include <asm/ptrace.h>
>   #include <asm/sysreg.h>
>   
>   void mte_sync_tags(pte_t *ptep, pte_t pte)
> @@ -179,3 +183,138 @@ long get_mte_ctrl(struct task_struct *task)
>   
>   	return ret;
>   }
> +
> +/*
> + * Access MTE tags in another process' address space as given in mm. Update
> + * the number of tags copied. Return 0 if any tags copied, error otherwise.
> + * Inspired by __access_remote_vm().
> + */
> +static int __access_remote_tags(struct task_struct *tsk, struct mm_struct *mm,
> +				unsigned long addr, struct iovec *kiov,
> +				unsigned int gup_flags)
> +{
> +	struct vm_area_struct *vma;
> +	void __user *buf = kiov->iov_base;
> +	size_t len = kiov->iov_len;
> +	int ret;
> +	int write = gup_flags & FOLL_WRITE;
> +
> +	if (!access_ok(buf, len))
> +		return -EFAULT;
> +
> +	if (mmap_read_lock_killable(mm))
> +		return -EIO;
> +
> +	while (len) {
> +		unsigned long tags, offset;
> +		void *maddr;
> +		struct page *page = NULL;
> +
> +		ret = get_user_pages_remote(tsk, mm, addr, 1, gup_flags,
> +					    &page, &vma, NULL);
> +		if (ret <= 0)
> +			break;
> +
> +		/*
> +		 * Only copy tags if the page has been mapped as PROT_MTE
> +		 * (PG_mte_tagged set). Otherwise the tags are not valid and
> +		 * not accessible to user. Moreover, an mprotect(PROT_MTE)
> +		 * would cause the existing tags to be cleared if the page
> +		 * was never mapped with PROT_MTE.
> +		 */
> +		if (!test_bit(PG_mte_tagged, &page->flags)) {
> +			ret = -EOPNOTSUPP;
> +			put_page(page);
> +			break;
> +		}
> +
> +		/* limit access to the end of the page */
> +		offset = offset_in_page(addr);
> +		tags = min(len, (PAGE_SIZE - offset) / MTE_GRANULE_SIZE);
> +
> +		maddr = page_address(page);
> +		if (write) {
> +			tags = mte_copy_tags_from_user(maddr + offset, buf, tags);
> +			set_page_dirty_lock(page);
> +		} else {
> +			tags = mte_copy_tags_to_user(buf, maddr + offset, tags);
> +		}
> +		put_page(page);
> +
> +		/* error accessing the tracer's buffer */
> +		if (!tags)
> +			break;
> +
> +		len -= tags;
> +		buf += tags;
> +		addr += tags * MTE_GRANULE_SIZE;
> +	}
> +	mmap_read_unlock(mm);
> +
> +	/* return an error if no tags copied */
> +	kiov->iov_len = buf - kiov->iov_base;
> +	if (!kiov->iov_len) {
> +		/* check for error accessing the tracee's address space */
> +		if (ret <= 0)
> +			return -EIO;
> +		else
> +			return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Copy MTE tags in another process' address space at 'addr' to/from tracer's
> + * iovec buffer. Return 0 on success. Inspired by ptrace_access_vm().
> + */
> +static int access_remote_tags(struct task_struct *tsk, unsigned long addr,
> +			      struct iovec *kiov, unsigned int gup_flags)
> +{
> +	struct mm_struct *mm;
> +	int ret;
> +
> +	mm = get_task_mm(tsk);
> +	if (!mm)
> +		return -EPERM;
> +
> +	if (!tsk->ptrace || (current != tsk->parent) ||
> +	    ((get_dumpable(mm) != SUID_DUMP_USER) &&
> +	     !ptracer_capable(tsk, mm->user_ns))) {
> +		mmput(mm);
> +		return -EPERM;
> +	}
> +
> +	ret = __access_remote_tags(tsk, mm, addr, kiov, gup_flags);
> +	mmput(mm);
> +
> +	return ret;
> +}
> +
> +int mte_ptrace_copy_tags(struct task_struct *child, long request,
> +			 unsigned long addr, unsigned long data)
> +{
> +	int ret;
> +	struct iovec kiov;
> +	struct iovec __user *uiov = (void __user *)data;
> +	unsigned int gup_flags = FOLL_FORCE;
> +
> +	if (!system_supports_mte())
> +		return -EIO;
> +
> +	if (get_user(kiov.iov_base, &uiov->iov_base) ||
> +	    get_user(kiov.iov_len, &uiov->iov_len))
> +		return -EFAULT;
> +
> +	if (request == PTRACE_POKEMTETAGS)
> +		gup_flags |= FOLL_WRITE;
> +
> +	/* align addr to the MTE tag granule */
> +	addr &= MTE_GRANULE_MASK;
> +
> +	ret = access_remote_tags(child, addr, &kiov, gup_flags);
> +	if (!ret)
> +		ret = put_user(kiov.iov_len, &uiov->iov_len);
> +
> +	return ret;
> +}
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 4582014dda25..653a03598c75 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -34,6 +34,7 @@
>   #include <asm/cpufeature.h>
>   #include <asm/debug-monitors.h>
>   #include <asm/fpsimd.h>
> +#include <asm/mte.h>
>   #include <asm/pointer_auth.h>
>   #include <asm/stacktrace.h>
>   #include <asm/syscall.h>
> @@ -1796,6 +1797,12 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
>   long arch_ptrace(struct task_struct *child, long request,
>   		 unsigned long addr, unsigned long data)
>   {
> +	switch (request) {
> +	case PTRACE_PEEKMTETAGS:
> +	case PTRACE_POKEMTETAGS:
> +		return mte_ptrace_copy_tags(child, request, addr, data);
> +	}
> +
>   	return ptrace_request(child, request, addr, data);
>   }
>   
> diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
> index 3c3d0edbbca3..434f81d9a180 100644
> --- a/arch/arm64/lib/mte.S
> +++ b/arch/arm64/lib/mte.S
> @@ -4,7 +4,9 @@
>    */
>   #include <linux/linkage.h>
>   
> +#include <asm/alternative.h>
>   #include <asm/assembler.h>
> +#include <asm/mte.h>
>   #include <asm/page.h>
>   #include <asm/sysreg.h>
>   
> @@ -51,3 +53,54 @@ SYM_FUNC_START(mte_copy_page_tags)
>   	b.ne	1b
>   	ret
>   SYM_FUNC_END(mte_copy_page_tags)
> +
> +/*
> + * Read tags from a user buffer (one tag per byte) and set the corresponding
> + * tags at the given kernel address. Used by PTRACE_POKEMTETAGS.
> + *   x0 - kernel address (to)
> + *   x1 - user buffer (from)
> + *   x2 - number of tags/bytes (n)
> + * Returns:
> + *   x0 - number of tags read/set
> + */
> +SYM_FUNC_START(mte_copy_tags_from_user)
> +	mov	x3, x1
> +	cbz	x2, 2f
> +1:
> +	uao_user_alternative 2f, ldrb, ldtrb, w4, x1, 0
> +	lsl	x4, x4, #MTE_TAG_SHIFT
> +	stg	x4, [x0], #MTE_GRANULE_SIZE
> +	add	x1, x1, #1
> +	subs	x2, x2, #1
> +	b.ne	1b
> +
> +	// exception handling and function return
> +2:	sub	x0, x1, x3		// update the number of tags set
> +	ret
> +SYM_FUNC_END(mte_copy_tags_from_user)
> +
> +/*
> + * Get the tags from a kernel address range and write the tag values to the
> + * given user buffer (one tag per byte). Used by PTRACE_PEEKMTETAGS.
> + *   x0 - user buffer (to)
> + *   x1 - kernel address (from)
> + *   x2 - number of tags/bytes (n)
> + * Returns:
> + *   x0 - number of tags read/set
> + */
> +SYM_FUNC_START(mte_copy_tags_to_user)
> +	mov	x3, x0
> +	cbz	x2, 2f
> +1:
> +	ldg	x4, [x1]
> +	ubfx	x4, x4, #MTE_TAG_SHIFT, #MTE_TAG_SIZE
> +	uao_user_alternative 2f, strb, sttrb, w4, x0, 0
> +	add	x0, x0, #1
> +	add	x1, x1, #MTE_GRANULE_SIZE
> +	subs	x2, x2, #1
> +	b.ne	1b
> +
> +	// exception handling and function return
> +2:	sub	x0, x0, x3		// update the number of tags copied
> +	ret
> +SYM_FUNC_END(mte_copy_tags_to_user)
> 
