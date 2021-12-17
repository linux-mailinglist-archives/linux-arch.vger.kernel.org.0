Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D440047866F
	for <lists+linux-arch@lfdr.de>; Fri, 17 Dec 2021 09:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhLQIqM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Dec 2021 03:46:12 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29138 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhLQIqM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Dec 2021 03:46:12 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JFjDX20kvz1DJjH;
        Fri, 17 Dec 2021 16:43:08 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 16:46:10 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 16:46:09 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <moyufeng@huawei.com>,
        <wangxiongfeng2@huawei.com>, <linux-arch@vger.kernel.org>
Subject: [PATCH] asm-generic: introduce io_stop_wc() and add implementation for ARM64
Date:   Fri, 17 Dec 2021 16:56:11 +0800
Message-ID: <20211217085611.111999-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For memory accesses with Normal-Non Cacheable attributes, the CPU may do
write combining. But in some situation, this is bad for the performance
because the prior access may wait too long just to be merged.

We introduce io_stop_wc() to prevent the Normal-NC memory accesses before
this instruction to be merged with memory accesses after this
instruction.

We add implementation for ARM64 using DGH instruction and provide NOP
implementation for other architectures.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 Documentation/memory-barriers.txt |  9 +++++++++
 arch/arm64/include/asm/barrier.h  |  9 +++++++++
 include/asm-generic/barrier.h     | 11 +++++++++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 7367ada13208..b868b51b1801 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1950,6 +1950,15 @@ There are some more advanced barrier functions:
      For load from persistent memory, existing read memory barriers are sufficient
      to ensure read ordering.
 
+ (*) io_stop_wc();
+
+     For memory accesses with Normal-Non Cacheable attributes (e.g. those
+     returned by ioremap_wc()), the CPU may do write combining. But in some
+     situation, this is bad for the performance because the prior access may
+     wait too long just to be merged. io_stop_wc() can be used to prevent
+     merging memory accesses with Normal-Non Cacheable attributes before this
+     instruction with any memory accesses appearing after this instruction.
+
 ===============================
 IMPLICIT KERNEL MEMORY BARRIERS
 ===============================
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 1c5a00598458..62217be36217 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -26,6 +26,14 @@
 #define __tsb_csync()	asm volatile("hint #18" : : : "memory")
 #define csdb()		asm volatile("hint #20" : : : "memory")
 
+/*
+ * Data Gathering Hint:
+ * This instruction prevents merging memory accesses with Normal-NC or
+ * Device-GRE attributes before the hint instruction with any memory accesses
+ * appearing after the hint instruction.
+ */
+#define dgh()		asm volatile("hint #6" : : : "memory")
+
 #ifdef CONFIG_ARM64_PSEUDO_NMI
 #define pmr_sync()						\
 	do {							\
@@ -46,6 +54,7 @@
 #define dma_rmb()	dmb(oshld)
 #define dma_wmb()	dmb(oshst)
 
+#define io_stop_wc()	dgh()
 
 #define tsb_csync()								\
 	do {									\
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 640f09479bdf..083be6d34cb9 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -251,5 +251,16 @@ do {									\
 #define pmem_wmb()	wmb()
 #endif
 
+/*
+ * ioremap_wc() maps I/O memory as memory with Normal-Non Cacheable attributes.
+ * The CPU may do write combining for this kind of memory access. io_stop_wc()
+ * prevents merging memory accesses with Normal-Non Cacheable attributes
+ * before this instruction with any memory accesses appearing after this
+ * instruction.
+ */
+#ifndef io_stop_wc
+#define io_stop_wc do { } while (0)
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
-- 
2.20.1

