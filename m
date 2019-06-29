Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92E4C5A926
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jun 2019 07:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfF2Fgy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jun 2019 01:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfF2Fgy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Jun 2019 01:36:54 -0400
Received: from guoren-Inspiron-7460.lan (89.208.247.74.16clouds.com [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 238102083B;
        Sat, 29 Jun 2019 05:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561786612;
        bh=nWkNnySjk8uiQ4+sR+iUY1m8BN1b2X+fpHxmzuIgc3k=;
        h=From:To:Cc:Subject:Date:From;
        b=HBAhUROqB8Y664ggn8hHUtbLbW5hYzeeJTmH3gVYuMct6B9Vt/6pYyh0q3FS198qk
         67AYJW5zRBnizIbCNCY9YpM+2HDbbrAZZlm8VT/jTSr8GvF6284nINiYTuS5Ix9LDG
         nmieJizXB0DUTYQ4QFE52ahKM3A+JBIgvRhUWy5Q=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH] csky: Improve abiv1 mem ops performance with glibc codes
Date:   Sat, 29 Jun 2019 13:36:41 +0800
Message-Id: <1561786601-19512-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

These codes are copied from glibc/string directory, they are the generic
implementation for string operations. We may further optimize them with
assembly code in the future.

In fact these code isn't tested enough for kernel, but we've tested them
on glibc and it seems good. We just trust them :)

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/abiv1/Makefile         |   6 +
 arch/csky/abiv1/inc/abi/string.h |  15 ++
 arch/csky/abiv1/memcmp.c         | 310 ++++++++++++++++++++++++++++++
 arch/csky/abiv1/memcopy.h        | 179 ++++++++++++++++++
 arch/csky/abiv1/memmove.c        |  93 +++++++++
 arch/csky/abiv1/memset.c         |  71 +++++++
 arch/csky/abiv1/strcpy.c         |  17 ++
 arch/csky/abiv1/strksyms.c       |   5 +
 arch/csky/abiv1/strlen.c         |  89 +++++++++
 arch/csky/abiv1/wordcopy.c       | 397 +++++++++++++++++++++++++++++++++++++++
 10 files changed, 1182 insertions(+)
 create mode 100644 arch/csky/abiv1/memcmp.c
 create mode 100644 arch/csky/abiv1/memcopy.h
 create mode 100644 arch/csky/abiv1/memmove.c
 create mode 100644 arch/csky/abiv1/memset.c
 create mode 100644 arch/csky/abiv1/strcpy.c
 create mode 100644 arch/csky/abiv1/strlen.c
 create mode 100644 arch/csky/abiv1/wordcopy.c

diff --git a/arch/csky/abiv1/Makefile b/arch/csky/abiv1/Makefile
index b8a7c2a..60b60fe 100644
--- a/arch/csky/abiv1/Makefile
+++ b/arch/csky/abiv1/Makefile
@@ -5,3 +5,9 @@ obj-y					+= cacheflush.o
 obj-y					+= mmap.o
 obj-y					+= memcpy.o
 obj-y					+= strksyms.o
+obj-y					+= memcmp.o
+obj-y					+= memset.o
+obj-y					+= memmove.o
+obj-y					+= strcpy.o
+obj-y					+= strlen.o
+obj-y					+= wordcopy.o
diff --git a/arch/csky/abiv1/inc/abi/string.h b/arch/csky/abiv1/inc/abi/string.h
index 0cd4338..a62d7a0 100644
--- a/arch/csky/abiv1/inc/abi/string.h
+++ b/arch/csky/abiv1/inc/abi/string.h
@@ -4,7 +4,22 @@
 #ifndef __ABI_CSKY_STRING_H
 #define __ABI_CSKY_STRING_H
 
+#define __HAVE_ARCH_MEMCMP
+extern int memcmp(const void *, const void *, __kernel_size_t);
+
 #define __HAVE_ARCH_MEMCPY
 extern void *memcpy(void *, const void *, __kernel_size_t);
 
+#define __HAVE_ARCH_MEMMOVE
+extern void *memmove(void *, const void *, __kernel_size_t);
+
+#define __HAVE_ARCH_MEMSET
+extern void *memset(void *, int,  __kernel_size_t);
+
+#define __HAVE_ARCH_STRCPY
+extern char *strcpy(char *, const char *);
+
+#define __HAVE_ARCH_STRLEN
+extern __kernel_size_t strlen(const char *);
+
 #endif /* __ABI_CSKY_STRING_H */
diff --git a/arch/csky/abiv1/memcmp.c b/arch/csky/abiv1/memcmp.c
new file mode 100644
index 0000000..766c5f5
--- /dev/null
+++ b/arch/csky/abiv1/memcmp.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 1991-2018 Free Software Foundation, Inc.
+
+#include "memcopy.h"
+
+#undef memcmp
+
+#ifndef MEMCMP
+# define MEMCMP memcmp
+#endif
+
+# define __THROW
+
+# ifndef WORDS_BIGENDIAN
+#  define MERGE(w0, sh_1, w1, sh_2) (((w0) >> (sh_1)) | ((w1) << (sh_2)))
+# else
+#  define MERGE(w0, sh_1, w1, sh_2) (((w0) << (sh_1)) | ((w1) >> (sh_2)))
+# endif
+
+#ifdef WORDS_BIGENDIAN
+# define CMP_LT_OR_GT(a, b) ((a) > (b) ? 1 : -1)
+#else
+# define CMP_LT_OR_GT(a, b) memcmp_bytes ((a), (b))
+#endif
+
+/* BE VERY CAREFUL IF YOU CHANGE THIS CODE!  */
+
+/* The strategy of this memcmp is:
+
+   1. Compare bytes until one of the block pointers is aligned.
+
+   2. Compare using memcmp_common_alignment or
+      memcmp_not_common_alignment, regarding the alignment of the other
+      block after the initial byte operations.  The maximum number of
+      full words (of type op_t) are compared in this way.
+
+   3. Compare the few remaining bytes.  */
+
+#ifndef WORDS_BIGENDIAN
+/* memcmp_bytes -- Compare A and B bytewise in the byte order of the machine.
+   A and B are known to be different.
+   This is needed only on little-endian machines.  */
+
+static int memcmp_bytes (op_t, op_t) __THROW;
+
+static int
+memcmp_bytes (op_t a, op_t b)
+{
+  long int srcp1 = (long int) &a;
+  long int srcp2 = (long int) &b;
+  op_t a0, b0;
+
+  do
+    {
+      a0 = ((byte *) srcp1)[0];
+      b0 = ((byte *) srcp2)[0];
+      srcp1 += 1;
+      srcp2 += 1;
+    }
+  while (a0 == b0);
+  return a0 - b0;
+}
+#endif
+
+static int memcmp_common_alignment (long, long, size_t) __THROW;
+
+/* memcmp_common_alignment -- Compare blocks at SRCP1 and SRCP2 with LEN `op_t'
+   objects (not LEN bytes!).  Both SRCP1 and SRCP2 should be aligned for
+   memory operations on `op_t's.  */
+static int
+memcmp_common_alignment (long int srcp1, long int srcp2, size_t len)
+{
+  op_t a0, a1;
+  op_t b0, b1;
+
+  switch (len % 4)
+    {
+    default: /* Avoid warning about uninitialized local variables.  */
+    case 2:
+      a0 = ((op_t *) srcp1)[0];
+      b0 = ((op_t *) srcp2)[0];
+      srcp1 -= 2 * OPSIZ;
+      srcp2 -= 2 * OPSIZ;
+      len += 2;
+      goto do1;
+    case 3:
+      a1 = ((op_t *) srcp1)[0];
+      b1 = ((op_t *) srcp2)[0];
+      srcp1 -= OPSIZ;
+      srcp2 -= OPSIZ;
+      len += 1;
+      goto do2;
+    case 0:
+      if (OP_T_THRES <= 3 * OPSIZ && len == 0)
+	return 0;
+      a0 = ((op_t *) srcp1)[0];
+      b0 = ((op_t *) srcp2)[0];
+      goto do3;
+    case 1:
+      a1 = ((op_t *) srcp1)[0];
+      b1 = ((op_t *) srcp2)[0];
+      srcp1 += OPSIZ;
+      srcp2 += OPSIZ;
+      len -= 1;
+      if (OP_T_THRES <= 3 * OPSIZ && len == 0)
+	goto do0;
+      /* Fall through.  */
+    }
+
+  do
+    {
+      a0 = ((op_t *) srcp1)[0];
+      b0 = ((op_t *) srcp2)[0];
+      if (a1 != b1)
+	return CMP_LT_OR_GT (a1, b1);
+
+    do3:
+      a1 = ((op_t *) srcp1)[1];
+      b1 = ((op_t *) srcp2)[1];
+      if (a0 != b0)
+	return CMP_LT_OR_GT (a0, b0);
+
+    do2:
+      a0 = ((op_t *) srcp1)[2];
+      b0 = ((op_t *) srcp2)[2];
+      if (a1 != b1)
+	return CMP_LT_OR_GT (a1, b1);
+
+    do1:
+      a1 = ((op_t *) srcp1)[3];
+      b1 = ((op_t *) srcp2)[3];
+      if (a0 != b0)
+	return CMP_LT_OR_GT (a0, b0);
+
+      srcp1 += 4 * OPSIZ;
+      srcp2 += 4 * OPSIZ;
+      len -= 4;
+    }
+  while (len != 0);
+
+  /* This is the right position for do0.  Please don't move
+     it into the loop.  */
+ do0:
+  if (a1 != b1)
+    return CMP_LT_OR_GT (a1, b1);
+  return 0;
+}
+
+static int memcmp_not_common_alignment (long, long, size_t) __THROW;
+
+/* memcmp_not_common_alignment -- Compare blocks at SRCP1 and SRCP2 with LEN
+   `op_t' objects (not LEN bytes!).  SRCP2 should be aligned for memory
+   operations on `op_t', but SRCP1 *should be unaligned*.  */
+static int
+memcmp_not_common_alignment (long int srcp1, long int srcp2, size_t len)
+{
+  op_t a0, a1, a2, a3;
+  op_t b0, b1, b2, b3;
+  op_t x;
+  int shl, shr;
+
+  /* Calculate how to shift a word read at the memory operation
+     aligned srcp1 to make it aligned for comparison.  */
+
+  shl = 8 * (srcp1 % OPSIZ);
+  shr = 8 * OPSIZ - shl;
+
+  /* Make SRCP1 aligned by rounding it down to the beginning of the `op_t'
+     it points in the middle of.  */
+  srcp1 &= -OPSIZ;
+
+  switch (len % 4)
+    {
+    default: /* Avoid warning about uninitialized local variables.  */
+    case 2:
+      a1 = ((op_t *) srcp1)[0];
+      a2 = ((op_t *) srcp1)[1];
+      b2 = ((op_t *) srcp2)[0];
+      srcp1 -= 1 * OPSIZ;
+      srcp2 -= 2 * OPSIZ;
+      len += 2;
+      goto do1;
+    case 3:
+      a0 = ((op_t *) srcp1)[0];
+      a1 = ((op_t *) srcp1)[1];
+      b1 = ((op_t *) srcp2)[0];
+      srcp2 -= 1 * OPSIZ;
+      len += 1;
+      goto do2;
+    case 0:
+      if (OP_T_THRES <= 3 * OPSIZ && len == 0)
+	return 0;
+      a3 = ((op_t *) srcp1)[0];
+      a0 = ((op_t *) srcp1)[1];
+      b0 = ((op_t *) srcp2)[0];
+      srcp1 += 1 * OPSIZ;
+      goto do3;
+    case 1:
+      a2 = ((op_t *) srcp1)[0];
+      a3 = ((op_t *) srcp1)[1];
+      b3 = ((op_t *) srcp2)[0];
+      srcp1 += 2 * OPSIZ;
+      srcp2 += 1 * OPSIZ;
+      len -= 1;
+      if (OP_T_THRES <= 3 * OPSIZ && len == 0)
+	goto do0;
+      /* Fall through.  */
+    }
+
+  do
+    {
+      a0 = ((op_t *) srcp1)[0];
+      b0 = ((op_t *) srcp2)[0];
+      x = MERGE(a2, shl, a3, shr);
+      if (x != b3)
+	return CMP_LT_OR_GT (x, b3);
+
+    do3:
+      a1 = ((op_t *) srcp1)[1];
+      b1 = ((op_t *) srcp2)[1];
+      x = MERGE(a3, shl, a0, shr);
+      if (x != b0)
+	return CMP_LT_OR_GT (x, b0);
+
+    do2:
+      a2 = ((op_t *) srcp1)[2];
+      b2 = ((op_t *) srcp2)[2];
+      x = MERGE(a0, shl, a1, shr);
+      if (x != b1)
+	return CMP_LT_OR_GT (x, b1);
+
+    do1:
+      a3 = ((op_t *) srcp1)[3];
+      b3 = ((op_t *) srcp2)[3];
+      x = MERGE(a1, shl, a2, shr);
+      if (x != b2)
+	return CMP_LT_OR_GT (x, b2);
+
+      srcp1 += 4 * OPSIZ;
+      srcp2 += 4 * OPSIZ;
+      len -= 4;
+    }
+  while (len != 0);
+
+  /* This is the right position for do0.  Please don't move
+     it into the loop.  */
+ do0:
+  x = MERGE(a2, shl, a3, shr);
+  if (x != b3)
+    return CMP_LT_OR_GT (x, b3);
+  return 0;
+}
+
+int
+MEMCMP (const void *s1, const void *s2, size_t len)
+{
+  op_t a0;
+  op_t b0;
+  long int srcp1 = (long int) s1;
+  long int srcp2 = (long int) s2;
+  op_t res;
+
+  if (len >= OP_T_THRES)
+    {
+      /* There are at least some bytes to compare.  No need to test
+	 for LEN == 0 in this alignment loop.  */
+      while (srcp2 % OPSIZ != 0)
+	{
+	  a0 = ((byte *) srcp1)[0];
+	  b0 = ((byte *) srcp2)[0];
+	  srcp1 += 1;
+	  srcp2 += 1;
+	  res = a0 - b0;
+	  if (res != 0)
+	    return res;
+	  len -= 1;
+	}
+
+      /* SRCP2 is now aligned for memory operations on `op_t'.
+	 SRCP1 alignment determines if we can do a simple,
+	 aligned compare or need to shuffle bits.  */
+
+      if (srcp1 % OPSIZ == 0)
+	res = memcmp_common_alignment (srcp1, srcp2, len / OPSIZ);
+      else
+	res = memcmp_not_common_alignment (srcp1, srcp2, len / OPSIZ);
+      if (res != 0)
+	return res;
+
+      /* Number of bytes remaining in the interval [0..OPSIZ-1].  */
+      srcp1 += len & -OPSIZ;
+      srcp2 += len & -OPSIZ;
+      len %= OPSIZ;
+    }
+
+  /* There are just a few bytes to compare.  Use byte memory operations.  */
+  while (len != 0)
+    {
+      a0 = ((byte *) srcp1)[0];
+      b0 = ((byte *) srcp2)[0];
+      srcp1 += 1;
+      srcp2 += 1;
+      res = a0 - b0;
+      if (res != 0)
+	return res;
+      len -= 1;
+    }
+
+  return 0;
+}
diff --git a/arch/csky/abiv1/memcopy.h b/arch/csky/abiv1/memcopy.h
new file mode 100644
index 0000000..bd6ec90
--- /dev/null
+++ b/arch/csky/abiv1/memcopy.h
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 1991-2018 Free Software Foundation, Inc.
+
+#ifndef _MEMCOPY_H
+#define _MEMCOPY_H	1
+
+/* The strategy of the memory functions is:
+
+     1. Copy bytes until the destination pointer is aligned.
+
+     2. Copy words in unrolled loops.  If the source and destination
+     are not aligned in the same way, use word memory operations,
+     but shift and merge two read words before writing.
+
+     3. Copy the few remaining bytes.
+
+   This is fast on processors that have at least 10 registers for
+   allocation by GCC, and that can access memory at reg+const in one
+   instruction.
+
+   I made an "exhaustive" test of this memmove when I wrote it,
+   exhaustive in the sense that I tried all alignment and length
+   combinations, with and without overlap.  */
+
+#include <linux/types.h>
+#include <linux/bug.h>
+#include <abi/string.h>
+
+/* The macros defined in this file are:
+
+   BYTE_COPY_FWD(dst_beg_ptr, src_beg_ptr, nbytes_to_copy)
+
+   BYTE_COPY_BWD(dst_end_ptr, src_end_ptr, nbytes_to_copy)
+
+   WORD_COPY_FWD(dst_beg_ptr, src_beg_ptr, nbytes_remaining, nbytes_to_copy)
+
+   WORD_COPY_BWD(dst_end_ptr, src_end_ptr, nbytes_remaining, nbytes_to_copy)
+
+   MERGE(old_word, sh_1, new_word, sh_2)
+     [I fail to understand.  I feel stupid.  --roland]
+*/
+
+/* Type to use for aligned memory operations.
+   This should normally be the biggest type supported by a single load
+   and store.  */
+#define	op_t	unsigned long int
+#define OPSIZ	(sizeof(op_t))
+
+/* Type to use for unaligned operations.  */
+typedef unsigned char byte;
+
+#define MERGE(w0, sh_1, w1, sh_2) (((w0) >> (sh_1)) | ((w1) << (sh_2)))
+
+/* Copy exactly NBYTES bytes from SRC_BP to DST_BP,
+   without any assumptions about alignment of the pointers.  */
+#define BYTE_COPY_FWD(dst_bp, src_bp, nbytes)				      \
+  do									      \
+    {									      \
+      size_t __nbytes = (nbytes);					      \
+      while (__nbytes > 0)						      \
+	{								      \
+	  byte __x = ((byte *) src_bp)[0];				      \
+	  src_bp += 1;							      \
+	  __nbytes -= 1;						      \
+	  ((byte *) dst_bp)[0] = __x;					      \
+	  dst_bp += 1;							      \
+	}								      \
+    } while (0)
+
+/* Copy exactly NBYTES_TO_COPY bytes from SRC_END_PTR to DST_END_PTR,
+   beginning at the bytes right before the pointers and continuing towards
+   smaller addresses.  Don't assume anything about alignment of the
+   pointers.  */
+#define BYTE_COPY_BWD(dst_ep, src_ep, nbytes)				      \
+  do									      \
+    {									      \
+      size_t __nbytes = (nbytes);					      \
+      while (__nbytes > 0)						      \
+	{								      \
+	  byte __x;							      \
+	  src_ep -= 1;							      \
+	  __x = ((byte *) src_ep)[0];					      \
+	  dst_ep -= 1;							      \
+	  __nbytes -= 1;						      \
+	  ((byte *) dst_ep)[0] = __x;					      \
+	}								      \
+    } while (0)
+
+/* Copy *up to* NBYTES bytes from SRC_BP to DST_BP, with
+   the assumption that DST_BP is aligned on an OPSIZ multiple.  If
+   not all bytes could be easily copied, store remaining number of bytes
+   in NBYTES_LEFT, otherwise store 0.  */
+extern void _wordcopy_fwd_aligned (long int, long int, size_t);
+extern void _wordcopy_fwd_dest_aligned (long int, long int, size_t);
+#define WORD_COPY_FWD(dst_bp, src_bp, nbytes_left, nbytes)		      \
+  do									      \
+    {									      \
+      if (src_bp % OPSIZ == 0)						      \
+	_wordcopy_fwd_aligned (dst_bp, src_bp, (nbytes) / OPSIZ);	      \
+      else								      \
+	_wordcopy_fwd_dest_aligned (dst_bp, src_bp, (nbytes) / OPSIZ);	      \
+      src_bp += (nbytes) & -OPSIZ;					      \
+      dst_bp += (nbytes) & -OPSIZ;					      \
+      (nbytes_left) = (nbytes) % OPSIZ;					      \
+    } while (0)
+
+/* Copy *up to* NBYTES_TO_COPY bytes from SRC_END_PTR to DST_END_PTR,
+   beginning at the words (of type op_t) right before the pointers and
+   continuing towards smaller addresses.  May take advantage of that
+   DST_END_PTR is aligned on an OPSIZ multiple.  If not all bytes could be
+   easily copied, store remaining number of bytes in NBYTES_REMAINING,
+   otherwise store 0.  */
+extern void _wordcopy_bwd_aligned (long int, long int, size_t);
+extern void _wordcopy_bwd_dest_aligned (long int, long int, size_t);
+#define WORD_COPY_BWD(dst_ep, src_ep, nbytes_left, nbytes)		      \
+  do									      \
+    {									      \
+      if (src_ep % OPSIZ == 0)						      \
+	_wordcopy_bwd_aligned (dst_ep, src_ep, (nbytes) / OPSIZ);	      \
+      else								      \
+	_wordcopy_bwd_dest_aligned (dst_ep, src_ep, (nbytes) / OPSIZ);	      \
+      src_ep -= (nbytes) & -OPSIZ;					      \
+      dst_ep -= (nbytes) & -OPSIZ;					      \
+      (nbytes_left) = (nbytes) % OPSIZ;					      \
+    } while (0)
+
+#define PAGE_COPY_THRESHOLD 0
+
+/* The macro PAGE_COPY_FWD_MAYBE (dstp, srcp, nbytes_left, nbytes) is invoked
+   like WORD_COPY_FWD et al.  The pointers should be at least word aligned.
+   This will check if virtual copying by pages can and should be done and do it
+   if so.  The pointers will be aligned to PAGE_SIZE bytes.  The macro requires
+   that pagecopy.h defines at least PAGE_COPY_THRESHOLD to 0.  If
+   PAGE_COPY_THRESHOLD is non-zero, the header must also define PAGE_COPY_FWD
+   and PAGE_SIZE.
+*/
+#if PAGE_COPY_THRESHOLD
+
+# include <assert.h>
+
+# define PAGE_COPY_FWD_MAYBE(dstp, srcp, nbytes_left, nbytes)		      \
+  do									      \
+    {									      \
+      if ((nbytes) >= PAGE_COPY_THRESHOLD &&				      \
+	  PAGE_OFFSET ((dstp) - (srcp)) == 0) 				      \
+	{								      \
+	  /* The amount to copy is past the threshold for copying	      \
+	     pages virtually with kernel VM operations, and the		      \
+	     source and destination addresses have the same alignment.  */    \
+	  size_t nbytes_before = PAGE_OFFSET (-(dstp));			      \
+	  if (nbytes_before != 0)					      \
+	    {								      \
+	      /* First copy the words before the first page boundary.  */     \
+	      WORD_COPY_FWD (dstp, srcp, nbytes_left, nbytes_before);	      \
+	      assert (nbytes_left == 0);				      \
+	      nbytes -= nbytes_before;					      \
+	    }								      \
+	  PAGE_COPY_FWD (dstp, srcp, nbytes_left, nbytes);		      \
+	}								      \
+    } while (0)
+
+/* The page size is always a power of two, so we can avoid modulo division.  */
+# define PAGE_OFFSET(n)	((n) & (PAGE_SIZE - 1))
+
+#else
+
+# define PAGE_COPY_FWD_MAYBE(dstp, srcp, nbytes_left, nbytes) /* nada */
+
+#endif
+
+/* Threshold value for when to enter the unrolled loops.  */
+#define	OP_T_THRES	16
+
+/* Set to 1 if memcpy is safe to use for forward-copying memmove with
+   overlapping addresses.  This is 0 by default because memcpy implementations
+   are generally not safe for overlapping addresses.  */
+#define MEMCPY_OK_FOR_FWD_MEMMOVE 0
+
+#endif /* memcopy.h */
diff --git a/arch/csky/abiv1/memmove.c b/arch/csky/abiv1/memmove.c
new file mode 100644
index 0000000..e01be41
--- /dev/null
+++ b/arch/csky/abiv1/memmove.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 1991-2018 Free Software Foundation, Inc.
+
+#include "memcopy.h"
+
+/* All this is so that bcopy.c can #include
+   this file after defining some things.  */
+#ifndef	a1
+#define	a1	dest	/* First arg is DEST.  */
+#define	a1const
+#define	a2	src	/* Second arg is SRC.  */
+#define	a2const	const
+#undef memmove
+#endif
+#if	!defined(RETURN) || !defined(rettype)
+#define	RETURN(s)	return (s)	/* Return DEST.  */
+#define	rettype		void *
+#endif
+
+#ifndef MEMMOVE
+#define MEMMOVE memmove
+#endif
+
+rettype
+MEMMOVE (a1const void *a1, a2const void *a2, size_t len)
+{
+  unsigned long int dstp = (long int) dest;
+  unsigned long int srcp = (long int) src;
+
+  /* This test makes the forward copying code be used whenever possible.
+     Reduces the working set.  */
+  if (dstp - srcp >= len)	/* *Unsigned* compare!  */
+    {
+      /* Copy from the beginning to the end.  */
+
+#if MEMCPY_OK_FOR_FWD_MEMMOVE
+      dest = memcpy (dest, src, len);
+#else
+      /* If there not too few bytes to copy, use word copy.  */
+      if (len >= OP_T_THRES)
+	{
+	  /* Copy just a few bytes to make DSTP aligned.  */
+	  len -= (-dstp) % OPSIZ;
+	  BYTE_COPY_FWD (dstp, srcp, (-dstp) % OPSIZ);
+
+	  /* Copy whole pages from SRCP to DSTP by virtual address
+	     manipulation, as much as possible.  */
+
+	  PAGE_COPY_FWD_MAYBE (dstp, srcp, len, len);
+
+	  /* Copy from SRCP to DSTP taking advantage of the known
+	     alignment of DSTP.  Number of bytes remaining is put
+	     in the third argument, i.e. in LEN.  This number may
+	     vary from machine to machine.  */
+
+	  WORD_COPY_FWD (dstp, srcp, len, len);
+
+	  /* Fall out and copy the tail.  */
+	}
+
+      /* There are just a few bytes to copy.  Use byte memory operations.  */
+      BYTE_COPY_FWD (dstp, srcp, len);
+#endif /* MEMCPY_OK_FOR_FWD_MEMMOVE */
+    }
+  else
+    {
+      /* Copy from the end to the beginning.  */
+      srcp += len;
+      dstp += len;
+
+      /* If there not too few bytes to copy, use word copy.  */
+      if (len >= OP_T_THRES)
+	{
+	  /* Copy just a few bytes to make DSTP aligned.  */
+	  len -= dstp % OPSIZ;
+	  BYTE_COPY_BWD (dstp, srcp, dstp % OPSIZ);
+
+	  /* Copy from SRCP to DSTP taking advantage of the known
+	     alignment of DSTP.  Number of bytes remaining is put
+	     in the third argument, i.e. in LEN.  This number may
+	     vary from machine to machine.  */
+
+	  WORD_COPY_BWD (dstp, srcp, len, len);
+
+	  /* Fall out and copy the tail.  */
+	}
+
+      /* There are just a few bytes to copy.  Use byte memory operations.  */
+      BYTE_COPY_BWD (dstp, srcp, len);
+    }
+
+  RETURN (dest);
+}
diff --git a/arch/csky/abiv1/memset.c b/arch/csky/abiv1/memset.c
new file mode 100644
index 0000000..2871ff5
--- /dev/null
+++ b/arch/csky/abiv1/memset.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 1991-2018 Free Software Foundation, Inc.
+
+#include "memcopy.h"
+
+#undef memset
+
+void *
+memset (void *dstpp, int c, size_t len)
+{
+  long int dstp = (long int) dstpp;
+
+  if (len >= 8)
+    {
+      size_t xlen;
+      op_t cccc;
+
+      cccc = (unsigned char) c;
+      cccc |= cccc << 8;
+      cccc |= cccc << 16;
+      if (OPSIZ > 4)
+	/* Do the shift in two steps to avoid warning if long has 32 bits.  */
+	cccc |= (cccc << 16) << 16;
+
+      /* There are at least some bytes to set.
+	 No need to test for LEN == 0 in this alignment loop.  */
+      while (dstp % OPSIZ != 0)
+	{
+	  ((byte *) dstp)[0] = c;
+	  dstp += 1;
+	  len -= 1;
+	}
+
+      /* Write 8 `op_t' per iteration until less than 8 `op_t' remain.  */
+      xlen = len / (OPSIZ * 8);
+      while (xlen > 0)
+	{
+	  ((op_t *) dstp)[0] = cccc;
+	  ((op_t *) dstp)[1] = cccc;
+	  ((op_t *) dstp)[2] = cccc;
+	  ((op_t *) dstp)[3] = cccc;
+	  ((op_t *) dstp)[4] = cccc;
+	  ((op_t *) dstp)[5] = cccc;
+	  ((op_t *) dstp)[6] = cccc;
+	  ((op_t *) dstp)[7] = cccc;
+	  dstp += 8 * OPSIZ;
+	  xlen -= 1;
+	}
+      len %= OPSIZ * 8;
+
+      /* Write 1 `op_t' per iteration until less than OPSIZ bytes remain.  */
+      xlen = len / OPSIZ;
+      while (xlen > 0)
+	{
+	  ((op_t *) dstp)[0] = cccc;
+	  dstp += OPSIZ;
+	  xlen -= 1;
+	}
+      len %= OPSIZ;
+    }
+
+  /* Write the last few bytes.  */
+  while (len > 0)
+    {
+      ((byte *) dstp)[0] = c;
+      dstp += 1;
+      len -= 1;
+    }
+
+  return dstpp;
+}
diff --git a/arch/csky/abiv1/strcpy.c b/arch/csky/abiv1/strcpy.c
new file mode 100644
index 0000000..50ae10c
--- /dev/null
+++ b/arch/csky/abiv1/strcpy.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 1991-2018 Free Software Foundation, Inc.
+
+#include "memcopy.h"
+
+#undef strcpy
+
+#ifndef STRCPY
+# define STRCPY strcpy
+#endif
+
+/* Copy SRC to DEST.  */
+char *
+STRCPY (char *dest, const char *src)
+{
+  return memcpy (dest, src, strlen (src) + 1);
+}
diff --git a/arch/csky/abiv1/strksyms.c b/arch/csky/abiv1/strksyms.c
index c7ccbb2..9c8fd9f 100644
--- a/arch/csky/abiv1/strksyms.c
+++ b/arch/csky/abiv1/strksyms.c
@@ -4,3 +4,8 @@
 #include <linux/module.h>
 
 EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memmove);
+EXPORT_SYMBOL(strcpy);
+EXPORT_SYMBOL(strlen);
diff --git a/arch/csky/abiv1/strlen.c b/arch/csky/abiv1/strlen.c
new file mode 100644
index 0000000..b5d9e99
--- /dev/null
+++ b/arch/csky/abiv1/strlen.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 1991-2018 Free Software Foundation, Inc.
+
+#include "memcopy.h"
+
+#undef strlen
+
+#ifndef STRLEN
+# define STRLEN strlen
+#endif
+
+/* Return the length of the null-terminated string STR.  Scan for
+   the null terminator quickly by testing four bytes at a time.  */
+size_t
+STRLEN (const char *str)
+{
+  const char *char_ptr;
+  const unsigned long int *longword_ptr;
+  unsigned long int longword, himagic, lomagic;
+
+  /* Handle the first few characters by reading one character at a time.
+     Do this until CHAR_PTR is aligned on a longword boundary.  */
+  for (char_ptr = str; ((unsigned long int) char_ptr
+			& (sizeof (longword) - 1)) != 0;
+       ++char_ptr)
+    if (*char_ptr == '\0')
+      return char_ptr - str;
+
+  /* All these elucidatory comments refer to 4-byte longwords,
+     but the theory applies equally well to 8-byte longwords.  */
+
+  longword_ptr = (unsigned long int *) char_ptr;
+
+  /* Bits 31, 24, 16, and 8 of this number are zero.  Call these bits
+     the "holes."  Note that there is a hole just to the left of
+     each byte, with an extra at the end:
+
+     bits:  01111110 11111110 11111110 11111111
+     bytes: AAAAAAAA BBBBBBBB CCCCCCCC DDDDDDDD
+
+     The 1-bits make sure that carries propagate to the next 0-bit.
+     The 0-bits provide holes for carries to fall into.  */
+  himagic = 0x80808080L;
+  lomagic = 0x01010101L;
+  if (sizeof (longword) > 4)
+    {
+      /* 64-bit version of the magic.  */
+      /* Do the shift in two steps to avoid a warning if long has 32 bits.  */
+      himagic = ((himagic << 16) << 16) | himagic;
+      lomagic = ((lomagic << 16) << 16) | lomagic;
+    }
+  BUG_ON(sizeof (longword) > 8);
+
+  /* Instead of the traditional loop which tests each character,
+     we will test a longword at a time.  The tricky part is testing
+     if *any of the four* bytes in the longword in question are zero.  */
+  for (;;)
+    {
+      longword = *longword_ptr++;
+
+      if (((longword - lomagic) & ~longword & himagic) != 0)
+	{
+	  /* Which of the bytes was the zero?  If none of them were, it was
+	     a misfire; continue the search.  */
+
+	  const char *cp = (const char *) (longword_ptr - 1);
+
+	  if (cp[0] == 0)
+	    return cp - str;
+	  if (cp[1] == 0)
+	    return cp - str + 1;
+	  if (cp[2] == 0)
+	    return cp - str + 2;
+	  if (cp[3] == 0)
+	    return cp - str + 3;
+	  if (sizeof (longword) > 4)
+	    {
+	      if (cp[4] == 0)
+		return cp - str + 4;
+	      if (cp[5] == 0)
+		return cp - str + 5;
+	      if (cp[6] == 0)
+		return cp - str + 6;
+	      if (cp[7] == 0)
+		return cp - str + 7;
+	    }
+	}
+    }
+}
diff --git a/arch/csky/abiv1/wordcopy.c b/arch/csky/abiv1/wordcopy.c
new file mode 100644
index 0000000..8c6ad23
--- /dev/null
+++ b/arch/csky/abiv1/wordcopy.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 1991-2018 Free Software Foundation, Inc.
+
+#include "memcopy.h"
+
+/* _wordcopy_fwd_aligned -- Copy block beginning at SRCP to
+   block beginning at DSTP with LEN `op_t' words (not LEN bytes!).
+   Both SRCP and DSTP should be aligned for memory operations on `op_t's.  */
+
+#ifndef WORDCOPY_FWD_ALIGNED
+# define WORDCOPY_FWD_ALIGNED _wordcopy_fwd_aligned
+#endif
+
+void
+WORDCOPY_FWD_ALIGNED (long int dstp, long int srcp, size_t len)
+{
+  op_t a0, a1;
+
+  switch (len % 8)
+    {
+    case 2:
+      a0 = ((op_t *) srcp)[0];
+      srcp -= 6 * OPSIZ;
+      dstp -= 7 * OPSIZ;
+      len += 6;
+      goto do1;
+    case 3:
+      a1 = ((op_t *) srcp)[0];
+      srcp -= 5 * OPSIZ;
+      dstp -= 6 * OPSIZ;
+      len += 5;
+      goto do2;
+    case 4:
+      a0 = ((op_t *) srcp)[0];
+      srcp -= 4 * OPSIZ;
+      dstp -= 5 * OPSIZ;
+      len += 4;
+      goto do3;
+    case 5:
+      a1 = ((op_t *) srcp)[0];
+      srcp -= 3 * OPSIZ;
+      dstp -= 4 * OPSIZ;
+      len += 3;
+      goto do4;
+    case 6:
+      a0 = ((op_t *) srcp)[0];
+      srcp -= 2 * OPSIZ;
+      dstp -= 3 * OPSIZ;
+      len += 2;
+      goto do5;
+    case 7:
+      a1 = ((op_t *) srcp)[0];
+      srcp -= 1 * OPSIZ;
+      dstp -= 2 * OPSIZ;
+      len += 1;
+      goto do6;
+
+    case 0:
+      if (OP_T_THRES <= 3 * OPSIZ && len == 0)
+	return;
+      a0 = ((op_t *) srcp)[0];
+      srcp -= 0 * OPSIZ;
+      dstp -= 1 * OPSIZ;
+      goto do7;
+    case 1:
+      a1 = ((op_t *) srcp)[0];
+      srcp -=-1 * OPSIZ;
+      dstp -= 0 * OPSIZ;
+      len -= 1;
+      if (OP_T_THRES <= 3 * OPSIZ && len == 0)
+	goto do0;
+      goto do8;			/* No-op.  */
+    }
+
+  do
+    {
+    do8:
+      a0 = ((op_t *) srcp)[0];
+      ((op_t *) dstp)[0] = a1;
+    do7:
+      a1 = ((op_t *) srcp)[1];
+      ((op_t *) dstp)[1] = a0;
+    do6:
+      a0 = ((op_t *) srcp)[2];
+      ((op_t *) dstp)[2] = a1;
+    do5:
+      a1 = ((op_t *) srcp)[3];
+      ((op_t *) dstp)[3] = a0;
+    do4:
+      a0 = ((op_t *) srcp)[4];
+      ((op_t *) dstp)[4] = a1;
+    do3:
+      a1 = ((op_t *) srcp)[5];
+      ((op_t *) dstp)[5] = a0;
+    do2:
+      a0 = ((op_t *) srcp)[6];
+      ((op_t *) dstp)[6] = a1;
+    do1:
+      a1 = ((op_t *) srcp)[7];
+      ((op_t *) dstp)[7] = a0;
+
+      srcp += 8 * OPSIZ;
+      dstp += 8 * OPSIZ;
+      len -= 8;
+    }
+  while (len != 0);
+
+  /* This is the right position for do0.  Please don't move
+     it into the loop.  */
+ do0:
+  ((op_t *) dstp)[0] = a1;
+}
+
+/* _wordcopy_fwd_dest_aligned -- Copy block beginning at SRCP to
+   block beginning at DSTP with LEN `op_t' words (not LEN bytes!).
+   DSTP should be aligned for memory operations on `op_t's, but SRCP must
+   *not* be aligned.  */
+
+#ifndef WORDCOPY_FWD_DEST_ALIGNED
+# define WORDCOPY_FWD_DEST_ALIGNED _wordcopy_fwd_dest_aligned
+#endif
+
+void
+WORDCOPY_FWD_DEST_ALIGNED (long int dstp, long int srcp, size_t len)
+{
+  op_t a0, a1, a2, a3;
+  int sh_1, sh_2;
+
+  /* Calculate how to shift a word read at the memory operation
+     aligned srcp to make it aligned for copy.  */
+
+  sh_1 = 8 * (srcp % OPSIZ);
+  sh_2 = 8 * OPSIZ - sh_1;
+
+  /* Make SRCP aligned by rounding it down to the beginning of the `op_t'
+     it points in the middle of.  */
+  srcp &= -OPSIZ;
+
+  switch (len % 4)
+    {
+    case 2:
+      a1 = ((op_t *) srcp)[0];
+      a2 = ((op_t *) srcp)[1];
+      srcp -= 1 * OPSIZ;
+      dstp -= 3 * OPSIZ;
+      len += 2;
+      goto do1;
+    case 3:
+      a0 = ((op_t *) srcp)[0];
+      a1 = ((op_t *) srcp)[1];
+      srcp -= 0 * OPSIZ;
+      dstp -= 2 * OPSIZ;
+      len += 1;
+      goto do2;
+    case 0:
+      if (OP_T_THRES <= 3 * OPSIZ && len == 0)
+	return;
+      a3 = ((op_t *) srcp)[0];
+      a0 = ((op_t *) srcp)[1];
+      srcp -=-1 * OPSIZ;
+      dstp -= 1 * OPSIZ;
+      len += 0;
+      goto do3;
+    case 1:
+      a2 = ((op_t *) srcp)[0];
+      a3 = ((op_t *) srcp)[1];
+      srcp -=-2 * OPSIZ;
+      dstp -= 0 * OPSIZ;
+      len -= 1;
+      if (OP_T_THRES <= 3 * OPSIZ && len == 0)
+	goto do0;
+      goto do4;			/* No-op.  */
+    }
+
+  do
+    {
+    do4:
+      a0 = ((op_t *) srcp)[0];
+      ((op_t *) dstp)[0] = MERGE (a2, sh_1, a3, sh_2);
+    do3:
+      a1 = ((op_t *) srcp)[1];
+      ((op_t *) dstp)[1] = MERGE (a3, sh_1, a0, sh_2);
+    do2:
+      a2 = ((op_t *) srcp)[2];
+      ((op_t *) dstp)[2] = MERGE (a0, sh_1, a1, sh_2);
+    do1:
+      a3 = ((op_t *) srcp)[3];
+      ((op_t *) dstp)[3] = MERGE (a1, sh_1, a2, sh_2);
+
+      srcp += 4 * OPSIZ;
+      dstp += 4 * OPSIZ;
+      len -= 4;
+    }
+  while (len != 0);
+
+  /* This is the right position for do0.  Please don't move
+     it into the loop.  */
+ do0:
+  ((op_t *) dstp)[0] = MERGE (a2, sh_1, a3, sh_2);
+}
+
+/* _wordcopy_bwd_aligned -- Copy block finishing right before
+   SRCP to block finishing right before DSTP with LEN `op_t' words
+   (not LEN bytes!).  Both SRCP and DSTP should be aligned for memory
+   operations on `op_t's.  */
+
+#ifndef WORDCOPY_BWD_ALIGNED
+# define WORDCOPY_BWD_ALIGNED _wordcopy_bwd_aligned
+#endif
+
+void
+WORDCOPY_BWD_ALIGNED (long int dstp, long int srcp, size_t len)
+{
+  op_t a0, a1;
+
+  switch (len % 8)
+    {
+    case 2:
+      srcp -= 2 * OPSIZ;
+      dstp -= 1 * OPSIZ;
+      a0 = ((op_t *) srcp)[1];
+      len += 6;
+      goto do1;
+    case 3:
+      srcp -= 3 * OPSIZ;
+      dstp -= 2 * OPSIZ;
+      a1 = ((op_t *) srcp)[2];
+      len += 5;
+      goto do2;
+    case 4:
+      srcp -= 4 * OPSIZ;
+      dstp -= 3 * OPSIZ;
+      a0 = ((op_t *) srcp)[3];
+      len += 4;
+      goto do3;
+    case 5:
+      srcp -= 5 * OPSIZ;
+      dstp -= 4 * OPSIZ;
+      a1 = ((op_t *) srcp)[4];
+      len += 3;
+      goto do4;
+    case 6:
+      srcp -= 6 * OPSIZ;
+      dstp -= 5 * OPSIZ;
+      a0 = ((op_t *) srcp)[5];
+      len += 2;
+      goto do5;
+    case 7:
+      srcp -= 7 * OPSIZ;
+      dstp -= 6 * OPSIZ;
+      a1 = ((op_t *) srcp)[6];
+      len += 1;
+      goto do6;
+
+    case 0:
+      if (OP_T_THRES <= 3 * OPSIZ && len == 0)
+	return;
+      srcp -= 8 * OPSIZ;
+      dstp -= 7 * OPSIZ;
+      a0 = ((op_t *) srcp)[7];
+      goto do7;
+    case 1:
+      srcp -= 9 * OPSIZ;
+      dstp -= 8 * OPSIZ;
+      a1 = ((op_t *) srcp)[8];
+      len -= 1;
+      if (OP_T_THRES <= 3 * OPSIZ && len == 0)
+	goto do0;
+      goto do8;			/* No-op.  */
+    }
+
+  do
+    {
+    do8:
+      a0 = ((op_t *) srcp)[7];
+      ((op_t *) dstp)[7] = a1;
+    do7:
+      a1 = ((op_t *) srcp)[6];
+      ((op_t *) dstp)[6] = a0;
+    do6:
+      a0 = ((op_t *) srcp)[5];
+      ((op_t *) dstp)[5] = a1;
+    do5:
+      a1 = ((op_t *) srcp)[4];
+      ((op_t *) dstp)[4] = a0;
+    do4:
+      a0 = ((op_t *) srcp)[3];
+      ((op_t *) dstp)[3] = a1;
+    do3:
+      a1 = ((op_t *) srcp)[2];
+      ((op_t *) dstp)[2] = a0;
+    do2:
+      a0 = ((op_t *) srcp)[1];
+      ((op_t *) dstp)[1] = a1;
+    do1:
+      a1 = ((op_t *) srcp)[0];
+      ((op_t *) dstp)[0] = a0;
+
+      srcp -= 8 * OPSIZ;
+      dstp -= 8 * OPSIZ;
+      len -= 8;
+    }
+  while (len != 0);
+
+  /* This is the right position for do0.  Please don't move
+     it into the loop.  */
+ do0:
+  ((op_t *) dstp)[7] = a1;
+}
+
+/* _wordcopy_bwd_dest_aligned -- Copy block finishing right
+   before SRCP to block finishing right before DSTP with LEN `op_t'
+   words (not LEN bytes!).  DSTP should be aligned for memory
+   operations on `op_t', but SRCP must *not* be aligned.  */
+
+#ifndef WORDCOPY_BWD_DEST_ALIGNED
+# define WORDCOPY_BWD_DEST_ALIGNED _wordcopy_bwd_dest_aligned
+#endif
+
+void
+WORDCOPY_BWD_DEST_ALIGNED (long int dstp, long int srcp, size_t len)
+{
+  op_t a0, a1, a2, a3;
+  int sh_1, sh_2;
+
+  /* Calculate how to shift a word read at the memory operation
+     aligned srcp to make it aligned for copy.  */
+
+  sh_1 = 8 * (srcp % OPSIZ);
+  sh_2 = 8 * OPSIZ - sh_1;
+
+  /* Make srcp aligned by rounding it down to the beginning of the op_t
+     it points in the middle of.  */
+  srcp &= -OPSIZ;
+  srcp += OPSIZ;
+
+  switch (len % 4)
+    {
+    case 2:
+      srcp -= 3 * OPSIZ;
+      dstp -= 1 * OPSIZ;
+      a2 = ((op_t *) srcp)[2];
+      a1 = ((op_t *) srcp)[1];
+      len += 2;
+      goto do1;
+    case 3:
+      srcp -= 4 * OPSIZ;
+      dstp -= 2 * OPSIZ;
+      a3 = ((op_t *) srcp)[3];
+      a2 = ((op_t *) srcp)[2];
+      len += 1;
+      goto do2;
+    case 0:
+      if (OP_T_THRES <= 3 * OPSIZ && len == 0)
+	return;
+      srcp -= 5 * OPSIZ;
+      dstp -= 3 * OPSIZ;
+      a0 = ((op_t *) srcp)[4];
+      a3 = ((op_t *) srcp)[3];
+      goto do3;
+    case 1:
+      srcp -= 6 * OPSIZ;
+      dstp -= 4 * OPSIZ;
+      a1 = ((op_t *) srcp)[5];
+      a0 = ((op_t *) srcp)[4];
+      len -= 1;
+      if (OP_T_THRES <= 3 * OPSIZ && len == 0)
+	goto do0;
+      goto do4;			/* No-op.  */
+    }
+
+  do
+    {
+    do4:
+      a3 = ((op_t *) srcp)[3];
+      ((op_t *) dstp)[3] = MERGE (a0, sh_1, a1, sh_2);
+    do3:
+      a2 = ((op_t *) srcp)[2];
+      ((op_t *) dstp)[2] = MERGE (a3, sh_1, a0, sh_2);
+    do2:
+      a1 = ((op_t *) srcp)[1];
+      ((op_t *) dstp)[1] = MERGE (a2, sh_1, a3, sh_2);
+    do1:
+      a0 = ((op_t *) srcp)[0];
+      ((op_t *) dstp)[0] = MERGE (a1, sh_1, a2, sh_2);
+
+      srcp -= 4 * OPSIZ;
+      dstp -= 4 * OPSIZ;
+      len -= 4;
+    }
+  while (len != 0);
+
+  /* This is the right position for do0.  Please don't move
+     it into the loop.  */
+ do0:
+  ((op_t *) dstp)[3] = MERGE (a0, sh_1, a1, sh_2);
+}
-- 
2.7.4

