Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B733C1F8C92
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jun 2020 05:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgFODjE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Jun 2020 23:39:04 -0400
Received: from foss.arm.com ([217.140.110.172]:37870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbgFODjD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 14 Jun 2020 23:39:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CCBA11B3;
        Sun, 14 Jun 2020 20:39:02 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.79.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9AE783F71F;
        Sun, 14 Jun 2020 20:38:52 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     christophe.leroy@c-s.fr, ziy@nvidia.com,
        gerald.schaefer@de.ibm.com,
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
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/4] Documentation/mm: Add descriptions for arch page table helpers
Date:   Mon, 15 Jun 2020 09:07:57 +0530
Message-Id: <1592192277-8421-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592192277-8421-1-git-send-email-anshuman.khandual@arm.com>
References: <1592192277-8421-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This adds a specific description file for all arch page table helpers which
is in sync with the semantics being tested via CONFIG_DEBUG_VM_PGTABLE. All
future changes either to these descriptions here or the debug test should
always remain in sync.

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
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: x86@kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/vm/arch_pgtable_helpers.rst | 258 ++++++++++++++++++++++
 mm/debug_vm_pgtable.c                     |   6 +
 2 files changed, 264 insertions(+)
 create mode 100644 Documentation/vm/arch_pgtable_helpers.rst

diff --git a/Documentation/vm/arch_pgtable_helpers.rst b/Documentation/vm/arch_pgtable_helpers.rst
new file mode 100644
index 000000000000..cd7609b05446
--- /dev/null
+++ b/Documentation/vm/arch_pgtable_helpers.rst
@@ -0,0 +1,258 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _arch_page_table_helpers:
+
+===============================
+Architecture Page Table Helpers
+===============================
+
+Generic MM expects architectures (with MMU) to provide helpers to create, access
+and modify page table entries at various level for different memory functions.
+These page table helpers need to conform to a common semantics across platforms.
+Following tables describe the expected semantics which can also be tested during
+boot via CONFIG_DEBUG_VM_PGTABLE option. All future changes in here or the debug
+test need to be in sync.
+
+======================
+PTE Page Table Helpers
+======================
+
+--------------------------------------------------------------------------------
+| pte_same                  | Tests whether both PTE entries are the same      |
+--------------------------------------------------------------------------------
+| pte_bad                   | Tests a non-table mapped PTE                     |
+--------------------------------------------------------------------------------
+| pte_present               | Tests a valid mapped PTE                         |
+--------------------------------------------------------------------------------
+| pte_young                 | Tests a young PTE                                |
+--------------------------------------------------------------------------------
+| pte_dirty                 | Tests a dirty PTE                                |
+--------------------------------------------------------------------------------
+| pte_write                 | Tests a writable PTE                             |
+--------------------------------------------------------------------------------
+| pte_special               | Tests a special PTE                              |
+--------------------------------------------------------------------------------
+| pte_protnone              | Tests a PROT_NONE PTE                            |
+--------------------------------------------------------------------------------
+| pte_devmap                | Tests a ZONE_DEVICE mapped PTE                   |
+--------------------------------------------------------------------------------
+| pte_soft_dirty            | Tests a soft dirty PTE                           |
+--------------------------------------------------------------------------------
+| pte_swp_soft_dirty        | Tests a soft dirty swapped PTE                   |
+--------------------------------------------------------------------------------
+| pte_mkyoung               | Creates a young PTE                              |
+--------------------------------------------------------------------------------
+| pte_mkold                 | Creates an old PTE                               |
+--------------------------------------------------------------------------------
+| pte_mkdirty               | Creates a dirty PTE                              |
+--------------------------------------------------------------------------------
+| pte_mkclean               | Creates a clean PTE                              |
+--------------------------------------------------------------------------------
+| pte_mkwrite               | Creates a writable PTE                           |
+--------------------------------------------------------------------------------
+| pte_mkwrprotect           | Creates a write protected PTE                    |
+--------------------------------------------------------------------------------
+| pte_mkspecial             | Creates a special PTE                            |
+--------------------------------------------------------------------------------
+| pte_mkdevmap              | Creates a ZONE_DEVICE mapped PTE                 |
+--------------------------------------------------------------------------------
+| pte_mksoft_dirty          | Creates a soft dirty PTE                         |
+--------------------------------------------------------------------------------
+| pte_clear_soft_dirty      | Clears a soft dirty PTE                          |
+--------------------------------------------------------------------------------
+| pte_swp_mksoft_dirty      | Creates a soft dirty swapped PTE                 |
+--------------------------------------------------------------------------------
+| pte_swp_clear_soft_dirty  | Clears a soft dirty swapped PTE                  |
+--------------------------------------------------------------------------------
+| pte_mknotpresent          | Invalidates a mapped PTE                         |
+--------------------------------------------------------------------------------
+| ptep_get_and_clear        | Clears a PTE                                     |
+--------------------------------------------------------------------------------
+| ptep_get_and_clear_full   | Clears a PTE                                     |
+--------------------------------------------------------------------------------
+| ptep_test_and_clear_young | Clears young from a PTE                          |
+--------------------------------------------------------------------------------
+| ptep_set_wrprotect        | Converts into a write protected PTE              |
+--------------------------------------------------------------------------------
+| ptep_set_access_flags     | Converts into a more permissive PTE              |
+--------------------------------------------------------------------------------
+
+======================
+PMD Page Table Helpers
+======================
+
+--------------------------------------------------------------------------------
+| pmd_same                  | Tests whether both PMD entries are the same      |
+--------------------------------------------------------------------------------
+| pmd_bad                   | Tests a non-table mapped PMD                     |
+--------------------------------------------------------------------------------
+| pmd_leaf                  | Tests a leaf mapped PMD                          |
+--------------------------------------------------------------------------------
+| pmd_huge                  | Tests a HugeTLB mapped PMD                       |
+--------------------------------------------------------------------------------
+| pmd_trans_huge            | Tests a Transparent Huge Page (THP) at PMD       |
+--------------------------------------------------------------------------------
+| pmd_present               | Tests a valid mapped PMD                         |
+--------------------------------------------------------------------------------
+| pmd_young                 | Tests a young PMD                                |
+--------------------------------------------------------------------------------
+| pmd_dirty                 | Tests a dirty PMD                                |
+--------------------------------------------------------------------------------
+| pmd_write                 | Tests a writable PMD                             |
+--------------------------------------------------------------------------------
+| pmd_special               | Tests a special PMD                              |
+--------------------------------------------------------------------------------
+| pmd_protnone              | Tests a PROT_NONE PMD                            |
+--------------------------------------------------------------------------------
+| pmd_devmap                | Tests a ZONE_DEVICE mapped PMD                   |
+--------------------------------------------------------------------------------
+| pmd_soft_dirty            | Tests a soft dirty PMD                           |
+--------------------------------------------------------------------------------
+| pmd_swp_soft_dirty        | Tests a soft dirty swapped PMD                   |
+--------------------------------------------------------------------------------
+| pmd_mkyoung               | Creates a young PMD                              |
+--------------------------------------------------------------------------------
+| pmd_mkold                 | Creates an old PMD                               |
+--------------------------------------------------------------------------------
+| pmd_mkdirty               | Creates a dirty PMD                              |
+--------------------------------------------------------------------------------
+| pmd_mkclean               | Creates a clean PMD                              |
+--------------------------------------------------------------------------------
+| pmd_mkwrite               | Creates a writable PMD                           |
+--------------------------------------------------------------------------------
+| pmd_mkwrprotect           | Creates a write protected PMD                    |
+--------------------------------------------------------------------------------
+| pmd_mkspecial             | Creates a special PMD                            |
+--------------------------------------------------------------------------------
+| pmd_mkdevmap              | Creates a ZONE_DEVICE mapped PMD                 |
+--------------------------------------------------------------------------------
+| pmd_mksoft_dirty          | Creates a soft dirty PMD                         |
+--------------------------------------------------------------------------------
+| pmd_clear_soft_dirty      | Clears a soft dirty PMD                          |
+--------------------------------------------------------------------------------
+| pmd_swp_mksoft_dirty      | Creates a soft dirty swapped PMD                 |
+--------------------------------------------------------------------------------
+| pmd_swp_clear_soft_dirty  | Clears a soft dirty swapped PMD                  |
+--------------------------------------------------------------------------------
+| pmd_mkinvalid             | Invalidates a mapped PMD [1]                     |
+--------------------------------------------------------------------------------
+| pmd_set_huge              | Creates a PMD huge mapping                       |
+--------------------------------------------------------------------------------
+| pmd_clear_huge            | Clears a PMD huge mapping                        |
+--------------------------------------------------------------------------------
+| pmdp_get_and_clear        | Clears a PMD                                     |
+--------------------------------------------------------------------------------
+| pmdp_get_and_clear_full   | Clears a PMD                                     |
+--------------------------------------------------------------------------------
+| pmdp_test_and_clear_young | Clears young from a PMD                          |
+--------------------------------------------------------------------------------
+| pmdp_set_wrprotect        | Converts into a write protected PMD              |
+--------------------------------------------------------------------------------
+| pmdp_set_access_flags     | Converts into a more permissive PMD              |
+--------------------------------------------------------------------------------
+
+======================
+PUD Page Table Helpers
+======================
+
+--------------------------------------------------------------------------------
+| pud_same                  | Tests whether both PUD entries are the same      |
+--------------------------------------------------------------------------------
+| pud_bad                   | Tests a non-table mapped PUD                     |
+--------------------------------------------------------------------------------
+| pud_leaf                  | Tests a leaf mapped PUD                          |
+--------------------------------------------------------------------------------
+| pud_huge                  | Tests a HugeTLB mapped PUD                       |
+--------------------------------------------------------------------------------
+| pud_trans_huge            | Tests a Transparent Huge Page (THP) at PUD       |
+--------------------------------------------------------------------------------
+| pud_present               | Tests a valid mapped PUD                         |
+--------------------------------------------------------------------------------
+| pud_young                 | Tests a young PUD                                |
+--------------------------------------------------------------------------------
+| pud_dirty                 | Tests a dirty PUD                                |
+--------------------------------------------------------------------------------
+| pud_write                 | Tests a writable PUD                             |
+--------------------------------------------------------------------------------
+| pud_devmap                | Tests a ZONE_DEVICE mapped PUD                   |
+--------------------------------------------------------------------------------
+| pud_mkyoung               | Creates a young PUD                              |
+--------------------------------------------------------------------------------
+| pud_mkold                 | Creates an old PUD                               |
+--------------------------------------------------------------------------------
+| pud_mkdirty               | Creates a dirty PUD                              |
+--------------------------------------------------------------------------------
+| pud_mkclean               | Creates a clean PUD                              |
+--------------------------------------------------------------------------------
+| pud_mkwrite               | Creates a writable PMD                           |
+--------------------------------------------------------------------------------
+| pud_mkwrprotect           | Creates a write protected PMD                    |
+--------------------------------------------------------------------------------
+| pud_mkdevmap              | Creates a ZONE_DEVICE mapped PMD                 |
+--------------------------------------------------------------------------------
+| pud_mkinvalid             | Invalidates a mapped PUD [1]                     |
+--------------------------------------------------------------------------------
+| pud_set_huge              | Creates a PUD huge mapping                       |
+--------------------------------------------------------------------------------
+| pud_clear_huge            | Clears a PUD huge mapping                        |
+--------------------------------------------------------------------------------
+| pudp_get_and_clear        | Clears a PUD                                     |
+--------------------------------------------------------------------------------
+| pudp_get_and_clear_full   | Clears a PUD                                     |
+--------------------------------------------------------------------------------
+| pudp_test_and_clear_young | Clears young from a PUD                          |
+--------------------------------------------------------------------------------
+| pudp_set_wrprotect        | Converts into a write protected PUD              |
+--------------------------------------------------------------------------------
+| pudp_set_access_flags     | Converts into a more permissive PUD              |
+--------------------------------------------------------------------------------
+
+==========================
+HugeTLB Page Table Helpers
+==========================
+
+--------------------------------------------------------------------------------
+| pte_huge                  | Tests a HugeTLB                                  |
+--------------------------------------------------------------------------------
+| pte_mkhuge                | Creates a HugeTLB                                |
+--------------------------------------------------------------------------------
+| huge_pte_dirty            | Tests a dirty HugeTLB                            |
+--------------------------------------------------------------------------------
+| huge_pte_write            | Tests a writable HugeTLB                         |
+--------------------------------------------------------------------------------
+| huge_pte_mkdirty          | Creates a dirty HugeTLB                          |
+--------------------------------------------------------------------------------
+| huge_pte_mkwrite          | Creates a writable HugeTLB                       |
+--------------------------------------------------------------------------------
+| huge_pte_mkwrprotect      | Creates a write protected HugeTLB                |
+--------------------------------------------------------------------------------
+| huge_ptep_get_and_clear   | Clears a HugeTLB                                 |
+--------------------------------------------------------------------------------
+| huge_ptep_set_wrprotect   | Converts into a write protected HugeTLB          |
+--------------------------------------------------------------------------------
+| huge_ptep_set_access_flags  | Converts into a more permissive HugeTLB        |
+--------------------------------------------------------------------------------
+
+========================
+SWAP Page Table Helpers
+========================
+
+--------------------------------------------------------------------------------
+| __pte_to_swp_entry        | Creates a swapped entry (arch) from a mapepd PTE |
+--------------------------------------------------------------------------------
+| __swp_to_pte_entry        | Creates a mapped PTE from a swapped entry (arch) |
+--------------------------------------------------------------------------------
+| __pmd_to_swp_entry        | Creates a swapped entry (arch) from a mapepd PMD |
+--------------------------------------------------------------------------------
+| __swp_to_pmd_entry        | Creates a mapped PMD from a swapped entry (arch) |
+--------------------------------------------------------------------------------
+| is_migration_entry        | Tests a migration (read or write) swapped entry  |
+--------------------------------------------------------------------------------
+| is_write_migration_entry  | Tests a write migration swapped entry            |
+--------------------------------------------------------------------------------
+| make_migration_entry_read | Converts into read migration swapped entry       |
+--------------------------------------------------------------------------------
+| make_migration_entry      | Creates a migration swapped entry (read or write)|
+--------------------------------------------------------------------------------
+
+[1] https://lore.kernel.org/linux-mm/20181017020930.GN30832@redhat.com/
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 536f3b1b3ad6..a2936938ed78 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -31,6 +31,12 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
+/*
+ * Please refer Documentation/vm/arch_pgtable_helpers.rst for the semantics
+ * expectations that are being validated here. All future changes in here
+ * or the documentation need to be in sync.
+ */
+
 #define VMFLAGS	(VM_READ|VM_WRITE|VM_EXEC)
 
 /*
-- 
2.20.1

