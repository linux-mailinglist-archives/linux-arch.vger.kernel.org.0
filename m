Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBB5394EBA
	for <lists+linux-arch@lfdr.de>; Sun, 30 May 2021 02:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhE3AxK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 May 2021 20:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhE3AxJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 May 2021 20:53:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D5C561107;
        Sun, 30 May 2021 00:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622335892;
        bh=PWNzmVem9VS//uwig1vEDgd9W083PCsm3baFjr0EQlQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dz5ODyQj3jZj9vOkeVa+Q50fMJBAiUfYq8x2cPJi19s/pSdXtJtMmlqH16qJ5n8/y
         W3GyGlb+MwGXn3jg/78Tqg9ccouo0cTqzCqBN2XD6LJMuF4ltnhSdQk7jPc85sp6Ac
         qMOtei5Lo6+xfbAlgysc2kXZHv/mqY23blpHI683qZSQ0uKUbjCizEAO3TFWyFI/qi
         PB9bL2OV0r5SyxBrVvFEoqV3TgHP/azY4VqE6PGsyssRAMVkLNMNo18PxMyxNRIyQo
         zkdtde9FniQ0TR4M/ljUOnKiD0HnCrPpsyWA8ZBtYcMVU3ddGHsHzPLiNeL5egwe1b
         L5pNTAT3NXxiw==
Received: by mail-lj1-f171.google.com with SMTP id p20so10105041ljj.8;
        Sat, 29 May 2021 17:51:32 -0700 (PDT)
X-Gm-Message-State: AOAM5321IGKLvZTIs7TWVh3H3zNTGWK3jIZ2QFmd0tKoDCrJwDMEGKhK
        ooujJA4ofTUgwlOdBtu792ZEZUyQn8g7gVwsfR4=
X-Google-Smtp-Source: ABdhPJz2oQ+nB/fKMvvqGrO2vZx+W5md+YIZJDzAEE/bZLcrKJ81oJQTDekOEPMm2E0lbAsEqzAbwAmkbFgNTITKBLQ=
X-Received: by 2002:a05:651c:502:: with SMTP id o2mr11500461ljp.105.1622335890517;
 Sat, 29 May 2021 17:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210527070903.GA32653@lst.de> <mhng-cfb5a043-4b59-4698-b732-5cf5ceb49114@palmerdabbelt-glaptop>
In-Reply-To: <mhng-cfb5a043-4b59-4698-b732-5cf5ceb49114@palmerdabbelt-glaptop>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 30 May 2021 08:51:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQr-5BZeZZo3YfmvjBCC6AkDMKubAR_9kcgYiBu_q8FYw@mail.gmail.com>
Message-ID: <CAJF2gTQr-5BZeZZo3YfmvjBCC6AkDMKubAR_9kcgYiBu_q8FYw@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] riscv: Use use_asid_allocator flush TLB
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Christoph Hellwig <hch@lst.de>, Anup Patel <Anup.Patel@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, May 30, 2021 at 7:42 AM <palmerdabbelt@google.com> wrote:
>
> On Thu, 27 May 2021 00:09:03 PDT (-0700), Christoph Hellwig wrote:
> > On Wed, May 26, 2021 at 05:49:21AM +0000, guoren@kernel.org wrote:
> >> From: Guo Ren <guoren@linux.alibaba.com>
> >>
> >> Use static_branch_unlikely(&use_asid_allocator) to keep the origin
> >> tlb flush style, so it's no effect on the existing machine. Here
> >> are the optimized functions:
> >>  - flush_tlb_mm
> >>  - flush_tlb_page
> >>  - flush_tlb_range
> >>
> >> All above are based on the below new implement functions:
> >>  - __sbi_tlb_flush_range_asid
> >>  - local_flush_tlb_range_asid
> >>
> >> These functions are based on ASID instead of previous non-ASID
> >> tlb_flush implementation which invalidates more useful tlb
> >> entries.
> >
> > I still think the commit message is incomplete and rather misleading.
> > Here is what I'd come up with from reading the patch:
> >
> > ---------
> > Subject: add ASID-based tlbflushing methods
> >
> > Implement optimized version of the tlb flushing routines for systems
> > using ASIDs.  These are behind the use_asid_allocator static branch to
> > not affect existing systems not using ASIDs.
> > ---------
>
> That seems much better, thanks.
>
> >> +static inline void local_flush_tlb_range_asid(unsigned long start,
> >> +                            unsigned long size, unsigned long asid)
> >> +{
> >> +    unsigned long tmp, end = ALIGN(start + size, PAGE_SIZE);
> >> +
> >> +    for (tmp = start & PAGE_MASK; tmp < end; tmp += PAGE_SIZE) {
> >> +            __asm__ __volatile__ ("sfence.vma %0, %1"
> >> +                            :
> >> +                            : "r" (tmp), "r" (asid)
> >> +                            : "memory");
> >> +            tmp += PAGE_SIZE;
> >> +    }
> >
> > This double increments tmp.
> >
> > Also the non-ASID code switches to a global flush once flushing more
> > than a single page.  It might be worth documenting the tradeoff in the
> > code.
>
> For some reason I thought we'd written this down in the commentary of
> teh ISA manual as the suggested huersitic here, but I can't find it so
> maybe I'm wrong.  If it's actually there it would be good to point that
> out, otherwise some documentation seems fine as it'll probably become a
> tunable at some point anyway.
From my view: "non-ASID code switches to a global flush all" is a
hardware bug fixup, so I just reserved it to prevent breaking other
machines.

The comment for the "non-ASID code" should be another patch.

>
> >> +static void __sbi_tlb_flush_range_asid(struct cpumask *cmask,
> >> +                                   unsigned long start,
> >> +                                   unsigned long size,
> >> +                                   unsigned long asid)
> >> +{
> >
> > I don't think the calling conventions here are optimal.  I'd pass
> > the mm_struct as the first argument, as we can derive both the cpumask
> > and asid from it instead of doing that in the callers.
> >
> > But more importantly I think the static branch check can be moved deeper
> > into the code to avoid a lot of duplication.  What do you think of this
> > version?
> >
> > diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
> > index b0659413a080..7030837adc1a 100644
> > --- a/arch/riscv/include/asm/mmu_context.h
> > +++ b/arch/riscv/include/asm/mmu_context.h
> > @@ -33,6 +33,8 @@ static inline int init_new_context(struct task_struct *tsk,
> >       return 0;
> >  }
> >
> > +DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
> > +
> >  #include <asm-generic/mmu_context.h>
> >
> >  #endif /* _ASM_RISCV_MMU_CONTEXT_H */
> > diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> > index 68aa312fc352..45c1b04b105d 100644
> > --- a/arch/riscv/mm/context.c
> > +++ b/arch/riscv/mm/context.c
> > @@ -18,7 +18,7 @@
> >
> >  #ifdef CONFIG_MMU
> >
> > -static DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
> > +DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
> >
> >  static unsigned long asid_bits;
> >  static unsigned long num_asids;
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index 720b443c4528..d8afbb1269d5 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -4,6 +4,33 @@
> >  #include <linux/smp.h>
> >  #include <linux/sched.h>
> >  #include <asm/sbi.h>
> > +#include <asm/mmu_context.h>
> > +
> > +static inline void local_flush_tlb_all_asid(unsigned long asid)
> > +{
> > +     __asm__ __volatile__ ("sfence.vma x0, %0"
> > +                     :
> > +                     : "r" (asid)
> > +                     : "memory");
> > +}
> > +
> > +static inline void local_flush_tlb_page_asid(unsigned long addr,
> > +             unsigned long asid)
> > +{
> > +     __asm__ __volatile__ ("sfence.vma %0, %1"
> > +                     :
> > +                     : "r" (addr), "r" (asid)
> > +                     : "memory");
> > +}
> > +
> > +static inline void local_flush_tlb_range_asid(unsigned long start,
> > +                             unsigned long size, unsigned long asid)
> > +{
> > +     unsigned long addr, end = ALIGN(start + size, PAGE_SIZE);
> > +
> > +     for (addr = start & PAGE_MASK; addr < end; addr += PAGE_SIZE)
> > +             local_flush_tlb_page_asid(addr, asid);
> > +}
> >
> >  void flush_tlb_all(void)
> >  {
> > @@ -12,28 +39,43 @@ void flush_tlb_all(void)
> >
> >  /*
> >   * This function must not be called with cmask being null.
> > - * Kernel may panic if cmask is NULL.
> >   */
> > -static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
> > +static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
> >                                 unsigned long size)
> >  {
> > +     struct cpumask *cmask = mm_cpumask(mm);
> >       struct cpumask hmask;
> >       unsigned int cpuid;
> > +     bool broadcast;
> >
> >       if (cpumask_empty(cmask))
> >               return;
> >
> >       cpuid = get_cpu();
> > +     /* check if the tlbflush needs to be sent to other CPUs */
> > +     broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
> > +     if (static_branch_unlikely(&use_asid_allocator)) {
> > +             unsigned long asid = atomic_long_read(&mm->context.id);
> >
> > -     if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids) {
> > -             /* local cpu is the only cpu present in cpumask */
> > -             if (size <= PAGE_SIZE)
> > +             if (broadcast) {
> > +                     riscv_cpuid_to_hartid_mask(cmask, &hmask);
> > +                     sbi_remote_sfence_vma_asid(cpumask_bits(&hmask),
> > +                                                start, size, asid);
> > +             } else if (size != -1) {
> > +                     local_flush_tlb_range_asid(start, size, asid);
> > +             } else {
> > +                     local_flush_tlb_all_asid(asid);
> > +             }
> > +     } else {
> > +             if (broadcast) {
> > +                     riscv_cpuid_to_hartid_mask(cmask, &hmask);
> > +                     sbi_remote_sfence_vma(cpumask_bits(&hmask),
> > +                                           start, size);
> > +             } else if (size <= PAGE_SIZE) {
> >                       local_flush_tlb_page(start);
> > -             else
> > +             } else {
> >                       local_flush_tlb_all();
> > -     } else {
> > -             riscv_cpuid_to_hartid_mask(cmask, &hmask);
> > -             sbi_remote_sfence_vma(cpumask_bits(&hmask), start, size);
> > +             }
> >       }
> >
> >       put_cpu();
> > @@ -41,16 +83,16 @@ static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
> >
> >  void flush_tlb_mm(struct mm_struct *mm)
> >  {
> > -     __sbi_tlb_flush_range(mm_cpumask(mm), 0, -1);
> > +     __sbi_tlb_flush_range(mm, 0, -1);
> >  }
> >
> >  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
> >  {
> > -     __sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE);
> > +     __sbi_tlb_flush_range(vma->vm_mm, addr, PAGE_SIZE);
> >  }
> >
> >  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
> >                    unsigned long end)
> >  {
> > -     __sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), start, end - start);
> > +     __sbi_tlb_flush_range(vma->vm_mm, start, end - start);
> >  }
>
> LGTM.  I took the first one as IMO they're really distnict issues, LMK
> if you want to re-spin this one or if I should just take what's here.



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
