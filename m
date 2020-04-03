Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5CCE19D2EE
	for <lists+linux-arch@lfdr.de>; Fri,  3 Apr 2020 11:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390433AbgDCJBN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Apr 2020 05:01:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727860AbgDCJBN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Apr 2020 05:01:13 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3FEEA593A8533F9AB649;
        Fri,  3 Apr 2020 17:01:07 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 3 Apr 2020 17:00:59 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <peterz@infradead.org>, <mark.rutland@arm.com>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <aneesh.kumar@linux.ibm.com>,
        <akpm@linux-foundation.org>, <npiggin@gmail.com>, <arnd@arndb.de>,
        <rostedt@goodmis.org>, <maz@kernel.org>, <suzuki.poulose@arm.com>,
        <tglx@linutronix.de>, <yuzhao@google.com>, <Dave.Martin@arm.com>,
        <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
Subject: [PATCH v1 0/6] arm64: tlb: add support for TTL feature
Date:   Fri, 3 Apr 2020 17:00:42 +0800
Message-ID: <20200403090048.938-1-yezhenyu2@huawei.com>
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
which detect the TTL feature and add __tlbi_level interface.  Patch 3
added __tlbi_user_level interface.  Patch 4 was provided by Peter and
added some mmu_gather APIs.  Patch 5 provided flush_*_tlb_range wrappers
so we can do the tlb invalidation according to the information in
struct mmu_gather.  Finally, we supported TTL feature in ARM64 by using
tlb->cleared_* in struct mmu_gather.

See patches for details, Thanks.

Marc Zyngier (2):
  arm64: Detect the ARMv8.4 TTL feature
  arm64: Add level-hinted TLB invalidation helper

Peter Zijlstra (Intel) (1):
  tlb: mmu_gather: add tlb_set_*_range APIs

Zhenyu Ye (3):
  arm64: Add tlbi_user_level TLB invalidation helper
  mm: tlb: Provide flush_*_tlb_range wrappers
  arm64: tlb: Set the TTL field in flush_tlb_range

 arch/arm64/include/asm/cpucaps.h  |  3 +-
 arch/arm64/include/asm/sysreg.h   |  1 +
 arch/arm64/include/asm/tlb.h      | 26 ++++++++++++++-
 arch/arm64/include/asm/tlbflush.h | 53 ++++++++++++++++++++++++-----
 arch/arm64/kernel/cpufeature.c    | 11 +++++++
 include/asm-generic/pgtable.h     | 12 +++++--
 include/asm-generic/tlb.h         | 55 ++++++++++++++++++++++---------
 mm/pgtable-generic.c              | 50 ++++++++++++++++++++++++++++
 8 files changed, 184 insertions(+), 27 deletions(-)

-- 
2.19.1


