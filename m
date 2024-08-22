Return-Path: <linux-arch+bounces-6488-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BD795ACAA
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 06:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B100BB2297E
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 04:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC38364CD;
	Thu, 22 Aug 2024 04:49:11 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9F14D8B0;
	Thu, 22 Aug 2024 04:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724302151; cv=none; b=CS6r/aCGPeOB06sNODCToIYz7bL29Oyh1zZbekRQMmXQEBtlF4IriwS/+ET8pEGVb0FZkXuTlIAM/cYU6+ZkpdkDIpQ1cMJoABy+FZENu4ZoqeI+Myo0h0VVSfcKS6xqD0xkeTJeEWpeS6VgZymfs9hIeScraPdmpVsbGiXJyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724302151; c=relaxed/simple;
	bh=VW33Ac8+jRs555ThuaBraAOAiqzRsYVam8nN8komjlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMGl0hLuZeUzAG6Em9hEUOsusPPPUzPPFzUjtw8Dueku/XRXTNsCMTbBsvGivnLAr+Q7aUTyU/y/H/N2Eb1i2o9XcxWu3qU5wg86FyLOWjywicAuSmVaWn02q2vhr1YfuD+eARVoUMyuLWtx3LZn3Pj2W5xm2WbsSsR6QTDUmWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96285FEC;
	Wed, 21 Aug 2024 21:49:34 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.59.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D818A3F73B;
	Wed, 21 Aug 2024 21:49:05 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-kernel@vger.kernel.org,
	yury.norov@gmail.com,
	arnd@arndb.de
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-arch@vger.kernel.org
Subject: [PATCH V4 1/2] uapi: Define GENMASK_U128
Date: Thu, 22 Aug 2024 10:18:52 +0530
Message-Id: <20240822044853.567386-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822044853.567386-1-anshuman.khandual@arm.com>
References: <20240822044853.567386-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds GENMASK_U128() and __GENMASK_U128() macros using __BITS_PER_U128
and __int128 data types. These macros will be used in providing support for
generating 128 bit masks.

The macros wouldn't work in all assembler flavors for reasons described
in the comments on top of declarations. Enforce it for more by adding
!__ASSEMBLY__ guard.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arnd Bergmann <arnd@arndb.de>>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/bits.h       | 15 +++++++++++++++
 include/uapi/linux/bits.h  |  3 +++
 include/uapi/linux/const.h | 17 +++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 0eb24d21aac2..60044b608817 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -36,4 +36,19 @@
 #define GENMASK_ULL(h, l) \
 	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
 
+#if !defined(__ASSEMBLY__)
+/*
+ * Missing asm support
+ *
+ * __GENMASK_U128() depends on _BIT128() which would not work
+ * in the asm code, as it shifts an 'unsigned __init128' data
+ * type instead of direct representation of 128 bit constants
+ * such as long and unsigned long. The fundamental problem is
+ * that a 128 bit constant will get silently truncated by the
+ * gcc compiler.
+ */
+#define GENMASK_U128(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
+#endif
+
 #endif	/* __LINUX_BITS_H */
diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
index 3c2a101986a3..5ee30f882736 100644
--- a/include/uapi/linux/bits.h
+++ b/include/uapi/linux/bits.h
@@ -12,4 +12,7 @@
         (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
          (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
 
+#define __GENMASK_U128(h, l) \
+	((_BIT128((h)) << 1) - (_BIT128(l)))
+
 #endif /* _UAPI_LINUX_BITS_H */
diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index a429381e7ca5..e16be0d37746 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -28,6 +28,23 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
+#if !defined(__ASSEMBLY__)
+/*
+ * Missing asm support
+ *
+ * __BIT128() would not work in the asm code, as it shifts an
+ * 'unsigned __init128' data type as direct representation of
+ * 128 bit constants is not supported in the gcc compiler, as
+ * they get silently truncated.
+ *
+ * TODO: Please revisit this implementation when gcc compiler
+ * starts representing 128 bit constants directly like long
+ * and unsigned long etc. Subsequently drop the comment for
+ * GENMASK_U128() which would then start supporting asm code.
+ */
+#define _BIT128(x)	((unsigned __int128)(1) << (x))
+#endif
+
 #define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
 #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
 
-- 
2.30.2


