Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364B353D766
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jun 2022 17:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbiFDPE7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Jun 2022 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237288AbiFDPE6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Jun 2022 11:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF3531221
        for <linux-arch@vger.kernel.org>; Sat,  4 Jun 2022 08:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8A8560DB6
        for <linux-arch@vger.kernel.org>; Sat,  4 Jun 2022 15:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04554C385B8;
        Sat,  4 Jun 2022 15:04:52 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Fix the !CONFIG_SMP build
Date:   Sat,  4 Jun 2022 23:06:29 +0800
Message-Id: <20220604150629.691836-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
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

1, We assume arch/loongarch/include/asm/smp.h be included in include/
   linux/smp.h is valid and the reverse inclusion isn't. So remove the
   <linux/smp.h> in arch/loongarch/include/asm/smp.h.
2, arch/loongarch/include/asm/smp.h is only needed when CONFIG_SMP,
   and setup.c include it only because it need plat_smp_setup(). So,
   reorganize setup.c & smp.h, and then remove <asm/smp.h> in setup.c.
3, Fix cacheinfo.c and percpu.h build error by adding the missing header
   files when !CONFIG_SMP.
4, Fix acpi.c build error by adding CONFIG_SMP guards.
5, Select CONFIG_SMP for CONFIG_NUMA, similar as other architectures do.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/include/asm/percpu.h |  1 +
 arch/loongarch/include/asm/smp.h    | 23 +++++++----------------
 arch/loongarch/kernel/acpi.c        |  4 ++++
 arch/loongarch/kernel/cacheinfo.c   |  1 +
 arch/loongarch/kernel/setup.c       |  5 ++---
 6 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 80657bf83b05..1920d52653b4 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -343,6 +343,7 @@ config NR_CPUS
 
 config NUMA
 	bool "NUMA Support"
+	select SMP
 	select ACPI_NUMA if ACPI
 	help
 	  Say Y to compile the kernel with NUMA (Non-Uniform Memory Access)
diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
index 34f15a6fb1e7..e6569f18c6dd 100644
--- a/arch/loongarch/include/asm/percpu.h
+++ b/arch/loongarch/include/asm/percpu.h
@@ -6,6 +6,7 @@
 #define __ASM_PERCPU_H
 
 #include <asm/cmpxchg.h>
+#include <asm/loongarch.h>
 
 /* Use r21 for fast access */
 register unsigned long __my_cpu_offset __asm__("$r21");
diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
index 551e1f37c705..71189b28bfb2 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -9,10 +9,16 @@
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/linkage.h>
-#include <linux/smp.h>
 #include <linux/threads.h>
 #include <linux/cpumask.h>
 
+extern int smp_num_siblings;
+extern int num_processors;
+extern int disabled_cpus;
+extern cpumask_t cpu_sibling_map[];
+extern cpumask_t cpu_core_map[];
+extern cpumask_t cpu_foreign_map[];
+
 void loongson3_smp_setup(void);
 void loongson3_prepare_cpus(unsigned int max_cpus);
 void loongson3_boot_secondary(int cpu, struct task_struct *idle);
@@ -25,26 +31,11 @@ int loongson3_cpu_disable(void);
 void loongson3_cpu_die(unsigned int cpu);
 #endif
 
-#ifdef CONFIG_SMP
-
 static inline void plat_smp_setup(void)
 {
 	loongson3_smp_setup();
 }
 
-#else /* !CONFIG_SMP */
-
-static inline void plat_smp_setup(void) { }
-
-#endif /* !CONFIG_SMP */
-
-extern int smp_num_siblings;
-extern int num_processors;
-extern int disabled_cpus;
-extern cpumask_t cpu_sibling_map[];
-extern cpumask_t cpu_core_map[];
-extern cpumask_t cpu_foreign_map[];
-
 static inline int raw_smp_processor_id(void)
 {
 #if defined(__VDSO__)
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index b16c3dea5eeb..bb729ee8a237 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -138,6 +138,7 @@ void __init acpi_boot_table_init(void)
 	}
 }
 
+#ifdef CONFIG_SMP
 static int set_processor_mask(u32 id, u32 flags)
 {
 
@@ -166,15 +167,18 @@ static int set_processor_mask(u32 id, u32 flags)
 
 	return cpu;
 }
+#endif
 
 static void __init acpi_process_madt(void)
 {
+#ifdef CONFIG_SMP
 	int i;
 
 	for (i = 0; i < NR_CPUS; i++) {
 		__cpu_number_map[i] = -1;
 		__cpu_logical_map[i] = -1;
 	}
+#endif
 
 	loongson_sysconf.nr_cpus = num_processors;
 }
diff --git a/arch/loongarch/kernel/cacheinfo.c b/arch/loongarch/kernel/cacheinfo.c
index 8c9fe29e98f0..b38f5489d094 100644
--- a/arch/loongarch/kernel/cacheinfo.c
+++ b/arch/loongarch/kernel/cacheinfo.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
+#include <asm/cpu-info.h>
 #include <linux/cacheinfo.h>
 
 /* Populates leaf and increments to next leaf */
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 185e4035811a..c74860b53375 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -39,7 +39,6 @@
 #include <asm/pgalloc.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
-#include <asm/smp.h>
 #include <asm/time.h>
 
 #define SMBIOS_BIOSSIZE_OFFSET		0x09
@@ -349,8 +348,6 @@ static void __init prefill_possible_map(void)
 
 	nr_cpu_ids = possible;
 }
-#else
-static inline void prefill_possible_map(void) {}
 #endif
 
 void __init setup_arch(char **cmdline_p)
@@ -367,8 +364,10 @@ void __init setup_arch(char **cmdline_p)
 	arch_mem_init(cmdline_p);
 
 	resource_init();
+#ifdef CONFIG_SMP
 	plat_smp_setup();
 	prefill_possible_map();
+#endif
 
 	paging_init();
 }
-- 
2.27.0

