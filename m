Return-Path: <linux-arch+bounces-14657-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FFAC50425
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 02:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A14A4E75D0
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 01:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB2A2989B7;
	Wed, 12 Nov 2025 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="nsgAEFK7"
X-Original-To: linux-arch@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB66E21ADCB;
	Wed, 12 Nov 2025 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912736; cv=none; b=PrT93BX7PPDNvSU1mgZZIeLHseCmcUQmjPPV3AacTA1SShKUIkHUI6FW2bLnlAVi2b/yR4R00HTHTcbYNxdVwzblNXE39qvX0Y6cbZ6IGKtqYJawr38HnuhASZPY1vNcB9cFRQ6VxB/ICvEb8QAuKRa+HHYj2O/mTy95YTchcME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912736; c=relaxed/simple;
	bh=Wri0oARE9fYYweuln30312GKw9s15M6V/6eoGk212C8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isGmKe67qFG5FVyg+LuW/bBP2/BtkmJqCQxwJZ4ySGPJ+1z64gqBMyFOk8lCZTfwH0+g51db47p88eBfEVmrFRxnZBxpHx2TOHMCwVSHdsQeCbvnYQaSAdGgSqEqNRnX/b8kOWrZHSiuwhVMvzWWJYN9jbHRfowJhctFQxKOzEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=nsgAEFK7; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4NGVOMoFoiYK8NHpr6+aDzLHn4o8fKsUT+YnbH38cQc=;
	b=nsgAEFK7w6R/ueKq5W+USJKU8iwoWNGUVqjvqa+ZGS+/mNxMTC2XtkOItgPGdbPyBZzreEtBP
	BigFrBS/NqJn1NH88gXlWhN3vXq/Axg5ukB+OJhCaJ2G+ArBtgrVNqfwWf02s4OU9tqm863zloE
	PNofJq0NuN8VJc6iyu1k1hg=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d5mjz1D9Bz1prM1;
	Wed, 12 Nov 2025 09:57:11 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D5011400D9;
	Wed, 12 Nov 2025 09:58:51 +0800 (CST)
Received: from kwepemq200001.china.huawei.com (7.202.195.16) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 09:58:50 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemq200001.china.huawei.com (7.202.195.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 09:58:50 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <arnd@arndb.de>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<akpm@linux-foundation.org>, <anshuman.khandual@arm.com>,
	<ryan.roberts@arm.com>, <andriy.shevchenko@linux.intel.com>,
	<herbert@gondor.apana.org.au>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-crypto@vger.kernel.org>, <linux-api@vger.kernel.org>
CC: <fanghao11@huawei.com>, <shenyang39@huawei.com>, <liulongfang@huawei.com>,
	<qianweili@huawei.com>
Subject: [PATCH RFC 4/4] arm64/io: Add {__raw_read|__raw_write}128 support
Date: Wed, 12 Nov 2025 09:58:46 +0800
Message-ID: <20251112015846.1842207-5-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251112015846.1842207-1-huangchenghai2@huawei.com>
References: <20251112015846.1842207-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq200001.china.huawei.com (7.202.195.16)

From: Weili Qian <qianweili@huawei.com>

Starting from ARMv8.4, stp and ldp instructions become atomic.
Currently, device drivers depend on 128-bit atomic memory IO access,
but these are implemented within the drivers. Therefore, this introduces
generic {__raw_read|__raw_write}128 function for 128-bit memory access.

Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 arch/arm64/include/asm/io.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 83e03abbb2ca..80430750a28c 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -50,6 +50,17 @@ static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
 	asm volatile("str %x0, %1" : : "rZ" (val), "Qo" (*ptr));
 }
 
+#define __raw_write128 __raw_write128
+static __always_inline void __raw_write128(u128 val, volatile void __iomem *addr)
+{
+	u64 low, high;
+
+	low = val;
+	high = (u64)(val >> 64);
+
+	asm volatile ("stp %x0, %x1, [%2]\n" :: "rZ"(low), "rZ"(high), "r"(addr));
+}
+
 #define __raw_readb __raw_readb
 static __always_inline u8 __raw_readb(const volatile void __iomem *addr)
 {
@@ -95,6 +106,16 @@ static __always_inline u64 __raw_readq(const volatile void __iomem *addr)
 	return val;
 }
 
+#define __raw_read128 __raw_read128
+static __always_inline u128 __raw_read128(const volatile void __iomem *addr)
+{
+	u64 high, low;
+
+	asm volatile("ldp %0, %1, [%2]" : "=r" (low), "=r" (high) : "r" (addr));
+
+	return (((u128)high << 64) | (u128)low);
+}
+
 /* IO barriers */
 #define __io_ar(v)							\
 ({									\
-- 
2.33.0


