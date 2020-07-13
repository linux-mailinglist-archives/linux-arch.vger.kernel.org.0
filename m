Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA9A21CD9B
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 05:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgGMDXv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Jul 2020 23:23:51 -0400
Received: from foss.arm.com ([217.140.110.172]:37438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMDXv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 12 Jul 2020 23:23:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA64C1FB;
        Sun, 12 Jul 2020 20:23:49 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.87.124])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 92B753F7D8;
        Sun, 12 Jul 2020 20:23:35 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     agordeev@linux.ibm.com, ziy@nvidia.com, gerald.schaefer@de.ibm.com,
        christophe.leroy@c-s.fr, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, rppt@kernel.org, cai@lca.pw,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 0/4] mm/debug_vm_pgtable: Add some more tests
Date:   Mon, 13 Jul 2020 08:53:03 +0530
Message-Id: <1594610587-4172-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series adds some more arch page table helper validation tests which
are related to core and advanced memory functions. This also creates a
documentation, enlisting expected semantics for all page table helpers as
suggested by Mike Rapoport previously (https://lkml.org/lkml/2020/1/30/40).

There are many TRANSPARENT_HUGEPAGE and ARCH_HAS_TRANSPARENT_HUGEPAGE_PUD
ifdefs scattered across the test. But consolidating all the fallback stubs
is not very straight forward because ARCH_HAS_TRANSPARENT_HUGEPAGE_PUD is
not explicitly dependent on ARCH_HAS_TRANSPARENT_HUGEPAGE.

Tested on arm64, x86 platforms but only build tested on all other enabled
platforms through ARCH_HAS_DEBUG_VM_PGTABLE i.e powerpc, arc, s390. The
following failure on arm64 still exists which was mentioned previously. It
will be fixed with the upcoming THP migration on arm64 enablement series.

WARNING .... mm/debug_vm_pgtable.c:866 debug_vm_pgtable+0x940/0xa54
WARN_ON(!pmd_present(pmd_mkinvalid(pmd_mkhuge(pmd))))

This series is based on v5.8-rc5.

Changes in V5:

- Dropped RANDOM_ORVALUE from hugetlb_advanced_tests()
- Folded in Mike's patch for the rst document
- Fixed typos in the rst document

Changes in V4: (https://patchwork.kernel.org/project/linux-mm/list/?series=313173)

- Replaced READ_ONCE() with ptep_get() while accessing PTE pointers per Christophe
- Fixed function argument alignments per Christophe

Changes in V3: (https://patchwork.kernel.org/project/linux-mm/list/?series=302483)

- Replaced HAVE_ARCH_SOFT_DIRTY with MEM_SOFT_DIRTY
- Added HAVE_ARCH_HUGE_VMAP checks in pxx_huge_tests() per Gerald
- Updated documentation for pmd_thp_tests() per Zi Yan
- Replaced READ_ONCE() with huge_ptep_get() per Gerald
- Added pte_mkhuge() and masking with PMD_MASK per Gerald
- Replaced pte_same() with holding pfn check in pxx_swap_tests()
- Added documentation for all (#ifdef #else #endif) per Gerald
- Updated pmd_protnone_tests() per Gerald
- Updated HugeTLB PTE creation in hugetlb_advanced_tests() per Gerald
- Replaced [pmd|pud]_mknotpresent() with [pmd|pud]_mkinvalid()
- Added has_transparent_hugepage() check for PMD and PUD tests
- Added a patch which debug prints all individual tests being executed
- Updated documentation for renamed [pmd|pud]_mkinvalid() helpers

Changes in V2: (https://patchwork.kernel.org/project/linux-mm/list/?series=260573)

- Dropped CONFIG_ARCH_HAS_PTE_SPECIAL per Christophe
- Dropped CONFIG_NUMA_BALANCING per Christophe
- Dropped CONFIG_HAVE_ARCH_SOFT_DIRTY per Christophe
- Dropped CONFIG_MIGRATION per Christophe
- Replaced CONFIG_S390 with __HAVE_ARCH_PMDP_INVALIDATE
- Moved page allocation & free inside swap_migration_tests() per Christophe
- Added CONFIG_TRANSPARENT_HUGEPAGE to protect pfn_pmd()
- Added CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD to protect pfn_pud()
- Added a patch for other arch advanced page table helper tests
- Added a patch creating a documentation for page table helper semantics

Changes in V1: (https://patchwork.kernel.org/patch/11408253/)

Cc: Jonathan Corbet <corbet@lwn.net>
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
Cc: Zi Yan <ziy@nvidia.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: x86@kernel.org
Cc: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (4):
  mm/debug_vm_pgtable: Add tests validating arch helpers for core MM features
  mm/debug_vm_pgtable: Add tests validating advanced arch page table helpers
  mm/debug_vm_pgtable: Add debug prints for individual tests
  Documentation/mm: Add descriptions for arch page table helpers

 Documentation/vm/arch_pgtable_helpers.rst | 258 +++++++++
 mm/debug_vm_pgtable.c                     | 666 +++++++++++++++++++++-
 2 files changed, 922 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/vm/arch_pgtable_helpers.rst

-- 
2.20.1

