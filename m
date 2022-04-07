Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29684F7CF2
	for <lists+linux-arch@lfdr.de>; Thu,  7 Apr 2022 12:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244460AbiDGKgO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Apr 2022 06:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244469AbiDGKgH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Apr 2022 06:36:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A490D95D4;
        Thu,  7 Apr 2022 03:32:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87DA012FC;
        Thu,  7 Apr 2022 03:32:38 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.36.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 224E63F5A1;
        Thu,  7 Apr 2022 03:32:33 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/7] mm/mmap: Drop arch_vm_get_page_prot() and arch_filter_pgprot()
Date:   Thu,  7 Apr 2022 16:02:44 +0530
Message-Id: <20220407103251.1209606-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

protection_map[] is an array based construct that translates given vm_flags
combination. This array contains page protection map, which is populated by
the platform via [__S000 .. __S111] and [__P000 .. __P111] exported macros.
Primary usage for protection_map[] is for vm_get_page_prot(), which is used
to determine page protection value for a given vm_flags. vm_get_page_prot()
implementation, could again call platform overrides arch_vm_get_page_prot()
and arch_filter_pgprot(). Some platforms override protection_map[] that was
originally built with __SXXX/__PXXX with different runtime values.

Currently there are multiple layers of abstraction i.e __SXXX/__PXXX macros
, protection_map[], arch_vm_get_page_prot() and arch_filter_pgprot() built
between the platform and generic MM, finally defining vm_get_page_prot().

Hence this series proposes to drop later two abstraction levels and instead
just move the responsibility of defining vm_get_page_prot() to the platform
(still utilizing generic protection_map[] array) itself making it clean and
simple.

This first introduces ARCH_HAS_VM_GET_PAGE_PROT which enables the platforms
to define custom vm_get_page_prot(). This starts converting platforms that
define the overrides arch_filter_pgprot() or arch_vm_get_page_prot() which
enables for those constructs to be dropped off completely.

The series has been inspired from an earlier discuss with Christoph Hellwig

https://lore.kernel.org/all/1632712920-8171-1-git-send-email-anshuman.khandual@arm.com/

This series applies on 5.18-rc1 after the following patch.

https://lore.kernel.org/all/1643004823-16441-1-git-send-email-anshuman.khandual@arm.com/

This series has been cross built for multiple platforms.

- Anshuman

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: sparclinux@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Changes in V4:

- ARCH_HAS_VM_GET_PAGE_PROT now excludes generic protection_map[]
- Changed platform's vm_get_page_prot() to use generic protection_map[]
- Dropped all platform changes not enabling either arch_vm_get_page_prot() or arch_filter_pgprot() 
- Dropped all previous tags as code base has changed

Changes in V3:

https://lore.kernel.org/all/1646045273-9343-1-git-send-email-anshuman.khandual@arm.com/

- Dropped variable 'i' from sme_early_init() on x86 platform
- Moved CONFIG_COLDFIRE vm_get_page_prot() inside arch/m68k/mm/mcfmmu.c
- Moved CONFIG_SUN3 vm_get_page_prot() inside arch/m68k/mm/sun3mmu.c
- Dropped cachebits for vm_get_page_prot() inside arch/m68k/mm/motorola.c
- Dropped PAGE_XXX_C definitions from arch/m68k/include/asm/motorola_pgtable.h
- Used PAGE_XXX instead for vm_get_page_prot() inside arch/m68k/mm/motorola.c
- Dropped all references to protection_map[] in the tree
- Replaced s/extensa/xtensa/ on the patch title
- Moved left over comments from pgtable.h into init.c on nios2 platform

Changes in V2:

https://lore.kernel.org/all/1645425519-9034-1-git-send-email-anshuman.khandual@arm.com/

- Dropped the entire comment block in [PATCH 30/30] per Geert
- Replaced __P010 (although commented) with __PAGE_COPY on arm platform
- Replaced __P101 with PAGE_READONLY on um platform

Changes in V1:

https://lore.kernel.org/all/1644805853-21338-1-git-send-email-anshuman.khandual@arm.com/

- Add white spaces around the | operators 
- Moved powerpc_vm_get_page_prot() near vm_get_page_prot() on powerpc
- Moved arm64_vm_get_page_prot() near vm_get_page_prot() on arm64
- Moved sparc_vm_get_page_prot() near vm_get_page_prot() on sparc
- Compacted vm_get_page_prot() switch cases on all platforms
-  _PAGE_CACHE040 inclusion is dependent on CPU_IS_040_OR_060
- VM_SHARED case should return PAGE_NONE (not PAGE_COPY) on SH platform
- Reorganized VM_SHARED, VM_EXEC, VM_WRITE, VM_READ
- Dropped the last patch [RFC V1 31/31] which added macros for vm_flags combinations
  https://lore.kernel.org/all/1643029028-12710-32-git-send-email-anshuman.khandual@arm.com/

Changes in RFC:

https://lore.kernel.org/all/1643029028-12710-1-git-send-email-anshuman.khandual@arm.com/

Anshuman Khandual (6):
  mm/mmap: Add new config ARCH_HAS_VM_GET_PAGE_PROT
  powerpc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  arm64/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  sparc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  mm/mmap: Drop arch_filter_pgprot()
  mm/mmap: Drop arch_vm_get_page_pgprot()

Christoph Hellwig (1):
  x86/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT

 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/mman.h    | 24 ----------------------
 arch/arm64/mm/mmap.c             | 33 ++++++++++++++++++++++++++++++
 arch/powerpc/Kconfig             |  1 +
 arch/powerpc/include/asm/mman.h  | 12 -----------
 arch/powerpc/mm/mmap.c           | 26 ++++++++++++++++++++++++
 arch/sparc/Kconfig               |  1 +
 arch/sparc/include/asm/mman.h    |  6 ------
 arch/sparc/mm/init_64.c          | 13 ++++++++++++
 arch/x86/Kconfig                 |  2 +-
 arch/x86/include/asm/pgtable.h   |  5 -----
 arch/x86/include/uapi/asm/mman.h | 14 -------------
 arch/x86/mm/Makefile             |  2 +-
 arch/x86/mm/pgprot.c             | 35 ++++++++++++++++++++++++++++++++
 include/linux/mman.h             |  4 ----
 mm/Kconfig                       |  2 +-
 mm/mmap.c                        | 14 ++++---------
 17 files changed, 117 insertions(+), 78 deletions(-)
 create mode 100644 arch/x86/mm/pgprot.c

-- 
2.25.1

