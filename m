Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7100238E22B
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 10:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhEXIOv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 04:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhEXIOv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 May 2021 04:14:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D00C061574
        for <linux-arch@vger.kernel.org>; Mon, 24 May 2021 01:13:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so10516907wmg.3
        for <linux-arch@vger.kernel.org>; Mon, 24 May 2021 01:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hkoJ4XU3fJYIUXpsvaVz4eo9jPqdu/8/7QTK7vX9wJM=;
        b=pL2oo52tUpRLBy49VIx5zFQfFs5QoWz6wCdaZlOZynpDEiny/Ix3dTTLDNMS3jTgP+
         CAvTt0KKu+xM5jHc9zloqeIu+MILVF1fS0tLdulYu0KHAhGdkXyg/ezsgjuFDshU/ipv
         Nc6vA/sFhFWX0CtXzfB8q/dBybiq/y3SCsxnogvRPd8VgF5hhq3CT56rtSKRNN3rsHZ9
         6xA8OndA1FmuRj6PzaoOaJ9Kr0EEIbMfvHcy78eF3jAhKwg9eXN9h0Cs+EykFPkbD5cP
         6mo1yQO1u3Iqh6grda/3LMtWRo+eGmxP449xoKZhaNwwtAnAhYQJrtAzarXyd2pmiP4f
         /DfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkoJ4XU3fJYIUXpsvaVz4eo9jPqdu/8/7QTK7vX9wJM=;
        b=fvbtefuQJNk69HLO8D6ihSMpcBLq86qiqMXiqe68LVzHC4pU0T4EuxXkk9/FKkHTXp
         5R4YrvShzs9uYm9As4E+cLl+ovztGN6MrBCOwMkMpwJt69NMECiFd/6Jc4EoR4V2R/5W
         Gg1ERs4BxW6RKfQ3WEDgalEVs2f8MH2ACM2WudfrWkTWCHmvijuyZ5w+KFS9qyGDbHE2
         wFdbykG7hJa5wS9/GS1jGe8XRCubRMCLrA0FcU0ZFzdKKMp/duv3D1PBNe4yWeWT/Y5r
         UWOv9Bq9akBl6TlOAcsQur12SOkVCFPtZYeVy5SJ71roM0ftUAuQb/fA3QdpEd89GwBV
         s55w==
X-Gm-Message-State: AOAM533tFj4CNrR0DLueNc70S/ydBrwUDClf5r9h2+WP1emSJpwiWehg
        CLuzezwiO2j19zmyEUXBrIpbW7Uk650JjiYs2w/DuQ==
X-Google-Smtp-Source: ABdhPJyC2jCu7SFxxUWfosx6Xigmxy1B2+g0gPGzW98vy1plPs28wHz7rs4SviVoeR8UnTFwEAYZZhBVno/WhE+51kM=
X-Received: by 2002:a1c:4e0b:: with SMTP id g11mr18341827wmh.3.1621844001916;
 Mon, 24 May 2021 01:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <1621839068-31738-1-git-send-email-guoren@kernel.org> <1621839068-31738-3-git-send-email-guoren@kernel.org>
In-Reply-To: <1621839068-31738-3-git-send-email-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 24 May 2021 13:43:10 +0530
Message-ID: <CAAhSdy16yXsuPRBv2Sn-OJwEhvs1UkdMUr1jqhB8qxXo+Mu7=w@mail.gmail.com>
Subject: Re: [PATCH 3/3] riscv: Use use_asid_allocator flush TLB
To:     Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 24, 2021 at 12:22 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Use static_branch_unlikely(&use_asid_allocator) to keep the origin
> tlb flush style, so it's no effect on the existing machine. Here
> are the optimized functions:
>  - flush_tlb_mm
>  - flush_tlb_page
>  - flush_tlb_range
>
> All above are based on the below new implement functions:
>  - __sbi_tlb_flush_range_asid
>  - local_flush_tlb_range_asid
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/include/asm/mmu_context.h |  2 ++
>  arch/riscv/include/asm/tlbflush.h    | 22 ++++++++++++++++++++
>  arch/riscv/mm/context.c              |  2 +-
>  arch/riscv/mm/tlbflush.c             | 40 +++++++++++++++++++++++++++++++++---
>  4 files changed, 62 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
> index b065941..7030837 100644
> --- a/arch/riscv/include/asm/mmu_context.h
> +++ b/arch/riscv/include/asm/mmu_context.h
> @@ -33,6 +33,8 @@ static inline int init_new_context(struct task_struct *tsk,
>         return 0;
>  }
>
> +DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
> +
>  #include <asm-generic/mmu_context.h>
>
>  #endif /* _ASM_RISCV_MMU_CONTEXT_H */
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index c84218a..9390319 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -8,6 +8,7 @@
>  #define _ASM_RISCV_TLBFLUSH_H
>
>  #include <linux/mm_types.h>
> +#include <asm/page.h>
>  #include <asm/smp.h>
>  #include <asm/errata_list.h>
>
> @@ -22,9 +23,30 @@ static inline void local_flush_tlb_page(unsigned long addr)
>  {
>         ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
>  }
> +
> +static inline void local_flush_tlb_range_asid(unsigned long start, unsigned long size,
> +                                             unsigned long asid)
> +{
> +       unsigned long page_add = PAGE_DOWN(start);
> +       unsigned long page_end = PAGE_UP(start + size);

Your PATCH2 is not correct because PAGE_UP(x) should in-fact
return 0 when x == 0.

In fact, if both "start" and "size" are zero then both page_add and
page_end should be zero so that no "sfence.vma" is executed.

If you want at least one TLB entry to be invalidated when size == 0
then you can simply set "size = 1" when size is zero which will force
one TLB invalidation.

Please drop your PATCH2 and the rest of the things look good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> +
> +       if (size == -1) {
> +               __asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (asid) : "memory");
> +               return;
> +       }
> +
> +       while(page_add < page_end) {
> +               __asm__ __volatile__ ("sfence.vma %0, %1"
> +                               :
> +                               : "r" (page_add), "r" (asid)
> +                               : "memory");
> +               page_add += PAGE_SIZE;
> +       }
> +}
>  #else /* CONFIG_MMU */
>  #define local_flush_tlb_all()                  do { } while (0)
>  #define local_flush_tlb_page(addr)             do { } while (0)
> +#define local_flush_tlb_range_asid(addr)       do { } while (0)
>  #endif /* CONFIG_MMU */
>
>  #if defined(CONFIG_SMP) && defined(CONFIG_MMU)
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 68aa312..45c1b04 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -18,7 +18,7 @@
>
>  #ifdef CONFIG_MMU
>
> -static DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
> +DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
>
>  static unsigned long asid_bits;
>  static unsigned long num_asids;
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 720b443..69588dc 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -4,6 +4,7 @@
>  #include <linux/smp.h>
>  #include <linux/sched.h>
>  #include <asm/sbi.h>
> +#include <asm/mmu_context.h>
>
>  void flush_tlb_all(void)
>  {
> @@ -39,18 +40,51 @@ static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
>         put_cpu();
>  }
>
> +static void __sbi_tlb_flush_range_asid(struct cpumask *cmask, unsigned long start,
> +                                      unsigned long size, unsigned long asid)
> +{
> +       struct cpumask hmask;
> +       unsigned int cpuid;
> +
> +       if (cpumask_empty(cmask))
> +               return;
> +
> +       cpuid = get_cpu();
> +
> +       if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids) {
> +               local_flush_tlb_range_asid(start, size, asid);
> +       } else {
> +               riscv_cpuid_to_hartid_mask(cmask, &hmask);
> +               sbi_remote_sfence_vma_asid(cpumask_bits(&hmask), start, size, asid);
> +       }
> +
> +       put_cpu();
> +}
> +
>  void flush_tlb_mm(struct mm_struct *mm)
>  {
> -       __sbi_tlb_flush_range(mm_cpumask(mm), 0, -1);
> +       if (static_branch_unlikely(&use_asid_allocator))
> +               __sbi_tlb_flush_range_asid(mm_cpumask(mm), 0, -1,
> +                                          atomic_long_read(&mm->context.id));
> +       else
> +               __sbi_tlb_flush_range(mm_cpumask(mm), 0, -1);
>  }
>
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
>  {
> -       __sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE);
> +       if (static_branch_unlikely(&use_asid_allocator))
> +               __sbi_tlb_flush_range_asid(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE,
> +                                          atomic_long_read(&vma->vm_mm->context.id));
> +       else
> +               __sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE);
>  }
>
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>                      unsigned long end)
>  {
> -       __sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), start, end - start);
> +       if (static_branch_unlikely(&use_asid_allocator))
> +               __sbi_tlb_flush_range_asid(mm_cpumask(vma->vm_mm), start, end - start,
> +                                          atomic_long_read(&vma->vm_mm->context.id));
> +       else
> +               __sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), start, end - start);
>  }
> --
> 2.7.4
>
