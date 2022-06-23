Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E6D557270
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 07:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiFWFDr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 01:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiFWFDN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 01:03:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D40C4B1D5
        for <linux-arch@vger.kernel.org>; Wed, 22 Jun 2022 21:46:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6C08B821B9
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 04:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233D3C3411D;
        Thu, 23 Jun 2022 04:46:52 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Rui Wang <wangrui@loongson.cn>
Subject: [PATCH V2 2/2] LoongArch: Add qspinlock support
Date:   Thu, 23 Jun 2022 12:47:52 +0800
Message-Id: <20220623044752.2074066-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220623044752.2074066-1-chenhuacai@loongson.cn>
References: <20220623044752.2074066-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On NUMA system, the performance of qspinlock is better than generic
spinlock. Below is the UnixBench test results on a 8 nodes (4 cores
per node, 32 cores in total) machine.

A. With generic spinlock:

System Benchmarks Index Values               BASELINE       RESULT    INDEX
Dhrystone 2 using register variables         116700.0  449574022.5  38523.9
Double-Precision Whetstone                       55.0      85190.4  15489.2
Execl Throughput                                 43.0      14696.2   3417.7
File Copy 1024 bufsize 2000 maxblocks          3960.0     143157.8    361.5
File Copy 256 bufsize 500 maxblocks            1655.0      37631.8    227.4
File Copy 4096 bufsize 8000 maxblocks          5800.0     444814.2    766.9
Pipe Throughput                               12440.0    5047490.7   4057.5
Pipe-based Context Switching                   4000.0    2021545.7   5053.9
Process Creation                                126.0      23829.8   1891.3
Shell Scripts (1 concurrent)                     42.4      33756.7   7961.5
Shell Scripts (8 concurrent)                      6.0       4062.9   6771.5
System Call Overhead                          15000.0    2479748.6   1653.2
                                                                   ========
System Benchmarks Index Score                                        2955.6

B. With qspinlock:

System Benchmarks Index Values               BASELINE       RESULT    INDEX
Dhrystone 2 using register variables         116700.0  449467876.9  38514.8
Double-Precision Whetstone                       55.0      85174.6  15486.3
Execl Throughput                                 43.0      14769.1   3434.7
File Copy 1024 bufsize 2000 maxblocks          3960.0     146150.5    369.1
File Copy 256 bufsize 500 maxblocks            1655.0      37496.8    226.6
File Copy 4096 bufsize 8000 maxblocks          5800.0     447527.0    771.6
Pipe Throughput                               12440.0    5175989.2   4160.8
Pipe-based Context Switching                   4000.0    2207747.8   5519.4
Process Creation                                126.0      25125.5   1994.1
Shell Scripts (1 concurrent)                     42.4      33461.2   7891.8
Shell Scripts (8 concurrent)                      6.0       4024.7   6707.8
System Call Overhead                          15000.0    2917278.6   1944.9
                                                                   ========
System Benchmarks Index Score                                        3040.1

Signed-off-by: Rui Wang <wangrui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig                      |  1 +
 arch/loongarch/include/asm/Kbuild           |  5 ++---
 arch/loongarch/include/asm/spinlock.h       | 12 ++++++++++++
 arch/loongarch/include/asm/spinlock_types.h | 11 +++++++++++
 4 files changed, 26 insertions(+), 3 deletions(-)
 create mode 100644 arch/loongarch/include/asm/spinlock.h
 create mode 100644 arch/loongarch/include/asm/spinlock_types.h

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 1920d52653b4..1ec220df751d 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -46,6 +46,7 @@ config LOONGARCH
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select ARCH_WANTS_NO_INSTR
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index 83bc0681e72b..a0eed6076c79 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -1,12 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += dma-contiguous.h
 generic-y += export.h
+generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += early_ioremap.h
 generic-y += qrwlock.h
-generic-y += qrwlock_types.h
-generic-y += spinlock.h
-generic-y += spinlock_types.h
+generic-y += qspinlock.h
 generic-y += rwsem.h
 generic-y += segment.h
 generic-y += user.h
diff --git a/arch/loongarch/include/asm/spinlock.h b/arch/loongarch/include/asm/spinlock.h
new file mode 100644
index 000000000000..7cb3476999be
--- /dev/null
+++ b/arch/loongarch/include/asm/spinlock.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_SPINLOCK_H
+#define _ASM_SPINLOCK_H
+
+#include <asm/processor.h>
+#include <asm/qspinlock.h>
+#include <asm/qrwlock.h>
+
+#endif /* _ASM_SPINLOCK_H */
diff --git a/arch/loongarch/include/asm/spinlock_types.h b/arch/loongarch/include/asm/spinlock_types.h
new file mode 100644
index 000000000000..7458d036c161
--- /dev/null
+++ b/arch/loongarch/include/asm/spinlock_types.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_SPINLOCK_TYPES_H
+#define _ASM_SPINLOCK_TYPES_H
+
+#include <asm-generic/qspinlock_types.h>
+#include <asm-generic/qrwlock_types.h>
+
+#endif
-- 
2.27.0

