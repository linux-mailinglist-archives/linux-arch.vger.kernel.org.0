Return-Path: <linux-arch+bounces-14659-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06748C50449
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 03:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D30C3B38B9
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 01:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A662BE7D5;
	Wed, 12 Nov 2025 01:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PnwF6rmi"
X-Original-To: linux-arch@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32252BE644;
	Wed, 12 Nov 2025 01:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912741; cv=none; b=odO4Aipz6xmlwUfB4cFKlFf8+WqCkaUGA3wARMK20LSzSXZjrSzDIST2cb6O1BpHUnds7MnIY1cmCt4eKhZ1MrNdq1p2lMV9Acw2aXSQ9WBuxkmuQE+SnAyiBo/J8OYDNgmXQ9CsDz08d/0YPNwhz/i9Fcs18PaMwGLn8ZujxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912741; c=relaxed/simple;
	bh=vbriuadhIZV35OxOXbspPmIgK6TNJimrzRg8bMDyo9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F60vNkkmio7/2rsTEoEeQ2Lkmrt+eGwppxJfp/4g73m/AE3KlOCJ4o85T7M0rUTNr3ndYeb26QOfY5HAHx+bvhaRmCwGhTD0JiisGnGAgoZMSCP2ZuqT8vIfMjedNLNd+dyV750OLj4HhvMDbsTPavgjrMR3fMgpDdu5Vx0egMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PnwF6rmi; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tCc5dWx94uDsgm2vFWLxYZQ8XDvd2PR/3FJli510E/M=;
	b=PnwF6rmirMI1fh3F7p/wUuUWStGvuLFd6zVfK8nN4P6HcA+7SBSNB0jxrIrnv+j11ssIUBAYF
	JCK1Dhonicifdg+BDsxdryvRM/CyJ8E1/v8GIHpyghBKi8g0oODdduDplwZSm5805dwgpH9nYsi
	qkBEg6cJAba5qna0I83UhFA=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d5mk675b4znTXd;
	Wed, 12 Nov 2025 09:57:18 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 9890B1A0188;
	Wed, 12 Nov 2025 09:58:50 +0800 (CST)
Received: from kwepemq200001.china.huawei.com (7.202.195.16) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 09:58:50 +0800
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
Subject: [PATCH RFC 3/4] io-128-nonatomic: introduce io{read|write}128_{lo_hi|hi_lo}
Date: Wed, 12 Nov 2025 09:58:45 +0800
Message-ID: <20251112015846.1842207-4-huangchenghai2@huawei.com>
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

In order to provide non-atomic functions for io{read|write}128.
We define a number of variants of these functions in the generic
iomap that will do non-atomic operations.

These functions are only defined if io{read|write}128 are defined.
If they are not, then the wrappers that always use non-atomic operations
from include/linux/io-128-nonatomic*.h will be used.

Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 include/linux/io-128-nonatomic-hi-lo.h | 35 ++++++++++++++++++++++++++
 include/linux/io-128-nonatomic-lo-hi.h | 34 +++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 include/linux/io-128-nonatomic-hi-lo.h
 create mode 100644 include/linux/io-128-nonatomic-lo-hi.h

diff --git a/include/linux/io-128-nonatomic-hi-lo.h b/include/linux/io-128-nonatomic-hi-lo.h
new file mode 100644
index 000000000000..b5b083a9e81b
--- /dev/null
+++ b/include/linux/io-128-nonatomic-hi-lo.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_IO_128_NONATOMIC_HI_LO_H_
+#define _LINUX_IO_128_NONATOMIC_HI_LO_H_
+
+#include <linux/io.h>
+#include <asm-generic/int-ll64.h>
+
+static inline u128 ioread128_hi_lo(const void __iomem *addr)
+{
+	u32 low, high;
+
+	high = ioread64(addr + sizeof(u64));
+	low = ioread64(addr);
+
+	return low + ((u128)high << 64);
+}
+
+static inline void iowrite128_hi_lo(u128 val, void __iomem *addr)
+{
+	iowrite64(val >> 64, addr + sizeof(u64));
+	iowrite64(val, addr);
+}
+
+#ifndef ioread128
+#define ioread128_is_nonatomic
+#define ioread128 ioread128_hi_lo
+#endif
+
+#ifndef iowrite128
+#define iowrite128_is_nonatomic
+#define iowrite128 iowrite128_hi_lo
+#endif
+
+#endif	/* _LINUX_IO_128_NONATOMIC_HI_LO_H_ */
+
diff --git a/include/linux/io-128-nonatomic-lo-hi.h b/include/linux/io-128-nonatomic-lo-hi.h
new file mode 100644
index 000000000000..0448ee5a13de
--- /dev/null
+++ b/include/linux/io-128-nonatomic-lo-hi.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_IO_128_NONATOMIC_LO_HI_H_
+#define _LINUX_IO_128_NONATOMIC_LO_HI_H_
+
+#include <linux/io.h>
+#include <asm-generic/int-ll64.h>
+
+static inline u128 ioread128_lo_hi(const void __iomem *addr)
+{
+	u64 low, high;
+
+	low = ioread64(addr);
+	high = ioread64(addr + sizeof(u64));
+
+	return low + ((u128)high << 64);
+}
+
+static inline void iowrite128_lo_hi(u128 val, void __iomem *addr)
+{
+	iowrite64(val, addr);
+	iowrite64(val >> 64, addr + sizeof(u64));
+}
+
+#ifndef ioread128
+#define ioread128_is_nonatomic
+#define ioread128 ioread128_lo_hi
+#endif
+
+#ifndef iowrite128
+#define iowrite128_is_nonatomic
+#define iowrite128 iowrite128_lo_hi
+#endif
+
+#endif	/* _LINUX_IO_128_NONATOMIC_LO_HI_H_ */
-- 
2.33.0


