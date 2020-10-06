Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0186828433C
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 02:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgJFASI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 20:18:08 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24250 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgJFASB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2020 20:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601943480; x=1633479480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yFZiLxGXA9elMo70n32xkkNg4f+3DGRCZkaVt0joPmw=;
  b=J86yf0k/E6hJHvKLEpinBAxH6qiK5FvkKlPMWdF4KN+1M42AyGydpg+I
   wKA6N5lx3SX73+9VuCOqRPrWI7FNAfzTEsQ1q9Hjn5mkRUp1d/YeYSzbn
   8FeqCKcZ2U7fxNH1/+DL65+FMmSsyY/iIsKkm46VInDY8X7GZ72K9J88u
   6IaP64SxKd61ZggegJ29jWKFNL3DFi8cxCdqqEoGYkgzPGqkFQWRHIFjP
   Sjjdm4JkJDCx3H6g+w9gn5DuPoSXb9jN32pMajt8Q+TdAWJc4YlAENk8w
   VGsWWBt8EwN9cg7oEMZoYpyfsNuty8443J19dkyGJM7IaoZtyU2LiwWP0
   Q==;
IronPort-SDR: j32YP0tuNZnl6g0iZ+GigbcPf1+ILY8psAyCs+xW7rfrIxqiFP2a28JWx79COc6a+Qy/MgOFOR
 wEvdXk+QQ6QYmllssc4Lyu+WXPDP6UPh4QrtmcihEFlzQjwimr1VrX7AIKX5enyUPTGz6U1xA5
 fLemaF5HNujnBhPDX+muzFFi3sKgY0HawoRvl6yfORDSJT//CsvUcBc7HyyCYTD1vZKZc1xzG/
 DrtBa5SEWpB5/uaO60CGPO6pVG/e6kvSfT8TOnRa+u1kmomWxdsRXrYkjCPMVNtsYmUyRSPCHH
 ZM8=
X-IronPort-AV: E=Sophos;i="5.77,341,1596470400"; 
   d="scan'208";a="149023400"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2020 08:18:00 +0800
IronPort-SDR: 6lLPCKjbwkZsQ2MthiYO5QpBP4ucVVOp95pO0/w23caEsMwDIrXW2Fdo5iSVdTcL5bGHB+Gh0N
 9Dr0urjQldRQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 17:03:52 -0700
IronPort-SDR: rD45YZG01rzAHCHeb+UWPggXpioB4z171xHwJ8hS9et3cvwetahVQCKI4OLiFEf7barKvGm8Kv
 6Qg7IhGQ58+Q==
WDCIronportException: Internal
Received: from b9f8262.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.253])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Oct 2020 17:17:59 -0700
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
Subject: [PATCH v4 4/5] riscv: Add support pte_protnone and pmd_protnone if CONFIG_NUMA_BALANCING
Date:   Mon,  5 Oct 2020 17:17:51 -0700
Message-Id: <20201006001752.248564-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201006001752.248564-1-atish.patra@wdc.com>
References: <20201006001752.248564-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.25.1

