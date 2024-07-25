Return-Path: <linux-arch+bounces-5625-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 154EE93BC25
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 07:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A58FFB21ACD
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 05:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D162724B29;
	Thu, 25 Jul 2024 05:48:23 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223161CAA2;
	Thu, 25 Jul 2024 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721886503; cv=none; b=JKm1nHQZ/6gDcpwC+QYpDs0Kw7AFCKqazItX2IME4bNANcBcpiTdBIqpaNRtsOqADt+SoqBNLgr7SYKFBUO5UbVslqNtncYhuyPBkvi1s3f6/bNk+XTaGxcHJDLNXvlR13nDnjx1Z0/+1y3I0Vx6jZJYaK8yjpWZa0YuMlNFnjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721886503; c=relaxed/simple;
	bh=A2ty1Yaivv3pm5y7N06ALhLKd7L3sToHpr63zfgUPZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mmLmwYpQZwb0+U46KJtRHAo59S7d2WhpLTcENOiInqr5l3lKnYL7T6sg6HfL+fz3cfngbVXrIn18Trx77sHeO3tV19FlFIJyl/aXqxYQOinXrmC0UP/UG9YHYOVMiraGpEHJWtdkj4Y5tHhtL5nbd/+fxB7jozgtOn9xhAkguR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3DEE1476;
	Wed, 24 Jul 2024 22:48:45 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F8963F5A1;
	Wed, 24 Jul 2024 22:48:17 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-kernel@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH V2 1/2] uapi: Define GENMASK_U128
Date: Thu, 25 Jul 2024 11:18:07 +0530
Message-Id: <20240725054808.286708-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240725054808.286708-1-anshuman.khandual@arm.com>
References: <20240725054808.286708-1-anshuman.khandual@arm.com>
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
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/bits.h                   | 2 ++
 include/uapi/asm-generic/bitsperlong.h | 2 ++
 include/uapi/linux/bits.h              | 3 +++
 include/uapi/linux/const.h             | 1 +
 4 files changed, 8 insertions(+)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 0eb24d21aac2..0a174cce09d2 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -35,5 +35,7 @@
 	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
 #define GENMASK_ULL(h, l) \
 	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
+#define GENMASK_U128(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
 
 #endif	/* __LINUX_BITS_H */
diff --git a/include/uapi/asm-generic/bitsperlong.h b/include/uapi/asm-generic/bitsperlong.h
index fadb3f857f28..6275367b17bb 100644
--- a/include/uapi/asm-generic/bitsperlong.h
+++ b/include/uapi/asm-generic/bitsperlong.h
@@ -28,4 +28,6 @@
 #define __BITS_PER_LONG_LONG 64
 #endif
 
+#define __BITS_PER_U128 128
+
 #endif /* _UAPI__ASM_GENERIC_BITS_PER_LONG */
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
index a429381e7ca5..a0211136dfd8 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -27,6 +27,7 @@
 
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
+#define _BIT128(x)	((unsigned __int128)(1) << (x))
 
 #define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
 #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
-- 
2.30.2


