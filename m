Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F06D0199876
	for <lists+linux-arch@lfdr.de>; Tue, 31 Mar 2020 16:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbgCaOaD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Mar 2020 10:30:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12153 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731053AbgCaOaD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Mar 2020 10:30:03 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 112F5A18324581DE4AB4;
        Tue, 31 Mar 2020 22:29:53 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 31 Mar 2020 22:29:44 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <peterz@infradead.org>, <mark.rutland@arm.com>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <aneesh.kumar@linux.ibm.com>,
        <akpm@linux-foundation.org>, <npiggin@gmail.com>, <arnd@arndb.de>,
        <rostedt@goodmis.org>, <maz@kernel.org>, <suzuki.poulose@arm.com>,
        <tglx@linutronix.de>, <yuzhao@google.com>, <Dave.Martin@arm.com>,
        <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>, <corbet@lwn.net>, <vgupta@synopsys.com>,
        <tony.luck@intel.com>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
Subject: [RFC PATCH v5 0/8] arm64: tlb: add support for TTL feature
Date:   Tue, 31 Mar 2020 22:29:19 +0800
Message-ID: <20200331142927.1237-1-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
feature allows TLBs to be issued with a level allowing for quicker
invalidation.  This series provide support for this feature.

Patch 1 and Patch 2 was provided by Marc on his NV series[1] patches,
which detect the TTL feature and add __tlbi_level interface.
Patch 4-7 passes struct mmu_gather to flush_tlb_range, which can pass
the level of tlbi invalidations.  Arm64 and power9 can benefit from this.
Patch 8 set the TTL field in arm64 by using the cleared_* values in
struct mmu_gather.

See patches for details, Thanks.

[1] https://lore.kernel.org/linux-arm-kernel/20200211174938.27809-1-maz@kernel.org/
[2] https://lore.kernel.org/linux-arm-kernel/7859561b-78b4-4a12-2642-3741d7d3e7b8@huawei.com/

--
ChangeList:
v1:
add support for TTL feature in arm64.

v2:
build the patch on Marc's NV series[1].

v3:
use vma->vm_flags to replace mm->context.flags.

v4:
add Marc's patches into my series.

v5:
pass struct mmu_gather to flush_tlb_range, then set the
TTL field by using infos in struct mmu_gather.


Marc Zyngier (2):
  arm64: Detect the ARMv8.4 TTL feature
  arm64: Add level-hinted TLB invalidation helper

Zhenyu Ye (6):
  arm64: Add tlbi_user_level TLB invalidation helper
  mm: tlb: Pass struct mmu_gather to flush_pmd_tlb_range
  mm: tlb: Pass struct mmu_gather to flush_pud_tlb_range
  mm: tlb: Pass struct mmu_gather to flush_hugetlb_tlb_range
  mm: tlb: Pass struct mmu_gather to flush_tlb_range
  arm64: tlb: Set the TTL field in flush_tlb_range

 Documentation/core-api/cachetlb.rst           |  8 ++-
 arch/alpha/include/asm/tlbflush.h             |  8 +--
 arch/alpha/kernel/smp.c                       |  3 +-
 arch/arc/include/asm/hugepage.h               |  4 +-
 arch/arc/include/asm/tlbflush.h               | 11 ++--
 arch/arc/mm/tlb.c                             |  8 +--
 arch/arm/include/asm/tlbflush.h               | 12 ++--
 arch/arm/kernel/smp_tlb.c                     |  4 +-
 arch/arm/mach-rpc/ecard.c                     |  8 ++-
 arch/arm64/crypto/aes-glue.c                  |  1 -
 arch/arm64/include/asm/cpucaps.h              |  3 +-
 arch/arm64/include/asm/sysreg.h               |  1 +
 arch/arm64/include/asm/tlb.h                  | 39 +++++++++++-
 arch/arm64/include/asm/tlbflush.h             | 63 +++++++++++++------
 arch/arm64/kernel/cpufeature.c                | 11 ++++
 arch/arm64/mm/hugetlbpage.c                   | 10 ++-
 arch/csky/include/asm/tlb.h                   |  2 +-
 arch/csky/include/asm/tlbflush.h              |  6 +-
 arch/csky/mm/tlb.c                            |  4 +-
 arch/hexagon/include/asm/tlbflush.h           |  2 +-
 arch/hexagon/mm/vm_tlb.c                      |  4 +-
 arch/ia64/include/asm/tlbflush.h              |  6 +-
 arch/ia64/mm/tlb.c                            |  5 +-
 arch/m68k/include/asm/tlbflush.h              | 10 +--
 arch/microblaze/include/asm/tlbflush.h        |  5 +-
 arch/mips/include/asm/hugetlb.h               |  6 +-
 arch/mips/include/asm/tlbflush.h              |  9 +--
 arch/mips/kernel/smp.c                        |  3 +-
 arch/nds32/include/asm/tlbflush.h             |  3 +-
 arch/nios2/include/asm/tlbflush.h             |  9 +--
 arch/nios2/mm/tlb.c                           |  8 ++-
 arch/openrisc/include/asm/tlbflush.h          | 10 +--
 arch/openrisc/kernel/smp.c                    |  2 +-
 arch/parisc/include/asm/tlbflush.h            |  2 +-
 arch/parisc/kernel/cache.c                    | 13 +++-
 arch/powerpc/include/asm/book3s/32/tlbflush.h |  4 +-
 arch/powerpc/include/asm/book3s/64/tlbflush.h |  9 ++-
 arch/powerpc/include/asm/nohash/tlbflush.h    |  7 ++-
 arch/powerpc/mm/book3s32/tlb.c                |  6 +-
 arch/powerpc/mm/book3s64/pgtable.c            |  8 ++-
 arch/powerpc/mm/book3s64/radix_tlb.c          |  2 +-
 arch/powerpc/mm/nohash/tlb.c                  |  6 +-
 arch/riscv/include/asm/tlbflush.h             |  7 ++-
 arch/riscv/mm/tlbflush.c                      |  4 +-
 arch/s390/include/asm/tlbflush.h              |  5 +-
 arch/sh/include/asm/tlbflush.h                |  8 +--
 arch/sh/kernel/smp.c                          |  2 +-
 arch/sparc/include/asm/tlbflush_32.h          |  2 +-
 arch/sparc/include/asm/tlbflush_64.h          |  3 +-
 arch/sparc/mm/tlb.c                           |  5 +-
 arch/um/include/asm/tlbflush.h                |  6 +-
 arch/um/kernel/tlb.c                          |  4 +-
 arch/unicore32/include/asm/tlbflush.h         |  5 +-
 arch/x86/include/asm/tlbflush.h               |  4 +-
 arch/x86/mm/pgtable.c                         | 10 ++-
 arch/xtensa/include/asm/tlbflush.h            | 10 +--
 arch/xtensa/kernel/smp.c                      |  2 +-
 include/asm-generic/pgtable.h                 | 10 +--
 include/asm-generic/tlb.h                     |  2 +-
 mm/huge_memory.c                              | 19 +++++-
 mm/hugetlb.c                                  | 17 +++--
 mm/mapping_dirty_helpers.c                    | 23 ++++---
 mm/migrate.c                                  |  8 ++-
 mm/mprotect.c                                 |  8 ++-
 mm/mremap.c                                   | 17 ++++-
 mm/pgtable-generic.c                          | 51 ++++++++++++---
 mm/rmap.c                                     |  6 +-
 67 files changed, 409 insertions(+), 174 deletions(-)

-- 
2.19.1


