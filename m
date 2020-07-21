Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CF12289D1
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 22:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgGUUZw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 16:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbgGUUZv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 16:25:51 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2805BC0619DD;
        Tue, 21 Jul 2020 13:25:51 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxyph-00HPom-SF; Tue, 21 Jul 2020 20:25:49 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 06/18] alpha: propagate the calling convention changes down to csum_partial_copy.c helpers
Date:   Tue, 21 Jul 2020 21:25:37 +0100
Message-Id: <20200721202549.4150745-6-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

get rid of set_fs() in csum_partial_copy_nocheck(), while we are at it -
just take the part of csum_and_copy_from_user() sans the access_ok() check
into a helper function and have csum_partial_copy_nocheck() call that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/lib/csum_partial_copy.c | 157 ++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 88 deletions(-)

diff --git a/arch/alpha/lib/csum_partial_copy.c b/arch/alpha/lib/csum_partial_copy.c
index 3c0e89c39ddb..dc68efbe9367 100644
--- a/arch/alpha/lib/csum_partial_copy.c
+++ b/arch/alpha/lib/csum_partial_copy.c
@@ -39,12 +39,11 @@ __asm__ __volatile__("insql %1,%2,%0":"=r" (z):"r" (x),"r" (y))
 #define insqh(x,y,z) \
 __asm__ __volatile__("insqh %1,%2,%0":"=r" (z):"r" (x),"r" (y))
 
-
-#define __get_user_u(x,ptr)				\
+#define __get_word(insn,x,ptr)				\
 ({							\
 	long __guu_err;					\
 	__asm__ __volatile__(				\
-	"1:	ldq_u %0,%2\n"				\
+	"1:	"#insn" %0,%2\n"			\
 	"2:\n"						\
 	EXC(1b,2b,%0,%1)				\
 		: "=r"(x), "=r"(__guu_err)		\
@@ -52,19 +51,6 @@ __asm__ __volatile__("insqh %1,%2,%0":"=r" (z):"r" (x),"r" (y))
 	__guu_err;					\
 })
 
-#define __put_user_u(x,ptr)				\
-({							\
-	long __puu_err;					\
-	__asm__ __volatile__(				\
-	"1:	stq_u %2,%1\n"				\
-	"2:\n"						\
-	EXC(1b,2b,$31,%0)				\
-		: "=r"(__puu_err)			\
-		: "m"(__m(addr)), "rJ"(x), "0"(0));	\
-	__puu_err;					\
-})
-
-
 static inline unsigned short from64to16(unsigned long x)
 {
 	/* Using extract instructions is a bit more efficient
@@ -95,15 +81,15 @@ static inline unsigned short from64to16(unsigned long x)
  */
 static inline unsigned long
 csum_partial_cfu_aligned(const unsigned long __user *src, unsigned long *dst,
-			 long len, unsigned long checksum,
-			 int *errp)
+			 long len)
 {
+	unsigned long checksum = ~0U;
 	unsigned long carry = 0;
-	int err = 0;
 
 	while (len >= 0) {
 		unsigned long word;
-		err |= __get_user(word, src);
+		if (__get_word(ldq, word, src))
+			return 0;
 		checksum += carry;
 		src++;
 		checksum += word;
@@ -116,7 +102,8 @@ csum_partial_cfu_aligned(const unsigned long __user *src, unsigned long *dst,
 	checksum += carry;
 	if (len) {
 		unsigned long word, tmp;
-		err |= __get_user(word, src);
+		if (__get_word(ldq, word, src))
+			return 0;
 		tmp = *dst;
 		mskql(word, len, word);
 		checksum += word;
@@ -125,7 +112,6 @@ csum_partial_cfu_aligned(const unsigned long __user *src, unsigned long *dst,
 		*dst = word | tmp;
 		checksum += carry;
 	}
-	if (err && errp) *errp = err;
 	return checksum;
 }
 
@@ -137,20 +123,21 @@ static inline unsigned long
 csum_partial_cfu_dest_aligned(const unsigned long __user *src,
 			      unsigned long *dst,
 			      unsigned long soff,
-			      long len, unsigned long checksum,
-			      int *errp)
+			      long len)
 {
 	unsigned long first;
 	unsigned long word, carry;
 	unsigned long lastsrc = 7+len+(unsigned long)src;
-	int err = 0;
+	unsigned long checksum = ~0U;
 
-	err |= __get_user_u(first,src);
+	if (__get_word(ldq_u, first,src))
+		return 0;
 	carry = 0;
 	while (len >= 0) {
 		unsigned long second;
 
-		err |= __get_user_u(second, src+1);
+		if (__get_word(ldq_u, second, src+1))
+			return 0;
 		extql(first, soff, word);
 		len -= 8;
 		src++;
@@ -168,7 +155,8 @@ csum_partial_cfu_dest_aligned(const unsigned long __user *src,
 	if (len) {
 		unsigned long tmp;
 		unsigned long second;
-		err |= __get_user_u(second, lastsrc);
+		if (__get_word(ldq_u, second, lastsrc))
+			return 0;
 		tmp = *dst;
 		extql(first, soff, word);
 		extqh(second, soff, first);
@@ -180,7 +168,6 @@ csum_partial_cfu_dest_aligned(const unsigned long __user *src,
 		*dst = word | tmp;
 		checksum += carry;
 	}
-	if (err && errp) *errp = err;
 	return checksum;
 }
 
@@ -191,18 +178,18 @@ static inline unsigned long
 csum_partial_cfu_src_aligned(const unsigned long __user *src,
 			     unsigned long *dst,
 			     unsigned long doff,
-			     long len, unsigned long checksum,
-			     unsigned long partial_dest,
-			     int *errp)
+			     long len,
+			     unsigned long partial_dest)
 {
 	unsigned long carry = 0;
 	unsigned long word;
 	unsigned long second_dest;
-	int err = 0;
+	unsigned long checksum = ~0U;
 
 	mskql(partial_dest, doff, partial_dest);
 	while (len >= 0) {
-		err |= __get_user(word, src);
+		if (__get_word(ldq, word, src))
+			return 0;
 		len -= 8;
 		insql(word, doff, second_dest);
 		checksum += carry;
@@ -216,7 +203,8 @@ csum_partial_cfu_src_aligned(const unsigned long __user *src,
 	len += 8;
 	if (len) {
 		checksum += carry;
-		err |= __get_user(word, src);
+		if (__get_word(ldq, word, src))
+			return 0;
 		mskql(word, len, word);
 		len -= 8;
 		checksum += word;
@@ -237,7 +225,6 @@ csum_partial_cfu_src_aligned(const unsigned long __user *src,
 	stq_u(partial_dest | second_dest, dst);
 out:
 	checksum += carry;
-	if (err && errp) *errp = err;
 	return checksum;
 }
 
@@ -249,23 +236,23 @@ static inline unsigned long
 csum_partial_cfu_unaligned(const unsigned long __user * src,
 			   unsigned long * dst,
 			   unsigned long soff, unsigned long doff,
-			   long len, unsigned long checksum,
-			   unsigned long partial_dest,
-			   int *errp)
+			   long len, unsigned long partial_dest)
 {
 	unsigned long carry = 0;
 	unsigned long first;
 	unsigned long lastsrc;
-	int err = 0;
+	unsigned long checksum = ~0U;
 
-	err |= __get_user_u(first, src);
+	if (__get_word(ldq_u, first, src))
+		return 0;
 	lastsrc = 7+len+(unsigned long)src;
 	mskql(partial_dest, doff, partial_dest);
 	while (len >= 0) {
 		unsigned long second, word;
 		unsigned long second_dest;
 
-		err |= __get_user_u(second, src+1);
+		if (__get_word(ldq_u, second, src+1))
+			return 0;
 		extql(first, soff, word);
 		checksum += carry;
 		len -= 8;
@@ -286,7 +273,8 @@ csum_partial_cfu_unaligned(const unsigned long __user * src,
 		unsigned long second, word;
 		unsigned long second_dest;
 
-		err |= __get_user_u(second, lastsrc);
+		if (__get_word(ldq_u, second, lastsrc))
+			return 0;
 		extql(first, soff, word);
 		extqh(second, soff, first);
 		word |= first;
@@ -307,7 +295,8 @@ csum_partial_cfu_unaligned(const unsigned long __user * src,
 		unsigned long second, word;
 		unsigned long second_dest;
 
-		err |= __get_user_u(second, lastsrc);
+		if (__get_word(ldq_u, second, lastsrc))
+			return 0;
 		extql(first, soff, word);
 		extqh(second, soff, first);
 		word |= first;
@@ -320,63 +309,55 @@ csum_partial_cfu_unaligned(const unsigned long __user * src,
 		stq_u(partial_dest | word | second_dest, dst);
 		checksum += carry;
 	}
-	if (err && errp) *errp = err;
 	return checksum;
 }
 
-__wsum
-csum_and_copy_from_user(const void __user *src, void *dst, int len)
+static __wsum __csum_and_copy(const void __user *src, void *dst, int len)
 {
-	unsigned long checksum = ~0U;
 	unsigned long soff = 7 & (unsigned long) src;
 	unsigned long doff = 7 & (unsigned long) dst;
-	int err = 0;
-
-	if (len) {
-		if (!access_ok(src, len))
-			return 0;
-		if (!doff) {
-			if (!soff)
-				checksum = csum_partial_cfu_aligned(
-					(const unsigned long __user *) src,
-					(unsigned long *) dst,
-					len-8, checksum, &err);
-			else
-				checksum = csum_partial_cfu_dest_aligned(
-					(const unsigned long __user *) src,
-					(unsigned long *) dst,
-					soff, len-8, checksum, &err);
-		} else {
-			unsigned long partial_dest;
-			ldq_u(partial_dest, dst);
-			if (!soff)
-				checksum = csum_partial_cfu_src_aligned(
-					(const unsigned long __user *) src,
-					(unsigned long *) dst,
-					doff, len-8, checksum,
-					partial_dest, &err);
-			else
-				checksum = csum_partial_cfu_unaligned(
-					(const unsigned long __user *) src,
-					(unsigned long *) dst,
-					soff, doff, len-8, checksum,
-					partial_dest, &err);
-		}
-		checksum = err ? 0 : from64to16 (checksum);
+	unsigned long checksum;
+
+	if (!doff) {
+		if (!soff)
+			checksum = csum_partial_cfu_aligned(
+				(const unsigned long __user *) src,
+				(unsigned long *) dst, len-8);
+		else
+			checksum = csum_partial_cfu_dest_aligned(
+				(const unsigned long __user *) src,
+				(unsigned long *) dst,
+				soff, len-8);
+	} else {
+		unsigned long partial_dest;
+		ldq_u(partial_dest, dst);
+		if (!soff)
+			checksum = csum_partial_cfu_src_aligned(
+				(const unsigned long __user *) src,
+				(unsigned long *) dst,
+				doff, len-8, partial_dest);
+		else
+			checksum = csum_partial_cfu_unaligned(
+				(const unsigned long __user *) src,
+				(unsigned long *) dst,
+				soff, doff, len-8, partial_dest);
 	}
-	return (__force __wsum)checksum;
+	return (__force __wsum)from64to16 (checksum);
+}
+
+__wsum
+csum_and_copy_from_user(const void __user *src, void *dst, int len)
+{
+	if (!access_ok(src, len))
+		return 0;
+	return __csum_and_copy(src, dst, len);
 }
 EXPORT_SYMBOL(csum_and_copy_from_user);
 
 __wsum
 csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	__wsum checksum;
-	mm_segment_t oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	checksum = csum_and_copy_from_user((__force const void __user *)src,
+	return __csum_and_copy((__force const void __user *)src,
 						dst, len);
-	set_fs(oldfs);
-	return checksum;
 }
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
-- 
2.11.0

