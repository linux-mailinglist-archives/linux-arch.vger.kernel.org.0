Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A871E4CD222
	for <lists+linux-arch@lfdr.de>; Fri,  4 Mar 2022 11:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiCDKNf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Mar 2022 05:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiCDKNe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Mar 2022 05:13:34 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F1437AA0;
        Fri,  4 Mar 2022 02:12:45 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id z10so3367624uaa.3;
        Fri, 04 Mar 2022 02:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uS2B76amqrUivQxdB2w6x2mADYcqGePMbA5ahPvBBes=;
        b=RCIpE6wEAaYuKuKX/hp+Oe12HxIgX6sWPqSWPRACWxshXS2i/LzlMn1UK2IrafkheI
         +H/8ANRbrXNuKaRdulMMDyEg52ZccMsk16uhuNpBrxjmD8k6EuqAqpF9xyp4lKj/cHQz
         bJwohnjIZPiA7VYh9zA+iUGRkcgR1j5PJo2OQw5USXJzekubVXJfJcXSPrEzAfL/rPej
         6nZFOuUfUq0j8ziGZrptkFHXxm76dMm2rAE6EKhq7FLtmYSn83O97+IJ4qrwTQ5LrYAv
         SsRGDFNDIfSYHOX0L1omVnqjcbsqWKD74IOGmsGfMjlTQKFWHsiS/HaxnXw0ZJxKDyTd
         zlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uS2B76amqrUivQxdB2w6x2mADYcqGePMbA5ahPvBBes=;
        b=RzzMHGGSZVVr9HRMoF6039jqW596Wzx46oCfE6shRfhHmBh+QNd74G2ZcI98GVBdXX
         rNg3oE+5ebklC6ZPcxjt/dVLrG+GZpz4GkVgmT1flO08TMxRXiXqdjuPr4FZbRbsOk+d
         MpteKcpbVgKXzaDDEJ/xz21OLFYY0MTWCgYQKxYkHEBJvwOFisgcM7jCCQ4paIidyYkY
         O73t47fHtQc9f80rb9h9DBXkEivIMMAr03gz6n36d3pqK+scwEjD0p07+/+3PoOoWahC
         lf/5x9x4qVC/n6WLwVO1hcC9F67+TyS22YqyU/iuAzH+zAvtJgTtyFjLg3rhMRBG3ZLw
         UH1w==
X-Gm-Message-State: AOAM530Np18W6Nhq9tiu10bHmScK9Hr3VmiFPMFrVJ5n/3UDklaL450q
        nMNHtWwpP3K67kVUq53x3CmwKJ+xOjiZdk3lTts=
X-Google-Smtp-Source: ABdhPJw00lQPrCec3/TTZ20tO8Lzug4ENjMEKPnCnZxXCFM/b1zV8TSFgelW8P7mCLV2akEObVBWiXZdgWA1+5zZwqE=
X-Received: by 2002:ab0:2809:0:b0:341:f4aa:829d with SMTP id
 w9-20020ab02809000000b00341f4aa829dmr16117477uap.42.1646388764333; Fri, 04
 Mar 2022 02:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20220226110338.77547-1-chenhuacai@loongson.cn>
 <20220226110338.77547-13-chenhuacai@loongson.cn> <YiDp1VmAv4aMfX3B@kernel.org>
In-Reply-To: <YiDp1VmAv4aMfX3B@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 4 Mar 2022 18:12:31 +0800
Message-ID: <CAAhV-H77MeSNOjh_cr=BuN_ns6Zfq3csN-iVS_nQLDRF+SyQJQ@mail.gmail.com>
Subject: Re: [PATCH V6 12/22] LoongArch: Add memory management
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Mike,

On Fri, Mar 4, 2022 at 12:16 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Sat, Feb 26, 2022 at 07:03:28PM +0800, Huacai Chen wrote:
> > This patch adds memory management support for LoongArch, including:
> > cache and tlb management, page fault handling and ioremap/mmap support.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
>
> ...
>
> > diff --git a/arch/loongarch/include/asm/fixmap.h b/arch/loongarch/include/asm/fixmap.h
> > new file mode 100644
> > index 000000000000..04ac3c871294
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/fixmap.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * fixmap.h: compile-time virtual memory allocation
> > + *
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#ifndef _ASM_FIXMAP_H
> > +#define _ASM_FIXMAP_H
> > +
> > +#include <asm/page.h>
>
> Why this include is needed here?
OK, let's remove it.

>
> > +
> > +#define NR_FIX_BTMAPS 64
> > +
> > +#endif
> > diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
> > new file mode 100644
> > index 000000000000..8619ef2823ad
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/page.h
> > @@ -0,0 +1,127 @@
>
> ...
>
> > +/*
> > + * __pa()/__va() should be used only during mem init.
> > + */
> > +#define __pa(x)              PHYSADDR(x)
> > +#define __va(x)              ((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
> > +
> > +#ifndef __pa_symbol
> > +#define __pa_symbol(x)       __pa(RELOC_HIDE((unsigned long)(x), 0))
> > +#endif
>
> This is the same definition as in include/linux/mm.h.
> Is it required here?
OK, let's remove it.

>
> ...
>
> > diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
> > new file mode 100644
> > index 000000000000..61993cd4c3d7
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/pgtable.h
>
> ...
>
> > +#define PGD_ORDER            0
> > +#define PUD_ORDER            0
> > +#define PMD_ORDER            0
> > +#define PTE_ORDER            0
>
> Is it possible for these to change?
> If not, please remove them.
>
> ...
>
> > diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
> > new file mode 100644
> > index 000000000000..d0170e4d5fe0
> > --- /dev/null
> > +++ b/arch/loongarch/mm/fault.c
> > @@ -0,0 +1,257 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + *
> > + * Derived from MIPS:
> > + * Copyright (C) 1995 - 2000 by Ralf Baechle
> > + */
> > +#include <linux/context_tracking.h>
> > +#include <linux/signal.h>
> > +#include <linux/sched.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/entry-common.h>
> > +#include <linux/errno.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
> > +#include <linux/ptrace.h>
> > +#include <linux/ratelimit.h>
> > +#include <linux/mman.h>
> > +#include <linux/mm.h>
> > +#include <linux/smp.h>
> > +#include <linux/kdebug.h>
> > +#include <linux/kprobes.h>
> > +#include <linux/perf_event.h>
> > +#include <linux/uaccess.h>
> > +
> > +#include <asm/branch.h>
> > +#include <asm/mmu_context.h>
> > +#include <asm/ptrace.h>
> > +
> > +int show_unhandled_signals = 1;
> > +
> > +/*
> > + * This routine handles page faults.  It determines the address,
> > + * and the problem, and then passes it off to one of the appropriate
> > + * routines.
> > + */
> > +static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
> > +     unsigned long address)
> > +{
> > +     int si_code;
> > +     const int field = sizeof(unsigned long) * 2;
> > +     unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
> > +     struct task_struct *tsk = current;
> > +     struct mm_struct *mm = tsk->mm;
> > +     struct vm_area_struct *vma = NULL;
> > +     vm_fault_t fault;
> > +
> > +     static DEFINE_RATELIMIT_STATE(ratelimit_state, 5 * HZ, 10);
> > +
> > +     si_code = SEGV_MAPERR;
> > +
> > +     if (user_mode(regs) && (address & __UA_LIMIT))
> > +             goto bad_area_nosemaphore;
> > +
> > +     /*
> > +      * We fault-in kernel-space virtual memory on-demand. The
> > +      * 'reference' page table is init_mm.pgd.
> > +      *
> > +      * NOTE! We MUST NOT take any locks for this case. We may
> > +      * be in an interrupt or a critical region, and should
> > +      * only copy the information from the master page table,
> > +      * nothing more.
> > +      */
> > +     if (unlikely(address >= MODULES_VADDR && address <= MODULES_END))
> > +             goto no_context;
> > +
> > +     if (unlikely(address >= VMALLOC_START && address <= VMALLOC_END))
> > +             goto no_context;
> > +
> > +     /*
> > +      * If we're in an interrupt or have no user
> > +      * context, we must not take the fault..
> > +      */
> > +     if (faulthandler_disabled() || !mm)
> > +             goto bad_area_nosemaphore;
> > +
> > +     if (user_mode(regs))
> > +             flags |= FAULT_FLAG_USER;
> > +retry:
> > +     mmap_read_lock(mm);
> > +     vma = find_vma(mm, address);
> > +     if (!vma)
> > +             goto bad_area;
> > +     if (vma->vm_start <= address)
> > +             goto good_area;
> > +     if (!(vma->vm_flags & VM_GROWSDOWN))
> > +             goto bad_area;
> > +     if (expand_stack(vma, address))
> > +             goto bad_area;
> > +/*
> > + * Ok, we have a good vm_area for this memory access, so
> > + * we can handle it..
> > + */
> > +good_area:
> > +     si_code = SEGV_ACCERR;
> > +
> > +     if (write) {
> > +             if (!(vma->vm_flags & VM_WRITE))
> > +                     goto bad_area;
> > +             flags |= FAULT_FLAG_WRITE;
> > +     } else {
> > +             if (address == regs->csr_era && !(vma->vm_flags & VM_EXEC))
> > +                     goto bad_area;
> > +             if (!(vma->vm_flags & VM_READ) && exception_era(regs) != address)
> > +                     goto bad_area;
> > +     }
> > +
> > +     /*
> > +      * If for any reason at all we couldn't handle the fault,
> > +      * make sure we exit gracefully rather than endlessly redo
> > +      * the fault.
> > +      */
> > +     fault = handle_mm_fault(vma, address, flags, regs);
> > +
> > +     if (fault_signal_pending(fault, regs)) {
> > +             if (!user_mode(regs))
> > +                     goto no_context;
> > +             return;
> > +     }
> > +
> > +     perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
> > +     if (unlikely(fault & VM_FAULT_ERROR)) {
> > +             if (fault & VM_FAULT_OOM)
> > +                     goto out_of_memory;
> > +             else if (fault & VM_FAULT_SIGSEGV)
> > +                     goto bad_area;
> > +             else if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE))
> > +                     goto do_sigbus;
> > +             BUG();
> > +     }
> > +     if (flags & FAULT_FLAG_ALLOW_RETRY) {
> > +             if (fault & VM_FAULT_MAJOR) {
> > +                     perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
> > +                                               regs, address);
> > +                     tsk->maj_flt++;
> > +             } else {
> > +                     perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
> > +                                               regs, address);
> > +                     tsk->min_flt++;
> > +             }
> > +             if (fault & VM_FAULT_RETRY) {
> > +                     flags &= ~FAULT_FLAG_ALLOW_RETRY;
> > +                     flags |= FAULT_FLAG_TRIED;
> > +
> > +                     /*
> > +                      * No need to mmap_read_unlock(mm) as we would
> > +                      * have already released it in __lock_page_or_retry
> > +                      * in mm/filemap.c.
> > +                      */
> > +
> > +                     goto retry;
> > +             }
> > +     }
> > +
> > +     mmap_read_unlock(mm);
> > +     return;
> > +
> > +/*
> > + * Something tried to access memory that isn't in our memory map..
> > + * Fix it, but check if it's kernel or user first..
> > + */
> > +bad_area:
> > +     mmap_read_unlock(mm);
> > +
> > +bad_area_nosemaphore:
> > +     /* User mode accesses just cause a SIGSEGV */
> > +     if (user_mode(regs)) {
> > +             tsk->thread.csr_badvaddr = address;
> > +             if (!write)
> > +                     tsk->thread.error_code = 1;
> > +             else
> > +                     tsk->thread.error_code = 2;
> > +
> > +             if (show_unhandled_signals &&
> > +                 unhandled_signal(tsk, SIGSEGV) &&
> > +                 __ratelimit(&ratelimit_state)) {
> > +                     pr_info("do_page_fault(): sending SIGSEGV to %s for invalid %s %0*lx\n",
> > +                             tsk->comm,
> > +                             write ? "write access to" : "read access from",
> > +                             field, address);
> > +                     pr_info("era = %0*lx in", field,
> > +                             (unsigned long) regs->csr_era);
> > +                     print_vma_addr(KERN_CONT " ", regs->csr_era);
> > +                     pr_cont("\n");
> > +                     pr_info("ra  = %0*lx in", field,
> > +                             (unsigned long) regs->regs[1]);
> > +                     print_vma_addr(KERN_CONT " ", regs->regs[1]);
> > +                     pr_cont("\n");
> > +             }
> > +             current->thread.trap_nr = read_csr_excode();
> > +             force_sig_fault(SIGSEGV, si_code, (void __user *)address);
> > +             return;
> > +     }
> > +
> > +no_context:
> > +     /* Are we prepared to handle this kernel fault?  */
> > +     if (fixup_exception(regs))
> > +             return;
> > +
> > +     /*
> > +      * Oops. The kernel tried to access some bad page. We'll have to
> > +      * terminate things with extreme prejudice.
> > +      */
> > +     bust_spinlocks(1);
> > +
> > +     pr_alert("CPU %d Unable to handle kernel paging request at "
> > +            "virtual address %0*lx, era == %0*lx, ra == %0*lx\n",
> > +            raw_smp_processor_id(), field, address, field, regs->csr_era,
> > +            field,  regs->regs[1]);
> > +     die("Oops", regs);
> > +
> > +out_of_memory:
> > +     /*
> > +      * We ran out of memory, call the OOM killer, and return the userspace
> > +      * (which will retry the fault, or kill us if we got oom-killed).
> > +      */
> > +     mmap_read_unlock(mm);
> > +     if (!user_mode(regs))
> > +             goto no_context;
> > +     pagefault_out_of_memory();
> > +
> > +     return;
> > +
> > +do_sigbus:
> > +     mmap_read_unlock(mm);
> > +
> > +     /* Kernel mode? Handle exceptions or die */
> > +     if (!user_mode(regs))
> > +             goto no_context;
> > +
> > +     /*
> > +      * Send a sigbus, regardless of whether we were in kernel
> > +      * or user mode.
> > +      */
> > +     current->thread.trap_nr = read_csr_excode();
> > +     tsk->thread.csr_badvaddr = address;
> > +     force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
> > +
>
> The page fault handler is really long.
> Consider splitting it to several functions.
OK, it's difficult but let me try.

>
> > +     return;
> > +}
> > +
> > +asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
> > +     unsigned long write, unsigned long address)
> > +{
> > +     irqentry_state_t state = irqentry_enter(regs);
> > +
> > +     /* Enable interrupt if enabled in parent context */
> > +     if (likely(regs->csr_prmd & CSR_PRMD_PIE))
> > +             local_irq_enable();
> > +
> > +     __do_page_fault(regs, write, address);
> > +
> > +     local_irq_disable();
> > +
> > +     irqentry_exit(regs, state);
> > +}
>
> ...
>
> > diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> > new file mode 100644
> > index 000000000000..b8aa96903056
> > --- /dev/null
> > +++ b/arch/loongarch/mm/init.c
> > @@ -0,0 +1,196 @@
>
> ...
>
> > +void free_init_pages(const char *what, unsigned long begin, unsigned long end)
> > +{
>
> This function seems unused
OK, let's remove it.

>
> > +     unsigned long pfn;
> > +
> > +     for (pfn = PFN_UP(begin); pfn < PFN_DOWN(end); pfn++) {
> > +             struct page *page = pfn_to_page(pfn);
> > +             void *addr = phys_to_virt(PFN_PHYS(pfn));
> > +
> > +             memset(addr, POISON_FREE_INITMEM, PAGE_SIZE);
> > +             free_reserved_page(page);
> > +     }
> > +     pr_info("Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
> > +}
> > +
> > +#ifdef CONFIG_BLK_DEV_INITRD
> > +void free_initrd_mem(unsigned long start, unsigned long end)
> > +{
>
> There is a generic free_initrd_mem(), no need to override it.
OK, let's remove it.

Huacai
>
> > +     free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
> > +                        "initrd");
> > +}
> > +#endif
>
> --
> Sincerely yours,
> Mike.
