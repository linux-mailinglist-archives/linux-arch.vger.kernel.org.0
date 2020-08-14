Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4167D244FA4
	for <lists+linux-arch@lfdr.de>; Fri, 14 Aug 2020 23:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgHNVsw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Aug 2020 17:48:52 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25032 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgHNVsd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Aug 2020 17:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597441713; x=1628977713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=riQjp16BU3MGRmQFd57ikw/BK/iRNF+3tCmpWPLw6VM=;
  b=IwX+9HHKjmzG8OwMmiye5gXQw0wXjGJemUGSd/f3eliLOEyj5iXb/tdr
   phNlaNsl21bBwqHOBvPDPyH/pHfTgFzepiFmhN0koq1NZxszhtYOZUloS
   Th0nq1aMoP2/EL1buLxZtea5zt+AmrpJ2PsXdByqnH+WRAzW+mphuOa+h
   u9bU9SlT2Ct1U5hZWZAmTmOsOXW4x5yo7YbDxwag6yQb0qNCBdVklMGvx
   0gULidPqwcOF/LMMOeYisDzveOg2js033iBk5+v3BH+3io/yGQiuB7/pQ
   piqGwTNjzW+VA511O8K+r8q7iwaBBur20HxKGb0rLoJq96YnA08S69eLK
   w==;
IronPort-SDR: iyTwkQkuQPQ43t7J/aF1yqumRuppB/j3E13otOVT9EfPPtJDr2Zj+dY6uixXgRwg5e6r8Tv8Mg
 ktvLUTXXz70e2zMBLUXBClpEedUPYIFmv+RR7oik77HT34lr6pYm4zABO4VbpdcuXkazRZ62kP
 50nj2CKNTLh8pignacQdndG7NkuslRt17gD7SXzQaIO4wireVfuxu9IsqJPiMNfEKShPvX8fBo
 bLnSuOZYtFKxzNBg31tMXN0o/a/2BgpXugaWd99/KF5XLrVWsEpgEj/47t1fa6hHHoalLgMqew
 mGo=
X-IronPort-AV: E=Sophos;i="5.76,313,1592841600"; 
   d="scan'208";a="146217655"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2020 05:48:32 +0800
IronPort-SDR: AqDTmNClFWB/Ey6Y9+QoIf91eAUTl5shXKLNOxWbXE1QeqW/KuFZMybTlKMt0KnBmmOOC+qRcu
 1GJtvJlSDC6w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 14:35:37 -0700
IronPort-SDR: 2qIF5Vqs6Zgae5cf+Vy+yHG7TJhk/dEiYuok3B/fYP/hVUpyilT7HsF7J4pS0Ix0FM311oNdZM
 CLhJfYjs37Rg==
WDCIronportException: Internal
Received: from cnf006060.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.56])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Aug 2020 14:48:30 -0700
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
Subject: [RFC/RFT PATCH 4/6] riscv: Separate memory init from paging init
Date:   Fri, 14 Aug 2020 14:47:23 -0700
Message-Id: <20200814214725.28818-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200814214725.28818-1-atish.patra@wdc.com>
References: <20200814214725.28818-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently, we perform some memory init functions in paging init. But,
that will be an issue for NUMA support where DT needs to be flattened
before numa initialization and memblock_present can only be called
after numa initialization.

Move memory initialization related functions to a separate function.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/pgtable.h | 1 +
 arch/riscv/kernel/setup.c        | 2 ++
 arch/riscv/mm/init.c             | 6 +++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

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
index f04373be54a6..32bb5a1bea05 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -79,6 +79,8 @@ void __init setup_arch(char **cmdline_p)
 #else
 	unflatten_device_tree();
 #endif
+	misc_mem_init();
+
 	clint_init_boot_cpu();
 
 #ifdef CONFIG_SWIOTLB
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 787c75f751a5..b8905ae2bbe7 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -570,8 +570,12 @@ static void __init resource_init(void)
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
2.24.0

