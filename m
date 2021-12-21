Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6DE47B917
	for <lists+linux-arch@lfdr.de>; Tue, 21 Dec 2021 04:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhLUDqS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Dec 2021 22:46:18 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30083 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhLUDqS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Dec 2021 22:46:18 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JJ2NX6d3bz1DJrQ;
        Tue, 21 Dec 2021 11:43:08 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 11:46:16 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 11:46:15 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <mark.rutland@arm.com>, <peterz@infradead.org>, <corbet@lwn.net>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <moyufeng@huawei.com>, <wangxiongfeng2@huawei.com>,
        <linux-arch@vger.kernel.org>
Subject: [PATCH v2] asm-generic: introduce io_stop_wc() and add implementation for ARM64
Date:   Tue, 21 Dec 2021 11:55:56 +0800
Message-ID: <20211221035556.60346-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For memory accesses with write-combining attributes (e.g. those returned
by ioremap_wc()), the CPU may wait for prior accesses to be merged with
subsequent ones. But in some situation, such wait is bad for the
performance.

We introduce io_stop_wc() to prevent the merging of write-combining
memory accesses before this macro with those after it.

We add implementation for ARM64 using DGH instruction and provide NOP
implementation for other architectures.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Suggested-by: Will Deacon <will@kernel.org>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
---
v1->v2: change 'Normal-Non Cacheable' to 'write-combining'
---
 Documentation/memory-barriers.txt |  8 ++++++++
 arch/arm64/include/asm/barrier.h  |  9 +++++++++
 include/asm-generic/barrier.h     | 11 +++++++++++
 3 files changed, 28 insertions(+)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 7367ada13208..b12df9137e1c 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1950,6 +1950,14 @@ There are some more advanced barrier functions:
      For load from persistent memory, existing read memory barriers are sufficient
      to ensure read ordering.
 
+ (*) io_stop_wc();
+
+     For memory accesses with write-combining attributes (e.g. those returned
+     by ioremap_wc(), the CPU may wait for prior accesses to be merged with
+     subsequent ones. io_stop_wc() can be used to prevent the merging of
+     write-combining memory accesses before this macro with those after it when
+     such wait has performance implications.
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
index 640f09479bdf..4c2c1b830344 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -251,5 +251,16 @@ do {									\
 #define pmem_wmb()	wmb()
 #endif
 
+/*
+ * ioremap_wc() maps I/O memory as memory with write-combining attributes. For
+ * this kind of memory accesses, the CPU may wait for prior accesses to be
+ * merged with subsequent ones. In some situation, such wait is bad for the
+ * performance. io_stop_wc() can be used to prevent the merging of
+ * write-combining memory accesses before this macro with those after it.
+ */
+#ifndef io_stop_wc
+#define io_stop_wc do { } while (0)
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
-- 
2.20.1

