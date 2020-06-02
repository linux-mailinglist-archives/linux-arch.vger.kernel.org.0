Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422A71EBD7A
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jun 2020 16:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgFBN7Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Jun 2020 09:59:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5771 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725841AbgFBN7M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Jun 2020 09:59:12 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CEA41722FE87F9BA00E8;
        Tue,  2 Jun 2020 21:59:10 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 2 Jun 2020 21:59:01 +0800
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
Subject: [PATCH v4 2/6] arm64: Add level-hinted TLB invalidation helper
Date:   Tue, 2 Jun 2020 21:58:32 +0800
Message-ID: <20200602135836.1620-3-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20200602135836.1620-1-yezhenyu2@huawei.com>
References: <20200602135836.1620-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

Add a level-hinted TLB invalidation helper that only gets used if
ARMv8.4-TTL gets detected.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index bc3949064725..8adbd6fd8489 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -10,6 +10,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/bitfield.h>
 #include <linux/mm_types.h>
 #include <linux/sched.h>
 #include <asm/cputype.h>
@@ -59,6 +60,34 @@
 		__ta;						\
 	})
 
+#define TLBI_TTL_MASK	GENMASK_ULL(47, 44)
+
+#define __tlbi_level(op, addr, level) do {			\
+	u64 arg = addr;						\
+								\
+	if (cpus_have_const_cap(ARM64_HAS_ARMv8_4_TTL) &&	\
+	    level) {						\
+		u64 ttl = level;				\
+								\
+		switch (PAGE_SIZE) {				\
+		case SZ_4K:					\
+			ttl |= 1 << 2;				\
+			break;					\
+		case SZ_16K:					\
+			ttl |= 2 << 2;				\
+			break;					\
+		case SZ_64K:					\
+			ttl |= 3 << 2;				\
+			break;					\
+		}						\
+								\
+		arg &= ~TLBI_TTL_MASK;				\
+		arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);		\
+	}							\
+								\
+	__tlbi(op,  arg);					\
+} while (0)
+
 /*
  *	TLB Invalidation
  *	================
-- 
2.19.1


