Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9101C318E
	for <lists+linux-arch@lfdr.de>; Mon,  4 May 2020 06:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgEDEBy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 May 2020 00:01:54 -0400
Received: from foss.arm.com ([217.140.110.172]:36806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgEDEBx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 May 2020 00:01:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ADE51FB;
        Sun,  3 May 2020 21:01:52 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.71.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 919B83F71F;
        Sun,  3 May 2020 21:01:44 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V18 0/2] mm/debug: Add tests validating architecture page table helpers
Date:   Mon,  4 May 2020 09:31:03 +0530
Message-Id: <1588564865-31160-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This adds a test validation for architecture exported page table helpers.
Patch adds basic transformation tests at various levels of the page table.

This test was originally suggested by Catalin during arm64 THP migration
RFC discussion earlier. Going forward it can include more specific tests
with respect to various generic MM functions like THP, HugeTLB etc and
platform specific tests.

https://lore.kernel.org/linux-mm/20190628102003.GA56463@arrakis.emea.arm.com/

Needs to be applied on linux V5.7-rc4

Changes in V18:

- Stopped enabling CONFIG_DEBUG_VM_PGTABLE via CONFIG_EXPERT
- Dropped the exclude list (IA64 and ARM) as CONFIG_EXPERT route no longer available
- Updated CONFIG_DEBUG_VM_PGTABLE's help section as required
- Updated the commit message for [PATCH 2/2] as required

Changes in V17: (https://patchwork.kernel.org/project/linux-mm/list/?series=274401)

- debug_vm_pgtable() is now called from late_initcall() per Linus
- Explicitly enable DEBUG_VM_PGTABLE when ARCH_HAS_DEBUG_VM_PGTABLE and DEBUG_VM
- Added #ifdef documentation per Gerald
- Dropped page table helper semantics documentation (will be added via later patches)
- Split the X86 changes defining mm_p4d_folded() into a new prerequisite patch

Changes in V16: (https://patchwork.kernel.org/patch/11431277/)

- Replaced WRITE_ONCE() with set_pte_at() with a new barrier() in pte_clear_tests() per Qian
- Enabled all powerpc platforms and updated the feature list

Changes in V15: (https://patchwork.kernel.org/patch/11422803/)

- Replaced __pa() with __pa_symbol() (https://patchwork.kernel.org/patch/11407715/) 
- Replaced pte_alloc_map() with pte_alloc_map_lock() per Qian
- Replaced pte_unmap() with pte_unmap_unlock() per Qian
- Added address to pte_clear_tests() and passed it down till pte_clear() per Qian

Changes in V14: (https://patchwork.kernel.org/project/linux-mm/list/?series=242305)

- Disabled DEBUG_VM_PGTABLE for IA64 and ARM (32 Bit) per Andrew and Christophe
- Updated DEBUG_VM_PGTABLE documentation wrt EXPERT and disabled platforms
- Updated RANDOM_[OR|NZ]VALUE open encodings with GENMASK() per Catalin
- Updated s390 constraint bits from 12 to 4 (S390_MASK_BITS) per Gerald
- Updated in-code documentation for RANDOM_ORVALUE per Gerald
- Updated pxx_basic_tests() to use invert functions first per Catalin
- Dropped ARCH_HAS_4LEVEL_HACK check from pud_basic_tests()
- Replaced __ARCH_HAS_[4|5]LEVEL_HACK with __PAGETABLE_[PUD|P4D]_FOLDED per Catalin
- Trimmed the CC list on the commit message per Catalin

Changes in V13: (https://patchwork.kernel.org/project/linux-mm/list/?series=237125)

- Subscribed s390 platform and updated debug-vm-pgtable/arch-support.txt per Gerald
- Dropped keyword 'extern' from debug_vm_pgtable() declaration per Christophe
- Moved debug_vm_pgtable() declarations to <linux/mmdebug.h> per Christophe
- Moved debug_vm_pgtable() call site into kernel_init() per Christophe
- Changed CONFIG_DEBUG_VM_PGTABLE rules per Christophe
- Updated commit to include new supported platforms and changed config selection

Changes in V12: (https://patchwork.kernel.org/project/linux-mm/list/?series=233905)

- Replaced __mmdrop() with mmdrop()
- Enable ARCH_HAS_DEBUG_VM_PGTABLE on X86 for non CONFIG_X86_PAE platforms as the
  test procedure interfere with pre-allocated PMDs attached to the PGD resulting
  in runtime failures with VM_BUG_ON()

Changes in V11: (https://patchwork.kernel.org/project/linux-mm/list/?series=221135)

- Rebased the patch on V5.4

Changes in V10: (https://patchwork.kernel.org/project/linux-mm/list/?series=205529)

- Always enable DEBUG_VM_PGTABLE when DEBUG_VM is enabled per Ingo
- Added tags from Ingo

Changes in V9: (https://patchwork.kernel.org/project/linux-mm/list/?series=201429)

- Changed feature support enumeration for powerpc platforms per Christophe
- Changed config wrapper for basic_[pmd|pud]_tests() to enable ARC platform
- Enabled the test on ARC platform

Changes in V8: (https://patchwork.kernel.org/project/linux-mm/list/?series=194297)

- Enabled ARCH_HAS_DEBUG_VM_PGTABLE on PPC32 platform per Christophe
- Updated feature documentation as DEBUG_VM_PGTABLE is now enabled on PPC32 platform
- Moved ARCH_HAS_DEBUG_VM_PGTABLE earlier to indent it with DEBUG_VM per Christophe
- Added an information message in debug_vm_pgtable() per Christophe
- Dropped random_vaddr boundary condition checks per Christophe and Qian
- Replaced virt_addr_valid() check with pfn_valid() check in debug_vm_pgtable()
- Slightly changed pr_fmt(fmt) information

Changes in V7: (https://patchwork.kernel.org/project/linux-mm/list/?series=193051)

- Memory allocation and free routines for mapped pages have been droped
- Mapped pfns are derived from standard kernel text symbol per Matthew
- Moved debug_vm_pgtaable() after page_alloc_init_late() per Michal and Qian 
- Updated the commit message per Michal
- Updated W=1 GCC warning problem on x86 per Qian Cai
- Addition of new alloc_contig_pages() helper has been submitted separately

Changes in V6: (https://patchwork.kernel.org/project/linux-mm/list/?series=187589)

- Moved alloc_gigantic_page_order() into mm/page_alloc.c per Michal
- Moved alloc_gigantic_page_order() within CONFIG_CONTIG_ALLOC in the test
- Folded Andrew's include/asm-generic/pgtable.h fix into the test patch 2/2

Changes in V5: (https://patchwork.kernel.org/project/linux-mm/list/?series=185991)

- Redefined and moved X86 mm_p4d_folded() into a different header per Kirill/Ingo
- Updated the config option comment per Ingo and dropped 'kernel module' reference
- Updated the commit message and dropped 'kernel module' reference
- Changed DEBUG_ARCH_PGTABLE_TEST into DEBUG_VM_PGTABLE per Ingo
- Moved config option from mm/Kconfig.debug into lib/Kconfig.debug
- Renamed core test function arch_pgtable_tests() as debug_vm_pgtable()
- Renamed mm/arch_pgtable_test.c as mm/debug_vm_pgtable.c
- debug_vm_pgtable() gets called from kernel_init_freeable() after init_mm_internals()
- Added an entry in Documentation/features/debug/ per Ingo
- Enabled the test on arm64 and x86 platforms for now

Changes in V4: (https://patchwork.kernel.org/project/linux-mm/list/?series=183465)

- Disable DEBUG_ARCH_PGTABLE_TEST for ARM and IA64 platforms

Changes in V3: (https://lore.kernel.org/patchwork/project/lkml/list/?series=411216)

- Changed test trigger from module format into late_initcall()
- Marked all functions with __init to be freed after completion
- Changed all __PGTABLE_PXX_FOLDED checks as mm_pxx_folded()
- Folded in PPC32 fixes from Christophe

Changes in V2:

https://lore.kernel.org/linux-mm/1568268173-31302-1-git-send-email-anshuman.khandual@arm.com/T/#t

- Fixed small typo error in MODULE_DESCRIPTION()
- Fixed m64k build problems for lvalue concerns in pmd_xxx_tests()
- Fixed dynamic page table level folding problems on x86 as per Kirril
- Fixed second pointers during pxx_populate_tests() per Kirill and Gerald
- Allocate and free pte table with pte_alloc_one/pte_free per Kirill
- Modified pxx_clear_tests() to accommodate s390 lower 12 bits situation
- Changed RANDOM_NZVALUE value from 0xbe to 0xff
- Changed allocation, usage, free sequence for saved_ptep
- Renamed VMA_FLAGS as VMFLAGS
- Implemented a new method for random vaddr generation
- Implemented some other cleanups
- Dropped extern reference to mm_alloc()
- Created and exported new alloc_gigantic_page_order()
- Dropped the custom allocator and used new alloc_gigantic_page_order()

Changes in V1:

https://lore.kernel.org/linux-mm/1567497706-8649-1-git-send-email-anshuman.khandual@arm.com/

- Added fallback mechanism for PMD aligned memory allocation failure

Changes in RFC V2:

https://lore.kernel.org/linux-mm/1565335998-22553-1-git-send-email-anshuman.khandual@arm.com/T/#u

- Moved test module and it's config from lib/ to mm/
- Renamed config TEST_ARCH_PGTABLE as DEBUG_ARCH_PGTABLE_TEST
- Renamed file from test_arch_pgtable.c to arch_pgtable_test.c
- Added relevant MODULE_DESCRIPTION() and MODULE_AUTHOR() details
- Dropped loadable module config option
- Basic tests now use memory blocks with required size and alignment
- PUD aligned memory block gets allocated with alloc_contig_range()
- If PUD aligned memory could not be allocated it falls back on PMD aligned
  memory block from page allocator and pud_* tests are skipped
- Clear and populate tests now operate on real in memory page table entries
- Dummy mm_struct gets allocated with mm_alloc()
- Dummy page table entries get allocated with [pud|pmd|pte]_alloc_[map]()
- Simplified [p4d|pgd]_basic_tests(), now has random values in the entries

Original RFC V1:

https://lore.kernel.org/linux-mm/1564037723-26676-1-git-send-email-anshuman.khandual@arm.com/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: x86@kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Anshuman Khandual (2):
  x86/mm: Define mm_p4d_folded()
  mm/debug: Add tests validating architecture page table helpers

 .../debug/debug-vm-pgtable/arch-support.txt   |  34 ++
 arch/arc/Kconfig                              |   1 +
 arch/arm64/Kconfig                            |   1 +
 arch/powerpc/Kconfig                          |   1 +
 arch/s390/Kconfig                             |   1 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/include/asm/pgtable_64.h             |   6 +
 lib/Kconfig.debug                             |  22 +
 mm/Makefile                                   |   1 +
 mm/debug_vm_pgtable.c                         | 382 ++++++++++++++++++
 10 files changed, 450 insertions(+)
 create mode 100644 Documentation/features/debug/debug-vm-pgtable/arch-support.txt
 create mode 100644 mm/debug_vm_pgtable.c

-- 
2.20.1

