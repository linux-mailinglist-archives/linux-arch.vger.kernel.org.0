Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880DC2B8921
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 01:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgKSAij (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 19:38:39 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49086 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgKSAii (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 19:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605746316; x=1637282316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d3s03R5W/P58NhdkaX/eI00Uo7wjk8iETPnJwkMJkhA=;
  b=iKffwtxVh7nt4vw30pkbYK0FSu9WH3hDg86GZveDzuyv/Vd6Lr0OrL+b
   1ihj8Gc5YO3bHpnsbSQALdZHWE9obpODTVvCkkwH00l2WqsBISA9zW9lp
   c0tbRCIOOu1aC3YuK0hpsA7LeD0OjSx4hLweECTGL1O0gorHTENeu5t1A
   LkTW/4zmLgZZeaLQ+KKunDAL/YXrbq2TtkAEuoTohSWWZRDFTwHx3xDDN
   v4iVTe5HezNFvzCp9Yd37dnNMNMrwVTpxiVqFxo7cvWixQS8mkYpi2nBE
   NfKnBSyy2eBup0neP2ojLUHPFp7F1bvS5KmLUjeWcCgKby8V0TSip7buX
   g==;
IronPort-SDR: CCLqaB2aJbntS7AGSyf5ajb5aMdS4jg7S4U1JqQfbBDqO3oo6oC985KRmWrgMP1h7PUDF4VGm6
 u3G4GZnAm+LsQqQ7+HsgTLJR4VBZ2biwNeSHk85+WovCbCHfMw/WUPIlek+WOW7KJTGp5HpFCF
 K9tyx62PWw0ODu5+md7ORuslJ17geV1A9SHX01k7VeqGkbiwArhmJCBWSpaqUh7unfDOLRAz7J
 PnH2gUzgoUm1MguBk8LqbFD+GDj6brY+uae8nINRMAF6dXH35PwiOWVr0C2aC8txyi4Kj4taZ9
 XA0=
X-IronPort-AV: E=Sophos;i="5.77,488,1596470400"; 
   d="scan'208";a="262974329"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2020 08:38:36 +0800
IronPort-SDR: oWTUXTqoOupazfYa5fhZTuKLRXpU12zkKZL5e/eKxVphyW44ssEyxSY2sOpcDje1wfmShJq9G0
 9tz5cU2uEeDf9A84YytzeH3nf+fHQ7uSPusqw+0YbyXuq1ZxN71qUyN+PJIAjDkt+AlCMqUlkR
 IigksXj3aU+ELS/COSceS6yUZYtrFsv7IqN6n8xQuEUmMhfeoxF22BZM1eip5OINZ77gSDofYC
 tUIXqGQSxA+VJg2ga6+PmxFKGrwmt4AwnNAYiLzS8UbNv0JmCyuDXfj8vDTO1PpoDTaokbd32n
 YPA0Kri6+T6ssbDoX4RHYcXE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 16:23:07 -0800
IronPort-SDR: kMFG0KK2onH84n/YkSW2DPfPkfqV7JvYk2Z5etWmTh2d7R7KjInZRcMAwOWbZEHwAnEqzVFKdd
 iNJwUDMIK5wbHtmnRSrxLxDjZOzwXabgibkBvwrE5wJ98CmTuT0t65rebDoe02B5oBWeZHTFUr
 rm+nRsbJP4SoOzmt0cA/8+n3bpEigbujo3ntO2GXoQJ46min3JyoPejqh2QhYWDdAKfNKQnN6+
 krptl40k7Z7xvMRsTcDFH03NeFKiLVYT1XfzKdyJRXCEdINMe6psaBaq7FbEK1Gx6WwkGGxtzv
 pao=
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.61.71])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2020 16:38:35 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>,
        Zhengyuan Liu <liuzhengyuan@tj.kylinos.cn>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/5] arm64, numa: Change the numa init functions name to be generic
Date:   Wed, 18 Nov 2020 16:38:25 -0800
Message-Id: <20201119003829.1282810-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201119003829.1282810-1-atish.patra@wdc.com>
References: <20201119003829.1282810-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a preparatory patch for unifying numa implementation between
ARM64 & RISC-V. As the numa implementation will be moved to generic
code, rename the arm64 related functions to a generic one.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/numa.h |  4 ++--
 arch/arm64/kernel/acpi_numa.c | 12 ------------
 arch/arm64/mm/init.c          |  4 ++--
 arch/arm64/mm/numa.c          | 27 +++++++++++++++++++++++----
 4 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
index dd870390d639..ffc1dcdf1871 100644
--- a/arch/arm64/include/asm/numa.h
+++ b/arch/arm64/include/asm/numa.h
@@ -32,7 +32,7 @@ static inline const struct cpumask *cpumask_of_node(int node)
 }
 #endif
 
-void __init arm64_numa_init(void);
+void __init arch_numa_init(void);
 int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 void __init numa_set_distance(int from, int to, int distance);
 void __init numa_free_distance(void);
@@ -46,7 +46,7 @@ void numa_remove_cpu(unsigned int cpu);
 static inline void numa_store_cpu_info(unsigned int cpu) { }
 static inline void numa_add_cpu(unsigned int cpu) { }
 static inline void numa_remove_cpu(unsigned int cpu) { }
-static inline void arm64_numa_init(void) { }
+static inline void arch_numa_init(void) { }
 static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
 
 #endif	/* CONFIG_NUMA */
diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index 7ff800045434..fdfecf0991ce 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -118,15 +118,3 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
 	node_set(node, numa_nodes_parsed);
 }
 
-int __init arm64_acpi_numa_init(void)
-{
-	int ret;
-
-	ret = acpi_numa_init();
-	if (ret) {
-		pr_info("Failed to initialise from firmware\n");
-		return ret;
-	}
-
-	return srat_disabled() ? -EINVAL : 0;
-}
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 095540667f0f..977b47f6815a 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -407,10 +407,10 @@ void __init bootmem_init(void)
 	max_pfn = max_low_pfn = max;
 	min_low_pfn = min;
 
-	arm64_numa_init();
+	arch_numa_init();
 
 	/*
-	 * must be done after arm64_numa_init() which calls numa_init() to
+	 * must be done after arch_numa_init() which calls numa_init() to
 	 * initialize node_online_map that gets used in hugetlb_cma_reserve()
 	 * while allocating required CMA size across online nodes.
 	 */
diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index a8303bc6b62a..0dae54ce7d43 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -13,7 +13,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 
-#include <asm/acpi.h>
 #include <asm/sections.h>
 
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
@@ -445,16 +444,36 @@ static int __init dummy_numa_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI_NUMA
+static int __init arch_acpi_numa_init(void)
+{
+	int ret;
+
+	ret = acpi_numa_init();
+	if (ret) {
+		pr_info("Failed to initialise from firmware\n");
+		return ret;
+	}
+
+	return srat_disabled() ? -EINVAL : 0;
+}
+#else
+static int __init arch_acpi_numa_init(void)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 /**
- * arm64_numa_init() - Initialize NUMA
+ * arch_numa_init() - Initialize NUMA
  *
  * Try each configured NUMA initialization method until one succeeds. The
  * last fallback is dummy single node config encompassing whole memory.
  */
-void __init arm64_numa_init(void)
+void __init arch_numa_init(void)
 {
 	if (!numa_off) {
-		if (!acpi_disabled && !numa_init(arm64_acpi_numa_init))
+		if (!acpi_disabled && !numa_init(arch_acpi_numa_init))
 			return;
 		if (acpi_disabled && !numa_init(of_numa_init))
 			return;
-- 
2.25.1

