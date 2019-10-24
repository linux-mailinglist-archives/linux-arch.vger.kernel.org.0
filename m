Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E92D2E2945
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 06:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfJXEJM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 00:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfJXEJL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 24 Oct 2019 00:09:11 -0400
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 914102075C;
        Thu, 24 Oct 2019 04:09:04 +0000 (UTC)
Subject: Re: [PATCH 04/12] m68k: nommu: use pgtable-nopud instead of
 4level-fixup
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
 <1571822941-29776-5-git-send-email-rppt@kernel.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <de03a882-fb1a-455c-7c60-84ab0c4f9674@linux-m68k.org>
Date:   Thu, 24 Oct 2019 14:09:01 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571822941-29776-5-git-send-email-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mike,

On 23/10/19 7:28 pm, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The generic nommu implementation of page table manipulation takes care of
> folding of the upper levels and does not require fixups.
> 
> Simply replace of include/asm-generic/4level-fixup.h with
> include/asm-generic/pgtable-nopud.h.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   arch/m68k/include/asm/pgtable_no.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
> index c18165b..ccc4568 100644
> --- a/arch/m68k/include/asm/pgtable_no.h
> +++ b/arch/m68k/include/asm/pgtable_no.h
> @@ -2,7 +2,7 @@
>   #ifndef _M68KNOMMU_PGTABLE_H
>   #define _M68KNOMMU_PGTABLE_H
>   
> -#include <asm-generic/4level-fixup.h>
> +#include <asm-generic/pgtable-nopud.h>
>   
>   /*
>    * (C) Copyright 2000-2002, Greg Ungerer <gerg@snapgear.com>

This fails to compile for me (targeting m5208evb_defconfig):

   CC      init/main.o
In file included from ./arch/m68k/include/asm/pgtable_no.h:56:0,
                  from ./arch/m68k/include/asm/pgtable.h:3,
                  from ./include/linux/mm.h:99,
                  from ./include/linux/ring_buffer.h:5,
                  from ./include/linux/trace_events.h:6,
                  from ./include/trace/syscall.h:7,
                  from ./include/linux/syscalls.h:85,
                  from init/main.c:21:
./include/asm-generic/pgtable.h:738:34: error: unknown type name ‘pmd_t’
  static inline int pmd_soft_dirty(pmd_t pmd)
                                   ^
./include/asm-generic/pgtable.h:748:15: error: unknown type name ‘pmd_t’
  static inline pmd_t pmd_mksoft_dirty(pmd_t pmd)
                ^
./include/asm-generic/pgtable.h:748:38: error: unknown type name ‘pmd_t’
  static inline pmd_t pmd_mksoft_dirty(pmd_t pmd)
                                       ^
./include/asm-generic/pgtable.h:758:15: error: unknown type name ‘pmd_t’
  static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
                ^
./include/asm-generic/pgtable.h:758:42: error: unknown type name ‘pmd_t’
  static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
                                           ^
./include/asm-generic/pgtable.h:778:15: error: unknown type name ‘pmd_t’
  static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
                ^
./include/asm-generic/pgtable.h:778:42: error: unknown type name ‘pmd_t’
  static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
                                           ^
./include/asm-generic/pgtable.h:783:38: error: unknown type name ‘pmd_t’
  static inline int pmd_swp_soft_dirty(pmd_t pmd)
                                       ^
./include/asm-generic/pgtable.h:788:15: error: unknown type name ‘pmd_t’
  static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
                ^
./include/asm-generic/pgtable.h:788:46: error: unknown type name ‘pmd_t’
  static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
                                               ^
./include/asm-generic/pgtable.h:1071:32: error: unknown type name ‘pmd_t’
  static inline int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
                                 ^
./include/asm-generic/pgtable.h:1083:34: error: unknown type name ‘pmd_t’
  static inline int pmd_clear_huge(pmd_t *pmd)
                                   ^
./include/asm-generic/pgtable.h:1095:37: error: unknown type name ‘pmd_t’
  static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
                                      ^
In file included from ./include/linux/ring_buffer.h:5:0,
                  from ./include/linux/trace_events.h:6,
                  from ./include/trace/syscall.h:7,
                  from ./include/linux/syscalls.h:85,
                  from init/main.c:21:
./include/linux/mm.h:423:2: error: unknown type name ‘pmd_t’
   pmd_t *pmd;   /* Pointer to pmd entry matching
   ^
./include/linux/mm.h:568:30: error: unknown type name ‘pmd_t’
  static inline int pmd_devmap(pmd_t pmd)
                               ^
In file included from ./include/linux/mm.h:587:0,
                  from ./include/linux/ring_buffer.h:5,
                  from ./include/linux/trace_events.h:6,
                  from ./include/trace/syscall.h:7,
                  from ./include/linux/syscalls.h:85,
                  from init/main.c:21:
./include/linux/huge_mm.h:12:5: error: unknown type name ‘pmd_t’
      pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
      ^
./include/linux/huge_mm.h:12:21: error: unknown type name ‘pmd_t’
      pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
                      ^
./include/linux/huge_mm.h:14:57: error: unknown type name ‘pmd_t’
  extern void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd);
                                                          ^
./include/linux/huge_mm.h:27:61: error: unknown type name ‘pmd_t’
  extern vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd);
                                                              ^
./include/linux/huge_mm.h:30:8: error: unknown type name ‘pmd_t’
         pmd_t *pmd,
         ^
./include/linux/huge_mm.h:34:4: error: unknown type name ‘pmd_t’
     pmd_t *pmd, unsigned long addr, unsigned long next);
     ^
./include/linux/huge_mm.h:37:4: error: unknown type name ‘pmd_t’
     pmd_t *pmd, unsigned long addr);
     ^
./include/linux/huge_mm.h:41:57: error: unknown type name ‘pmd_t’
  extern int mincore_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
                                                          ^
./include/linux/huge_mm.h:46:5: error: unknown type name ‘pmd_t’
      pmd_t *old_pmd, pmd_t *new_pmd);
      ^
./include/linux/huge_mm.h:46:21: error: unknown type name ‘pmd_t’
      pmd_t *old_pmd, pmd_t *new_pmd);
                      ^
./include/linux/huge_mm.h:47:56: error: unknown type name ‘pmd_t’
  extern int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
                                                         ^
./include/linux/huge_mm.h:336:65: error: unknown type name ‘pmd_t’
  static inline void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
                                                                  ^
./include/linux/huge_mm.h:356:31: error: unknown type name ‘pmd_t’
  static inline int is_swap_pmd(pmd_t pmd)
                                ^
./include/linux/huge_mm.h:360:47: error: unknown type name ‘pmd_t’
  static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
                                                ^
./include/linux/huge_mm.h:372:3: error: unknown type name ‘pmd_t’
    pmd_t orig_pmd)
    ^
./include/linux/huge_mm.h:393:22: error: unknown type name ‘pmd_t’
   unsigned long addr, pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
                       ^
In file included from ./include/linux/ring_buffer.h:5:0,
                  from ./include/linux/trace_events.h:6,
                  from ./include/trace/syscall.h:7,
                  from ./include/linux/syscalls.h:85,
                  from init/main.c:21:
./include/linux/mm.h:1447:5: error: unknown type name ‘pmd_t’
      pmd_t pmd);
      ^
./include/linux/mm.h:1464:21: error: unknown type name ‘pmd_t’
       pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp);
                      ^
./include/linux/mm.h:1850:39: error: unknown type name ‘pmd_t’
  int __pte_alloc(struct mm_struct *mm, pmd_t *pmd);
                                        ^
./include/linux/mm.h:1851:24: error: unknown type name ‘pmd_t’
  int __pte_alloc_kernel(pmd_t *pmd);
                         ^
./include/linux/mm.h:1937:61: error: unknown type name ‘pmd_t’
  static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
                                                              ^
./include/linux/mm.h:2028:61: error: unknown type name ‘pmd_t’
  static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
                                                              ^
./include/linux/mm.h:2040:58: error: unknown type name ‘pmd_t’
  static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
                                                           ^
In file included from ./include/linux/ring_buffer.h:5:0,
                  from ./include/linux/trace_events.h:6,
                  from ./include/trace/syscall.h:7,
                  from ./include/linux/syscalls.h:85,
                  from init/main.c:21:
./include/linux/mm.h:2755:1: error: unknown type name ‘pmd_t’
  pmd_t *vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node);
  ^
./include/linux/mm.h:2756:29: error: unknown type name ‘pmd_t’
  pte_t *vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node);
                              ^
scripts/Makefile.build:265: recipe for target 'init/main.o' failed
make[1]: *** [init/main.o] Error 1
Makefile:1649: recipe for target 'init' failed
make: *** [init] Error 2

Regards
Greg

