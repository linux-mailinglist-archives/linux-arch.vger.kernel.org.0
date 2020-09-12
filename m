Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88523267710
	for <lists+linux-arch@lfdr.de>; Sat, 12 Sep 2020 03:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgILBez (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Sep 2020 21:34:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:13356 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgILBer (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Sep 2020 21:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599874488; x=1631410488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tbb0dwy6D9iYWS1kPOnxa+vdqEyJ1+ag9dCJR1CHDY0=;
  b=HteRHqpfO3TQqDyGVaf8UfKh5fVU8ITe5P+ffOpgPQKH3B+oIia/cqoI
   vDpjxEZKowdAkNH6pjJdsnIkSk4zciyioX/EegU2yJGxE/3ztw48APyOy
   t1A/XbXpPn0972cMY6jB/GivzlINJbVS21B6l4HiLMJIw7YVLFaFVJrxe
   OBSHpQOKLZSNLyfi2WQzvA94ALiQ1OkU4ecl3nGYaf3kqM/E4KF8PUTa+
   Ko/pkKT9COKhyJzym62cBM97+vYE5xVg2yhA5QLndsrNeI6ud+DrHPRiN
   PKpISqzc3aA0bhBzUg3BwO9p4gb1CuxfsslMUxUo2nYlEAqsvsHgV4zNR
   Q==;
IronPort-SDR: pqlkHEduGwkYEml0LlLYaXhiOrNKVYecmaQ93km4psa8XK/BEY/ngD3Jb3OzYtn4fSg9ROgGkE
 P3LvRTiNOXQwvPkRGt6C5rmWkFRHq8JjfFMdGxyWpgZKCX+buQ53cR/Ca3go6XMfCVDN8i/Sg/
 BojBXawSK0vEEF98yRVj5GBdEIFv4P1C5mBmxBjr156AO62e1oFhiduC/ph8leuYecKUfnxEh3
 k7fZZNcaXeNHMKCY9i01I0I2M91kelEKi7slwY2Vi7XEbC9MCyBrau+zd1ZJfXVuUlppGhjdKs
 UuA=
X-IronPort-AV: E=Sophos;i="5.76,418,1592841600"; 
   d="scan'208";a="147177954"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2020 09:34:47 +0800
IronPort-SDR: XF7KyhGrxPcyk6oCJKxUvE76PJHfCo+sHDUCs9i35Ygkc3AcbWPI5dsZsClsLj4kmBNUW4mj4I
 BaXil7HHI1iw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 18:22:01 -0700
IronPort-SDR: hu6MvwAluDkqpVTgl2uVsaHk+jsK3Sr0U4cnByviLCrw2u2Q4CzH4YrOtkM8MDFlEF+vRjGGOs
 P37IHm8lszDA==
WDCIronportException: Internal
Received: from unknown (HELO jedi-01.hgst.com) ([10.86.59.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 18:34:46 -0700
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
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jia He <justin.he@arm.com>, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mike Rapoport <rppt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC/RFT PATCH v2 2/5] arm64, numa: Change the numa init function name to be generic
Date:   Fri, 11 Sep 2020 18:34:38 -0700
Message-Id: <20200912013441.9730-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200912013441.9730-1-atish.patra@wdc.com>
References: <20200912013441.9730-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As we are using generic numa implementation code, modify the init function
name to indicate that generic implementation.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/arm64/kernel/acpi_numa.c | 13 -------------
 arch/arm64/mm/init.c          |  4 ++--
 drivers/base/arch_numa.c      | 29 ++++++++++++++++++++++++++---
 include/asm-generic/numa.h    |  4 ++--
 4 files changed, 30 insertions(+), 20 deletions(-)

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
index 73f8b49d485c..a4039dcabd3e 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -13,7 +13,9 @@
 #include <linux/module.h>
 #include <linux/of.h>
 
+#ifdef CONFIG_ACPI_NUMA
 #include <asm/acpi.h>
+#endif
 #include <asm/sections.h>
 
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
@@ -444,16 +446,37 @@ static int __init dummy_numa_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI_NUMA
+int __init arch_acpi_numa_init(void)
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
+int __init arch_acpi_numa_init(void)
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
2.24.0

