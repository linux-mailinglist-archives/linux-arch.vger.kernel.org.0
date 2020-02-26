Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB9B1700C1
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 15:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgBZOJr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 09:09:47 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35852 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgBZOJr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 09:09:47 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so2316433qto.3
        for <linux-arch@vger.kernel.org>; Wed, 26 Feb 2020 06:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G9AF7HwBvzniHwSaAO0sGMgRWxAm6d66pGJFYLAcUqk=;
        b=YE3R28K03/OSkKci4pIu5feJz/Gza2peB1lndyCeGfvTr8WSbzxpFaAqlK/20xrBvl
         6QpXE5F7H7Vx83KoDdAzQd4b3z0ApO16qPGG/ft6YbvZNOaPkn87uQWs825uQ85pt/4b
         6iLpy8Vc4N/vq91uAhMsYpM6abgr85RtDcb3e6GNiUOwS/8MHsgktIWoPXcHIJX382y4
         eQPAzmcZV3HPXCrkguoaDLw2qUKIkkBKWsa0lAG3fgRUaEaHdqBmwboSJl5RPi1yeMej
         b/aMFlj2uh6WPxJMdvcluXKnXEc/lfM/eeQ1zXrVk7RsLNT7Ol7Bgk22NZcLjJQYlBn5
         L7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G9AF7HwBvzniHwSaAO0sGMgRWxAm6d66pGJFYLAcUqk=;
        b=uZAWrxqNXey1CEbOU3G7aJyQ7dfsqSLUjJYkKuZalc9iJE5Ier9pu1CQGp7OfQird+
         c/jfgeYy7LuZIBrdcdqPjbM2IF9tHHKJVyTB+MlUwzIairnOaBvCoKjvlZAEfHglk8Zv
         D+JWDP3dMFBlTz21x4cTjIq94yyuLKWGdadfTpcgIfkSD6PF+Ju5FH34uDCcTARXlm6U
         pvmbVIv70/daD45fBJBkt0+aaB2X1MfMmHuFyZoNZ+IdLrkoLuecBPUzwNDpEbOmjlAs
         Uw5U+8fbT/Tv4YUFiKJJTpZmV+MVrn62hjBdsnlAYugt9t0kyKVjTQt60+ba8TpzWuG4
         +wdw==
X-Gm-Message-State: APjAAAUo2VjTf6O1T9KkiXJ9HzQzBOwSu0+aWwJPnuvLpU26v29/3W8/
        u/6P7iTkkRsjkybwCjBeodLoqQ==
X-Google-Smtp-Source: APXvYqxRvESuFPk6siqL9qo/1/2cXkkp2ceYeSTQ/uCoTGJhGid6usa2pYO6rAddiidPiSORcGRtfQ==
X-Received: by 2002:ac8:2bf8:: with SMTP id n53mr5572816qtn.1.1582726185762;
        Wed, 26 Feb 2020 06:09:45 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b5sm1176402qkg.110.2020.02.26.06.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 06:09:44 -0800 (PST)
Message-ID: <1582726182.7365.123.camel@lca.pw>
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page
 table helpers
From:   Qian Cai <cai@lca.pw>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@c-s.fr>
Date:   Wed, 26 Feb 2020 09:09:42 -0500
In-Reply-To: <1581909460-19148-1-git-send-email-anshuman.khandual@arm.com>
References: <1581909460-19148-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2020-02-17 at 08:47 +0530, Anshuman Khandual wrote:
> This adds tests which will validate architecture page table helpers and
> other accessors in their compliance with expected generic MM semantics.
> This will help various architectures in validating changes to existing
> page table helpers or addition of new ones.
> 
> This test covers basic page table entry transformations including but not
> limited to old, young, dirty, clean, write, write protect etc at various
> level along with populating intermediate entries with next page table page
> and validating them.
> 
> Test page table pages are allocated from system memory with required size
> and alignments. The mapped pfns at page table levels are derived from a
> real pfn representing a valid kernel text symbol. This test gets called
> inside kernel_init() right after async_synchronize_full().
> 
> This test gets built and run when CONFIG_DEBUG_VM_PGTABLE is selected. Any
> architecture, which is willing to subscribe this test will need to select
> ARCH_HAS_DEBUG_VM_PGTABLE. For now this is limited to arc, arm64, x86, s390
> and ppc32 platforms where the test is known to build and run successfully.
> Going forward, other architectures too can subscribe the test after fixing
> any build or runtime problems with their page table helpers. Meanwhile for
> better platform coverage, the test can also be enabled with CONFIG_EXPERT
> even without ARCH_HAS_DEBUG_VM_PGTABLE.
> 
> Folks interested in making sure that a given platform's page table helpers
> conform to expected generic MM semantics should enable the above config
> which will just trigger this test during boot. Any non conformity here will
> be reported as an warning which would need to be fixed. This test will help
> catch any changes to the agreed upon semantics expected from generic MM and
> enable platforms to accommodate it thereafter.

How useful is this that straightly crash the powerpc?

[   23.263425][    T1] debug_vm_pgtable: debug_vm_pgtable: Validating
architecture page table helpers
[   23.263625][    T1] ------------[ cut here ]------------
[   23.263649][    T1] kernel BUG at arch/powerpc/mm/pgtable.c:274!
[   23.263675][    T1] Oops: Exception in kernel mode, sig: 5 [#1]
[   23.263698][    T1] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=256
DEBUG_PAGEALLOC NUMA PowerNV
[   23.263731][    T1] Modules linked in:
[   23.263752][    T1] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc3-next-
20200226 #1
[   23.263776][    T1] NIP:  c00000000007308c LR: c00000000103dbd8 CTR:
0000000000000000
[   23.263810][    T1] REGS: c00000003ddaf9c0 TRAP: 0700   Not tainted  (5.6.0-
rc3-next-20200226)
[   23.263846][    T1] MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR:
22000228  XER: 00000000
[   23.263888][    T1] CFAR: c000000000073030 IRQMASK: 0 
[   23.263888][    T1] GPR00: c00000000103dbd8 c00000003ddafc50 c000000001656f00
c000001d7b4ca080 
[   23.263888][    T1] GPR04: 0000000000000000 0000000000000009 c00000003ddafc04
0000000000000000 
[   23.263888][    T1] GPR08: f0ffffffffffffff 0000000000000001 c0000000016279d0
00000000000a0000 
[   23.263888][    T1] GPR12: 0000000000000000 c000001fffffae00 c000000000010e84
0000000000000000 
[   23.263888][    T1] GPR16: 0000000000000000 8000000000000105 0000000000000100
c000000001689a18 
[   23.263888][    T1] GPR20: c00020032c660000 c00020032c620000 c000000001716030
c00020032c600000 
[   23.263888][    T1] GPR24: 000000000000000d c000000001716030 c000001d7b4ca080
c000000001716040 
[   23.263888][    T1] GPR28: c000000001716038 0000000000000000 0000000000000000
0000000000000000 
[   23.264122][    T1] NIP [c00000000007308c] assert_pte_locked+0x11c/0x320
[   23.264154][    T1] LR [c00000000103dbd8] debug_vm_pgtable+0x770/0xb7c
[   23.264186][    T1] Call Trace:
[   23.264206][    T1] [c00000003ddafc50] [c000000000999760]
_raw_spin_unlock+0x30/0x70 (unreliable)
[   23.264244][    T1] [c00000003ddafcd0] [c00000000103d924]
debug_vm_pgtable+0x4bc/0xb7c
[   23.264279][    T1] [c00000003ddafdb0] [c000000000010eac]
kernel_init+0x30/0x194
[   23.264315][    T1] [c00000003ddafe20] [c00000000000b748]
ret_from_kernel_thread+0x5c/0x74
[   23.264349][    T1] Instruction dump:
[   23.264368][    T1] 60000000 3be00001 7fbef436 eafa0040 7fffc030 3bffffff
7fff07b4 7ffff038 
[   23.264409][    T1] 7bff1f24 7d37f82a 7d290074 7929d182 <0b090000> ebdb0000
e93c0000 7fde4a14 
[   23.264460][    T1] ---[ end trace 72d2931022e9ab24 ]---
[   23.627311][    T1] 
[   24.627407][    T1] Kernel panic - not syncing: Fatal exception
[   26.5

> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: x86@kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> Tested-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>	# s390
> Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>	# ppc32
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This adds a test validation for architecture exported page table helpers.
> Patch adds basic transformation tests at various levels of the page table.
> 
> This test was originally suggested by Catalin during arm64 THP migration
> RFC discussion earlier. Going forward it can include more specific tests
> with respect to various generic MM functions like THP, HugeTLB etc and
> platform specific tests.
> 
> https://lore.kernel.org/linux-mm/20190628102003.GA56463@arrakis.emea.arm.com/
> 
> Needs to be applied on linux V5.6-rc2
> 
> Changes in V14:
> 
> - Disabled DEBUG_VM_PGFLAGS for IA64 and ARM (32 Bit) per Andrew and Christophe
> - Updated DEBUG_VM_PGFLAGS documentation wrt EXPERT and disabled platforms
> - Updated RANDOM_[OR|NZ]VALUE open encodings with GENMASK() per Catalin
> - Updated s390 constraint bits from 12 to 4 (S390_MASK_BITS) per Gerald
> - Updated in-code documentation for RANDOM_ORVALUE per Gerald
> - Updated pxx_basic_tests() to use invert functions first per Catalin
> - Dropped ARCH_HAS_4LEVEL_HACK check from pud_basic_tests()
> - Replaced __ARCH_HAS_[4|5]LEVEL_HACK with __PAGETABLE_[PUD|P4D]_FOLDED per Catalin
> - Trimmed the CC list on the commit message per Catalin
> 
> Changes in V13: (https://patchwork.kernel.org/project/linux-mm/list/?series=237125)
> 
> - Subscribed s390 platform and updated debug-vm-pgtable/arch-support.txt per Gerald
> - Dropped keyword 'extern' from debug_vm_pgtable() declaration per Christophe
> - Moved debug_vm_pgtable() declarations to <linux/mmdebug.h> per Christophe
> - Moved debug_vm_pgtable() call site into kernel_init() per Christophe
> - Changed CONFIG_DEBUG_VM_PGTABLE rules per Christophe
> - Updated commit to include new supported platforms and changed config selection
> 
> Changes in V12: (https://patchwork.kernel.org/project/linux-mm/list/?series=233905)
> 
> - Replaced __mmdrop() with mmdrop()
> - Enable ARCH_HAS_DEBUG_VM_PGTABLE on X86 for non CONFIG_X86_PAE platforms as the
>   test procedure interfere with pre-allocated PMDs attached to the PGD resulting
>   in runtime failures with VM_BUG_ON()
> 
> Changes in V11: (https://patchwork.kernel.org/project/linux-mm/list/?series=221135)
> 
> - Rebased the patch on V5.4
> 
> Changes in V10: (https://patchwork.kernel.org/project/linux-mm/list/?series=205529)
> 
> - Always enable DEBUG_VM_PGTABLE when DEBUG_VM is enabled per Ingo
> - Added tags from Ingo
> 
> Changes in V9: (https://patchwork.kernel.org/project/linux-mm/list/?series=201429)
> 
> - Changed feature support enumeration for powerpc platforms per Christophe
> - Changed config wrapper for basic_[pmd|pud]_tests() to enable ARC platform
> - Enabled the test on ARC platform
> 
> Changes in V8: (https://patchwork.kernel.org/project/linux-mm/list/?series=194297)
> 
> - Enabled ARCH_HAS_DEBUG_VM_PGTABLE on PPC32 platform per Christophe
> - Updated feature documentation as DEBUG_VM_PGTABLE is now enabled on PPC32 platform
> - Moved ARCH_HAS_DEBUG_VM_PGTABLE earlier to indent it with DEBUG_VM per Christophe
> - Added an information message in debug_vm_pgtable() per Christophe
> - Dropped random_vaddr boundary condition checks per Christophe and Qian
> - Replaced virt_addr_valid() check with pfn_valid() check in debug_vm_pgtable()
> - Slightly changed pr_fmt(fmt) information
> 
> Changes in V7: (https://patchwork.kernel.org/project/linux-mm/list/?series=193051)
> 
> - Memory allocation and free routines for mapped pages have been droped
> - Mapped pfns are derived from standard kernel text symbol per Matthew
> - Moved debug_vm_pgtaable() after page_alloc_init_late() per Michal and Qian 
> - Updated the commit message per Michal
> - Updated W=1 GCC warning problem on x86 per Qian Cai
> - Addition of new alloc_contig_pages() helper has been submitted separately
> 
> Changes in V6: (https://patchwork.kernel.org/project/linux-mm/list/?series=187589)
> 
> - Moved alloc_gigantic_page_order() into mm/page_alloc.c per Michal
> - Moved alloc_gigantic_page_order() within CONFIG_CONTIG_ALLOC in the test
> - Folded Andrew's include/asm-generic/pgtable.h fix into the test patch 2/2
> 
> Changes in V5: (https://patchwork.kernel.org/project/linux-mm/list/?series=185991)
> 
> - Redefined and moved X86 mm_p4d_folded() into a different header per Kirill/Ingo
> - Updated the config option comment per Ingo and dropped 'kernel module' reference
> - Updated the commit message and dropped 'kernel module' reference
> - Changed DEBUG_ARCH_PGTABLE_TEST into DEBUG_VM_PGTABLE per Ingo
> - Moved config option from mm/Kconfig.debug into lib/Kconfig.debug
> - Renamed core test function arch_pgtable_tests() as debug_vm_pgtable()
> - Renamed mm/arch_pgtable_test.c as mm/debug_vm_pgtable.c
> - debug_vm_pgtable() gets called from kernel_init_freeable() after init_mm_internals()
> - Added an entry in Documentation/features/debug/ per Ingo
> - Enabled the test on arm64 and x86 platforms for now
> 
> Changes in V4: (https://patchwork.kernel.org/project/linux-mm/list/?series=183465)
> 
> - Disable DEBUG_ARCH_PGTABLE_TEST for ARM and IA64 platforms
> 
> Changes in V3: (https://lore.kernel.org/patchwork/project/lkml/list/?series=411216)
> 
> - Changed test trigger from module format into late_initcall()
> - Marked all functions with __init to be freed after completion
> - Changed all __PGTABLE_PXX_FOLDED checks as mm_pxx_folded()
> - Folded in PPC32 fixes from Christophe
> 
> Changes in V2:
> 
> https://lore.kernel.org/linux-mm/1568268173-31302-1-git-send-email-anshuman.khandual@arm.com/T/#t
> 
> - Fixed small typo error in MODULE_DESCRIPTION()
> - Fixed m64k build problems for lvalue concerns in pmd_xxx_tests()
> - Fixed dynamic page table level folding problems on x86 as per Kirril
> - Fixed second pointers during pxx_populate_tests() per Kirill and Gerald
> - Allocate and free pte table with pte_alloc_one/pte_free per Kirill
> - Modified pxx_clear_tests() to accommodate s390 lower 12 bits situation
> - Changed RANDOM_NZVALUE value from 0xbe to 0xff
> - Changed allocation, usage, free sequence for saved_ptep
> - Renamed VMA_FLAGS as VMFLAGS
> - Implemented a new method for random vaddr generation
> - Implemented some other cleanups
> - Dropped extern reference to mm_alloc()
> - Created and exported new alloc_gigantic_page_order()
> - Dropped the custom allocator and used new alloc_gigantic_page_order()
> 
> Changes in V1:
> 
> https://lore.kernel.org/linux-mm/1567497706-8649-1-git-send-email-anshuman.khandual@arm.com/
> 
> - Added fallback mechanism for PMD aligned memory allocation failure
> 
> Changes in RFC V2:
> 
> https://lore.kernel.org/linux-mm/1565335998-22553-1-git-send-email-anshuman.khandual@arm.com/T/#u
> 
> - Moved test module and it's config from lib/ to mm/
> - Renamed config TEST_ARCH_PGTABLE as DEBUG_ARCH_PGTABLE_TEST
> - Renamed file from test_arch_pgtable.c to arch_pgtable_test.c
> - Added relevant MODULE_DESCRIPTION() and MODULE_AUTHOR() details
> - Dropped loadable module config option
> - Basic tests now use memory blocks with required size and alignment
> - PUD aligned memory block gets allocated with alloc_contig_range()
> - If PUD aligned memory could not be allocated it falls back on PMD aligned
>   memory block from page allocator and pud_* tests are skipped
> - Clear and populate tests now operate on real in memory page table entries
> - Dummy mm_struct gets allocated with mm_alloc()
> - Dummy page table entries get allocated with [pud|pmd|pte]_alloc_[map]()
> - Simplified [p4d|pgd]_basic_tests(), now has random values in the entries
> 
> Original RFC V1:
> 
> https://lore.kernel.org/linux-mm/1564037723-26676-1-git-send-email-anshuman.khandual@arm.com/
> 
> 
>  .../debug/debug-vm-pgtable/arch-support.txt   |  35 ++
>  arch/arc/Kconfig                              |   1 +
>  arch/arm64/Kconfig                            |   1 +
>  arch/powerpc/Kconfig                          |   1 +
>  arch/s390/Kconfig                             |   1 +
>  arch/x86/Kconfig                              |   1 +
>  arch/x86/include/asm/pgtable_64.h             |   6 +
>  include/linux/mmdebug.h                       |   5 +
>  init/main.c                                   |   2 +
>  lib/Kconfig.debug                             |  26 ++
>  mm/Makefile                                   |   1 +
>  mm/debug_vm_pgtable.c                         | 389 ++++++++++++++++++
>  12 files changed, 469 insertions(+)
>  create mode 100644 Documentation/features/debug/debug-vm-pgtable/arch-support.txt
>  create mode 100644 mm/debug_vm_pgtable.c
> 
> diff --git a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
> new file mode 100644
> index 000000000000..64d0f9b15c49
> --- /dev/null
> +++ b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
> @@ -0,0 +1,35 @@
> +#
> +# Feature name:          debug-vm-pgtable
> +#         Kconfig:       ARCH_HAS_DEBUG_VM_PGTABLE
> +#         description:   arch supports pgtable tests for semantics compliance
> +#
> +    -----------------------
> +    |         arch |status|
> +    -----------------------
> +    |       alpha: | TODO |
> +    |         arc: |  ok  |
> +    |         arm: | TODO |
> +    |       arm64: |  ok  |
> +    |         c6x: | TODO |
> +    |        csky: | TODO |
> +    |       h8300: | TODO |
> +    |     hexagon: | TODO |
> +    |        ia64: | TODO |
> +    |        m68k: | TODO |
> +    |  microblaze: | TODO |
> +    |        mips: | TODO |
> +    |       nds32: | TODO |
> +    |       nios2: | TODO |
> +    |    openrisc: | TODO |
> +    |      parisc: | TODO |
> +    |  powerpc/32: |  ok  |
> +    |  powerpc/64: | TODO |
> +    |       riscv: | TODO |
> +    |        s390: |  ok  |
> +    |          sh: | TODO |
> +    |       sparc: | TODO |
> +    |          um: | TODO |
> +    |   unicore32: | TODO |
> +    |         x86: |  ok  |
> +    |      xtensa: | TODO |
> +    -----------------------
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index ff2a393b635c..3e72e6cf0e42 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -6,6 +6,7 @@
>  config ARC
>  	def_bool y
>  	select ARC_TIMERS
> +	select ARCH_HAS_DEBUG_VM_PGTABLE
>  	select ARCH_HAS_DMA_PREP_COHERENT
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_SETUP_DMA_OPS
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0b30e884e088..aaf8ba415145 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -11,6 +11,7 @@ config ARM64
>  	select ACPI_PPTT if ACPI
>  	select ARCH_CLOCKSOURCE_DATA
>  	select ARCH_HAS_DEBUG_VIRTUAL
> +	select ARCH_HAS_DEBUG_VM_PGTABLE
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_DMA_PREP_COHERENT
>  	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 497b7d0b2d7e..8d5ae14c5d4c 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -116,6 +116,7 @@ config PPC
>  	#
>  	select ARCH_32BIT_OFF_T if PPC32
>  	select ARCH_HAS_DEBUG_VIRTUAL
> +	select ARCH_HAS_DEBUG_VM_PGTABLE if PPC32
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_FORTIFY_SOURCE
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 8abe77536d9d..af284dbb07e7 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -59,6 +59,7 @@ config KASAN_SHADOW_OFFSET
>  config S390
>  	def_bool y
>  	select ARCH_BINFMT_ELF_STATE
> +	select ARCH_HAS_DEBUG_VM_PGTABLE
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_FORTIFY_SOURCE
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index beea77046f9b..df8a19e52e82 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -61,6 +61,7 @@ config X86
>  	select ARCH_CLOCKSOURCE_INIT
>  	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
>  	select ARCH_HAS_DEBUG_VIRTUAL
> +	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_FAST_MULTIPLIER
> diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
> index 0b6c4042942a..fb0e76d254b3 100644
> --- a/arch/x86/include/asm/pgtable_64.h
> +++ b/arch/x86/include/asm/pgtable_64.h
> @@ -53,6 +53,12 @@ static inline void sync_initial_page_table(void) { }
>  
>  struct mm_struct;
>  
> +#define mm_p4d_folded mm_p4d_folded
> +static inline bool mm_p4d_folded(struct mm_struct *mm)
> +{
> +	return !pgtable_l5_enabled();
> +}
> +
>  void set_pte_vaddr_p4d(p4d_t *p4d_page, unsigned long vaddr, pte_t new_pte);
>  void set_pte_vaddr_pud(pud_t *pud_page, unsigned long vaddr, pte_t new_pte);
>  
> diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
> index 2ad72d2c8cc5..5339aa14b749 100644
> --- a/include/linux/mmdebug.h
> +++ b/include/linux/mmdebug.h
> @@ -64,4 +64,9 @@ void dump_mm(const struct mm_struct *mm);
>  #define VM_BUG_ON_PGFLAGS(cond, page) BUILD_BUG_ON_INVALID(cond)
>  #endif
>  
> +#ifdef CONFIG_DEBUG_VM_PGTABLE
> +void debug_vm_pgtable(void);
> +#else
> +static inline void debug_vm_pgtable(void) { }
> +#endif
>  #endif
> diff --git a/init/main.c b/init/main.c
> index cc0ee4873419..adf37e8b1d69 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -94,6 +94,7 @@
>  #include <linux/rodata_test.h>
>  #include <linux/jump_label.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/mmdebug.h>
>  
>  #include <asm/io.h>
>  #include <asm/bugs.h>
> @@ -1323,6 +1324,7 @@ static int __ref kernel_init(void *unused)
>  	kernel_init_freeable();
>  	/* need to finish all async __init code before freeing the memory */
>  	async_synchronize_full();
> +	debug_vm_pgtable();
>  	ftrace_free_init_mem();
>  	free_initmem();
>  	mark_readonly();
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 69def4a9df00..1b5bd9f7c967 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -653,6 +653,12 @@ config SCHED_STACK_END_CHECK
>  	  data corruption or a sporadic crash at a later stage once the region
>  	  is examined. The runtime overhead introduced is minimal.
>  
> +config ARCH_HAS_DEBUG_VM_PGTABLE
> +	bool
> +	help
> +	  An architecture should select this when it can successfully
> +	  build and run DEBUG_VM_PGTABLE.
> +
>  config DEBUG_VM
>  	bool "Debug VM"
>  	depends on DEBUG_KERNEL
> @@ -688,6 +694,26 @@ config DEBUG_VM_PGFLAGS
>  
>  	  If unsure, say N.
>  
> +config DEBUG_VM_PGTABLE
> +	bool "Debug arch page table for semantics compliance"
> +	depends on MMU
> +	depends on !IA64 && !ARM
> +	depends on ARCH_HAS_DEBUG_VM_PGTABLE || EXPERT
> +	default n if !ARCH_HAS_DEBUG_VM_PGTABLE
> +	default y if DEBUG_VM
> +	help
> +	  This option provides a debug method which can be used to test
> +	  architecture page table helper functions on various platforms in
> +	  verifying if they comply with expected generic MM semantics. This
> +	  will help architecture code in making sure that any changes or
> +	  new additions of these helpers still conform to expected
> +	  semantics of the generic MM. Platforms will have to opt in for
> +	  this through ARCH_HAS_DEBUG_VM_PGTABLE. Although it can also be
> +	  enabled through EXPERT without requiring code change. This test
> +	  is disabled on IA64 and ARM platforms where it fails to build.
> +
> +	  If unsure, say N.
> +
>  config ARCH_HAS_DEBUG_VIRTUAL
>  	bool
>  
> diff --git a/mm/Makefile b/mm/Makefile
> index 272e66039e70..b0692e6a4b58 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_HWPOISON_INJECT) += hwpoison-inject.o
>  obj-$(CONFIG_DEBUG_KMEMLEAK) += kmemleak.o
>  obj-$(CONFIG_DEBUG_KMEMLEAK_TEST) += kmemleak-test.o
>  obj-$(CONFIG_DEBUG_RODATA_TEST) += rodata_test.o
> +obj-$(CONFIG_DEBUG_VM_PGTABLE) += debug_vm_pgtable.o
>  obj-$(CONFIG_PAGE_OWNER) += page_owner.o
>  obj-$(CONFIG_CLEANCACHE) += cleancache.o
>  obj-$(CONFIG_MEMORY_ISOLATION) += page_isolation.o
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> new file mode 100644
> index 000000000000..70bf8ed8fd51
> --- /dev/null
> +++ b/mm/debug_vm_pgtable.c
> @@ -0,0 +1,389 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * This kernel test validates architecture page table helpers and
> + * accessors and helps in verifying their continued compliance with
> + * expected generic MM semantics.
> + *
> + * Copyright (C) 2019 ARM Ltd.
> + *
> + * Author: Anshuman Khandual <anshuman.khandual@arm.com>
> + */
> +#define pr_fmt(fmt) "debug_vm_pgtable: %s: " fmt, __func__
> +
> +#include <linux/gfp.h>
> +#include <linux/highmem.h>
> +#include <linux/hugetlb.h>
> +#include <linux/kernel.h>
> +#include <linux/kconfig.h>
> +#include <linux/mm.h>
> +#include <linux/mman.h>
> +#include <linux/mm_types.h>
> +#include <linux/module.h>
> +#include <linux/pfn_t.h>
> +#include <linux/printk.h>
> +#include <linux/random.h>
> +#include <linux/spinlock.h>
> +#include <linux/swap.h>
> +#include <linux/swapops.h>
> +#include <linux/start_kernel.h>
> +#include <linux/sched/mm.h>
> +#include <asm/pgalloc.h>
> +#include <asm/pgtable.h>
> +
> +/*
> + * Basic operations
> + *
> + * mkold(entry)			= An old and not a young entry
> + * mkyoung(entry)		= A young and not an old entry
> + * mkdirty(entry)		= A dirty and not a clean entry
> + * mkclean(entry)		= A clean and not a dirty entry
> + * mkwrite(entry)		= A write and not a write protected entry
> + * wrprotect(entry)		= A write protected and not a write entry
> + * pxx_bad(entry)		= A mapped and non-table entry
> + * pxx_same(entry1, entry2)	= Both entries hold the exact same value
> + */
> +#define VMFLAGS	(VM_READ|VM_WRITE|VM_EXEC)
> +
> +/*
> + * On s390 platform, the lower 4 bits are used to identify given page table
> + * entry type. But these bits might affect the ability to clear entries with
> + * pxx_clear() because of how dynamic page table folding works on s390. So
> + * while loading up the entries do not change the lower 4 bits. It does not
> + * have affect any other platform.
> + */
> +#define S390_MASK_BITS	4
> +#define RANDOM_ORVALUE	GENMASK(BITS_PER_LONG - 1, S390_MASK_BITS)
> +#define RANDOM_NZVALUE	GENMASK(7, 0)
> +
> +static void __init pte_basic_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pte_t pte = pfn_pte(pfn, prot);
> +
> +	WARN_ON(!pte_same(pte, pte));
> +	WARN_ON(!pte_young(pte_mkyoung(pte_mkold(pte))));
> +	WARN_ON(!pte_dirty(pte_mkdirty(pte_mkclean(pte))));
> +	WARN_ON(!pte_write(pte_mkwrite(pte_wrprotect(pte))));
> +	WARN_ON(pte_young(pte_mkold(pte_mkyoung(pte))));
> +	WARN_ON(pte_dirty(pte_mkclean(pte_mkdirty(pte))));
> +	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte))));
> +}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pmd_t pmd = pfn_pmd(pfn, prot);
> +
> +	WARN_ON(!pmd_same(pmd, pmd));
> +	WARN_ON(!pmd_young(pmd_mkyoung(pmd_mkold(pmd))));
> +	WARN_ON(!pmd_dirty(pmd_mkdirty(pmd_mkclean(pmd))));
> +	WARN_ON(!pmd_write(pmd_mkwrite(pmd_wrprotect(pmd))));
> +	WARN_ON(pmd_young(pmd_mkold(pmd_mkyoung(pmd))));
> +	WARN_ON(pmd_dirty(pmd_mkclean(pmd_mkdirty(pmd))));
> +	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite(pmd))));
> +	/*
> +	 * A huge page does not point to next level page table
> +	 * entry. Hence this must qualify as pmd_bad().
> +	 */
> +	WARN_ON(!pmd_bad(pmd_mkhuge(pmd)));
> +}
> +
> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> +static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pud_t pud = pfn_pud(pfn, prot);
> +
> +	WARN_ON(!pud_same(pud, pud));
> +	WARN_ON(!pud_young(pud_mkyoung(pud_mkold(pud))));
> +	WARN_ON(!pud_write(pud_mkwrite(pud_wrprotect(pud))));
> +	WARN_ON(pud_write(pud_wrprotect(pud_mkwrite(pud))));
> +	WARN_ON(pud_young(pud_mkold(pud_mkyoung(pud))));
> +
> +	if (mm_pmd_folded(mm))
> +		return;
> +
> +	/*
> +	 * A huge page does not point to next level page table
> +	 * entry. Hence this must qualify as pud_bad().
> +	 */
> +	WARN_ON(!pud_bad(pud_mkhuge(pud)));
> +}
> +#else
> +static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot) { }
> +#endif
> +#else
> +static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot) { }
> +#endif
> +
> +static void __init p4d_basic_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	p4d_t p4d;
> +
> +	memset(&p4d, RANDOM_NZVALUE, sizeof(p4d_t));
> +	WARN_ON(!p4d_same(p4d, p4d));
> +}
> +
> +static void __init pgd_basic_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pgd_t pgd;
> +
> +	memset(&pgd, RANDOM_NZVALUE, sizeof(pgd_t));
> +	WARN_ON(!pgd_same(pgd, pgd));
> +}
> +
> +#ifndef __PAGETABLE_PUD_FOLDED
> +static void __init pud_clear_tests(struct mm_struct *mm, pud_t *pudp)
> +{
> +	pud_t pud = READ_ONCE(*pudp);
> +
> +	if (mm_pmd_folded(mm))
> +		return;
> +
> +	pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
> +	WRITE_ONCE(*pudp, pud);
> +	pud_clear(pudp);
> +	pud = READ_ONCE(*pudp);
> +	WARN_ON(!pud_none(pud));
> +}
> +
> +static void __init pud_populate_tests(struct mm_struct *mm, pud_t *pudp,
> +				      pmd_t *pmdp)
> +{
> +	pud_t pud;
> +
> +	if (mm_pmd_folded(mm))
> +		return;
> +	/*
> +	 * This entry points to next level page table page.
> +	 * Hence this must not qualify as pud_bad().
> +	 */
> +	pmd_clear(pmdp);
> +	pud_clear(pudp);
> +	pud_populate(mm, pudp, pmdp);
> +	pud = READ_ONCE(*pudp);
> +	WARN_ON(pud_bad(pud));
> +}
> +#else
> +static void __init pud_clear_tests(struct mm_struct *mm, pud_t *pudp) { }
> +static void __init pud_populate_tests(struct mm_struct *mm, pud_t *pudp,
> +				      pmd_t *pmdp)
> +{
> +}
> +#endif
> +
> +#ifndef __PAGETABLE_P4D_FOLDED
> +static void __init p4d_clear_tests(struct mm_struct *mm, p4d_t *p4dp)
> +{
> +	p4d_t p4d = READ_ONCE(*p4dp);
> +
> +	if (mm_pud_folded(mm))
> +		return;
> +
> +	p4d = __p4d(p4d_val(p4d) | RANDOM_ORVALUE);
> +	WRITE_ONCE(*p4dp, p4d);
> +	p4d_clear(p4dp);
> +	p4d = READ_ONCE(*p4dp);
> +	WARN_ON(!p4d_none(p4d));
> +}
> +
> +static void __init p4d_populate_tests(struct mm_struct *mm, p4d_t *p4dp,
> +				      pud_t *pudp)
> +{
> +	p4d_t p4d;
> +
> +	if (mm_pud_folded(mm))
> +		return;
> +
> +	/*
> +	 * This entry points to next level page table page.
> +	 * Hence this must not qualify as p4d_bad().
> +	 */
> +	pud_clear(pudp);
> +	p4d_clear(p4dp);
> +	p4d_populate(mm, p4dp, pudp);
> +	p4d = READ_ONCE(*p4dp);
> +	WARN_ON(p4d_bad(p4d));
> +}
> +
> +static void __init pgd_clear_tests(struct mm_struct *mm, pgd_t *pgdp)
> +{
> +	pgd_t pgd = READ_ONCE(*pgdp);
> +
> +	if (mm_p4d_folded(mm))
> +		return;
> +
> +	pgd = __pgd(pgd_val(pgd) | RANDOM_ORVALUE);
> +	WRITE_ONCE(*pgdp, pgd);
> +	pgd_clear(pgdp);
> +	pgd = READ_ONCE(*pgdp);
> +	WARN_ON(!pgd_none(pgd));
> +}
> +
> +static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
> +				      p4d_t *p4dp)
> +{
> +	pgd_t pgd;
> +
> +	if (mm_p4d_folded(mm))
> +		return;
> +
> +	/*
> +	 * This entry points to next level page table page.
> +	 * Hence this must not qualify as pgd_bad().
> +	 */
> +	p4d_clear(p4dp);
> +	pgd_clear(pgdp);
> +	pgd_populate(mm, pgdp, p4dp);
> +	pgd = READ_ONCE(*pgdp);
> +	WARN_ON(pgd_bad(pgd));
> +}
> +#else
> +static void __init p4d_clear_tests(struct mm_struct *mm, p4d_t *p4dp) { }
> +static void __init pgd_clear_tests(struct mm_struct *mm, pgd_t *pgdp) { }
> +static void __init p4d_populate_tests(struct mm_struct *mm, p4d_t *p4dp,
> +				      pud_t *pudp)
> +{
> +}
> +static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
> +				      p4d_t *p4dp)
> +{
> +}
> +#endif
> +
> +static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep)
> +{
> +	pte_t pte = READ_ONCE(*ptep);
> +
> +	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
> +	WRITE_ONCE(*ptep, pte);
> +	pte_clear(mm, 0, ptep);
> +	pte = READ_ONCE(*ptep);
> +	WARN_ON(!pte_none(pte));
> +}
> +
> +static void __init pmd_clear_tests(struct mm_struct *mm, pmd_t *pmdp)
> +{
> +	pmd_t pmd = READ_ONCE(*pmdp);
> +
> +	pmd = __pmd(pmd_val(pmd) | RANDOM_ORVALUE);
> +	WRITE_ONCE(*pmdp, pmd);
> +	pmd_clear(pmdp);
> +	pmd = READ_ONCE(*pmdp);
> +	WARN_ON(!pmd_none(pmd));
> +}
> +
> +static void __init pmd_populate_tests(struct mm_struct *mm, pmd_t *pmdp,
> +				      pgtable_t pgtable)
> +{
> +	pmd_t pmd;
> +
> +	/*
> +	 * This entry points to next level page table page.
> +	 * Hence this must not qualify as pmd_bad().
> +	 */
> +	pmd_clear(pmdp);
> +	pmd_populate(mm, pmdp, pgtable);
> +	pmd = READ_ONCE(*pmdp);
> +	WARN_ON(pmd_bad(pmd));
> +}
> +
> +static unsigned long __init get_random_vaddr(void)
> +{
> +	unsigned long random_vaddr, random_pages, total_user_pages;
> +
> +	total_user_pages = (TASK_SIZE - FIRST_USER_ADDRESS) / PAGE_SIZE;
> +
> +	random_pages = get_random_long() % total_user_pages;
> +	random_vaddr = FIRST_USER_ADDRESS + random_pages * PAGE_SIZE;
> +
> +	return random_vaddr;
> +}
> +
> +void __init debug_vm_pgtable(void)
> +{
> +	struct mm_struct *mm;
> +	pgd_t *pgdp;
> +	p4d_t *p4dp, *saved_p4dp;
> +	pud_t *pudp, *saved_pudp;
> +	pmd_t *pmdp, *saved_pmdp, pmd;
> +	pte_t *ptep;
> +	pgtable_t saved_ptep;
> +	pgprot_t prot;
> +	phys_addr_t paddr;
> +	unsigned long vaddr, pte_aligned, pmd_aligned;
> +	unsigned long pud_aligned, p4d_aligned, pgd_aligned;
> +
> +	pr_info("Validating architecture page table helpers\n");
> +	prot = vm_get_page_prot(VMFLAGS);
> +	vaddr = get_random_vaddr();
> +	mm = mm_alloc();
> +	if (!mm) {
> +		pr_err("mm_struct allocation failed\n");
> +		return;
> +	}
> +
> +	/*
> +	 * PFN for mapping at PTE level is determined from a standard kernel
> +	 * text symbol. But pfns for higher page table levels are derived by
> +	 * masking lower bits of this real pfn. These derived pfns might not
> +	 * exist on the platform but that does not really matter as pfn_pxx()
> +	 * helpers will still create appropriate entries for the test. This
> +	 * helps avoid large memory block allocations to be used for mapping
> +	 * at higher page table levels.
> +	 */
> +	paddr = __pa(&start_kernel);
> +
> +	pte_aligned = (paddr & PAGE_MASK) >> PAGE_SHIFT;
> +	pmd_aligned = (paddr & PMD_MASK) >> PAGE_SHIFT;
> +	pud_aligned = (paddr & PUD_MASK) >> PAGE_SHIFT;
> +	p4d_aligned = (paddr & P4D_MASK) >> PAGE_SHIFT;
> +	pgd_aligned = (paddr & PGDIR_MASK) >> PAGE_SHIFT;
> +	WARN_ON(!pfn_valid(pte_aligned));
> +
> +	pgdp = pgd_offset(mm, vaddr);
> +	p4dp = p4d_alloc(mm, pgdp, vaddr);
> +	pudp = pud_alloc(mm, p4dp, vaddr);
> +	pmdp = pmd_alloc(mm, pudp, vaddr);
> +	ptep = pte_alloc_map(mm, pmdp, vaddr);
> +
> +	/*
> +	 * Save all the page table page addresses as the page table
> +	 * entries will be used for testing with random or garbage
> +	 * values. These saved addresses will be used for freeing
> +	 * page table pages.
> +	 */
> +	pmd = READ_ONCE(*pmdp);
> +	saved_p4dp = p4d_offset(pgdp, 0UL);
> +	saved_pudp = pud_offset(p4dp, 0UL);
> +	saved_pmdp = pmd_offset(pudp, 0UL);
> +	saved_ptep = pmd_pgtable(pmd);
> +
> +	pte_basic_tests(pte_aligned, prot);
> +	pmd_basic_tests(pmd_aligned, prot);
> +	pud_basic_tests(pud_aligned, prot);
> +	p4d_basic_tests(p4d_aligned, prot);
> +	pgd_basic_tests(pgd_aligned, prot);
> +
> +	pte_clear_tests(mm, ptep);
> +	pmd_clear_tests(mm, pmdp);
> +	pud_clear_tests(mm, pudp);
> +	p4d_clear_tests(mm, p4dp);
> +	pgd_clear_tests(mm, pgdp);
> +
> +	pte_unmap(ptep);
> +
> +	pmd_populate_tests(mm, pmdp, saved_ptep);
> +	pud_populate_tests(mm, pudp, saved_pmdp);
> +	p4d_populate_tests(mm, p4dp, saved_pudp);
> +	pgd_populate_tests(mm, pgdp, saved_p4dp);
> +
> +	p4d_free(mm, saved_p4dp);
> +	pud_free(mm, saved_pudp);
> +	pmd_free(mm, saved_pmdp);
> +	pte_free(mm, saved_ptep);
> +
> +	mm_dec_nr_puds(mm);
> +	mm_dec_nr_pmds(mm);
> +	mm_dec_nr_ptes(mm);
> +	mmdrop(mm);
> +}
