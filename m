Return-Path: <linux-arch+bounces-14658-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0528FC5043D
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 02:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A038B189B451
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 01:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8246329A9F9;
	Wed, 12 Nov 2025 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="X6AmB1Tg"
X-Original-To: linux-arch@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03992951B3;
	Wed, 12 Nov 2025 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912736; cv=none; b=axFkhy5aByUz7iVoFIJ12uN9QWe+RX81dXqaHbcOTXUrQXYqYc97sDAS3SbtxzIa9BwJp4Dld96NsIQAxvGlT01yV4ggKAXbWgKkcPykYvkhMgYOCP6evM7Ton9HRqZt8rHA85+h8SIeiIl6rA3E1xPmJ27Jd0r/qZMMcPYMKlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912736; c=relaxed/simple;
	bh=tzZa6vtYzmz6G0etazCSQ4lDn5Fz76x4TG1FiuJJ/xA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jca3A8wSsY1HVn+icILgjXW8EG0RkeO7Th4x8bEiRdUswALtQzOuDmV+jqRxn5tdeTLZWrmKKh03n8qOPasNfZFMQBJAdQuJdCYDKwxvjlzusVvrTH3KmuJCaKQf/2qKdSo8eZvT+W1m04a0Z07dqjGIcK+awMzrDX2CfEJUKCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=X6AmB1Tg; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yI+shLkJDKP9R9FfeV7amQ3F21U8McCYPl060RXsF6s=;
	b=X6AmB1TgFNTa6XtAjH1xMk95R+gRIPwso7WvfB00LQM7JQa+5LFCIbkXRJq9/OzVFeyfs2INg
	I10eYgoZNuBnxKDS+KEZC+gHaV1dyhKTI8zw9CBXFptqDB9FIeayEBY5aLLfO2NjrS4MLJYbKml
	riib1ZHqWsETQJUaT4rhGvI=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d5mkG4hQvz1T4Fs;
	Wed, 12 Nov 2025 09:57:26 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 81DFC1400E3;
	Wed, 12 Nov 2025 09:58:49 +0800 (CST)
Received: from kwepemq200001.china.huawei.com (7.202.195.16) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 09:58:49 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemq200001.china.huawei.com (7.202.195.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 09:58:48 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <arnd@arndb.de>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<akpm@linux-foundation.org>, <anshuman.khandual@arm.com>,
	<ryan.roberts@arm.com>, <andriy.shevchenko@linux.intel.com>,
	<herbert@gondor.apana.org.au>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-crypto@vger.kernel.org>, <linux-api@vger.kernel.org>
CC: <fanghao11@huawei.com>, <shenyang39@huawei.com>, <liulongfang@huawei.com>,
	<qianweili@huawei.com>
Subject: [PATCH RFC 1/4] UAPI: Introduce 128-bit types and byteswap operations
Date: Wed, 12 Nov 2025 09:58:43 +0800
Message-ID: <20251112015846.1842207-2-huangchenghai2@huawei.com>
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

Architectures like ARM64 support 128-bit integer types and
operations. This patch adds a generic byte order conversion
interface for 128-bit.

Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 include/uapi/linux/byteorder/big_endian.h    |  6 ++++++
 include/uapi/linux/byteorder/little_endian.h |  6 ++++++
 include/uapi/linux/swab.h                    | 10 ++++++++++
 include/uapi/linux/types.h                   |  3 +++
 4 files changed, 25 insertions(+)

diff --git a/include/uapi/linux/byteorder/big_endian.h b/include/uapi/linux/byteorder/big_endian.h
index 80aa5c41a763..318d51a18f43 100644
--- a/include/uapi/linux/byteorder/big_endian.h
+++ b/include/uapi/linux/byteorder/big_endian.h
@@ -29,6 +29,12 @@
 #define __constant_be32_to_cpu(x) ((__force __u32)(__be32)(x))
 #define __constant_cpu_to_be16(x) ((__force __be16)(__u16)(x))
 #define __constant_be16_to_cpu(x) ((__force __u16)(__be16)(x))
+
+#ifdef __SIZEOF_INT128__
+#define __cpu_to_le128(x) ((__force __le128)__swab128((x)))
+#define __le128_to_cpu(x) __swab128((__force __u128)(__le128)(x))
+#endif
+
 #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
 #define __le64_to_cpu(x) __swab64((__force __u64)(__le64)(x))
 #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
diff --git a/include/uapi/linux/byteorder/little_endian.h b/include/uapi/linux/byteorder/little_endian.h
index cd98982e7523..b2732452b825 100644
--- a/include/uapi/linux/byteorder/little_endian.h
+++ b/include/uapi/linux/byteorder/little_endian.h
@@ -29,6 +29,12 @@
 #define __constant_be32_to_cpu(x) ___constant_swab32((__force __u32)(__be32)(x))
 #define __constant_cpu_to_be16(x) ((__force __be16)___constant_swab16((x)))
 #define __constant_be16_to_cpu(x) ___constant_swab16((__force __u16)(__be16)(x))
+
+#ifdef __SIZEOF_INT128__
+#define __cpu_to_le128(x) ((__force __le128)(__u128)(x))
+#define __le128_to_cpu(x) ((__force __u128)(__le128)(x))
+#endif
+
 #define __cpu_to_le64(x) ((__force __le64)(__u64)(x))
 #define __le64_to_cpu(x) ((__force __u64)(__le64)(x))
 #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
index 01717181339e..7381b9a785ce 100644
--- a/include/uapi/linux/swab.h
+++ b/include/uapi/linux/swab.h
@@ -133,6 +133,16 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
 	__fswab64(x))
 #endif
 
+#ifdef __SIZEOF_INT128__
+static inline __attribute_const__ __u128 __swab128(__u128 val)
+{
+	__u64 h = val >> 64;
+	__u64 l = val;
+
+	return (((__u128)__swab64(l)) << 64) | ((__u128)(__swab64(h)));
+}
+#endif
+
 static __always_inline unsigned long __swab(const unsigned long y)
 {
 #if __BITS_PER_LONG == 64
diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
index 48b933938877..9624ea43cd8a 100644
--- a/include/uapi/linux/types.h
+++ b/include/uapi/linux/types.h
@@ -40,6 +40,9 @@ typedef __u32 __bitwise __be32;
 typedef __u64 __bitwise __le64;
 typedef __u64 __bitwise __be64;
 
+#ifdef __SIZEOF_INT128__
+typedef __u128 __bitwise __le128;
+#endif
 typedef __u16 __bitwise __sum16;
 typedef __u32 __bitwise __wsum;
 
-- 
2.33.0


