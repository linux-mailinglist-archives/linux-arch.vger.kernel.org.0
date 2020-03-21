Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E99A18E10A
	for <lists+linux-arch@lfdr.de>; Sat, 21 Mar 2020 13:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgCUMQr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Mar 2020 08:16:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12115 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726997AbgCUMQr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 21 Mar 2020 08:16:47 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4E3BAB000FCFC12C27AE;
        Sat, 21 Mar 2020 20:16:37 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Sat, 21 Mar 2020 20:16:29 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <aneesh.kumar@linux.ibm.com>,
        <maz@kernel.org>, <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>
Subject: [RFC PATCH v3 0/4] arm64: tlb: add support for TTL field
Date:   Sat, 21 Mar 2020 20:16:17 +0800
Message-ID: <20200321121621.1600-1-yezhenyu2@huawei.com>
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

--
ChangeList:
v3:
use vma->vm_flags to replace mm->context.flags.

v2:
build the patch on Marc's NV series[1].

v1:
add support for TTL field in arm64.

--
ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
the level of translation table walk holding the leaf entry for the
address that is being invalidated. Hardware can use this information
to determine if there was a risk of splintering.

Marc has provided basic support for ARM64-TTL features on his
NV series[1] patches. NV is a large feature, however, only
patches 62[2] and 67[3] are need by this patch set. 
** You only need read those two patches before review this patch. **

Some of this patch depends on a feature powered by @Will Deacon
two years ago, which tracking the level of page tables in mm_gather.
See more in commit a6d60245.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/nv-5.6-rc1
[2] https://lore.kernel.org/linux-arm-kernel/20200211174938.27809-63-maz@kernel.org/
[3] https://lore.kernel.org/linux-arm-kernel/20200211174938.27809-68-maz@kernel.org/

Zhenyu Ye (4):
  arm64: Add level-hinted TLB invalidation helper to tlbi_user
  mm: Add page table level flags to vm_flags
  arm64: tlb: Use translation level hint in vm_flags
  mm: Set VM_LEVEL flags in some tlb_flush functions

 arch/arm64/include/asm/mmu.h      |  2 ++
 arch/arm64/include/asm/tlb.h      | 12 +++++++++
 arch/arm64/include/asm/tlbflush.h | 44 ++++++++++++++++++++++++++-----
 arch/arm64/mm/hugetlbpage.c       |  4 +--
 arch/arm64/mm/mmu.c               | 14 ++++++++++
 include/asm-generic/pgtable.h     | 16 +++++++++--
 include/linux/mm.h                | 10 +++++++
 include/trace/events/mmflags.h    | 15 ++++++++++-
 mm/huge_memory.c                  |  8 +++++-
 9 files changed, 113 insertions(+), 12 deletions(-)

-- 
2.19.1


