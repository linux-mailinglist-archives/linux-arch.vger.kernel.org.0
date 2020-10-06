Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902D028433B
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 02:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgJFASH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 20:18:07 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:18352 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgJFASA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2020 20:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601943479; x=1633479479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/JpC2RlQXkAFbMviFPpL7wwSbtn1c0inpseLQKJmER4=;
  b=nLCDOgKAirnCRa4gnJUVgKeer7plFr5jNmRFd+8uNRNmXvck9hO7yB8D
   N3elVzVpPmyImDUQwOT16hYlGCVzr0x3SqHYZoQUcy+04OIUq0+ax0/Xs
   VT7IGUAPiMFSQsVzAbR8qc8WyDLFPA/yIXj/6fmNiFCYD984ReGAVKvKZ
   HiUGbbeWrPWuBWkU8QJMtP66PXKj4Rlp6NaDTKi6/XYdwcsHvjB8+YKr2
   KbtwQ7xx6jJ3OJWlKIi4Gv84EqDfPgUoD93k9M6bX2MSZldLqJSB1wkut
   tyvWtQ3pqttVis54xI2NbUa8ZTBiy/4OlbSOwLjYscxhY3sPxnkWyqw5d
   w==;
IronPort-SDR: k3N4PQZq0J5cg94UqP1Lahx5bq5oB3xCJdBwWUmnmJF1inOLkLKz3qNkVpMA++J57kS4Ejpgba
 linRyeE6SJ8VmRgJku8SaLk1Qkt9xCSP88IG+lzdlNhH6bl14ToON77geZJbLsH5zimw3/sUdR
 pq9VWKyL/WRoiLziOpjAVl/23s3aDj71FRI/7Ugr1j/LdI38REUeeO0KGdbw2RYJiZsA7HguUi
 8L68XWnIs+uPO/w6d3Nn3N/Pq0Z+woZkZb6SFSiandQd+Q28NOnV+odxn8h9senfY14AuV+0iq
 reg=
X-IronPort-AV: E=Sophos;i="5.77,341,1596470400"; 
   d="scan'208";a="149023398"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2020 08:17:59 +0800
IronPort-SDR: 0/eoR8FkfQqZRnLOSEoFVsMSfk55ZYef6Mio3dy6yLzyUH2hNSjs/gTdH0NI6HuKhrTCZshoy8
 yJruexlAnsiQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 17:03:51 -0700
IronPort-SDR: TH8W7OjpWGFpVi6zlILnC5X5SZw8T4PzOGhHosd3duRWRJTVxv0OzfvYLhUL6c4Vnpya2hRFaw
 Hni8KP/LyO+g==
WDCIronportException: Internal
Received: from b9f8262.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.253])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Oct 2020 17:17:58 -0700
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
        Jia He <justin.he@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
Subject: [PATCH v4 3/5] riscv: Separate memory init from paging init
Date:   Mon,  5 Oct 2020 17:17:50 -0700
Message-Id: <20201006001752.248564-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201006001752.248564-1-atish.patra@wdc.com>
References: <20201006001752.248564-1-atish.patra@wdc.com>
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

