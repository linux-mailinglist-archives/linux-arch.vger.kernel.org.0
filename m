Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63332244FA1
	for <lists+linux-arch@lfdr.de>; Fri, 14 Aug 2020 23:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgHNVsf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Aug 2020 17:48:35 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25018 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgHNVse (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Aug 2020 17:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597441714; x=1628977714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UjeLYAGOcdXcIsgSttMVEHrk7RBdvzzoyHtETVrepjo=;
  b=SM0fwG7STXRMwyFzy9z3luTJL646RAlsWpvyf+B1nD5KDTJ7K5+1m9DA
   vER5azcK8Ff/KWfIEZnqVATgfwLEFW0Zd6fpRbYfSo9xudASpV8RecC74
   qfsjc+n2LmcoMrxRhMOTg5m7MMGZRU71Do7BELYNKVeXKDQ617PvGS0K3
   DprUAeUHlOH1XIywGtDJ+tOhp+dCnJdNV1o8SD60D6/kJLYUS2ZxCtJ40
   T7tNxKECOqnY9RVmr7xxB+Bc4xrUxZuyXM3kIuKlSkgtjhS9DZOuOc1/S
   Zx4mYYxMw2++o4T3hiHi+A+mw5b9PLSNuoYDsSAQcdlrCGnBWbJa4FeqW
   A==;
IronPort-SDR: DLj19ngf19Vk+atw2SpsBr+CYrdzK6VqONy493aVezvPekelR0lW41Vs41Mksf7ZjfoPM20cZ8
 iQp8UJb2QGzN0g7vvtZbcWHeFMkd4gwf5IZp/MsShMmEanjWURCf957bRZhYc0GsM+LDGV4yMU
 sYuEhXzEgcJCLHfIyqQJPTb7MnS3bPEorVwlTTqbVUsxMMRDhmV3PgFskWb56N2qYtoF3Fv70G
 5k9nk8/EqnND8+hv4vmL+e9KfWCXgMhiA1mJ5SMcFLEgHGnTaZ9IatrXghJgW6KDqfiEG4qfky
 oRM=
X-IronPort-AV: E=Sophos;i="5.76,313,1592841600"; 
   d="scan'208";a="146217658"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2020 05:48:33 +0800
IronPort-SDR: DvKPrsgP1fyL8qL/AulukhlyfDvn/gEfManoYtqBqqeTQjZJN4WVkcu9f4eXxufC5ltT6xYVwH
 Uu8JoZTyCqfQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 14:35:37 -0700
IronPort-SDR: OiHQPqy3m8DvMgsYc0QMagm9siS9tQWyreMlyzSSKgLyP9TYhEfZkQosudZErrRfYErDIjVTC5
 hyH3FpWbrN7Q==
WDCIronportException: Internal
Received: from cnf006060.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.56])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Aug 2020 14:48:31 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <Anup.Patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: [RFC/RFT PATCH 5/6] riscv: Add support pte_protnone and pmd_protnone if CONFIG_NUMA_BALANCING
Date:   Fri, 14 Aug 2020 14:47:24 -0700
Message-Id: <20200814214725.28818-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200814214725.28818-1-atish.patra@wdc.com>
References: <20200814214725.28818-1-atish.patra@wdc.com>
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

