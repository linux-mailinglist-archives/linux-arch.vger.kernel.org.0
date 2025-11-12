Return-Path: <linux-arch+bounces-14656-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75F2C5041F
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 02:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CDF93A9DAD
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 01:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C905296BB6;
	Wed, 12 Nov 2025 01:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="I4H5FiXs"
X-Original-To: linux-arch@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A381B291C07;
	Wed, 12 Nov 2025 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912735; cv=none; b=tX2cRLrNCRalQoe6nMv+6h1w9bmPj+UHGUY7Ez+tjyOMOddZHf1nApltVE3id6waV4aELliDWL8bVRU07SDt8keovrqO+70tFYsMoM2CSE1Fv5wGe1ESbetzu14622QDPUm79yH897xj9W5lpaAxUUnAavt5kKSZfETM5op8et8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912735; c=relaxed/simple;
	bh=0d24U/gQtR7PaFIB8U0Qme4G1IgYCEDPR4xbDK59YFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGGe6wgQ/wgc4p1h/gGR1fM1L2WRIyBgARr4vInHJ5dDwh2zSN+5NsaretwN7SPQX67x1TIVbuekH/Uy9YZodd7C0+n6CZsBJsDSnvvrQN6r7grrkX5trXH9LSwvo+Os0sAmcsmkXGoYU0Qo4O2RSzs0fEkfg3dov+5vVs4Pqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=I4H5FiXs; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DP8vjdYZDSobWILtLfZiQMWdEZEMU/+jU5eftNIaWJc=;
	b=I4H5FiXsckWGKiwWuQR7YErH3Rji7+fO7qkBrNGdRRFeAHv9JftjHulXLGSF9EJZYhFuf2Rv0
	rkhZI5AsoMZ9WjnEYveCtbpo237GjdS1FEeCFcU8u02B9uzb+SV5bAluJBXhQ/zpumjJeK08HSP
	2+IQfOFEbYkgz0himOw+HgA=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4d5mjz0drmzLlVP;
	Wed, 12 Nov 2025 09:57:11 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 11544140135;
	Wed, 12 Nov 2025 09:58:50 +0800 (CST)
Received: from kwepemq200001.china.huawei.com (7.202.195.16) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 09:58:49 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemq200001.china.huawei.com (7.202.195.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 09:58:49 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <arnd@arndb.de>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<akpm@linux-foundation.org>, <anshuman.khandual@arm.com>,
	<ryan.roberts@arm.com>, <andriy.shevchenko@linux.intel.com>,
	<herbert@gondor.apana.org.au>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-crypto@vger.kernel.org>, <linux-api@vger.kernel.org>
CC: <fanghao11@huawei.com>, <shenyang39@huawei.com>, <liulongfang@huawei.com>,
	<qianweili@huawei.com>
Subject: [PATCH RFC 2/4] asm-generic/io.h: add io{read,write}128 accessors
Date: Wed, 12 Nov 2025 09:58:44 +0800
Message-ID: <20251112015846.1842207-3-huangchenghai2@huawei.com>
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

Architectures like ARM64 already support 128-bit memory access. Currently,
device drivers implement atomic read and write operations for 128-bit
memory using assembly. This patch adds generic io{read,write}128 access
functions, which will enable device drivers to consistently use
io{read,write}128 for 128-bit access.

Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 include/asm-generic/io.h | 48 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index ca5a1ce6f0f8..c419021318e6 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -146,6 +146,16 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #endif
 #endif /* CONFIG_64BIT */
 
+#ifdef CONFIG_ARCH_SUPPORTS_INT128
+#ifndef __raw_read128
+#define __raw_read128 __raw_read128
+static inline u128 __raw_read128(volatile void __iomem *addr)
+{
+	return *(const volatile u128 __force *)addr;
+}
+#endif
+#endif /* CONFIG_ARCH_SUPPORTS_INT128 */
+
 #ifndef __raw_writeb
 #define __raw_writeb __raw_writeb
 static inline void __raw_writeb(u8 value, volatile void __iomem *addr)
@@ -180,6 +190,16 @@ static inline void __raw_writeq(u64 value, volatile void __iomem *addr)
 #endif
 #endif /* CONFIG_64BIT */
 
+#ifdef CONFIG_ARCH_SUPPORTS_INT128
+#ifndef __raw_write128
+#define __raw_write128 __raw_write128
+static inline void __raw_write128(u128 value, volatile void __iomem *addr)
+{
+	*(volatile u128 __force *)addr = value;
+}
+#endif
+#endif /* CONFIG_ARCH_SUPPORTS_INT128 */
+
 /*
  * {read,write}{b,w,l,q}() access little endian memory and return result in
  * native endianness.
@@ -917,6 +937,22 @@ static inline u64 ioread64(const volatile void __iomem *addr)
 #endif
 #endif /* CONFIG_64BIT */
 
+#ifdef CONFIG_ARCH_SUPPORTS_INT128
+#ifndef ioread128
+#define ioread128 ioread128
+static inline u128 ioread128(const volatile void __iomem *addr)
+{
+	u128 val;
+
+	__io_br();
+	val = __le128_to_cpu((__le128 __force)__raw_read128(addr));
+	__io_ar(val);
+
+	return val;
+}
+#endif
+#endif /* CONFIG_ARCH_SUPPORTS_INT128 */
+
 #ifndef iowrite8
 #define iowrite8 iowrite8
 static inline void iowrite8(u8 value, volatile void __iomem *addr)
@@ -951,6 +987,18 @@ static inline void iowrite64(u64 value, volatile void __iomem *addr)
 #endif
 #endif /* CONFIG_64BIT */
 
+#ifdef CONFIG_ARCH_SUPPORTS_INT128
+#ifndef iowrite128
+#define iowrite128 iowrite128
+static inline void iowrite128(u128 value, volatile void __iomem *addr)
+{
+	__io_bw();
+	__raw_write128((u128 __force)__cpu_to_le128(value), addr);
+	__io_aw();
+}
+#endif
+#endif /* CONFIG_ARCH_SUPPORTS_INT128 */
+
 #ifndef ioread16be
 #define ioread16be ioread16be
 static inline u16 ioread16be(const volatile void __iomem *addr)
-- 
2.33.0


