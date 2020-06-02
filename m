Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECA11EBD6D
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jun 2020 15:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgFBN7I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Jun 2020 09:59:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5769 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725841AbgFBN7I (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Jun 2020 09:59:08 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A2F4C9FFFE30778C5DEF;
        Tue,  2 Jun 2020 21:59:05 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 2 Jun 2020 21:58:58 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <catalin.marinas@arm.com>, <peterz@infradead.org>,
        <mark.rutland@arm.com>, <will@kernel.org>,
        <aneesh.kumar@linux.ibm.com>, <akpm@linux-foundation.org>,
        <npiggin@gmail.com>, <arnd@arndb.de>, <rostedt@goodmis.org>,
        <maz@kernel.org>, <suzuki.poulose@arm.com>, <tglx@linutronix.de>,
        <yuzhao@google.com>, <Dave.Martin@arm.com>, <steven.price@arm.com>,
        <broonie@kernel.org>, <guohanjun@huawei.com>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
Subject: [PATCH v4 0/6] arm64: tlb: add support for TTL feature
Date:   Tue, 2 Jun 2020 21:58:30 +0800
Message-ID: <20200602135836.1620-1-yezhenyu2@huawei.com>
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

In order to reduce the cost of TLB invalidation, ARMv8.4 provides
the TTL field in TLBI instruction.  The TTL field indicates the
level of page table walk holding the leaf entry for the address
being invalidated.  This series provide support for this feature.

When ARMv8.4-TTL is implemented, the operand for TLBIs looks like
below:

* +----------+-------+----------------------+
* |   ASID   |  TTL  |        BADDR         |
* +----------+-------+----------------------+
* |63      48|47   44|43                   0|

See patches for details, Thanks.

--
ChangeList:
v4:
implement flush_*_tlb_range only on arm64.

v3:
minor changes: reduce the indentation levels of __tlbi_level().

v2:
rebase series on Linux 5.7-rc1 and simplify the code implementation.

v1:
add support for TTL feature in arm64.


Marc Zyngier (2):
  arm64: Detect the ARMv8.4 TTL feature
  arm64: Add level-hinted TLB invalidation helper

Peter Zijlstra (Intel) (1):
  tlb: mmu_gather: add tlb_flush_*_range APIs

Zhenyu Ye (3):
  arm64: Add tlbi_user_level TLB invalidation helper
  arm64: tlb: Set the TTL field in flush_tlb_range
  arm64: tlb: Set the TTL field in flush_*_tlb_range

 arch/arm64/include/asm/cpucaps.h  |  3 +-
 arch/arm64/include/asm/pgtable.h  | 10 ++++++
 arch/arm64/include/asm/sysreg.h   |  1 +
 arch/arm64/include/asm/tlb.h      | 29 +++++++++++++++-
 arch/arm64/include/asm/tlbflush.h | 54 +++++++++++++++++++++++++-----
 arch/arm64/kernel/cpufeature.c    | 11 +++++++
 include/asm-generic/tlb.h         | 55 ++++++++++++++++++++++---------
 7 files changed, 138 insertions(+), 25 deletions(-)

-- 
2.19.1


