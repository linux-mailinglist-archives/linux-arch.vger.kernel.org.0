Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132542706EB
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgIRUWy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:22:54 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4417 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgIRUWv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600460586; x=1631996586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eQWut7VEytFHmwjjTAXD1GicN8HKGV0d/pToCkTzZ84=;
  b=oF/A7eTOPVkBrpvDAVwM8ysbi8gjQAr+GGSunyF3/UGRPQbQIBrKnfQI
   rogdylG0cVzWXzy4QJX6lUoU5RSlw2/kbULHAq5Pk9uFRq9U72VkDmHHz
   VRtCcvkRFud3al8dGl6p79hgBKhTTwNWeOAxjCNOF0s6rt6slH6qaQUSn
   RRympMAOaPoUvxUcqGP2TRRtXTJgcQwfltJ7CA2RB6fL+3XssxDYNLtPC
   CgXf+PpkImdkIV0hkSRRv2POIkFXJkKbAu7KbVkVjUY9EQWi/+KO0MCPE
   aHIv6U7EyyC1V+7HbPJUaHysRJPl/rq7CHTERDuYuHOUqFsyYYwbODJtr
   Q==;
IronPort-SDR: dd1nSGQ9dbdpPRrbE4i1IKBYUfdbrE1ggP8usdytjGCyubA63y4nTuljSDu0XCTt3XWAzUj4xk
 6VgLphem6ywHKREdf9tShM7OM9pqQQpa/PEPBMgRgmFcXlT9HhsyxcBs0b5pV9TfTb2kj9dB0e
 RBPg+PtxuT3nN/5hleEhy93Lzg3JFPQJieJOyHk1pG1elrnGCpcZgbk5i5c8+/cO34TS7qY7UN
 j9L9po26mGL39zHVSYw2a1lGvMLwLp5SJhIM/VVbWulQ7u7ZuYQZOSzec7WMNaF2iTG/Fiq1wx
 xbI=
X-IronPort-AV: E=Sophos;i="5.77,274,1596470400"; 
   d="scan'208";a="251108775"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2020 04:12:54 +0800
IronPort-SDR: xYSJ0+rhzfMVaEJ2Hzg+FLUNuLGKLVAPQW9CdJLancxHJc4KwzGtTSrilN031327icEE9Viq0E
 sqg66SGlBFXQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:59:55 -0700
IronPort-SDR: bDDDKBLpsk9o1327cbiMFjwz8XEu78h0rRKFjBWl8Dypn4J+bfOOWaVAOpgF9VtHTLhe2r6CvO
 cDgcK6823VSA==
WDCIronportException: Internal
Received: from us3v3d262.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.69])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Sep 2020 13:12:49 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFT PATCH v3 2/5] arm64, numa: Change the numa init functions name to be generic
Date:   Fri, 18 Sep 2020 13:11:37 -0700
Message-Id: <20200918201140.3172284-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918201140.3172284-1-atish.patra@wdc.com>
References: <20200918201140.3172284-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As we are using generic numa implementation code, modify the acpi & numa
init functions name to indicate that generic implementation.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/arm64/kernel/acpi_numa.c | 13 -------------
 arch/arm64/mm/init.c          |  4 ++--
 drivers/base/arch_numa.c      | 31 +++++++++++++++++++++++++++----
 include/asm-generic/numa.h    |  4 ++--
 4 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index 7ff800045434..96502ff92af5 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -117,16 +117,3 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
 
 	node_set(node, numa_nodes_parsed);
 }
-
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
index 481d22c32a2e..93b660229e1d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -418,10 +418,10 @@ void __init bootmem_init(void)
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
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 73f8b49d485c..1649c90a3bc5 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -13,7 +13,9 @@
 #include <linux/module.h>
 #include <linux/of.h>
 
-#include <asm/acpi.h>
+#ifdef CONFIG_ACPI_NUMA
+#include <linux/acpi.h>
+#endif
 #include <asm/sections.h>
 
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
@@ -444,16 +446,37 @@ static int __init dummy_numa_init(void)
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
+
+#endif
+
 /**
- * arm64_numa_init() - Initialize NUMA
+ * arch_numa_init() - Initialize NUMA
  *
  * Try each configured NUMA initialization method until one succeeds. The
  * last fallback is dummy single node config encomapssing whole memory.
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
diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
index 2718d5a6ff03..e7962db4ba44 100644
--- a/include/asm-generic/numa.h
+++ b/include/asm-generic/numa.h
@@ -27,7 +27,7 @@ static inline const struct cpumask *cpumask_of_node(int node)
 }
 #endif
 
-void __init arm64_numa_init(void);
+void __init arch_numa_init(void);
 int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 void __init numa_set_distance(int from, int to, int distance);
 void __init numa_free_distance(void);
@@ -41,7 +41,7 @@ void numa_remove_cpu(unsigned int cpu);
 static inline void numa_store_cpu_info(unsigned int cpu) { }
 static inline void numa_add_cpu(unsigned int cpu) { }
 static inline void numa_remove_cpu(unsigned int cpu) { }
-static inline void arm64_numa_init(void) { }
+static inline void arch_numa_init(void) { }
 static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
 
 #endif	/* CONFIG_NUMA */
-- 
2.25.1

