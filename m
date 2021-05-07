Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D39376C40
	for <lists+linux-arch@lfdr.de>; Sat,  8 May 2021 00:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhEGWN2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 May 2021 18:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhEGWNM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 May 2021 18:13:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1899611F1;
        Fri,  7 May 2021 22:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620425532;
        bh=FqcrcrnQ7vkJOY1cqlNt0wE2/7XCp0dNi+B1vOAoXe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tu5VGfAmS38aClM7MeQoVjelDyaKcuF7q4EU11x2d54C65InbIWcE/GFOKv3zmU2e
         ODDZhpr595shOrQalqqlsH9T1SlOGyhEDOJuEeUCqiCUjWXwx4FHby5es/ptnJufJD
         B5xgkGIzu5rJ9+1Iuii2hJkSYZ9Eu67UH7/92WV5/7J3NMkDwG51cOp2OmO+kqK7yk
         dNG78Rq9vDic5fZ0xMg6QXkFDr1rhtSTaQYPZzes2vWIdJgo/kPgDPmW/jIfAA730F
         kwDeAnxNUJjyie/J06Guspm4WSZoygF/J0gnYbdvrz7n2k5DnVMT++nSMcN3vDJOjU
         UndB1/fD5jAkg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [RFC 12/12] asm-generic: simplify asm/unaligned.h
Date:   Sat,  8 May 2021 00:07:57 +0200
Message-Id: <20210507220813.365382-13-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210507220813.365382-1-arnd@kernel.org>
References: <20210507220813.365382-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The get_unaligned()/put_unaligned() implementations are much more complex
than necessary, now that all architectures use the same code.

Move everything into one file and use a much more compact way to express
the same logic.

I've compared the binary output using gcc-11 across defconfig builds for
all architectures and found this patch to make no difference, except for
a single function on powerpc that needs two additional register moves
because of random differences in register allocation.

There are a handful of callers of the low-level __get_unaligned_cpu32,
so leave that in place for the time being even though the common code
no longer uses it.

This adds a warning for any caller of get_unaligned()/put_unaligned()
that passes in a single-byte pointer, but I've sent patches for all
instances that show up in x86 and randconfig builds. It would be nice
to change the arguments of the endian-specific accessors to take the
matching __be16/__be32/__be64/__le16/__le32/__le64 arguments instead of
a void pointer, but that requires more changes to the rest of the kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/unaligned.h     | 138 +++++++++++++++++++++++++---
 include/linux/unaligned/be_struct.h |  67 --------------
 include/linux/unaligned/generic.h   | 115 -----------------------
 include/linux/unaligned/le_struct.h |  67 --------------
 4 files changed, 125 insertions(+), 262 deletions(-)
 delete mode 100644 include/linux/unaligned/be_struct.h
 delete mode 100644 include/linux/unaligned/generic.h
 delete mode 100644 include/linux/unaligned/le_struct.h

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 36bf03aaa674..9ed952fba718 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -6,20 +6,132 @@
  * This is the most generic implementation of unaligned accesses
  * and should work almost anywhere.
  */
+#include <linux/unaligned/packed_struct.h>
 #include <asm/byteorder.h>
 
-#if defined(__LITTLE_ENDIAN)
-# include <linux/unaligned/le_struct.h>
-# include <linux/unaligned/generic.h>
-# define get_unaligned	__get_unaligned_le
-# define put_unaligned	__put_unaligned_le
-#elif defined(__BIG_ENDIAN)
-# include <linux/unaligned/be_struct.h>
-# include <linux/unaligned/generic.h>
-# define get_unaligned	__get_unaligned_be
-# define put_unaligned	__put_unaligned_be
-#else
-# error need to define endianess
-#endif
+#define __get_unaligned_t(type, ptr) ({						\
+	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
+	__pptr->x; 								\
+})
+
+#define get_unaligned(ptr) ({							\
+	__auto_type __ptr = (ptr);						\
+	__get_unaligned_t(typeof(*__ptr), __ptr);				\
+})
+
+#define __put_unaligned_t(type, val, ptr) ({					\
+	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
+	__pptr->x = (val); 							\
+})
+
+#define put_unaligned(val, ptr) do {						\
+	__auto_type __ptr = (ptr);						\
+	__put_unaligned_t(typeof(*__ptr), (val), __ptr);				\
+} while (0)
+
+
+static inline u16 get_unaligned_le16(const void *p)
+{
+	return le16_to_cpu(__get_unaligned_t(__le16, p));
+}
+
+static inline u32 get_unaligned_le32(const void *p)
+{
+	return le32_to_cpu(__get_unaligned_t(__le32, p));
+}
+
+static inline u64 get_unaligned_le64(const void *p)
+{
+	return le64_to_cpu(__get_unaligned_t(__le64, p));
+}
+
+static inline void put_unaligned_le16(u16 val, void *p)
+{
+	__put_unaligned_t(__le16, cpu_to_le16(val), p);
+}
+
+static inline void put_unaligned_le32(u32 val, void *p)
+{
+	__put_unaligned_t(__le32, cpu_to_le32(val), p);
+}
+
+static inline void put_unaligned_le64(u64 val, void *p)
+{
+	__put_unaligned_t(__le64, cpu_to_le64(val), p);
+}
+
+static inline u16 get_unaligned_be16(const void *p)
+{
+	return be16_to_cpu(__get_unaligned_t(__be16, p));
+}
+
+static inline u32 get_unaligned_be32(const void *p)
+{
+	return be32_to_cpu(__get_unaligned_t(__be32, p));
+}
+
+static inline u64 get_unaligned_be64(const void *p)
+{
+	return be64_to_cpu(__get_unaligned_t(__be64, p));
+}
+
+static inline void put_unaligned_be16(u16 val, void *p)
+{
+	__put_unaligned_t(__be16, cpu_to_be16(val), p);
+}
+
+static inline void put_unaligned_be32(u32 val, void *p)
+{
+	__put_unaligned_t(__be32, cpu_to_be32(val), p);
+}
+
+static inline void put_unaligned_be64(u64 val, void *p)
+{
+	__put_unaligned_t(__be64, cpu_to_be64(val), p);
+}
+
+static inline u32 __get_unaligned_be24(const u8 *p)
+{
+	return p[0] << 16 | p[1] << 8 | p[2];
+}
+
+static inline u32 get_unaligned_be24(const void *p)
+{
+	return __get_unaligned_be24(p);
+}
+
+static inline u32 __get_unaligned_le24(const u8 *p)
+{
+	return p[0] | p[1] << 8 | p[2] << 16;
+}
+
+static inline u32 get_unaligned_le24(const void *p)
+{
+	return __get_unaligned_le24(p);
+}
+
+static inline void __put_unaligned_be24(const u32 val, u8 *p)
+{
+	*p++ = val >> 16;
+	*p++ = val >> 8;
+	*p++ = val;
+}
+
+static inline void put_unaligned_be24(const u32 val, void *p)
+{
+	__put_unaligned_be24(val, p);
+}
+
+static inline void __put_unaligned_le24(const u32 val, u8 *p)
+{
+	*p++ = val;
+	*p++ = val >> 8;
+	*p++ = val >> 16;
+}
+
+static inline void put_unaligned_le24(const u32 val, void *p)
+{
+	__put_unaligned_le24(val, p);
+}
 
 #endif /* __ASM_GENERIC_UNALIGNED_H */
diff --git a/include/linux/unaligned/be_struct.h b/include/linux/unaligned/be_struct.h
deleted file mode 100644
index 76d9fe297c33..000000000000
--- a/include/linux/unaligned/be_struct.h
+++ /dev/null
@@ -1,67 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_UNALIGNED_BE_STRUCT_H
-#define _LINUX_UNALIGNED_BE_STRUCT_H
-
-#include <linux/unaligned/packed_struct.h>
-
-static inline u16 get_unaligned_be16(const void *p)
-{
-	return __get_unaligned_cpu16((const u8 *)p);
-}
-
-static inline u32 get_unaligned_be32(const void *p)
-{
-	return __get_unaligned_cpu32((const u8 *)p);
-}
-
-static inline u64 get_unaligned_be64(const void *p)
-{
-	return __get_unaligned_cpu64((const u8 *)p);
-}
-
-static inline void put_unaligned_be16(u16 val, void *p)
-{
-	__put_unaligned_cpu16(val, p);
-}
-
-static inline void put_unaligned_be32(u32 val, void *p)
-{
-	__put_unaligned_cpu32(val, p);
-}
-
-static inline void put_unaligned_be64(u64 val, void *p)
-{
-	__put_unaligned_cpu64(val, p);
-}
-
-static inline u16 get_unaligned_le16(const void *p)
-{
-	return swab16(__get_unaligned_cpu16((const u8 *)p));
-}
-
-static inline u32 get_unaligned_le32(const void *p)
-{
-	return swab32(__get_unaligned_cpu32((const u8 *)p));
-}
-
-static inline u64 get_unaligned_le64(const void *p)
-{
-	return swab64(__get_unaligned_cpu64((const u8 *)p));
-}
-
-static inline void put_unaligned_le16(u16 val, void *p)
-{
-	__put_unaligned_cpu16(swab16(val), p);
-}
-
-static inline void put_unaligned_le32(u32 val, void *p)
-{
-	__put_unaligned_cpu32(swab32(val), p);
-}
-
-static inline void put_unaligned_le64(u64 val, void *p)
-{
-	__put_unaligned_cpu64(swab64(val), p);
-}
-
-#endif /* _LINUX_UNALIGNED_BE_STRUCT_H */
diff --git a/include/linux/unaligned/generic.h b/include/linux/unaligned/generic.h
deleted file mode 100644
index 303289492859..000000000000
--- a/include/linux/unaligned/generic.h
+++ /dev/null
@@ -1,115 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_UNALIGNED_GENERIC_H
-#define _LINUX_UNALIGNED_GENERIC_H
-
-#include <linux/types.h>
-
-/*
- * Cause a link-time error if we try an unaligned access other than
- * 1,2,4 or 8 bytes long
- */
-extern void __bad_unaligned_access_size(void);
-
-#define __get_unaligned_le(ptr) ((__force typeof(*(ptr)))({			\
-	__builtin_choose_expr(sizeof(*(ptr)) == 1, *(ptr),			\
-	__builtin_choose_expr(sizeof(*(ptr)) == 2, get_unaligned_le16((ptr)),	\
-	__builtin_choose_expr(sizeof(*(ptr)) == 4, get_unaligned_le32((ptr)),	\
-	__builtin_choose_expr(sizeof(*(ptr)) == 8, get_unaligned_le64((ptr)),	\
-	__bad_unaligned_access_size()))));					\
-	}))
-
-#define __get_unaligned_be(ptr) ((__force typeof(*(ptr)))({			\
-	__builtin_choose_expr(sizeof(*(ptr)) == 1, *(ptr),			\
-	__builtin_choose_expr(sizeof(*(ptr)) == 2, get_unaligned_be16((ptr)),	\
-	__builtin_choose_expr(sizeof(*(ptr)) == 4, get_unaligned_be32((ptr)),	\
-	__builtin_choose_expr(sizeof(*(ptr)) == 8, get_unaligned_be64((ptr)),	\
-	__bad_unaligned_access_size()))));					\
-	}))
-
-#define __put_unaligned_le(val, ptr) ({					\
-	void *__gu_p = (ptr);						\
-	switch (sizeof(*(ptr))) {					\
-	case 1:								\
-		*(u8 *)__gu_p = (__force u8)(val);			\
-		break;							\
-	case 2:								\
-		put_unaligned_le16((__force u16)(val), __gu_p);		\
-		break;							\
-	case 4:								\
-		put_unaligned_le32((__force u32)(val), __gu_p);		\
-		break;							\
-	case 8:								\
-		put_unaligned_le64((__force u64)(val), __gu_p);		\
-		break;							\
-	default:							\
-		__bad_unaligned_access_size();				\
-		break;							\
-	}								\
-	(void)0; })
-
-#define __put_unaligned_be(val, ptr) ({					\
-	void *__gu_p = (ptr);						\
-	switch (sizeof(*(ptr))) {					\
-	case 1:								\
-		*(u8 *)__gu_p = (__force u8)(val);			\
-		break;							\
-	case 2:								\
-		put_unaligned_be16((__force u16)(val), __gu_p);		\
-		break;							\
-	case 4:								\
-		put_unaligned_be32((__force u32)(val), __gu_p);		\
-		break;							\
-	case 8:								\
-		put_unaligned_be64((__force u64)(val), __gu_p);		\
-		break;							\
-	default:							\
-		__bad_unaligned_access_size();				\
-		break;							\
-	}								\
-	(void)0; })
-
-static inline u32 __get_unaligned_be24(const u8 *p)
-{
-	return p[0] << 16 | p[1] << 8 | p[2];
-}
-
-static inline u32 get_unaligned_be24(const void *p)
-{
-	return __get_unaligned_be24(p);
-}
-
-static inline u32 __get_unaligned_le24(const u8 *p)
-{
-	return p[0] | p[1] << 8 | p[2] << 16;
-}
-
-static inline u32 get_unaligned_le24(const void *p)
-{
-	return __get_unaligned_le24(p);
-}
-
-static inline void __put_unaligned_be24(const u32 val, u8 *p)
-{
-	*p++ = val >> 16;
-	*p++ = val >> 8;
-	*p++ = val;
-}
-
-static inline void put_unaligned_be24(const u32 val, void *p)
-{
-	__put_unaligned_be24(val, p);
-}
-
-static inline void __put_unaligned_le24(const u32 val, u8 *p)
-{
-	*p++ = val;
-	*p++ = val >> 8;
-	*p++ = val >> 16;
-}
-
-static inline void put_unaligned_le24(const u32 val, void *p)
-{
-	__put_unaligned_le24(val, p);
-}
-
-#endif /* _LINUX_UNALIGNED_GENERIC_H */
diff --git a/include/linux/unaligned/le_struct.h b/include/linux/unaligned/le_struct.h
deleted file mode 100644
index 22f90a4afaa5..000000000000
--- a/include/linux/unaligned/le_struct.h
+++ /dev/null
@@ -1,67 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_UNALIGNED_LE_STRUCT_H
-#define _LINUX_UNALIGNED_LE_STRUCT_H
-
-#include <linux/unaligned/packed_struct.h>
-
-static inline u16 get_unaligned_le16(const void *p)
-{
-	return __get_unaligned_cpu16((const u8 *)p);
-}
-
-static inline u32 get_unaligned_le32(const void *p)
-{
-	return __get_unaligned_cpu32((const u8 *)p);
-}
-
-static inline u64 get_unaligned_le64(const void *p)
-{
-	return __get_unaligned_cpu64((const u8 *)p);
-}
-
-static inline void put_unaligned_le16(u16 val, void *p)
-{
-	__put_unaligned_cpu16(val, p);
-}
-
-static inline void put_unaligned_le32(u32 val, void *p)
-{
-	__put_unaligned_cpu32(val, p);
-}
-
-static inline void put_unaligned_le64(u64 val, void *p)
-{
-	__put_unaligned_cpu64(val, p);
-}
-
-static inline u16 get_unaligned_be16(const void *p)
-{
-	return swab16(__get_unaligned_cpu16((const u8 *)p));
-}
-
-static inline u32 get_unaligned_be32(const void *p)
-{
-	return swab32(__get_unaligned_cpu32((const u8 *)p));
-}
-
-static inline u64 get_unaligned_be64(const void *p)
-{
-	return swab64(__get_unaligned_cpu64((const u8 *)p));
-}
-
-static inline void put_unaligned_be16(u16 val, void *p)
-{
-	__put_unaligned_cpu16(swab16(val), p);
-}
-
-static inline void put_unaligned_be32(u32 val, void *p)
-{
-	__put_unaligned_cpu32(swab32(val), p);
-}
-
-static inline void put_unaligned_be64(u64 val, void *p)
-{
-	__put_unaligned_cpu64(swab64(val), p);
-}
-
-#endif /* _LINUX_UNALIGNED_LE_STRUCT_H */
-- 
2.29.2

