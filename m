Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3303806AF
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 12:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhENKEd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 06:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232788AbhENKEZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 06:04:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDEF1613BC;
        Fri, 14 May 2021 10:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620986594;
        bh=BxM0a2GIcYUsz3uGmN0mNfbozSdu2tjfSI9QqHdr1O4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FaN8BVmbXcbx5UiBjEKeBlsTMVt3vwEzGf/AMIrt7e8+iH+becJHPlNOueyjTrls7
         PEGg+6UoAQFAH4djhazwUS0Xyps0N5F1oe/cJGcUzNRRRxQr1CzhF60QR2XehJtChI
         mtc3HfsVvSgouIvW+YwM0csiyPD0LGZmjS59k29kQg2h9ESglvETMFhwkWBKQR1oh+
         muAniuKVBIShflrrUZjQavwOnWs5Z/baBFqpzF8JeigiJi7NeG8uvX00+RdOoaQxKx
         bwLqnwjAWpv1Gvb5KqgcbpEaUgB8dilMbVCssTL7R7KNvTZws43tr/xnbtbfEtB1wx
         uGimByU01Q34w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/13] sh: remove unaligned access for sh4a
Date:   Fri, 14 May 2021 12:00:51 +0200
Message-Id: <20210514100106.3404011-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210514100106.3404011-1-arnd@kernel.org>
References: <20210514100106.3404011-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Unlike every other architecture, sh4a uses an inline asm implementation
for get_unaligned(). I have shown that this produces better object
code than the asm-generic version. However, there are very few users of
arch/sh/ overall, and most of those seem to use sh4 rather than sh4a CPU
cores, so it seems not worth keeping the complexity in the architecture
independent code.

Change over to the generic version to allow simplifying that in a
follow-up patch.

If there are sh4a users that want the best performance, it would probably
be best to add support for the movua instruction in gcc itself, as this
would not just help get_unaligned() callers but any code that accesses
a __packed variable in user space or kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/include/asm/unaligned-sh4a.h | 199 ---------------------------
 arch/sh/include/asm/unaligned.h      |  13 --
 2 files changed, 212 deletions(-)
 delete mode 100644 arch/sh/include/asm/unaligned-sh4a.h
 delete mode 100644 arch/sh/include/asm/unaligned.h

diff --git a/arch/sh/include/asm/unaligned-sh4a.h b/arch/sh/include/asm/unaligned-sh4a.h
deleted file mode 100644
index d311f00ed530..000000000000
--- a/arch/sh/include/asm/unaligned-sh4a.h
+++ /dev/null
@@ -1,199 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_SH_UNALIGNED_SH4A_H
-#define __ASM_SH_UNALIGNED_SH4A_H
-
-/*
- * SH-4A has support for unaligned 32-bit loads, and 32-bit loads only.
- * Support for 64-bit accesses are done through shifting and masking
- * relative to the endianness. Unaligned stores are not supported by the
- * instruction encoding, so these continue to use the packed
- * struct.
- *
- * The same note as with the movli.l/movco.l pair applies here, as long
- * as the load is guaranteed to be inlined, nothing else will hook in to
- * r0 and we get the return value for free.
- *
- * NOTE: Due to the fact we require r0 encoding, care should be taken to
- * avoid mixing these heavily with other r0 consumers, such as the atomic
- * ops. Failure to adhere to this can result in the compiler running out
- * of spill registers and blowing up when building at low optimization
- * levels. See http://gcc.gnu.org/bugzilla/show_bug.cgi?id=34777.
- */
-#include <linux/unaligned/packed_struct.h>
-#include <linux/types.h>
-#include <asm/byteorder.h>
-
-static inline u16 sh4a_get_unaligned_cpu16(const u8 *p)
-{
-#ifdef __LITTLE_ENDIAN
-	return p[0] | p[1] << 8;
-#else
-	return p[0] << 8 | p[1];
-#endif
-}
-
-static __always_inline u32 sh4a_get_unaligned_cpu32(const u8 *p)
-{
-	unsigned long unaligned;
-
-	__asm__ __volatile__ (
-		"movua.l	@%1, %0\n\t"
-		 : "=z" (unaligned)
-		 : "r" (p)
-	);
-
-	return unaligned;
-}
-
-/*
- * Even though movua.l supports auto-increment on the read side, it can
- * only store to r0 due to instruction encoding constraints, so just let
- * the compiler sort it out on its own.
- */
-static inline u64 sh4a_get_unaligned_cpu64(const u8 *p)
-{
-#ifdef __LITTLE_ENDIAN
-	return (u64)sh4a_get_unaligned_cpu32(p + 4) << 32 |
-		    sh4a_get_unaligned_cpu32(p);
-#else
-	return (u64)sh4a_get_unaligned_cpu32(p) << 32 |
-		    sh4a_get_unaligned_cpu32(p + 4);
-#endif
-}
-
-static inline u16 get_unaligned_le16(const void *p)
-{
-	return le16_to_cpu(sh4a_get_unaligned_cpu16(p));
-}
-
-static inline u32 get_unaligned_le32(const void *p)
-{
-	return le32_to_cpu(sh4a_get_unaligned_cpu32(p));
-}
-
-static inline u64 get_unaligned_le64(const void *p)
-{
-	return le64_to_cpu(sh4a_get_unaligned_cpu64(p));
-}
-
-static inline u16 get_unaligned_be16(const void *p)
-{
-	return be16_to_cpu(sh4a_get_unaligned_cpu16(p));
-}
-
-static inline u32 get_unaligned_be32(const void *p)
-{
-	return be32_to_cpu(sh4a_get_unaligned_cpu32(p));
-}
-
-static inline u64 get_unaligned_be64(const void *p)
-{
-	return be64_to_cpu(sh4a_get_unaligned_cpu64(p));
-}
-
-static inline void nonnative_put_le16(u16 val, u8 *p)
-{
-	*p++ = val;
-	*p++ = val >> 8;
-}
-
-static inline void nonnative_put_le32(u32 val, u8 *p)
-{
-	nonnative_put_le16(val, p);
-	nonnative_put_le16(val >> 16, p + 2);
-}
-
-static inline void nonnative_put_le64(u64 val, u8 *p)
-{
-	nonnative_put_le32(val, p);
-	nonnative_put_le32(val >> 32, p + 4);
-}
-
-static inline void nonnative_put_be16(u16 val, u8 *p)
-{
-	*p++ = val >> 8;
-	*p++ = val;
-}
-
-static inline void nonnative_put_be32(u32 val, u8 *p)
-{
-	nonnative_put_be16(val >> 16, p);
-	nonnative_put_be16(val, p + 2);
-}
-
-static inline void nonnative_put_be64(u64 val, u8 *p)
-{
-	nonnative_put_be32(val >> 32, p);
-	nonnative_put_be32(val, p + 4);
-}
-
-static inline void put_unaligned_le16(u16 val, void *p)
-{
-#ifdef __LITTLE_ENDIAN
-	__put_unaligned_cpu16(val, p);
-#else
-	nonnative_put_le16(val, p);
-#endif
-}
-
-static inline void put_unaligned_le32(u32 val, void *p)
-{
-#ifdef __LITTLE_ENDIAN
-	__put_unaligned_cpu32(val, p);
-#else
-	nonnative_put_le32(val, p);
-#endif
-}
-
-static inline void put_unaligned_le64(u64 val, void *p)
-{
-#ifdef __LITTLE_ENDIAN
-	__put_unaligned_cpu64(val, p);
-#else
-	nonnative_put_le64(val, p);
-#endif
-}
-
-static inline void put_unaligned_be16(u16 val, void *p)
-{
-#ifdef __BIG_ENDIAN
-	__put_unaligned_cpu16(val, p);
-#else
-	nonnative_put_be16(val, p);
-#endif
-}
-
-static inline void put_unaligned_be32(u32 val, void *p)
-{
-#ifdef __BIG_ENDIAN
-	__put_unaligned_cpu32(val, p);
-#else
-	nonnative_put_be32(val, p);
-#endif
-}
-
-static inline void put_unaligned_be64(u64 val, void *p)
-{
-#ifdef __BIG_ENDIAN
-	__put_unaligned_cpu64(val, p);
-#else
-	nonnative_put_be64(val, p);
-#endif
-}
-
-/*
- * While it's a bit non-obvious, even though the generic le/be wrappers
- * use the __get/put_xxx prefixing, they actually wrap in to the
- * non-prefixed get/put_xxx variants as provided above.
- */
-#include <linux/unaligned/generic.h>
-
-#ifdef __LITTLE_ENDIAN
-# define get_unaligned __get_unaligned_le
-# define put_unaligned __put_unaligned_le
-#else
-# define get_unaligned __get_unaligned_be
-# define put_unaligned __put_unaligned_be
-#endif
-
-#endif /* __ASM_SH_UNALIGNED_SH4A_H */
diff --git a/arch/sh/include/asm/unaligned.h b/arch/sh/include/asm/unaligned.h
deleted file mode 100644
index 0c92e2c73af4..000000000000
--- a/arch/sh/include/asm/unaligned.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_SH_UNALIGNED_H
-#define _ASM_SH_UNALIGNED_H
-
-#ifdef CONFIG_CPU_SH4A
-/* SH-4A can handle unaligned loads in a relatively neutered fashion. */
-#include <asm/unaligned-sh4a.h>
-#else
-/* Otherwise, SH can't handle unaligned accesses. */
-#include <asm-generic/unaligned.h>
-#endif
-
-#endif /* _ASM_SH_UNALIGNED_H */
-- 
2.29.2

