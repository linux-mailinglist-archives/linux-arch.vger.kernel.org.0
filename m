Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E08C28433E
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 02:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgJFASI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 20:18:08 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24246 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgJFASA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2020 20:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601943479; x=1633479479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jfrlgXznAUc7CfJc5sdSM/Hlx3h6V83dfBBFaAjyQXg=;
  b=FCa6Lfa+nOEzmxt/q9li0gY2HVcaPCudr9PhTK55CXhcubkE3sDFsgLt
   RNhY1aGBABu7lKntTEiQ4ZkKM1+EGUaHlUUkLN+dBHgRGNgZvnWzjbhHT
   fTm9FwZ3atXHxV628xb6EGSFymQxrx1OabsTSCWFiiWSJ+YNXGNOym2iO
   z23oFLMbdCfKQT2e6/qMTzGNNYPh5nbhYDFB5/79GpU/M3G9X7aqlPUEB
   aiTt35AAIyLciq2p4ddRUqEHcDR4CtMOrG1tKJlaakjPju1VHHku/j77/
   z47L9DG5AeNSqxgXwyNMhljORcXC+ADuh80z6zpzmTArawlqtlJk5Dsis
   Q==;
IronPort-SDR: a2VWf5S4jVofRYba/X4gOvgOKS9OzzImhj3neKzp4q1OV4496W4alQ6FYAaxjkbIQm9HLmvsDg
 LeMhbqWeqDofL1wMZfHFpEX9PfqNf+t4gBFxbl+CGUKY2ztZwyAk5ifdC/N5m9YNgY7bT1WU+C
 rW0r/uyEIZKh99Stdc6oMrkVrLspCxJQBnKfOB/0A5vMsph/sRVyJFJMdBtBEi+IKnU+hQ+bP5
 brr60H4+rSpDJUItx5UhR+qvj5bJYHJPryoQrjMLamEKxwONTDEuFunfUVkJ+dqafdUi1aqSk+
 Cwk=
X-IronPort-AV: E=Sophos;i="5.77,341,1596470400"; 
   d="scan'208";a="149023395"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2020 08:17:58 +0800
IronPort-SDR: xAkRGxaf5OMZBwrbJRrBYvDtmyrsk4SorODV6jhc3WMiOOS5iBLNwFZHOvv49y4fJPfOZT/Kn9
 UWA5EVSC8pjg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 17:03:50 -0700
IronPort-SDR: E9y87SoW9Zy1q10ZwSTIl1B/6F0q/o9ZwnaI3zF+SSqC1S0WPF6vC59m4/JceurnRxcJWNVi1O
 WwUbQuSG8mRg==
WDCIronportException: Internal
Received: from b9f8262.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.253])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Oct 2020 17:17:57 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jia He <justin.he@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/5] arm64, numa: Change the numa init functions name to be generic
Date:   Mon,  5 Oct 2020 17:17:49 -0700
Message-Id: <20201006001752.248564-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201006001752.248564-1-atish.patra@wdc.com>
References: <20201006001752.248564-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As we are using generic numa implementation code, modify the acpi & numa
init functions name to indicate that generic implementation.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/arm64/kernel/acpi_numa.c | 13 -------------
 arch/arm64/mm/init.c          |  4 ++--
 drivers/base/arch_numa.c      | 30 +++++++++++++++++++++++++-----
 include/asm-generic/numa.h    |  4 ++--
 4 files changed, 29 insertions(+), 22 deletions(-)

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
index 73f8b49d485c..74b4f2ddad70 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -13,7 +13,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 
-#include <asm/acpi.h>
 #include <asm/sections.h>
 
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
@@ -444,16 +443,37 @@ static int __init dummy_numa_init(void)
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
- * last fallback is dummy single node config encomapssing whole memory.
+ * last fallback is dummy single node config encompassing whole memory.
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

