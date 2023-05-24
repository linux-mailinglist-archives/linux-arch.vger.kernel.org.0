Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0179A70FB17
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 18:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbjEXQAQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 12:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbjEXP7a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 11:59:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A281701;
        Wed, 24 May 2023 08:58:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QRG5p4CQBz4x4l;
        Thu, 25 May 2023 01:57:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1684943822;
        bh=p1bBAk5FodJhZ4XtodQ/RroeKg6GW9YX3VKIMJsVMLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R22szaPDT6DGwq17NyDcp7B49+a7ThZT8uGc7W+qKi3W0c6DMaB2h0vQ+vue6uOR+
         b2XrnJAvmLo6pAX2f8xxj86lm9GKwYwfvA2/tTAOaaqjtVABSuKDdGByysUc7XZpby
         +g2f+yFDRIE5qlupG1yMOC5jokWBHsyU4/WGLxWQfFoejzxG6suWMWgl04/jskyc9i
         /CaYcsLNYzVHcnBfcW3D25cIMeOmF/w3ZV9jkBMtgOoMwTxwU/h0vlEx+juDKliXeG
         NqsMJuHoAQZGkTxJaPZTxvY4ahm49NrEIZ0JLiz16imgfbF+CPAZCVjYNuqqubFdlU
         b01tMkPDIzEhg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linux-kernel@vger.kernel.org>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-arch@vger.kernel.org>,
        <ldufour@linux.ibm.com>, <tglx@linutronix.de>, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com, x86@kernel.org
Subject: [PATCH 8/9] powerpc: Add HOTPLUG_SMT support
Date:   Thu, 25 May 2023 01:56:29 +1000
Message-Id: <20230524155630.794584-8-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524155630.794584-1-mpe@ellerman.id.au>
References: <20230524155630.794584-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add support for HOTPLUG_SMT, which enables the generic sysfs SMT support
files in /sys/devices/system/cpu/smt, as well as the "nosmt" boot
parameter.

Implement the recently added hooks to allow partial SMT states, allow
any number of threads per core.

Tie the config symbol to HOTPLUG_CPU, which enables it on the major
platforms that support SMT. If there are other platforms that want the
SMT support that can be tweaked in future.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig                |  1 +
 arch/powerpc/include/asm/topology.h | 25 +++++++++++++++++++++++++
 arch/powerpc/kernel/smp.c           |  3 +++
 3 files changed, 29 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 539d1f03ff42..5cf87ca10a9c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -273,6 +273,7 @@ config PPC
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
+	select HOTPLUG_SMT			if HOTPLUG_CPU
 	select HUGETLB_PAGE_SIZE_VARIABLE	if PPC_BOOK3S_64 && HUGETLB_PAGE
 	select IOMMU_HELPER			if PPC64
 	select IRQ_DOMAIN
diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 8a4d4f4d9749..1e9117a22d14 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -143,5 +143,30 @@ static inline int cpu_to_coregroup_id(int cpu)
 #endif
 #endif
 
+#ifdef CONFIG_HOTPLUG_SMT
+#include <linux/cpu_smt.h>
+#include <asm/cputhreads.h>
+
+static inline bool topology_smt_supported(void)
+{
+	return threads_per_core > 1;
+}
+
+static inline bool topology_smt_threads_supported(unsigned int num_threads)
+{
+	return num_threads <= threads_per_core;
+}
+
+static inline bool topology_is_primary_thread(unsigned int cpu)
+{
+	return cpu == cpu_first_thread_sibling(cpu);
+}
+
+static inline bool topology_smt_thread_allowed(unsigned int cpu)
+{
+	return cpu_thread_in_core(cpu) < cpu_smt_num_threads;
+}
+#endif
+
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_TOPOLOGY_H */
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 265801a3e94c..eed20b9253b7 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1154,6 +1154,9 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 
 	if (smp_ops && smp_ops->probe)
 		smp_ops->probe();
+
+	// Initalise the generic SMT topology support
+	cpu_smt_check_topology(threads_per_core);
 }
 
 void smp_prepare_boot_cpu(void)
-- 
2.40.1

