Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FCD3B145F
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 09:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFWHHo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Jun 2021 03:07:44 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11085 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhFWHHm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Jun 2021 03:07:42 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G8vMy6HyszZhxW;
        Wed, 23 Jun 2021 15:02:22 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 23 Jun 2021 15:05:23 +0800
Received: from [10.174.186.21] (10.174.186.21) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 23 Jun 2021 15:05:22 +0800
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <aneesh.kumar@linux.ibm.com>,
        Marc Zyngier <maz@kernel.org>, <steven.price@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, Xiexiangyou <xiexiangyou@huawei.com>,
        <liushixin2@huawei.com>, huyaqin <huyaqin1@huawei.com>,
        <zhurui3@huawei.com>, <yezhenyu2@huawei.com>
Subject: [PATCH v1] arm64: tlb: fix the TTL value of tlb_get_level
Message-ID: <b80ead47-1f88-3a00-18e1-cacc22f54cc4@huawei.com>
Date:   Wed, 23 Jun 2021 15:05:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.21]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The TTL field indicates the level of page table walk holding the *leaf*
entry for the address being invalidated. But currently, the TTL field
may be set to an incorrent value in the following stack:

pte_free_tlb
    __pte_free_tlb
        tlb_remove_table
            tlb_table_invalidate
                tlb_flush_mmu_tlbonly
                    tlb_flush

In this case, we just want to flush a PTE page, but the tlb->cleared_pmds
is set and we get tlb_level = 2 in the tlb_get_level() function. This may
cause some unexpected problems.

This patch set the TTL field to 0 if tlb->freed_tables is set. The
tlb->freed_tables indicates page table pages are freed, not the leaf
entry.

Fixes: c4ab2cbc1d87 ("arm64: tlb: Set the TTL field in flush_tlb_range")
Reported-by: ZhuRui <zhurui3@huawei.com>
Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/tlb.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 61c97d3b58c7..c995d1f4594f 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -28,6 +28,10 @@ static void tlb_flush(struct mmu_gather *tlb);
  */
 static inline int tlb_get_level(struct mmu_gather *tlb)
 {
+	/* The TTL field is only valid for the leaf entry. */
+	if (tlb->freed_tables)
+		return 0;
+
 	if (tlb->cleared_ptes && !(tlb->cleared_pmds ||
 				   tlb->cleared_puds ||
 				   tlb->cleared_p4ds))
-- 
2.26.2
