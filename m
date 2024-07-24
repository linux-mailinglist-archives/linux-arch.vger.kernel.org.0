Return-Path: <linux-arch+bounces-5606-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9022493AFE1
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 12:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA6A1C223D6
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B48156C69;
	Wed, 24 Jul 2024 10:32:01 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F03156880;
	Wed, 24 Jul 2024 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721817121; cv=none; b=FgmRsUTTqmGNdgNzRntSpkqoLdoqaN9/kuIcMgHtONuOcnv0icb2UjybB+XBA9OaXNncq8Bp2SgcwzXNLvBgER3+CaTyLRdJjqNhbigSKNuWE70Ybf5oGFV+up32tQAoqWLDBLWgARD/vRLi3MPUpA7Kl1YXIuN5kWRAt8Tlx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721817121; c=relaxed/simple;
	bh=lxbwQPlGY7q7BiS2mIARLsQOqtzW/7faPvBzP/7GKw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eh7KpPBldAMkGeu0RD6y3LxOxEufXTVdhGI7iaUd59HxBmOlXtFI13reZallIJI75NksA+UoYN1Wyt/d3bMeZwEyq4xEYYWtO0mi/c2qbEpp0+5wk/LUT16oFhpLYNB2xwEnR10t6nNqCkRwM9eRVoqYofAjkuD1uAG1QfdAkLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 980EA1474;
	Wed, 24 Jul 2024 03:32:23 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.54.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 695FC3F5A1;
	Wed, 24 Jul 2024 03:31:55 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-kernel@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH 1/2] uapi: Define GENMASK_U128
Date: Wed, 24 Jul 2024 16:01:41 +0530
Message-Id: <20240724103142.165693-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724103142.165693-1-anshuman.khandual@arm.com>
References: <20240724103142.165693-1-anshuman.khandual@arm.com>
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
 include/uapi/asm-generic/bitsperlong.h | 4 ++++
 include/uapi/linux/bits.h              | 4 ++++
 include/uapi/linux/const.h             | 3 +++
 4 files changed, 13 insertions(+)

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
index fadb3f857f28..a2c425455b2f 100644
--- a/include/uapi/asm-generic/bitsperlong.h
+++ b/include/uapi/asm-generic/bitsperlong.h
@@ -28,4 +28,8 @@
 #define __BITS_PER_LONG_LONG 64
 #endif
 
+#ifndef __BITS_PER_U128
+#define __BITS_PER_U128 128
+#endif
+
 #endif /* _UAPI__ASM_GENERIC_BITS_PER_LONG */
diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
index 3c2a101986a3..780cf99b8e6e 100644
--- a/include/uapi/linux/bits.h
+++ b/include/uapi/linux/bits.h
@@ -12,4 +12,8 @@
         (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
          (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
 
+#define __GENMASK_U128(h, l) \
+	(((~_U128(0)) - (_U128(1) << (l)) + 1) & \
+	 (~_U128(0) >> (__BITS_PER_U128 - 1 - (h))))
+
 #endif /* _UAPI_LINUX_BITS_H */
diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index a429381e7ca5..e7d9189e6630 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -16,14 +16,17 @@
 #ifdef __ASSEMBLY__
 #define _AC(X,Y)	X
 #define _AT(T,X)	X
+#define _AC128(X)	X
 #else
 #define __AC(X,Y)	(X##Y)
 #define _AC(X,Y)	__AC(X,Y)
 #define _AT(T,X)	((T)(X))
+#define _AC128(X)	((unsigned __int128)(X))
 #endif
 
 #define _UL(x)		(_AC(x, UL))
 #define _ULL(x)		(_AC(x, ULL))
+#define _U128(x)	(_AC128(x))
 
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
-- 
2.30.2


