Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC7D3806B6
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 12:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhENKFY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 06:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbhENKFY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 06:05:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FCA6613BC;
        Fri, 14 May 2021 10:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620986653;
        bh=cCVVu+62kA2pXYPTc6FjelykeA3Lz1iR9GcRa0bvZ+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mrb4cX8JGEo6YhS2lWZqeQfpB0XaIgV/M2wRMQPF+XrF/24xEgD1w8712MTzypyh1
         5nwfzFFnMKLsizZaTAqLDmRgF9DHsPJCuq56qOhXyjkJu+f4YoHaaPyjpcE92g8zDW
         KHm4fyhb22gKrnZjv7THODKqSHh42FqpgstOMB3b29ETIS5IaaLqCcrHuVfmIf10x3
         yaDySR/yjWGCuqyMTRColt6PSseJNxdAetcSo3Cz16k/JNhLOaOJowDifZuXQ8q+Zw
         57HdfecvPHAlBPZESMxdkz106d0cdnTQ2ShxgC2aHd+r43vL5A0PYVG4qKR/LpT/44
         Y4BSPjQkndCdw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v2 06/13] asm-generic: unaligned: remove byteshift helpers
Date:   Fri, 14 May 2021 12:00:54 +0200
Message-Id: <20210514100106.3404011-7-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210514100106.3404011-1-arnd@kernel.org>
References: <20210514100106.3404011-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

In theory, compilers should be able to work this out themselves so we
can use a simpler version based on the swab() helpers.

I have verified that this works on all supported compiler versions
(gcc-4.9 and up, clang-10 and up). Looking at the object code produced by
gcc-11, I found that the impact is mostly a change in inlining decisions
that lead to slightly larger code.

In other cases, this version produces explicit byte swaps in place of
separate byte access, or comparing against pre-swapped constants.

While the source code is clearly simpler, I have not seen an indication
of the new version actually producing better code on Arm, so maybe
we want to skip this after all. From what I can tell, gcc recognizes
the byteswap pattern in the byteshift.h header and can turn it into
explicit instructions, but it does not turn a __builtin_bswap32() back
into individual bytes when that would result in better output, e.g.
when storing a byte-reversed constant.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/unaligned.h       |  2 -
 include/asm-generic/unaligned.h        |  2 -
 include/linux/unaligned/be_byteshift.h | 71 --------------------------
 include/linux/unaligned/be_struct.h    | 30 +++++++++++
 include/linux/unaligned/le_byteshift.h | 71 --------------------------
 include/linux/unaligned/le_struct.h    | 30 +++++++++++
 6 files changed, 60 insertions(+), 146 deletions(-)
 delete mode 100644 include/linux/unaligned/be_byteshift.h
 delete mode 100644 include/linux/unaligned/le_byteshift.h

diff --git a/arch/arm/include/asm/unaligned.h b/arch/arm/include/asm/unaligned.h
index ab905ffcf193..3c5248fb4cdc 100644
--- a/arch/arm/include/asm/unaligned.h
+++ b/arch/arm/include/asm/unaligned.h
@@ -10,13 +10,11 @@
 
 #if defined(__LITTLE_ENDIAN)
 # include <linux/unaligned/le_struct.h>
-# include <linux/unaligned/be_byteshift.h>
 # include <linux/unaligned/generic.h>
 # define get_unaligned	__get_unaligned_le
 # define put_unaligned	__put_unaligned_le
 #elif defined(__BIG_ENDIAN)
 # include <linux/unaligned/be_struct.h>
-# include <linux/unaligned/le_byteshift.h>
 # include <linux/unaligned/generic.h>
 # define get_unaligned	__get_unaligned_be
 # define put_unaligned	__put_unaligned_be
diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 374c940e9be1..d79df721ae60 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -16,7 +16,6 @@
 #if defined(__LITTLE_ENDIAN)
 # ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 #  include <linux/unaligned/le_struct.h>
-#  include <linux/unaligned/be_byteshift.h>
 # endif
 # include <linux/unaligned/generic.h>
 # define get_unaligned	__get_unaligned_le
@@ -24,7 +23,6 @@
 #elif defined(__BIG_ENDIAN)
 # ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 #  include <linux/unaligned/be_struct.h>
-#  include <linux/unaligned/le_byteshift.h>
 # endif
 # include <linux/unaligned/generic.h>
 # define get_unaligned	__get_unaligned_be
diff --git a/include/linux/unaligned/be_byteshift.h b/include/linux/unaligned/be_byteshift.h
deleted file mode 100644
index c43ff5918c8a..000000000000
--- a/include/linux/unaligned/be_byteshift.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_UNALIGNED_BE_BYTESHIFT_H
-#define _LINUX_UNALIGNED_BE_BYTESHIFT_H
-
-#include <linux/types.h>
-
-static inline u16 __get_unaligned_be16(const u8 *p)
-{
-	return p[0] << 8 | p[1];
-}
-
-static inline u32 __get_unaligned_be32(const u8 *p)
-{
-	return p[0] << 24 | p[1] << 16 | p[2] << 8 | p[3];
-}
-
-static inline u64 __get_unaligned_be64(const u8 *p)
-{
-	return (u64)__get_unaligned_be32(p) << 32 |
-	       __get_unaligned_be32(p + 4);
-}
-
-static inline void __put_unaligned_be16(u16 val, u8 *p)
-{
-	*p++ = val >> 8;
-	*p++ = val;
-}
-
-static inline void __put_unaligned_be32(u32 val, u8 *p)
-{
-	__put_unaligned_be16(val >> 16, p);
-	__put_unaligned_be16(val, p + 2);
-}
-
-static inline void __put_unaligned_be64(u64 val, u8 *p)
-{
-	__put_unaligned_be32(val >> 32, p);
-	__put_unaligned_be32(val, p + 4);
-}
-
-static inline u16 get_unaligned_be16(const void *p)
-{
-	return __get_unaligned_be16(p);
-}
-
-static inline u32 get_unaligned_be32(const void *p)
-{
-	return __get_unaligned_be32(p);
-}
-
-static inline u64 get_unaligned_be64(const void *p)
-{
-	return __get_unaligned_be64(p);
-}
-
-static inline void put_unaligned_be16(u16 val, void *p)
-{
-	__put_unaligned_be16(val, p);
-}
-
-static inline void put_unaligned_be32(u32 val, void *p)
-{
-	__put_unaligned_be32(val, p);
-}
-
-static inline void put_unaligned_be64(u64 val, void *p)
-{
-	__put_unaligned_be64(val, p);
-}
-
-#endif /* _LINUX_UNALIGNED_BE_BYTESHIFT_H */
diff --git a/include/linux/unaligned/be_struct.h b/include/linux/unaligned/be_struct.h
index 15ea503a13fc..76d9fe297c33 100644
--- a/include/linux/unaligned/be_struct.h
+++ b/include/linux/unaligned/be_struct.h
@@ -34,4 +34,34 @@ static inline void put_unaligned_be64(u64 val, void *p)
 	__put_unaligned_cpu64(val, p);
 }
 
+static inline u16 get_unaligned_le16(const void *p)
+{
+	return swab16(__get_unaligned_cpu16((const u8 *)p));
+}
+
+static inline u32 get_unaligned_le32(const void *p)
+{
+	return swab32(__get_unaligned_cpu32((const u8 *)p));
+}
+
+static inline u64 get_unaligned_le64(const void *p)
+{
+	return swab64(__get_unaligned_cpu64((const u8 *)p));
+}
+
+static inline void put_unaligned_le16(u16 val, void *p)
+{
+	__put_unaligned_cpu16(swab16(val), p);
+}
+
+static inline void put_unaligned_le32(u32 val, void *p)
+{
+	__put_unaligned_cpu32(swab32(val), p);
+}
+
+static inline void put_unaligned_le64(u64 val, void *p)
+{
+	__put_unaligned_cpu64(swab64(val), p);
+}
+
 #endif /* _LINUX_UNALIGNED_BE_STRUCT_H */
diff --git a/include/linux/unaligned/le_byteshift.h b/include/linux/unaligned/le_byteshift.h
deleted file mode 100644
index 2248dcb0df76..000000000000
--- a/include/linux/unaligned/le_byteshift.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_UNALIGNED_LE_BYTESHIFT_H
-#define _LINUX_UNALIGNED_LE_BYTESHIFT_H
-
-#include <linux/types.h>
-
-static inline u16 __get_unaligned_le16(const u8 *p)
-{
-	return p[0] | p[1] << 8;
-}
-
-static inline u32 __get_unaligned_le32(const u8 *p)
-{
-	return p[0] | p[1] << 8 | p[2] << 16 | p[3] << 24;
-}
-
-static inline u64 __get_unaligned_le64(const u8 *p)
-{
-	return (u64)__get_unaligned_le32(p + 4) << 32 |
-	       __get_unaligned_le32(p);
-}
-
-static inline void __put_unaligned_le16(u16 val, u8 *p)
-{
-	*p++ = val;
-	*p++ = val >> 8;
-}
-
-static inline void __put_unaligned_le32(u32 val, u8 *p)
-{
-	__put_unaligned_le16(val >> 16, p + 2);
-	__put_unaligned_le16(val, p);
-}
-
-static inline void __put_unaligned_le64(u64 val, u8 *p)
-{
-	__put_unaligned_le32(val >> 32, p + 4);
-	__put_unaligned_le32(val, p);
-}
-
-static inline u16 get_unaligned_le16(const void *p)
-{
-	return __get_unaligned_le16(p);
-}
-
-static inline u32 get_unaligned_le32(const void *p)
-{
-	return __get_unaligned_le32(p);
-}
-
-static inline u64 get_unaligned_le64(const void *p)
-{
-	return __get_unaligned_le64(p);
-}
-
-static inline void put_unaligned_le16(u16 val, void *p)
-{
-	__put_unaligned_le16(val, p);
-}
-
-static inline void put_unaligned_le32(u32 val, void *p)
-{
-	__put_unaligned_le32(val, p);
-}
-
-static inline void put_unaligned_le64(u64 val, void *p)
-{
-	__put_unaligned_le64(val, p);
-}
-
-#endif /* _LINUX_UNALIGNED_LE_BYTESHIFT_H */
diff --git a/include/linux/unaligned/le_struct.h b/include/linux/unaligned/le_struct.h
index 9977987883a6..22f90a4afaa5 100644
--- a/include/linux/unaligned/le_struct.h
+++ b/include/linux/unaligned/le_struct.h
@@ -34,4 +34,34 @@ static inline void put_unaligned_le64(u64 val, void *p)
 	__put_unaligned_cpu64(val, p);
 }
 
+static inline u16 get_unaligned_be16(const void *p)
+{
+	return swab16(__get_unaligned_cpu16((const u8 *)p));
+}
+
+static inline u32 get_unaligned_be32(const void *p)
+{
+	return swab32(__get_unaligned_cpu32((const u8 *)p));
+}
+
+static inline u64 get_unaligned_be64(const void *p)
+{
+	return swab64(__get_unaligned_cpu64((const u8 *)p));
+}
+
+static inline void put_unaligned_be16(u16 val, void *p)
+{
+	__put_unaligned_cpu16(swab16(val), p);
+}
+
+static inline void put_unaligned_be32(u32 val, void *p)
+{
+	__put_unaligned_cpu32(swab32(val), p);
+}
+
+static inline void put_unaligned_be64(u64 val, void *p)
+{
+	__put_unaligned_cpu64(swab64(val), p);
+}
+
 #endif /* _LINUX_UNALIGNED_LE_STRUCT_H */
-- 
2.29.2

