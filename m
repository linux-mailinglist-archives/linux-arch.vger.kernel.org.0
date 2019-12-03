Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5EF310FC67
	for <lists+linux-arch@lfdr.de>; Tue,  3 Dec 2019 12:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfLCLTO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Dec 2019 06:19:14 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35091 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCLTO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Dec 2019 06:19:14 -0500
Received: by mail-ot1-f67.google.com with SMTP id o9so2580266ote.2;
        Tue, 03 Dec 2019 03:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5mdmtX3+jMXoVvb5O8j8UAKbymjN3XPtjARaA0bV7U=;
        b=GUbefyN53wHfdORWOAAeT7hVJ/4yvNexdIW+/8hTE5EqdoiEpAveH4pGvnGd6ZGv5L
         JXuM7bI6HV0wcw5F/MkwXmH2YaPUxYpCwek4+ampBZ2je/RwPtImjZPnUMpz0Hq+3xnU
         ti9hYaYV4ev8HRQzs1oL3FgCCH7n05ud+XAJ/26jB8zv8v+IIJkHFSM0ib8LJQ817jjv
         zyMf57dYK4d4AUCXyEV21zlA9zl5V3z6P3vQ1TWGdBvQxjUcSRLhwki4utbjrKed4Q1F
         mGQmOmBw9s3F5c3boMDp2vRvnqXJuB+RPRv3hQ4Nx+VPsob7q8y1nva29oQGH1ojLM0l
         3zxA==
X-Gm-Message-State: APjAAAVbdsovaI8rCGdH0ucrDOvZ6jbCixxgEQrLZ4Aqn5+OJaeYGRVy
        BmRFtBye6T/ZT8QUBa5b9Zr+xaE0ETGTzbii1PY=
X-Google-Smtp-Source: APXvYqyVYdX+faUG92Wmv+COJLFc8n7CTvx8AdFlFg1kSzIYaFjbrAzaf/lkGqiGBhsDAtpHCPkbvxy4IWo7IeVZVwY=
X-Received: by 2002:a9d:3a37:: with SMTP id j52mr2774136otc.39.1575371951874;
 Tue, 03 Dec 2019 03:19:11 -0800 (PST)
MIME-Version: 1.0
References: <20190219103148.192029670@infradead.org> <20190219103233.443069009@infradead.org>
In-Reply-To: <20190219103233.443069009@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Dec 2019 12:19:00 +0100
Message-ID: <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hoi Peter,

On Tue, Feb 19, 2019 at 11:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
> Generic mmu_gather provides everything SH needs (range tracking and
> cache coherency).
>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I got remote access to an SH7722-based Migo-R again, which spews a long
sequence of BUGs during userspace startup.  I've bisected this to commit
c5b27a889da92f4a ("sh/tlb: Convert SH to generic mmu_gather").
Do you have a clue?
Thanks!

mount: mounting none on /dev failed: No such device
BUG: Bad page state in process grep  pfn:0e8c1
page:8fb50820 count:0 mapcount:2 mapping:8f403480 index:0x0
  (null)
flags: 0xc000000()
raw: 0c000000 00000100 00000200 8f403480 00000000 00000000 00000001 00000000
page dumped because: non-NULL mapping
CPU: 0 PID: 765 Comm: grep Tainted: G        W
5.1.0-rc3-migor-00024-gc5b27a889da92f4a #31
Stack: (0x8e8a7d4c to 0x8e8a8000)
7d40: 8c072e90 8fb50820 8fbf400c 00000000 8c0734bc
7d60: 00000200 8fbf4010 00000001 00000002 8fbf4000 00000002 8fbf400c 8e8a7d9c
7d80: 0030f231 00000100 8e8a7da0 00000000 8c2a8a38 8c2a8c0c 8c2a8a94 8c339fa0
7da0: 8fb052a4 8fb052a4 9165dc07 8c0744ea 00000010 00000000 8c0027ac 00000000
7dc0: 8c073ad0 8e8a7df8 8fb054a0 8fb50980 8c07ab54 000000aa 00000011 8e8b52b4
7de0: 00010000 000000aa 8c2a8a38 8fb50820 8c0027ac 00000000 8fb50824 8fb054a4
7e00: 9165dc07 8c0928e0 8c210e48 8c28900c 8e8a7ecc 8e8a7ee4 8c07a958 00000000
7e20: 8e8b5000 8c09296e 8e8a7ed4 8c08f414 8c28900c 8e8a7e60 8e8a7ecc 00000000
7e40: 9165dc07 8c099d08 8ef16178 8c339f60 00000001 00000000 8c0950bc 8c0027ac
7e60: 8c08b00e 7ba1bfff 40000000 7ba1c000 00000000 7ba1bfff 00000000 ffffffff
7e80: 8c08b1ec 8ef16140 8c08ae58 00000000 8ef16140 7b9fb000 8c094fe4 9165dc07
7ea0: 8c0929e6 8e8a7ecc 00000001 8e8a7ecc 8c092b3e 00100000 00000001 8e8a7ecc
7ec0: 8c090cfe 00000000 8ef16020 8f4b78e0 ffffffff ffffffff 8fb50501 00000001
7ee0: 8e8b5000 8e8b5000 00000000 00000008 8fb74f80 8fb74fa0 8fb74f00 8fb74f20
7f00: 8fb74f40 8fb74f60 8fb76c00 8fb76c20 9165dc07 8c0128a2 00000000 00000000
7f20: 8f4b7918 8f4b78e0 00000000 8f4b78e0 8c016326 8ea34f00 8ea3503c 8ea34f00
7f40: 8ea351bc 00000000 8ea3503c 8ea3507c 8c297c1c 8f4a717c 8f4f37a0 9165dc07
7f60: 8c016a58 7ba1bbe4 00000000 00000000 00000000 8eedd720 8eedd6e0 00000000
7f80: 8c016ac6 00000000 00000071 00000100 8c016abc 8c006242 00000000 00427b38
7fa0: 004c025c 00000000 00427b38 004c025c 000000fc 00000000 000000fc fffff000
7fc0: 00000000 00098d9c 00000000 004ac6f4 7ba1be94 00000000 00000000 7ba1bbe4
7fe0: 7ba1bbe4 00427b4e 0040a978 00000101 004c5450 00000022 ffffd000 00000044

Call trace:
 [<(ptrval)>] free_pcppages_bulk+0x114/0x33c
 [<(ptrval)>] free_unref_page_list+0xae/0x10c
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] free_unref_page_commit.isra.24+0x0/0x74
 [<(ptrval)>] release_pages+0x1fc/0x2d0
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] tlb_flush_mmu_free+0x30/0x4c
 [<(ptrval)>] down_read+0x0/0xc
 [<(ptrval)>] release_pages+0x0/0x2d0
 [<(ptrval)>] tlb_flush_mmu+0x72/0xc0
 [<(ptrval)>] remove_vma+0x0/0x48
 [<(ptrval)>] kmem_cache_free+0x34/0x90
 [<(ptrval)>] unlink_anon_vmas+0xd8/0x150
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] free_pgd_range+0x1b6/0x324
 [<(ptrval)>] free_pgtables+0x70/0xb4
 [<(ptrval)>] free_pgd_range+0x0/0x324
 [<(ptrval)>] unlink_anon_vmas+0x0/0x150
 [<(ptrval)>] arch_tlb_finish_mmu+0x2a/0x74
 [<(ptrval)>] tlb_finish_mmu+0x1a/0x38
 [<(ptrval)>] exit_mmap+0xa2/0x16c
 [<(ptrval)>] mmput+0x2a/0x80
 [<(ptrval)>] do_exit+0x186/0x85c
 [<(ptrval)>] do_group_exit+0x2c/0x90
 [<(ptrval)>] sys_exit_group+0xa/0x10
 [<(ptrval)>] sys_exit_group+0x0/0x10
 [<(ptrval)>] syscall_call+0x18/0x1e

Disabling lock debugging due to kernel taint
BUG: Bad page state in process rcS  pfn:0ee78
page:8fb5bf00 count:0 mapcount:2 mapping:8f403480 index:0x0
  (null)
flags: 0xc000000()
raw: 0c000000 00000100 00000200 8f403480 00000000 00000000 00000001 00000000
page dumped because: non-NULL mapping
CPU: 0 PID: 763 Comm: rcS Tainted: G    B   W
5.1.0-rc3-migor-00024-gc5b27a889da92f4a #31
Stack: (0x8ef55e54 to 0x8ef56000)
5e40: 8c072e90 8fb5bf00 8fbf400c
5e60: 00000000 8c0734bc 00000200 8fbf4010 00000001 00000002 8fbf4000 00000002
5e80: 8fbf400c 00989680 0030f231 00000100 8ef55ea8 00000000 8c2a8a38 00000028
5ea0: 00000000 8c29d340 8fb05344 8fb05344 b362ad67 8c074416 8f4f38e0 8c0027ac
5ec0: 8e9125e0 00000000 00000000 8c0027ac 8fb50760 8c0a59e4 8e9125a0 00000180
5ee0: 00000010 8c0a5a9a 8f4a69e0 8f01ad00 8f4f38e0 8f01b21c 8e9125a0 8c09f526
5f00: 8f414cf0 8f01b120 8f4f38e0 8c0281e0 8c20f7dc 8f4a6cdc 00000000 8f4a6cec
5f20: 8c003c18 00401f80 004c6aa0 00000000 8ef55fa4 8ef55fa4 09000080 8c28900c
5f40: 00000000 b362ad67 8c00bbde 8ef55fe4 8f4b7aa0 00000001 09000000 8f4a6c1c
5f60: 004c6ab4 00000055 8c215f8c ffff8bce 00000004 00000009 00003f10 8f4f38e0
5f80: b362ad67 8c0060f8 00401f80 004c6aa0 00000000 00000000 40000000 00000100
5fa0: 8ef54000 00000000 00000450 00000002 00000006 00000003 00000000 004c6ab4
5fc0: 00000000 7bdf069c 004c61d4 00000003 004c61bc 7bdf0670 004c6aa0 00401f80
5fe0: 7bdf069c 00401f94 0047d1cc 00000001 004c5450 00000043 0000000c 00000044

Call trace:
 [<(ptrval)>] free_pcppages_bulk+0x114/0x33c
 [<(ptrval)>] free_unref_page+0x4a/0x70
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] free_pipe_info+0x60/0x84
 [<(ptrval)>] pipe_release+0x92/0xb8
 [<(ptrval)>] __fput+0x3e/0x120
 [<(ptrval)>] task_work_run+0x78/0xa8
 [<(ptrval)>] _cond_resched+0x0/0x54
 [<(ptrval)>] do_notify_resume+0xd4/0x4c8
 [<(ptrval)>] do_page_fault+0xda/0x2a8
 [<(ptrval)>] resume_userspace+0x0/0x10

BUG: Bad page state in process rcS  pfn:0e8b2
page:8fb50640 count:0 mapcount:1026 mapping:8f403480 index:0x0
  (null)
flags: 0xc000000()
raw: 0c000000 00000100 00000200 8f403480 00000000 00000000 00000401 00000000
page dumped because: non-NULL mapping
CPU: 0 PID: 763 Comm: rcS Tainted: G    B   W
5.1.0-rc3-migor-00024-gc5b27a889da92f4a #31
Stack: (0x8ef55e54 to 0x8ef56000)
5e40: 8c072e90 8fb50640 8fbf400c
5e60: 00000000 8c0734bc 00000200 8fbf4010 00000001 00000001 8fbf4000 00000001
5e80: 8fbf400c 00989680 0030f231 00000100 8ef55ea8 00000000 8c2a8a38 00000028
5ea0: 00000000 8c29d340 8fb05344 8fb05344 b362ad67 8c074416 8f4f38e0 8c0027ac
5ec0: 8e9125e0 00000000 00000000 8c0027ac 8fb50760 8c0a59e4 8e9125a0 00000180
5ee0: 00000010 8c0a5a9a 8f4a69e0 8f01ad00 8f4f38e0 8f01b21c 8e9125a0 8c09f526
5f00: 8f414cf0 8f01b120 8f4f38e0 8c0281e0 8c20f7dc 8f4a6cdc 00000000 8f4a6cec
5f20: 8c003c18 00401f80 004c6aa0 00000000 8ef55fa4 8ef55fa4 09000080 8c28900c
5f40: 00000000 b362ad67 8c00bbde 8ef55fe4 8f4b7aa0 00000001 09000000 8f4a6c1c
5f60: 004c6ab4 00000055 8c215f8c ffff8bce 00000004 00000009 00003f10 8f4f38e0
5f80: b362ad67 8c0060f8 00401f80 004c6aa0 00000000 00000000 40000000 00000100
5fa0: 8ef54000 00000000 00000450 00000002 00000006 00000003 00000000 004c6ab4
5fc0: 00000000 7bdf069c 004c61d4 00000003 004c61bc 7bdf0670 004c6aa0 00401f80
5fe0: 7bdf069c 00401f94 0047d1cc 00000001 004c5450 00000043 0000000c 00000044

Call trace:
 [<(ptrval)>] free_pcppages_bulk+0x114/0x33c
 [<(ptrval)>] free_unref_page+0x4a/0x70
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] free_pipe_info+0x60/0x84
 [<(ptrval)>] pipe_release+0x92/0xb8
 [<(ptrval)>] __fput+0x3e/0x120
 [<(ptrval)>] task_work_run+0x78/0xa8
 [<(ptrval)>] _cond_resched+0x0/0x54
 [<(ptrval)>] do_notify_resume+0xd4/0x4c8
 [<(ptrval)>] do_page_fault+0xda/0x2a8
 [<(ptrval)>] resume_userspace+0x0/0x10
...

> ---
>  arch/sh/include/asm/pgalloc.h |    7 ++
>  arch/sh/include/asm/tlb.h     |  130 ------------------------------------------
>  2 files changed, 8 insertions(+), 129 deletions(-)
>
> --- a/arch/sh/include/asm/pgalloc.h
> +++ b/arch/sh/include/asm/pgalloc.h
> @@ -72,6 +72,15 @@ do {                                                 \
>         tlb_remove_page((tlb), (pte));                  \
>  } while (0)
>
> +#if CONFIG_PGTABLE_LEVELS > 2
> +#define __pmd_free_tlb(tlb, pmdp, addr)                        \
> +do {                                                   \
> +       struct page *page = virt_to_page(pmdp);         \
> +       pgtable_pmd_page_dtor(page);                    \
> +       tlb_remove_page((tlb), page);                   \
> +} while (0);
> +#endif
> +
>  static inline void check_pgt_cache(void)
>  {
>         quicklist_trim(QUICK_PT, NULL, 25, 16);
> --- a/arch/sh/include/asm/tlb.h
> +++ b/arch/sh/include/asm/tlb.h
> @@ -11,131 +11,8 @@
>
>  #ifdef CONFIG_MMU
>  #include <linux/swap.h>
> -#include <asm/pgalloc.h>
> -#include <asm/tlbflush.h>
> -#include <asm/mmu_context.h>
> -
> -/*
> - * TLB handling.  This allows us to remove pages from the page
> - * tables, and efficiently handle the TLB issues.
> - */
> -struct mmu_gather {
> -       struct mm_struct        *mm;
> -       unsigned int            fullmm;
> -       unsigned long           start, end;
> -};
>
> -static inline void init_tlb_gather(struct mmu_gather *tlb)
> -{
> -       tlb->start = TASK_SIZE;
> -       tlb->end = 0;
> -
> -       if (tlb->fullmm) {
> -               tlb->start = 0;
> -               tlb->end = TASK_SIZE;
> -       }
> -}
> -
> -static inline void
> -arch_tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
> -               unsigned long start, unsigned long end)
> -{
> -       tlb->mm = mm;
> -       tlb->start = start;
> -       tlb->end = end;
> -       tlb->fullmm = !(start | (end+1));
> -
> -       init_tlb_gather(tlb);
> -}
> -
> -static inline void
> -arch_tlb_finish_mmu(struct mmu_gather *tlb,
> -               unsigned long start, unsigned long end, bool force)
> -{
> -       if (tlb->fullmm || force)
> -               flush_tlb_mm(tlb->mm);
> -
> -       /* keep the page table cache within bounds */
> -       check_pgt_cache();
> -}
> -
> -static inline void
> -tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep, unsigned long address)
> -{
> -       if (tlb->start > address)
> -               tlb->start = address;
> -       if (tlb->end < address + PAGE_SIZE)
> -               tlb->end = address + PAGE_SIZE;
> -}
> -
> -#define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)       \
> -       tlb_remove_tlb_entry(tlb, ptep, address)
> -
> -/*
> - * In the case of tlb vma handling, we can optimise these away in the
> - * case where we're doing a full MM flush.  When we're doing a munmap,
> - * the vmas are adjusted to only cover the region to be torn down.
> - */
> -static inline void
> -tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
> -{
> -       if (!tlb->fullmm)
> -               flush_cache_range(vma, vma->vm_start, vma->vm_end);
> -}
> -
> -static inline void
> -tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
> -{
> -       if (!tlb->fullmm && tlb->end) {
> -               flush_tlb_range(vma, tlb->start, tlb->end);
> -               init_tlb_gather(tlb);
> -       }
> -}
> -
> -static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
> -{
> -}
> -
> -static inline void tlb_flush_mmu_free(struct mmu_gather *tlb)
> -{
> -}
> -
> -static inline void tlb_flush_mmu(struct mmu_gather *tlb)
> -{
> -}
> -
> -static inline int __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
> -{
> -       free_page_and_swap_cache(page);
> -       return false; /* avoid calling tlb_flush_mmu */
> -}
> -
> -static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
> -{
> -       __tlb_remove_page(tlb, page);
> -}
> -
> -static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
> -                                         struct page *page, int page_size)
> -{
> -       return __tlb_remove_page(tlb, page);
> -}
> -
> -static inline void tlb_remove_page_size(struct mmu_gather *tlb,
> -                                       struct page *page, int page_size)
> -{
> -       return tlb_remove_page(tlb, page);
> -}
> -
> -static inline void tlb_change_page_size(struct mmu_gather *tlb, unsigned int page_size)
> -{
> -}
> -
> -#define pte_free_tlb(tlb, ptep, addr)  pte_free((tlb)->mm, ptep)
> -#define pmd_free_tlb(tlb, pmdp, addr)  pmd_free((tlb)->mm, pmdp)
> -#define pud_free_tlb(tlb, pudp, addr)  pud_free((tlb)->mm, pudp)
> -
> -#define tlb_migrate_finish(mm)         do { } while (0)
> +#include <asm-generic/tlb.h>
>
>  #if defined(CONFIG_CPU_SH4) || defined(CONFIG_SUPERH64)
>  extern void tlb_wire_entry(struct vm_area_struct *, unsigned long, pte_t);
> @@ -155,11 +32,6 @@ static inline void tlb_unwire_entry(void
>
>  #else /* CONFIG_MMU */
>
> -#define tlb_start_vma(tlb, vma)                                do { } while (0)
> -#define tlb_end_vma(tlb, vma)                          do { } while (0)
> -#define __tlb_remove_tlb_entry(tlb, pte, address)      do { } while (0)
> -#define tlb_flush(tlb)                                 do { } while (0)
> -
>  #include <asm-generic/tlb.h>
>
>  #endif /* CONFIG_MMU */

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
