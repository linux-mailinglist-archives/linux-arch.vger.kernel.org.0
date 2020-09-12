Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEA326771A
	for <lists+linux-arch@lfdr.de>; Sat, 12 Sep 2020 03:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgILBgW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Sep 2020 21:36:22 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:13362 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgILBet (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Sep 2020 21:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599874490; x=1631410490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VNduA903hGAtFKvfx1wBqQc81Up09t3m8usKMGKsctI=;
  b=KpEjcHBYS7fJ5HWyoxN7oVnZuYj++FiNEVj6UXP4CzkKAwDSSRrFeh6G
   yV0PAYqqlhQ0+gwSy/3+qsxo3UjTwrjVEnw9/wI55U+ammTwz/cMXAEpJ
   WRNXkB081rpPs+QZw234Xy86VM2AC9DHjCF5CbkDzGZ8NZDc6EsWqEqDy
   6WbvBrU8EH4lU5zjv7tbHgbcFFvYcpYxo4t9DR1C2XyVf74YX8tgw50xK
   P1G42V3iiAHlbxftOkshGyBguai2anaa0IbpSygzhnnTpSfeZQbeTOu/L
   zzxFjmFbVhGbpfZXX+Vd4R+V4TS6rHJCCyPeCzcGhdM4XljHtzuzoyjDT
   A==;
IronPort-SDR: 6iiu0rji4REfpevOGTwvIndUUei0xXKvuuZLjqtieX6dW2BcBWeNmuUF26z72mkUA2SozFe1kz
 NciCVZu8v6QUwzbQ+fw8M9BR5mz6QGeiXHnhe1QalTtN1iK/wHUXSvLc6rS0H+dCxU+ya8GJrh
 jXyWr9SeyQ9el3rgswNK07TcMvyQZMIYQ/16SlMqA47dzoK2rE0jt60jDdB1rR6bcPigKAwNJW
 QLFaZYMkTjsYoIgqLsFPCI3mRxfFqEXjcR6Edw44bF9WkKRIrmtJxv/Friv+o0nBx4Lyha1EU6
 12M=
X-IronPort-AV: E=Sophos;i="5.76,418,1592841600"; 
   d="scan'208";a="147177957"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2020 09:34:48 +0800
IronPort-SDR: /Vzj+VDVY1neRaYaUh8DwZj3/tGVx6a4wEcqDU3yczPfyweSJzBR2K6PPBpbHPlwhnNZa5Lbnt
 QrdRhD5WpWlw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 18:22:02 -0700
IronPort-SDR: S0TF4y2bRre0PH+ek52/0KgHP3FiKK6o2STFMwSadOxbMTmksba5IZhyDYDIzis6lyZIdNa73o
 SqpXVaOEtYvg==
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
Subject: [RFC/RFT PATCH v2 3/5] riscv: Separate memory init from paging init
Date:   Fri, 11 Sep 2020 18:34:39 -0700
Message-Id: <20200912013441.9730-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200912013441.9730-1-atish.patra@wdc.com>
References: <20200912013441.9730-1-atish.patra@wdc.com>
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
index 188281fc2816..8f31a5428ce4 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -568,8 +568,12 @@ static void __init resource_init(void)
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

