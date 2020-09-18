Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978D12706EA
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgIRUWz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:22:55 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4416 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgIRUWv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:22:51 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 16:22:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600460587; x=1631996587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/JpC2RlQXkAFbMviFPpL7wwSbtn1c0inpseLQKJmER4=;
  b=eMpubWFe6J9iyM5k/WfqfPH+Aszs0divXQs5xwqVkY92wHrnNN0F7Sjr
   olKzcupOurnsMXgp7SdSiYYd18OVGe5H+sTLbh+P/zr6hdNX4y2vNIC+Q
   PS2vCvPYcdaSoWkSxQx2ZSXZQ3wyagmUTWjTQ1obTkcoLjSNN1XCdkzdB
   ho6pNpdVA2/6L8nLzlXej9eXy6q85xh0N/XVpPG0ARNHWYOOjTiIzEkXx
   906yFjvXsc999nEvGeLg4Mc04c9uX0pbkkki3uigZkZOSpl6OFlvXEkgS
   y0Dy1JmbQwMvQ+FqHe55Y1VxGjKN3fnW7M+FLoPcG1/3nkQJi49642jUH
   Q==;
IronPort-SDR: Y0hPY4CIdYsFZu1vpgFAB8xNUCr1kE8c2mz/LuoBkSqVo/6YE8ANQ3RT0TawM1gy2WzrYnikaX
 kXlXjWvNvXM0xxIqcqDFOp/SrBAEgojRaIYPFvb9qlDOA7VPfLofql3DJD/iLiPtA5q5vzPCpD
 LsXXzaLUlPGXAxeVWfhKyFNpNZffmhxdoW5KXtSsJ4SzjZbxR4XGDSEp0efZyXbLiJmZtLnjxo
 XvpbBCuR3pJ53/dIov3Q9iux3+E4T30IFetjnSpBPdXJQr4b6c2PLKjHSNlsA4xNC1Ss0B5CfX
 p6Y=
X-IronPort-AV: E=Sophos;i="5.77,274,1596470400"; 
   d="scan'208";a="251108779"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2020 04:12:55 +0800
IronPort-SDR: D1ey+Ll2kU/Fj3omL8f8yVh6oQ1eeqcXevSjot4ar6+80DouLRwGTWBE39Ggmrro3+27s6aE85
 YzQ9kU8Jt+0w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:59:56 -0700
IronPort-SDR: kv/bf5NetVldKD0fDiHItkHDfa9EIyHqDySY3Um7OGsv8KjbV4jGrSk4u94L5mrZMnvb9iL7GY
 SmOxNdxICoLQ==
WDCIronportException: Internal
Received: from us3v3d262.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.69])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Sep 2020 13:12:49 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
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
Subject: [RFT PATCH v3 3/5] riscv: Separate memory init from paging init
Date:   Fri, 18 Sep 2020 13:11:38 -0700
Message-Id: <20200918201140.3172284-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918201140.3172284-1-atish.patra@wdc.com>
References: <20200918201140.3172284-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently, we perform some memory init functions in paging init. But,
that will be an issue for NUMA support where DT needs to be flattened
before numa initialization and memblock_present can only be called
after numa initialization.

Move memory initialization related functions to a separate function.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/pgtable.h | 1 +
 arch/riscv/kernel/setup.c        | 1 +
 arch/riscv/mm/init.c             | 6 +++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index eaea1f717010..515b42f98d34 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -466,6 +466,7 @@ static inline void __kernel_map_pages(struct page *page, int numpages, int enabl
 extern void *dtb_early_va;
 void setup_bootmem(void);
 void paging_init(void);
+void misc_mem_init(void);
 
 #define FIRST_USER_ADDRESS  0
 
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 2c6dd329312b..07fa6d13367e 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -78,6 +78,7 @@ void __init setup_arch(char **cmdline_p)
 #else
 	unflatten_device_tree();
 #endif
+	misc_mem_init();
 
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(1);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index ed6e83871112..114c3966aadb 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -565,8 +565,12 @@ static void __init resource_init(void)
 void __init paging_init(void)
 {
 	setup_vm_final();
-	sparse_init();
 	setup_zero_page();
+}
+
+void __init misc_mem_init(void)
+{
+	sparse_init();
 	zone_sizes_init();
 	resource_init();
 }
-- 
2.25.1

