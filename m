Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CE1376C19
	for <lists+linux-arch@lfdr.de>; Sat,  8 May 2021 00:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhEGWLC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 May 2021 18:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhEGWLB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 May 2021 18:11:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA01360BD3;
        Fri,  7 May 2021 22:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620425401;
        bh=ply70cY0jwpzAgG2ZDtI4K9UFMyqc3wXGyhmkFaJd+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bpvzGh93+WhQNrBkJLq12wr1Y8ZgyhF7oZGaPtsrVXdaLYNlEY21c4Fyzomx2LqgW
         sO/6FFPHrnjd6GxaO28ITNDTv29pUPs7siTilSh+lKq1lveLnNHKheYM+sKrwOD3am
         L7K/aOImeFkIuDBgs16GeITaFXUMlhk5zxIAHMY7rDOCZRSPDhW04hUt4PF1mkvqiT
         nf+EayBmULXpT8yTOVU+SIjd5wEfrvRWbDRlUuPPsGKwZ4/jt4mVRUQKAnbRincQfs
         kZd9s1hpPPJDHtCur8kHTKwdT7a2vKYEUskeAbl1+TQeDMDre6kycZWFcpd29YQ0aB
         JjYq6nI+iscYQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: [RFC 02/12] openrisc: always use unaligned-struct header
Date:   Sat,  8 May 2021 00:07:47 +0200
Message-Id: <20210507220813.365382-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210507220813.365382-1-arnd@kernel.org>
References: <20210507220813.365382-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

openrisc is the only architecture using the linux/unaligned/*memmove
infrastructure. There is a comment saying that this version is more
efficient, but this was added in 2011 before the openrisc gcc port
was merged upstream.

I checked a couple of files to see what the actual difference is with
the mainline gcc (9.4 and 11.1), and found that the generic header
seems to produce better code now, regardless of the gcc version.

Specifically, the be_memmove leads to allocating a stack slot and
copying the data one byte at a time, then reading the whole word
from the stack:

00000000 <test_get_unaligned_memmove>:
   0:	9c 21 ff f4 	l.addi r1,r1,-12
   4:	d4 01 10 04 	l.sw 4(r1),r2
   8:	8e 63 00 00 	l.lbz r19,0(r3)
   c:	9c 41 00 0c 	l.addi r2,r1,12
  10:	8e 23 00 01 	l.lbz r17,1(r3)
  14:	db e2 9f f4 	l.sb -12(r2),r19
  18:	db e2 8f f5 	l.sb -11(r2),r17
  1c:	8e 63 00 02 	l.lbz r19,2(r3)
  20:	8e 23 00 03 	l.lbz r17,3(r3)
  24:	d4 01 48 08 	l.sw 8(r1),r9
  28:	db e2 9f f6 	l.sb -10(r2),r19
  2c:	db e2 8f f7 	l.sb -9(r2),r17
  30:	85 62 ff f4 	l.lwz r11,-12(r2)
  34:	85 21 00 08 	l.lwz r9,8(r1)
  38:	84 41 00 04 	l.lwz r2,4(r1)
  3c:	44 00 48 00 	l.jr r9
  40:	9c 21 00 0c 	l.addi r1,r1,12

while the be_struct version reads each byte into a register
and does a shift to the right position:

00000000 <test_get_unaligned_struct>:
   0:	9c 21 ff f8 	l.addi r1,r1,-8
   4:	8e 63 00 00 	l.lbz r19,0(r3)
   8:	aa 20 00 18 	l.ori r17,r0,0x18
   c:	e2 73 88 08 	l.sll r19,r19,r17
  10:	8d 63 00 01 	l.lbz r11,1(r3)
  14:	aa 20 00 10 	l.ori r17,r0,0x10
  18:	e1 6b 88 08 	l.sll r11,r11,r17
  1c:	e1 6b 98 04 	l.or r11,r11,r19
  20:	8e 23 00 02 	l.lbz r17,2(r3)
  24:	aa 60 00 08 	l.ori r19,r0,0x8
  28:	e2 31 98 08 	l.sll r17,r17,r19
  2c:	d4 01 10 00 	l.sw 0(r1),r2
  30:	d4 01 48 04 	l.sw 4(r1),r9
  34:	9c 41 00 08 	l.addi r2,r1,8
  38:	e2 31 58 04 	l.or r17,r17,r11
  3c:	8d 63 00 03 	l.lbz r11,3(r3)
  40:	e1 6b 88 04 	l.or r11,r11,r17
  44:	84 41 00 00 	l.lwz r2,0(r1)
  48:	85 21 00 04 	l.lwz r9,4(r1)
  4c:	44 00 48 00 	l.jr r9
  50:	9c 21 00 08 	l.addi r1,r1,8

I don't know how the loads/store perform compared to the shift version
on a particular microarchitecture, but my guess is that the shifts
are better.

In the trivial example, the struct version is a few instructions longer,
but building a whole kernel shows an overall reduction in code size,
presumably because it now has to manage fewer stack slots:

   text	   data	    bss	    dec	    hex	filename
4792010	 181480	  82324	5055814	 4d2546	vmlinux-unaligned-memmove
4790642	 181480	  82324	5054446	 4d1fee	vmlinux-unaligned-struct

Remove the memmove version completely and let openrisc use the same
code as everyone else, as a simplification.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/openrisc/include/asm/unaligned.h | 47 ---------------------------
 include/linux/unaligned/be_memmove.h  | 37 ---------------------
 include/linux/unaligned/le_memmove.h  | 37 ---------------------
 include/linux/unaligned/memmove.h     | 46 --------------------------
 4 files changed, 167 deletions(-)
 delete mode 100644 arch/openrisc/include/asm/unaligned.h
 delete mode 100644 include/linux/unaligned/be_memmove.h
 delete mode 100644 include/linux/unaligned/le_memmove.h
 delete mode 100644 include/linux/unaligned/memmove.h

diff --git a/arch/openrisc/include/asm/unaligned.h b/arch/openrisc/include/asm/unaligned.h
deleted file mode 100644
index 14353f2101f2..000000000000
--- a/arch/openrisc/include/asm/unaligned.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * OpenRISC Linux
- *
- * Linux architectural port borrowing liberally from similar works of
- * others.  All original copyrights apply as per the original source
- * declaration.
- *
- * OpenRISC implementation:
- * Copyright (C) 2003 Matjaz Breskvar <phoenix@bsemi.com>
- * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
- * et al.
- */
-
-#ifndef __ASM_OPENRISC_UNALIGNED_H
-#define __ASM_OPENRISC_UNALIGNED_H
-
-/*
- * This is copied from the generic implementation and the C-struct
- * variant replaced with the memmove variant.  The GCC compiler
- * for the OR32 arch optimizes too aggressively for the C-struct
- * variant to work, so use the memmove variant instead.
- *
- * It may be worth considering implementing the unaligned access
- * exception handler and allowing unaligned accesses (access_ok.h)...
- * not sure if it would be much of a performance win without further
- * investigation.
- */
-#include <asm/byteorder.h>
-
-#if defined(__LITTLE_ENDIAN)
-# include <linux/unaligned/le_memmove.h>
-# include <linux/unaligned/be_byteshift.h>
-# include <linux/unaligned/generic.h>
-# define get_unaligned	__get_unaligned_le
-# define put_unaligned	__put_unaligned_le
-#elif defined(__BIG_ENDIAN)
-# include <linux/unaligned/be_memmove.h>
-# include <linux/unaligned/le_byteshift.h>
-# include <linux/unaligned/generic.h>
-# define get_unaligned	__get_unaligned_be
-# define put_unaligned	__put_unaligned_be
-#else
-# error need to define endianess
-#endif
-
-#endif /* __ASM_OPENRISC_UNALIGNED_H */
diff --git a/include/linux/unaligned/be_memmove.h b/include/linux/unaligned/be_memmove.h
deleted file mode 100644
index 7164214a4ba1..000000000000
--- a/include/linux/unaligned/be_memmove.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_UNALIGNED_BE_MEMMOVE_H
-#define _LINUX_UNALIGNED_BE_MEMMOVE_H
-
-#include <linux/unaligned/memmove.h>
-
-static inline u16 get_unaligned_be16(const void *p)
-{
-	return __get_unaligned_memmove16((const u8 *)p);
-}
-
-static inline u32 get_unaligned_be32(const void *p)
-{
-	return __get_unaligned_memmove32((const u8 *)p);
-}
-
-static inline u64 get_unaligned_be64(const void *p)
-{
-	return __get_unaligned_memmove64((const u8 *)p);
-}
-
-static inline void put_unaligned_be16(u16 val, void *p)
-{
-	__put_unaligned_memmove16(val, p);
-}
-
-static inline void put_unaligned_be32(u32 val, void *p)
-{
-	__put_unaligned_memmove32(val, p);
-}
-
-static inline void put_unaligned_be64(u64 val, void *p)
-{
-	__put_unaligned_memmove64(val, p);
-}
-
-#endif /* _LINUX_UNALIGNED_LE_MEMMOVE_H */
diff --git a/include/linux/unaligned/le_memmove.h b/include/linux/unaligned/le_memmove.h
deleted file mode 100644
index 9202e864d026..000000000000
--- a/include/linux/unaligned/le_memmove.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_UNALIGNED_LE_MEMMOVE_H
-#define _LINUX_UNALIGNED_LE_MEMMOVE_H
-
-#include <linux/unaligned/memmove.h>
-
-static inline u16 get_unaligned_le16(const void *p)
-{
-	return __get_unaligned_memmove16((const u8 *)p);
-}
-
-static inline u32 get_unaligned_le32(const void *p)
-{
-	return __get_unaligned_memmove32((const u8 *)p);
-}
-
-static inline u64 get_unaligned_le64(const void *p)
-{
-	return __get_unaligned_memmove64((const u8 *)p);
-}
-
-static inline void put_unaligned_le16(u16 val, void *p)
-{
-	__put_unaligned_memmove16(val, p);
-}
-
-static inline void put_unaligned_le32(u32 val, void *p)
-{
-	__put_unaligned_memmove32(val, p);
-}
-
-static inline void put_unaligned_le64(u64 val, void *p)
-{
-	__put_unaligned_memmove64(val, p);
-}
-
-#endif /* _LINUX_UNALIGNED_LE_MEMMOVE_H */
diff --git a/include/linux/unaligned/memmove.h b/include/linux/unaligned/memmove.h
deleted file mode 100644
index ac71b53bc6dc..000000000000
--- a/include/linux/unaligned/memmove.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_UNALIGNED_MEMMOVE_H
-#define _LINUX_UNALIGNED_MEMMOVE_H
-
-#include <linux/kernel.h>
-#include <linux/string.h>
-
-/* Use memmove here, so gcc does not insert a __builtin_memcpy. */
-
-static inline u16 __get_unaligned_memmove16(const void *p)
-{
-	u16 tmp;
-	memmove(&tmp, p, 2);
-	return tmp;
-}
-
-static inline u32 __get_unaligned_memmove32(const void *p)
-{
-	u32 tmp;
-	memmove(&tmp, p, 4);
-	return tmp;
-}
-
-static inline u64 __get_unaligned_memmove64(const void *p)
-{
-	u64 tmp;
-	memmove(&tmp, p, 8);
-	return tmp;
-}
-
-static inline void __put_unaligned_memmove16(u16 val, void *p)
-{
-	memmove(p, &val, 2);
-}
-
-static inline void __put_unaligned_memmove32(u32 val, void *p)
-{
-	memmove(p, &val, 4);
-}
-
-static inline void __put_unaligned_memmove64(u64 val, void *p)
-{
-	memmove(p, &val, 8);
-}
-
-#endif /* _LINUX_UNALIGNED_MEMMOVE_H */
-- 
2.29.2

