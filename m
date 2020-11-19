Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90102B8920
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 01:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgKSAiu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 19:38:50 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49091 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgKSAij (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 19:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605746319; x=1637282319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tBpauZx+fMSCAhtcJtgaXTjyMk4K33HNxdPCRgo5eAU=;
  b=dTcrzsedYcALOIVOJ9/3ANfggSzTpX4wQ9zp7HK555so5+439ZM295Hc
   mNyjGMh8RSv+pdIjJL9Xa2hde9agZI5GLV53GyQ425whmUPQf+mv1dSFl
   tomsRmmkMl+0XbfcIxq8yzkEpzKIBWTEDujttsfKJKzUL2zWKC7wCdDfz
   +3lzzRZqvg5axrcuXYj9MpnjURB7GvfhrF840WEIEVpAXkH4CCFvp4VER
   gIV8yDON+8BwGn+NUE0/2xUMoK84FJClM94sgFgPU1Bg7ajn23NetnRsh
   B+i5akNjbOmIiTtEN7D4crCek4MULT7z3cLYNy6MiB+mFL7LBOq19gh5E
   Q==;
IronPort-SDR: mJKvHGGwhBzQw6leP7vFYTFL+9ux63zVj775Ssc9NKebCqmiJbI5EBGWd5OJC5g2E4CO6cfHm2
 htLQd2lHcKHe2BqAoZz5Lix8gPTwWEgJ/KdT/2Azrg2d7PtI2lf5iYUEuEcht8Z0derz0Hb8Hp
 cnZmoxwPKgKoYrG17/7wfEnOTWOAUsp1x2uJf0yyWDCMJvIAAEIK9TjSY4g/ZZ5JUjP/yVNh4y
 Wsw/nC6XJwHnKBgaq4UxrkE2VMjztKxa0bmehJHBe5dr8S0gNwsazEI2GahnTCQL5DGyQPwJEK
 UbI=
X-IronPort-AV: E=Sophos;i="5.77,488,1596470400"; 
   d="scan'208";a="262974341"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2020 08:38:39 +0800
IronPort-SDR: 2D/8WScK2SQVF891gB+M8clc3+LN4loHlAybpIaj748UTc77OSXdac9EvT80HUz6sb05d5I2pc
 ORVEWcMQGQoyQPnqoVo+dlBPX9SbAevCCr0PNum080EBPU6byabKZ0jsi/E6oQ9T+7WJZH19pI
 I975yJmKzLWrUIIMPNBQLgvk8GkKC6JLGuqs+dAdOTmMAK4pkcEXO1ND3ZrQ1+02n510nhvYmg
 Di8bjYpwOFngeGak1zULIYlgUp4jwsBZxZpfE3FAYSNWYomD8N1GIP4izXKWS9RbBdmrxzOS7F
 lJUVq6xVk8q+leq0NxvZmw4m
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 16:23:10 -0800
IronPort-SDR: WCaCsrsQeD76vs6BFx7SRimVV5INxI7DErIY0dh+zHL6r7f7mSDPhUNFrE4WqDFTIutVZMMunu
 wqhTxTrVS1A9vDQVtpsuWjd/gi0VH2iIABey0qs6WV6Xv3BZacKVArX7YI67nLhsntgDW28ipN
 Xn4BjRUZbX1axB9UG2WOz118O/X055REKNgOJ3MBAMk7DUnaK/LdNxI5NBZ3Gzj6oL4LbP1s1d
 VwgDTQ2No147z99s/TxQB3G3eNk7wdpCEnmu3aYGSBmgCYjZBFQ4NDa3q2K0v3fseBt1l/zGNy
 6x0=
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.61.71])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2020 16:38:37 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atish.patra@wdc.com>, Baoquan He <bhe@redhat.com>,
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
Subject: [PATCH v5 4/5] riscv: Add support pte_protnone and pmd_protnone if CONFIG_NUMA_BALANCING
Date:   Wed, 18 Nov 2020 16:38:28 -0800
Message-Id: <20201119003829.1282810-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201119003829.1282810-1-atish.patra@wdc.com>
References: <20201119003829.1282810-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Greentime Hu <greentime.hu@sifive.com>

These two functions are used to distinguish between PROT_NONENUMA
protections and hinting fault protections.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/pgtable.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index a0f8a86236e8..64aba4f7a0ed 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -187,6 +187,11 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
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
@@ -290,6 +295,21 @@ static inline pte_t pte_mkhuge(pte_t pte)
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

