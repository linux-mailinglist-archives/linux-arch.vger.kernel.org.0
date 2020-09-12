Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA89D267713
	for <lists+linux-arch@lfdr.de>; Sat, 12 Sep 2020 03:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgILBfK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Sep 2020 21:35:10 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:13347 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgILBev (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Sep 2020 21:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599874492; x=1631410492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UjeLYAGOcdXcIsgSttMVEHrk7RBdvzzoyHtETVrepjo=;
  b=D6gqLMi1qQbCq+reWHCt67U+SHy/nVfYFj2h/yEBJzrzkoqLSwNNCBeJ
   HlLenyQrngtdAM8YN/6Toy0sDTvYqUlVI011NYaEAymG2+WhsunL4nRn/
   Q7QbJIDVo3q+0D6NjzdaEkBhBvEPpu2Yn0Xn2ShGrJwPNuYau1sf+wwNd
   d4DL0MScxe+mLkn9qBqCpeU7hZTvti+sUTqXGJiFsCnAtufrRF+VQyafj
   sGVa0T29eBl+PhxLPVA4KQtqQ3/H2zNNkbbLl6v/A6C6ylZMOGrjFkFuZ
   Ck92gU9tdfDKA2Kp7wH5ZeTDBgc4YFo7hA0UWOabVl59byvUwN/GVMk4q
   g==;
IronPort-SDR: ZyeaPg6AJlP16otx3GhmEsj8RdBhslAuI18CAdvCzL+uHY1/dWsE6sZNBXjypZMxN3dTcLsem9
 rswBKF2eZuH8VwBv2OcDFWySsixM3WnthIGoWXplwW6XAJ5+k89yGuBT30oYPIlQVU6RyFalWU
 6oo8cAu/CxIOlsYVKu8PpSd+jlUfJ8QkBosK0cJ2SCAOvIS3jI0RwSRHytKJFXa+XQ5Q1CIgqo
 r6VwqkOZ3kWNL2sqY65hjJGDQRWe9/XQcwyMcmhCsRxefAMMJ+Erd9BiGT1rhMmQX898Nfgo1w
 AgU=
X-IronPort-AV: E=Sophos;i="5.76,418,1592841600"; 
   d="scan'208";a="147177959"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2020 09:34:49 +0800
IronPort-SDR: 4uQFoKyKJmr6iWwPSJtej+Sjyt5Qg+Lh4pF62LUGN3wnWF3y6tRIqRTcI4OdvAOk9h2JTFw14k
 QgRpHqurEcHw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 18:22:03 -0700
IronPort-SDR: WVSo90k5RB/Op5MTYgcl3P06o6rSxyXsLjYI6RB1XlWinPa+NfnA15S7rPXmE06Vk6mVbeY/fl
 3iTlz6g4oEww==
WDCIronportException: Internal
Received: from unknown (HELO jedi-01.hgst.com) ([10.86.59.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 18:34:47 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atish.patra@wdc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
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
Subject: [RFC/RFT PATCH v2 4/5] riscv: Add support pte_protnone and pmd_protnone if CONFIG_NUMA_BALANCING
Date:   Fri, 11 Sep 2020 18:34:40 -0700
Message-Id: <20200912013441.9730-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200912013441.9730-1-atish.patra@wdc.com>
References: <20200912013441.9730-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Greentime Hu <greentime.hu@sifive.com>

These two functions are used to distinguish between PROT_NONENUMA
protections and hinting fault protections.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/pgtable.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 515b42f98d34..2751110675e6 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -183,6 +183,11 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
 }
 
+static inline pte_t pmd_pte(pmd_t pmd)
+{
+	return __pte(pmd_val(pmd));
+}
+
 /* Yields the page frame number (PFN) of a page table entry */
 static inline unsigned long pte_pfn(pte_t pte)
 {
@@ -286,6 +291,21 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
+#ifdef CONFIG_NUMA_BALANCING
+/*
+ * See the comment in include/asm-generic/pgtable.h
+ */
+static inline int pte_protnone(pte_t pte)
+{
+	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE)) == _PAGE_PROT_NONE;
+}
+
+static inline int pmd_protnone(pmd_t pmd)
+{
+	return pte_protnone(pmd_pte(pmd));
+}
+#endif
+
 /* Modify page protection bits */
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-- 
2.24.0

