Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B262244FA2
	for <lists+linux-arch@lfdr.de>; Fri, 14 Aug 2020 23:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgHNVse (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Aug 2020 17:48:34 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25018 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNVsb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Aug 2020 17:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597441711; x=1628977711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m0ccOUy/zHhyg/Evs7xmin4JSbqfjO8+1dBWk5YQiwo=;
  b=pHRymtt9fZqhgJbw1DRYDH9sBG77AgGDjKarGSmHTephtiBZ7xbPJ0R4
   1jtYAeO3jdyyO27Q3gA9BCXsjJ3ny/2/dnYf0wd70YMHN5hukaoNcPPYl
   6p71pMQRBkjPAvPdx51t7Vws8FjjGHgcowe67C4UGGU2ZOT855SXSFmKA
   JRgoFm93txhLOrBQSc6x6X84ytTpLdQNu3E3DhSQQBn3gXZXwXyIUw80T
   BvRsOZMLrlmaI5eZyGNvpbng3mrElUyc6LIsCd6k1Sad1Bgnn3Pzf+uDd
   DzO1umBWZf2xGCCRDeZa8ORpKI0dwFEx5jzvWgTFbapMpfIh3pWSoJ96c
   g==;
IronPort-SDR: vlMzTpLfhiIbcos5QIL6rEEM5+n4dlYCcs6lAv8p83LT7m9NX9phLcahwA/jIzdr5jQXftHR2d
 DN9Q1qdGw2RDVUsq6uJMf7jatxM+0sag2kWj8hOyOqQDpFXvL3ecW3zEY+QR9Qs+I2WzjQhqGL
 CwvGEOXosjETSPYiBlPWJc7f4H3vYRIghguAcFrnjio+2/MJ0Yb+skaB/nhm1uDD4Tb0QGcmRT
 ijLc3Epee79tF2wzv02OQmOsqqX8ujhZ4LK4xliMIDRJuI8KrjS+RAORpErMCVIUGpkqEn+pEB
 tXI=
X-IronPort-AV: E=Sophos;i="5.76,313,1592841600"; 
   d="scan'208";a="146217644"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2020 05:48:30 +0800
IronPort-SDR: GuoeXe6RNrCbmW7LjiwYXCInQbZWCx3bODEenedX9sYYBsg6TjexTXxPVvFM4AdDeLhSf+mnBB
 e8eIP9XbShDA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 14:35:35 -0700
IronPort-SDR: 2DVjtT6pQ6aK8cobzGLIr5QvsxKqDYZY5QAG/Ddtcd0GZ8GIwoCQOm4wZ3qrCTJjgmFEssxSQT
 4a2SYWxH1DIg==
WDCIronportException: Internal
Received: from cnf006060.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.56])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Aug 2020 14:48:28 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <Anup.Patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Ganapatrao Kulkarni <gkulkarni@cavium.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC/RFT PATCH 2/6] arm64, numa: Change the numa init function name to be generic
Date:   Fri, 14 Aug 2020 14:47:21 -0700
Message-Id: <20200814214725.28818-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200814214725.28818-1-atish.patra@wdc.com>
References: <20200814214725.28818-1-atish.patra@wdc.com>
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
 arch/arm64/mm/init.c       | 4 ++--
 drivers/base/arch_numa.c   | 8 ++++++--
 include/asm-generic/numa.h | 4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

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
index 73f8b49d485c..83341c807240 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -13,7 +13,9 @@
 #include <linux/module.h>
 #include <linux/of.h>
 
+#ifdef CONFIG_ARM64
 #include <asm/acpi.h>
+#endif
 #include <asm/sections.h>
 
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
@@ -445,16 +447,18 @@ static int __init dummy_numa_init(void)
 }
 
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
+#ifdef CONFIG_ARM64
 		if (!acpi_disabled && !numa_init(arm64_acpi_numa_init))
 			return;
+#endif
 		if (acpi_disabled && !numa_init(of_numa_init))
 			return;
 	}
diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
index 0635c0724b7c..309eca8c0b5d 100644
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

