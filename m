Return-Path: <linux-arch+bounces-10425-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21F9A48154
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 15:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CE219C36D0
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 14:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF64A233128;
	Thu, 27 Feb 2025 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM9lzni/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2E1662EF;
	Thu, 27 Feb 2025 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665954; cv=none; b=DpKTGOjEwPWvqEPTnl7WKexJh8zCzwSeZSSd28xYPjtNYs+CUofnEhEurlZFCief+q19zvhV+huxZ7cAMzHhrznXgQuhHNdnsPygELS6hSfjx5VrcANdXEKY4XECjNhRzi+iHwC6+C/za2jMqewGJRi8nwcs+k8gN+PMv0glsak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665954; c=relaxed/simple;
	bh=RLgVlnTpy9CI9sjxADDXsi5z9lnhfW8JBanO63WvXjs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UkhvMSMHhD7/pUcOrQq1nIO2AKh4MRg/IavG84+lk0RsOSKcAuLKVy8jr10rTeuKOGJzH894QoFviuZDxORTvNhGXaNyWFsy9fIrk9B0VAbeVLiAxVpCVlx01T0H8x2oPb+MCwTAYnbVIrqA7y25go6gjpxLtCQRMvNcRb+4Sxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM9lzni/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BFEC4CEE6;
	Thu, 27 Feb 2025 14:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740665954;
	bh=RLgVlnTpy9CI9sjxADDXsi5z9lnhfW8JBanO63WvXjs=;
	h=From:To:Cc:Subject:Date:From;
	b=RM9lzni/OUsu2Lf9dbRHYmCRw7TXPSAfzhY+CH7uUuaEJh57vecuOmRg3n3YwBK4x
	 F5OvaS6i26loyLEAvOQIxJZKhgYBBhu/OhPIU2/R/arhxSzbOPqjxAX4U/TITYSISE
	 OOovpKScaNqbEUNECNhHZoTFebOrTAvefRqj6PA3w3ChH7W0VJI2cwl9Q8WX8Bpd9v
	 j4c6WOwR4YlBC+yMdDSskewdx9WixeQ/8p3xV8YXXRBmofF9W0WmWMhUjlZtKJ/l4/
	 KRC7lbO8s2sUl97aCAo+h12+OQe3kEJjGq3RhNfoRCGOD4N5qYqvu7uwp6LBJym3CV
	 rgX5munMmx6Fg==
From: Arnd Bergmann <arnd@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] asm-generic/io.h: rework split ioread64/iowrite64 helpers
Date: Thu, 27 Feb 2025 15:19:01 +0100
Message-Id: <20250227141910.3819351-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

There are two incompatible sets of definitions of these eight functions:
On 64-bit architectures setting CONFIG_HAS_IOPORT, they turn into
either pair of 32-bit PIO (inl/outl) accesses or a single 64-bit MMIO
(readq/writeq). On other 64-bit architectures, they are always split
into 32-bit accesses.

Depending on which header gets included in a driver, there are
additionally definitions for ioread64()/iowrite64() that are
expected to produce a 64-bit register MMIO access on all 64-bit
architectures.

To separate the conflicting definitions, make the version in
include/linux/io-64-nonatomic-*.h visible on all architectures
but pick the one from lib/iomap.c on architectures that set
CONFIG_GENERIC_IOMAP in place of the default fallback.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/iomap.h           | 36 ++++++------------------
 include/linux/io-64-nonatomic-hi-lo.h | 16 +++++++++++
 include/linux/io-64-nonatomic-lo-hi.h | 16 +++++++++++
 lib/iomap.c                           | 40 +++++++++++++--------------
 4 files changed, 60 insertions(+), 48 deletions(-)

diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 196087a8126e..9f3f25d7fc58 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -31,42 +31,22 @@ extern unsigned int ioread16(const void __iomem *);
 extern unsigned int ioread16be(const void __iomem *);
 extern unsigned int ioread32(const void __iomem *);
 extern unsigned int ioread32be(const void __iomem *);
-#ifdef CONFIG_64BIT
-extern u64 ioread64(const void __iomem *);
-extern u64 ioread64be(const void __iomem *);
-#endif
 
-#ifdef readq
-#define ioread64_lo_hi ioread64_lo_hi
-#define ioread64_hi_lo ioread64_hi_lo
-#define ioread64be_lo_hi ioread64be_lo_hi
-#define ioread64be_hi_lo ioread64be_hi_lo
-extern u64 ioread64_lo_hi(const void __iomem *addr);
-extern u64 ioread64_hi_lo(const void __iomem *addr);
-extern u64 ioread64be_lo_hi(const void __iomem *addr);
-extern u64 ioread64be_hi_lo(const void __iomem *addr);
-#endif
+extern u64 __ioread64_lo_hi(const void __iomem *addr);
+extern u64 __ioread64_hi_lo(const void __iomem *addr);
+extern u64 __ioread64be_lo_hi(const void __iomem *addr);
+extern u64 __ioread64be_hi_lo(const void __iomem *addr);
 
 extern void iowrite8(u8, void __iomem *);
 extern void iowrite16(u16, void __iomem *);
 extern void iowrite16be(u16, void __iomem *);
 extern void iowrite32(u32, void __iomem *);
 extern void iowrite32be(u32, void __iomem *);
-#ifdef CONFIG_64BIT
-extern void iowrite64(u64, void __iomem *);
-extern void iowrite64be(u64, void __iomem *);
-#endif
 
-#ifdef writeq
-#define iowrite64_lo_hi iowrite64_lo_hi
-#define iowrite64_hi_lo iowrite64_hi_lo
-#define iowrite64be_lo_hi iowrite64be_lo_hi
-#define iowrite64be_hi_lo iowrite64be_hi_lo
-extern void iowrite64_lo_hi(u64 val, void __iomem *addr);
-extern void iowrite64_hi_lo(u64 val, void __iomem *addr);
-extern void iowrite64be_lo_hi(u64 val, void __iomem *addr);
-extern void iowrite64be_hi_lo(u64 val, void __iomem *addr);
-#endif
+extern void __iowrite64_lo_hi(u64 val, void __iomem *addr);
+extern void __iowrite64_hi_lo(u64 val, void __iomem *addr);
+extern void __iowrite64be_lo_hi(u64 val, void __iomem *addr);
+extern void __iowrite64be_hi_lo(u64 val, void __iomem *addr);
 
 /*
  * "string" versions of the above. Note that they
diff --git a/include/linux/io-64-nonatomic-hi-lo.h b/include/linux/io-64-nonatomic-hi-lo.h
index f32522bb3aa5..cdb86c8f514c 100644
--- a/include/linux/io-64-nonatomic-hi-lo.h
+++ b/include/linux/io-64-nonatomic-hi-lo.h
@@ -101,22 +101,38 @@ static inline void iowrite64be_hi_lo(u64 val, void __iomem *addr)
 
 #ifndef ioread64
 #define ioread64_is_nonatomic
+#ifdef CONFIG_GENERIC_IOREMAP
+#define ioread64 __ioread64_hi_lo
+#else
 #define ioread64 ioread64_hi_lo
 #endif
+#endif
 
 #ifndef iowrite64
 #define iowrite64_is_nonatomic
+#ifdef CONFIG_GENERIC_IOREMAP
+#define iowrite64 __iowrite64_hi_lo
+#else
 #define iowrite64 iowrite64_hi_lo
 #endif
+#endif
 
 #ifndef ioread64be
 #define ioread64be_is_nonatomic
+#ifdef CONFIG_GENERIC_IOREMAP
+#define ioread64be __ioread64be_hi_lo
+#else
 #define ioread64be ioread64be_hi_lo
 #endif
+#endif
 
 #ifndef iowrite64be
 #define iowrite64be_is_nonatomic
+#ifdef CONFIG_GENERIC_IOREMAP
+#define iowrite64be __iowrite64be_hi_lo
+#else
 #define iowrite64be iowrite64be_hi_lo
 #endif
+#endif
 
 #endif	/* _LINUX_IO_64_NONATOMIC_HI_LO_H_ */
diff --git a/include/linux/io-64-nonatomic-lo-hi.h b/include/linux/io-64-nonatomic-lo-hi.h
index 448a21435dba..c4575e6a44d9 100644
--- a/include/linux/io-64-nonatomic-lo-hi.h
+++ b/include/linux/io-64-nonatomic-lo-hi.h
@@ -101,22 +101,38 @@ static inline void iowrite64be_lo_hi(u64 val, void __iomem *addr)
 
 #ifndef ioread64
 #define ioread64_is_nonatomic
+#ifdef CONFIG_GENERIC_IOREMAP
+#define ioread64 __ioread64_lo_hi
+#else
 #define ioread64 ioread64_lo_hi
 #endif
+#endif
 
 #ifndef iowrite64
 #define iowrite64_is_nonatomic
+#ifdef CONFIG_GENERIC_IOREMAP
+#define iowrite64 __iowrite64_lo_hi
+#else
 #define iowrite64 iowrite64_lo_hi
 #endif
+#endif
 
 #ifndef ioread64be
 #define ioread64be_is_nonatomic
+#ifdef CONFIG_GENERIC_IOREMAP
+#define ioread64be __ioread64be_lo_hi
+#else
 #define ioread64be ioread64be_lo_hi
 #endif
+#endif
 
 #ifndef iowrite64be
 #define iowrite64be_is_nonatomic
+#ifdef CONFIG_GENERIC_IOREMAP
+#define iowrite64be __iowrite64be_lo_hi
+#else
 #define iowrite64be iowrite64be_lo_hi
 #endif
+#endif
 
 #endif	/* _LINUX_IO_64_NONATOMIC_LO_HI_H_ */
diff --git a/lib/iomap.c b/lib/iomap.c
index 4f8b31baa575..a65717cd86f7 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -111,7 +111,7 @@ EXPORT_SYMBOL(ioread16be);
 EXPORT_SYMBOL(ioread32);
 EXPORT_SYMBOL(ioread32be);
 
-#ifdef readq
+#ifdef CONFIG_64BIT
 static u64 pio_read64_lo_hi(unsigned long port)
 {
 	u64 lo, hi;
@@ -153,21 +153,21 @@ static u64 pio_read64be_hi_lo(unsigned long port)
 }
 
 __no_kmsan_checks
-u64 ioread64_lo_hi(const void __iomem *addr)
+u64 __ioread64_lo_hi(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read64_lo_hi(port), return readq(addr));
 	return 0xffffffffffffffffULL;
 }
 
 __no_kmsan_checks
-u64 ioread64_hi_lo(const void __iomem *addr)
+u64 __ioread64_hi_lo(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read64_hi_lo(port), return readq(addr));
 	return 0xffffffffffffffffULL;
 }
 
 __no_kmsan_checks
-u64 ioread64be_lo_hi(const void __iomem *addr)
+u64 __ioread64be_lo_hi(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read64be_lo_hi(port),
 		return mmio_read64be(addr));
@@ -175,19 +175,19 @@ u64 ioread64be_lo_hi(const void __iomem *addr)
 }
 
 __no_kmsan_checks
-u64 ioread64be_hi_lo(const void __iomem *addr)
+u64 __ioread64be_hi_lo(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read64be_hi_lo(port),
 		return mmio_read64be(addr));
 	return 0xffffffffffffffffULL;
 }
 
-EXPORT_SYMBOL(ioread64_lo_hi);
-EXPORT_SYMBOL(ioread64_hi_lo);
-EXPORT_SYMBOL(ioread64be_lo_hi);
-EXPORT_SYMBOL(ioread64be_hi_lo);
+EXPORT_SYMBOL(__ioread64_lo_hi);
+EXPORT_SYMBOL(__ioread64_hi_lo);
+EXPORT_SYMBOL(__ioread64be_lo_hi);
+EXPORT_SYMBOL(__ioread64be_hi_lo);
 
-#endif /* readq */
+#endif /* CONFIG_64BIT */
 
 #ifndef pio_write16be
 #define pio_write16be(val,port) outw(swab16(val),port)
@@ -236,7 +236,7 @@ EXPORT_SYMBOL(iowrite16be);
 EXPORT_SYMBOL(iowrite32);
 EXPORT_SYMBOL(iowrite32be);
 
-#ifdef writeq
+#ifdef CONFIG_64BIT
 static void pio_write64_lo_hi(u64 val, unsigned long port)
 {
 	outl(val, port);
@@ -261,7 +261,7 @@ static void pio_write64be_hi_lo(u64 val, unsigned long port)
 	pio_write32be(val, port + sizeof(u32));
 }
 
-void iowrite64_lo_hi(u64 val, void __iomem *addr)
+void __iowrite64_lo_hi(u64 val, void __iomem *addr)
 {
 	/* Make sure uninitialized memory isn't copied to devices. */
 	kmsan_check_memory(&val, sizeof(val));
@@ -269,7 +269,7 @@ void iowrite64_lo_hi(u64 val, void __iomem *addr)
 		writeq(val, addr));
 }
 
-void iowrite64_hi_lo(u64 val, void __iomem *addr)
+void __iowrite64_hi_lo(u64 val, void __iomem *addr)
 {
 	/* Make sure uninitialized memory isn't copied to devices. */
 	kmsan_check_memory(&val, sizeof(val));
@@ -277,7 +277,7 @@ void iowrite64_hi_lo(u64 val, void __iomem *addr)
 		writeq(val, addr));
 }
 
-void iowrite64be_lo_hi(u64 val, void __iomem *addr)
+void __iowrite64be_lo_hi(u64 val, void __iomem *addr)
 {
 	/* Make sure uninitialized memory isn't copied to devices. */
 	kmsan_check_memory(&val, sizeof(val));
@@ -285,7 +285,7 @@ void iowrite64be_lo_hi(u64 val, void __iomem *addr)
 		mmio_write64be(val, addr));
 }
 
-void iowrite64be_hi_lo(u64 val, void __iomem *addr)
+void __iowrite64be_hi_lo(u64 val, void __iomem *addr)
 {
 	/* Make sure uninitialized memory isn't copied to devices. */
 	kmsan_check_memory(&val, sizeof(val));
@@ -293,12 +293,12 @@ void iowrite64be_hi_lo(u64 val, void __iomem *addr)
 		mmio_write64be(val, addr));
 }
 
-EXPORT_SYMBOL(iowrite64_lo_hi);
-EXPORT_SYMBOL(iowrite64_hi_lo);
-EXPORT_SYMBOL(iowrite64be_lo_hi);
-EXPORT_SYMBOL(iowrite64be_hi_lo);
+EXPORT_SYMBOL(__iowrite64_lo_hi);
+EXPORT_SYMBOL(__iowrite64_hi_lo);
+EXPORT_SYMBOL(__iowrite64be_lo_hi);
+EXPORT_SYMBOL(__iowrite64be_hi_lo);
 
-#endif /* readq */
+#endif /* CONFIG_64BIT */
 
 /*
  * These are the "repeat MMIO read/write" functions.
-- 
2.39.5


