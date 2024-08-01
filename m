Return-Path: <linux-arch+bounces-5832-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6B0944545
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 09:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150D91F21944
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 07:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDA816D9A0;
	Thu,  1 Aug 2024 07:17:05 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926D6158219;
	Thu,  1 Aug 2024 07:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722496625; cv=none; b=Ie2kaepS6Z0SQkmIsEsqf4U7b27o5qav93ugUW0/TDJ1nTIRhsUMDM4cWkpkzFAHm6GPEVbOHvIkfHUzw3K5QGIHuJexvgy/fFM74FDos8GBWs9+XP5FXiyL9Rc7OKru7RLYYCl2VX3laamhnpMdRfLW1v2FqlPwiaueQKfgsxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722496625; c=relaxed/simple;
	bh=zKcECkm8nar+w75DnzuxDPf4ZLyYPifOgs5mMZbvdEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kI2t1VOh86l8DVv3a3jQQxjvxah+/tT+qLPF7ph13xeJBDkFQKbdIhE79Xcei6BnxSXYVb0Eihielim6uPuGucXPTllQAYkEkrMR/4iDiqjLzFFpGsrHjNSFmZGL6fpfi+VWE+hXlfOjFaJlgeHWv/xgsWRYg7jqP4YE0ETqJxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FDC01063;
	Thu,  1 Aug 2024 00:17:28 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.56.112])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B508C3F766;
	Thu,  1 Aug 2024 00:16:59 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-kernel@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	ardb@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH V3 1/2] uapi: Define GENMASK_U128
Date: Thu,  1 Aug 2024 12:46:45 +0530
Message-Id: <20240801071646.682731-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240801071646.682731-1-anshuman.khandual@arm.com>
References: <20240801071646.682731-1-anshuman.khandual@arm.com>
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

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arnd Bergmann <arnd@arndb.de>>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/bits.h       | 13 +++++++++++++
 include/uapi/linux/bits.h  |  3 +++
 include/uapi/linux/const.h | 15 +++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 0eb24d21aac2..bf99feb5570e 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -36,4 +36,17 @@
 #define GENMASK_ULL(h, l) \
 	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
 
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
+
 #endif	/* __LINUX_BITS_H */
diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
index 3c2a101986a3..4d4b7b08003c 100644
--- a/include/uapi/linux/bits.h
+++ b/include/uapi/linux/bits.h
@@ -12,4 +12,7 @@
         (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
          (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
 
+#define __GENMASK_U128(h, l) \
+	((_BIT128((h) + 1)) - (_BIT128(l)))
+
 #endif /* _UAPI_LINUX_BITS_H */
diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index a429381e7ca5..5be12e8f8f9c 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -28,6 +28,21 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
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
+
 #define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
 #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
 
-- 
2.30.2


