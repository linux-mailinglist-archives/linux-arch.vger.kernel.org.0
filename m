Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4622B8918
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 01:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgKSAik (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 19:38:40 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49086 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgKSAij (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 19:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605746319; x=1637282319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GUaYqW4/OtPcVsQlEiV+NW6wzQDKURMHsfJSB6w7l4o=;
  b=HJrVUpzcrzD2fhRHBKjtnrdaU9f2N4fi6ZBD06RWwujPX8OumcgAc1hC
   Iv+wUyufLSBK+849wUBr/Gwa9sd2gEtWVcdnQIuYego/xSQgN82U9wubo
   af8B5/mJsGJ7dgsvhodfKp7Z62zvBGNzMCq8G/f9baxj2bvFQ0HhSh3fN
   JyFJ93uakuEOo4p3VcYNv8uVZ3P/h4waa4ZpFx4zeuNgnMNk9aJg3gVVC
   Ib2qVm4S1DCTtUjchMrH5fWQrXR6lzXDmTIsfvn1or1ohTWvK+IGVoumA
   9tQUW4C+D4FgtzsNtnG7vfzzVAkauF9JxwAm4RZdWNWt9BLRbuYuGGOsO
   Q==;
IronPort-SDR: eelDtPHStmPPkcmLIlcTEescuM3gmEKDS+pQ71JalXChgaalG7jOOoYcKwNKtksPZUiZgunGWQ
 OK8sWEfEIFArE6BJFM5dYI6wuFHnuIqXgG7m8Bmu5pgPK/SPZG1T78PlAE3jpp1flaSitJ2BU9
 t9+f3lr/TKjdVkDjlS198ymsytDR5DtcI46qyMPKFm3BkkKHppOJW36vYvJKVFQJw4AnWYhINm
 kaBx1KPkE353l2Gak8MTH33tTW5Psx3sbM+bxBO54dNnqGb6S43Ny5qCdg2F9UP7VUMORgqjqy
 BzM=
X-IronPort-AV: E=Sophos;i="5.77,488,1596470400"; 
   d="scan'208";a="262974337"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2020 08:38:38 +0800
IronPort-SDR: SgMXW94vjXAR1UnNloPetv/Cv5976jM7PghEIPmDgSF7Rum0PA/mI6CJsYyCkqHEaNDXDH5czu
 DVJM5K6zJQrZrerNORhPisTXWX8kikV17GnNeaGmDZrhApCpZbw4KBgY9gvQmMKUd+yUSKUYRD
 byMbqQWl09UpGRyw9HYcxTK2SzG1zylRNOuq4ch1P+Qf3mze0MPApIX1M/ym1s4LluH02VLbfB
 cRUAwjYF4LNK8A18vZm/uC0WNxOwGcFKew/rhLUKEO7Lwxd4PgeWudjYPSPAFUZbVLEaT5094a
 ilgn7Un72yi8vOrBSKzR/Csa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 16:23:09 -0800
IronPort-SDR: risX5pD68f3hhs/NiXWXWp0naexRBIux6tSPhzOA2lH0DH2WM0DPaKLZK30a23KsaTvngg71k5
 fTaNcLohcL1OBZTYVjGe2QnRMPXwersQduanJYS90weebYhgTxMGU3xNPIfvUorMe0YXSXjo5n
 pt+0LjUgmE8QJOghQUZYDxJgvmtZueuy1PQHw4ls3AZFY4SHgq3a1UfWuMVV3k1pe5IP+e7cWU
 Rejbda9CEO640ZXnkFk6A4iM6ivFLbS6Cn/rKkdns5zS8SnzHhf5GCEVKKNjGjHTDHzpt+Rdvf
 /5A=
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.61.71])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2020 16:38:37 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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
Subject: [PATCH v5 3/5] riscv: Separate memory init from paging init
Date:   Wed, 18 Nov 2020 16:38:27 -0800
Message-Id: <20201119003829.1282810-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201119003829.1282810-1-atish.patra@wdc.com>
References: <20201119003829.1282810-1-atish.patra@wdc.com>
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
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/pgtable.h | 1 +
 arch/riscv/kernel/setup.c        | 1 +
 arch/riscv/mm/init.c             | 6 +++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 183f1f4b2ae6..a0f8a86236e8 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -471,6 +471,7 @@ extern void *dtb_early_va;
 extern uintptr_t dtb_early_pa;
 void setup_bootmem(void);
 void paging_init(void);
+void misc_mem_init(void);
 
 #define FIRST_USER_ADDRESS  0
 
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index c424cc6dd833..eb1cbdc29ea7 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -88,6 +88,7 @@ void __init setup_arch(char **cmdline_p)
 	else
 		pr_err("No DTB found in kernel mappings\n");
 #endif
+	misc_mem_init();
 
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(1);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 8e577f14f120..826e7de73f45 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -664,8 +664,12 @@ static void __init resource_init(void)
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

