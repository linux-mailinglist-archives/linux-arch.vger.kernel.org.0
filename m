Return-Path: <linux-arch+bounces-14834-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAD5C63A03
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 11:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D12E3B4E0F
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 10:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4DA287507;
	Mon, 17 Nov 2025 10:51:15 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117B9257435;
	Mon, 17 Nov 2025 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763376675; cv=none; b=VK5zuSpTdvTnmAVl59SMWMd1w3WFiQJihbLQ7OOa7a9lStCV8sS5wukvUGkhFq2/ykGqyDTWSw6S0+fYNL01S3Sr7Zb6QmiEGpdftusCVUVjy5UvdCbwQgobF3ktiVrZmuXYlz/Edhvr3adqhfaak7MgJTPW2pYrTFQ11AULsC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763376675; c=relaxed/simple;
	bh=a6A1flYHy1jzKJL0bxU9RooZuc8Pn92Ke79kootm4eU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVPktJAbPi2X4d1WfSJHwRjlf0vwSJIAvQ8hazYKSBeF+pZmYaV232O/uokmyVQbVNOzFe4wAC8Uwr9S487DgepYFkQ2kz0sz2bogBsI5p2NpOJGrv01KhVC3m4793C8C7qyMND9tGg++RF92fipCvQTmt9Bd2IrllQi2qC+l74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d94K32LZZzJ46dd;
	Mon, 17 Nov 2025 18:50:31 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C455E14011A;
	Mon, 17 Nov 2025 18:51:11 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 17 Nov 2025 10:51:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Conor Dooley <conor@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, Dan Williams <dan.j.williams@intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Drew Fustini
	<fustini@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Krzysztof Kozlowski
	<krzk@kernel.org>
CC: <james.morse@arm.com>, Will Deacon <will@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v6 6/7] cache: Make top level Kconfig menu a boolean dependent on RISCV
Date: Mon, 17 Nov 2025 10:47:59 +0000
Message-ID: <20251117104800.2041329-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251117104800.2041329-1-Jonathan.Cameron@huawei.com>
References: <20251117104800.2041329-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

The next patch will add a new type of cache maintenance driver responsible
for flushing deeper than is necessary for non coherent DMA (current
use case of drivers/cache drivers), as needed when performing operations
such as memory hotplug and security unlocking of persistent memory. The two
types of operation are similar enough to share a drivers/cache directory
and MAINTAINERS but are otherwise currently unrelated.

To avoid confusion have two separate menus. Each has dependencies that are
implemented by making them boolean symbols, here CACHEMAINT_FOR_DMA
which is dependent on RISCV as all driver are currently for platforms of
that architecture. Set new symbol default to y to avoid breaking existing
configs. This has no affect on actual code built, just visibility of the
menu.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v6: New patch as suggested by Arnd.
---
 drivers/cache/Kconfig | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index db51386c663a..59a79df4c0ce 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -1,9 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Cache Drivers"
+
+menuconfig CACHEMAINT_FOR_DMA
+	bool "Cache management for noncoherent DMA"
+	depends on RISCV
+	default y
+	help
+	  These drivers implement support for noncoherent DMA master devices
+	  on platforms that lack the standard CPU interfaces for this.
+
+if CACHEMAINT_FOR_DMA
 
 config AX45MP_L2_CACHE
 	bool "Andes Technology AX45MP L2 Cache controller"
-	depends on RISCV
 	select RISCV_NONSTANDARD_CACHE_OPS
 	help
 	  Support for the L2 cache controller on Andes Technology AX45MP platforms.
@@ -16,7 +24,6 @@ config SIFIVE_CCACHE
 
 config STARFIVE_STARLINK_CACHE
 	bool "StarFive StarLink Cache controller"
-	depends on RISCV
 	depends on ARCH_STARFIVE
 	depends on 64BIT
 	select RISCV_DMA_NONCOHERENT
@@ -24,4 +31,4 @@ config STARFIVE_STARLINK_CACHE
 	help
 	  Support for the StarLink cache controller IP from StarFive.
 
-endmenu
+endif #CACHEMAINT_FOR_DMA
-- 
2.48.1


