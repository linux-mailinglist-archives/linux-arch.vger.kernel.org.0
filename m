Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10B791904E1
	for <lists+linux-arch@lfdr.de>; Tue, 24 Mar 2020 06:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgCXFXU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Mar 2020 01:23:20 -0400
Received: from foss.arm.com ([217.140.110.172]:57454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgCXFXT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Mar 2020 01:23:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CB3F30E;
        Mon, 23 Mar 2020 22:23:19 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6AE573F7C3;
        Mon, 23 Mar 2020 22:27:15 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     christophe.leroy@c-s.fr,
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
Subject: [PATCH V2 0/3] mm/debug: Add more arch page table helper tests
Date:   Tue, 24 Mar 2020 10:52:52 +0530
Message-Id: <1585027375-9997-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series adds more arch page table helper tests. The new tests here are
either related to core memory functions and advanced arch pgtable helpers.
This also creates a documentation file enlisting all expected semantics as
suggested by Mike Rapoport (https://lkml.org/lkml/2020/1/30/40).

This series has been tested on arm64 and x86 platforms. There is just one
expected failure on arm64 that will be fixed when we enable THP migration.

[   21.741634] WARNING: CPU: 0 PID: 1 at mm/debug_vm_pgtable.c:782

which corresponds to

WARN_ON(!pmd_present(pmd_mknotpresent(pmd_mkhuge(pmd))))

There are many TRANSPARENT_HUGEPAGE and ARCH_HAS_TRANSPARENT_HUGEPAGE_PUD
ifdefs scattered across the test. But consolidating all the fallback stubs
is not very straight forward because ARCH_HAS_TRANSPARENT_HUGEPAGE_PUD is
not explicitly dependent on ARCH_HAS_TRANSPARENT_HUGEPAGE.

This series has been build tested on many platforms including the ones that
subscribe the test through ARCH_HAS_DEBUG_VM_PGTABLE.

This series is based on v5.6-rc7 after applying these following patches.

1. https://patchwork.kernel.org/patch/11431277/
2. https://patchwork.kernel.org/patch/11452185/

Changes in V2:

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
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (3):
  mm/debug: Add tests validating arch page table helpers for core features
  mm/debug: Add tests validating arch advanced page table helpers
  Documentation/mm: Add descriptions for arch page table helpers

 Documentation/vm/arch_pgtable_helpers.rst | 256 ++++++++++
 mm/debug_vm_pgtable.c                     | 594 +++++++++++++++++++++-
 2 files changed, 839 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/vm/arch_pgtable_helpers.rst

-- 
2.20.1

