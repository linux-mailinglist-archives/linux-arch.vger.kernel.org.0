Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430552706E5
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgIRUWx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:22:53 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4418 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgIRUWw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600460589; x=1631996589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yFZiLxGXA9elMo70n32xkkNg4f+3DGRCZkaVt0joPmw=;
  b=EpDuX8gXdq0H22Ng4forNfkzKhq0GBSjww/JND9v8EDeBebKeecKvDx8
   0HMgQ7n/NsjM52jM30zv5QGWOcH9Vl7tNYru8ubvsoUVGJUGGgQ8MafNC
   08UcdCerWcrpw57WaQoZqXTRTebvWVJx6aoPleoGIkp0g0ZtTalwGxHAK
   imzugicIFwuk1CdJLKvP/PfjjULmT4H9Jzj/dVqJgDseOZJeOoY3opaoM
   AlUjDNDOcsbNKTjjdMlgKARvBTEoh87EfD5p3o+lhAKADzRHPSIGjxsx3
   oaiE48xuphTwh9TJiXhaNnyAVFdhwrr3ubuiWII8W1Hk06N6lG7rvCXNj
   g==;
IronPort-SDR: xkieGeG370HlEOgW6uWmQ+t7YgD0OxQj2wB8kDtUxIJXr34/tQmkUT5//GW+V/Mm8ltpRp2aFB
 wGhVw7fS4IOeGKDkqUgV1zSwKwe/2fXhR98WGux9Ongio61EdgJL5gGF45Ng1+RHgDSzRPnz/a
 /85rWFMrJtPiIY/5MEl6LiYvRaqUMMrKhECRQfCg+JcbtSVyhDTn48KpJ7PwNDvK43oCE0f8JF
 WHGWVL+ZYWOTrqtMfGbxf43rsBKzQVZFo2dYzGb4wf/EVT8pBIWBPufLwEiOMG67D26MrY5cwR
 0WU=
X-IronPort-AV: E=Sophos;i="5.77,274,1596470400"; 
   d="scan'208";a="251108784"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2020 04:12:56 +0800
IronPort-SDR: nncl1Yhlto7WZciuDd9Fpf5YawcYq5DErYdvhGV4JXKY//OQsjW6LSPsF2vaO7qrZyPiYr88zj
 27tn9132K+cA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:59:57 -0700
IronPort-SDR: nFg7iJKfhXph3l+76Ansy35dqHtaUlKkxiQMAKc1U64BmEUoqafedKZBwy+X4FreVqruthP5F4
 N/AvufJIo0Mw==
WDCIronportException: Internal
Received: from us3v3d262.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.69])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Sep 2020 13:12:50 -0700
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
Subject: [RFT PATCH v3 4/5] riscv: Add support pte_protnone and pmd_protnone if CONFIG_NUMA_BALANCING
Date:   Fri, 18 Sep 2020 13:11:39 -0700
Message-Id: <20200918201140.3172284-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918201140.3172284-1-atish.patra@wdc.com>
References: <20200918201140.3172284-1-atish.patra@wdc.com>
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

