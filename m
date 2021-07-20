Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEDD3CFE01
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jul 2021 17:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242399AbhGTPBT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jul 2021 11:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240444AbhGTOaw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Jul 2021 10:30:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0306610C7;
        Tue, 20 Jul 2021 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626793801;
        bh=VG8mYKeaN6zpY3H4xqfPQ3oOb4jYn6Rtk1kwDRGEwmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TRVXEstmbXvgIPowqqpERgHQbA/Ms1tCvt6eKaE2uXkZySZcsrr3vr+KWYX/jB0xW
         +vEoRAELksjNfDpltvLQlzLCqyjjfTzI28qs/ywoeu9FH/GMeghRN5QQtsSfU0B/e0
         LCTSp9e1mWCEgF9XoNitj58W0fR92SS9xyUFsDv7yFoaX8FAyqzaTCMBlxAfCvNAal
         Pvo1YP11fVnlvJrpw3BShr49ag/EdRDsh8x7l8z9XykjCgq2vDBOHgVe/wL7SWZ9/2
         4TgghmQLtkja4py3HkGsEVHaXrj/MfNJ1Htbdp0FRHkKeSz+TPbetLLOKR82jjjUuO
         ghYfcXHffJKaw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        kexec@lists.infradead.org
Subject: [PATCH v4 1/4] kexec: avoid compat_alloc_user_space
Date:   Tue, 20 Jul 2021 17:09:47 +0200
Message-Id: <20210720150950.3669610-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210720150950.3669610-1-arnd@kernel.org>
References: <20210720150950.3669610-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The compat version of sys_kexec_load() uses compat_alloc_user_space to
convert the user-provided arguments into the native format, and it is
one of the last system calls to do this after almost all other ones have
been converted to a different solution.

Change do_kexec_load_locked() to instead take a kernel pointer,
and do the conversion of the compat format in the two entry points
for native and compat mode.

This approach was suggested by Eric Biederman, who posted the initial
version as an alternative to a different patch from Arnd.

Link: https://lore.kernel.org/lkml/m1y2cbzmnw.fsf@fess.ebiederm.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/kexec.c | 116 +++++++++++++++++++++++++------------------------
 1 file changed, 59 insertions(+), 57 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index c82c6c06f051..4eae5f2aa159 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -19,26 +19,21 @@
 
 #include "kexec_internal.h"
 
-static int copy_user_segment_list(struct kimage *image,
+static void copy_user_segment_list(struct kimage *image,
 				  unsigned long nr_segments,
-				  struct kexec_segment __user *segments)
+				  struct kexec_segment *segments)
 {
-	int ret;
 	size_t segment_bytes;
 
 	/* Read in the segments */
 	image->nr_segments = nr_segments;
 	segment_bytes = nr_segments * sizeof(*segments);
-	ret = copy_from_user(image->segment, segments, segment_bytes);
-	if (ret)
-		ret = -EFAULT;
-
-	return ret;
+	memcpy(image->segment, segments, segment_bytes);
 }
 
 static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 			     unsigned long nr_segments,
-			     struct kexec_segment __user *segments,
+			     struct kexec_segment *segments,
 			     unsigned long flags)
 {
 	int ret;
@@ -59,9 +54,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 
 	image->start = entry;
 
-	ret = copy_user_segment_list(image, nr_segments, segments);
-	if (ret)
-		goto out_free_image;
+	copy_user_segment_list(image, nr_segments, segments);
 
 	if (kexec_on_panic) {
 		/* Enable special crash kernel control page alloc policy. */
@@ -103,8 +96,8 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 	return ret;
 }
 
-static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
-		struct kexec_segment __user *segments, unsigned long flags)
+static int do_kexec_load_locked(unsigned long entry, unsigned long nr_segments,
+			struct kexec_segment *segments, unsigned long flags)
 {
 	struct kimage **dest_image, *image;
 	unsigned long i;
@@ -174,6 +167,27 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	return ret;
 }
 
+static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
+			struct kexec_segment *segments, unsigned long flags)
+{
+	int result;
+
+	/* Because we write directly to the reserved memory
+	 * region when loading crash kernels we need a mutex here to
+	 * prevent multiple crash  kernels from attempting to load
+	 * simultaneously, and to prevent a crash kernel from loading
+	 * over the top of a in use crash kernel.
+	 *
+	 * KISS: always take the mutex.
+	 */
+	if (!mutex_trylock(&kexec_mutex))
+		return -EBUSY;
+
+	result = do_kexec_load_locked(entry, nr_segments, segments, flags);
+	mutex_unlock(&kexec_mutex);
+	return result;
+}
+
 /*
  * Exec Kernel system call: for obvious reasons only root may call it.
  *
@@ -224,6 +238,11 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if ((flags & KEXEC_FLAGS) != (flags & ~KEXEC_ARCH_MASK))
 		return -EINVAL;
 
+	/* Verify we are on the appropriate architecture */
+	if (((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH) &&
+	    ((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
+		return -EINVAL;
+
 	/* Put an artificial cap on the number
 	 * of segments passed to kexec_load.
 	 */
@@ -236,32 +255,26 @@ static inline int kexec_load_check(unsigned long nr_segments,
 SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		struct kexec_segment __user *, segments, unsigned long, flags)
 {
-	int result;
+	struct kexec_segment *ksegments;
+	unsigned long bytes, result;
 
 	result = kexec_load_check(nr_segments, flags);
 	if (result)
 		return result;
 
-	/* Verify we are on the appropriate architecture */
-	if (((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH) &&
-		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
-		return -EINVAL;
-
-	/* Because we write directly to the reserved memory
-	 * region when loading crash kernels we need a mutex here to
-	 * prevent multiple crash  kernels from attempting to load
-	 * simultaneously, and to prevent a crash kernel from loading
-	 * over the top of a in use crash kernel.
-	 *
-	 * KISS: always take the mutex.
-	 */
-	if (!mutex_trylock(&kexec_mutex))
-		return -EBUSY;
+	bytes = nr_segments * sizeof(ksegments[0]);
+	ksegments = kmalloc(bytes, GFP_KERNEL);
+	if (!ksegments)
+		return -ENOMEM;
 
-	result = do_kexec_load(entry, nr_segments, segments, flags);
+	result = copy_from_user(ksegments, segments, bytes);
+	if (result)
+		goto fail;
 
-	mutex_unlock(&kexec_mutex);
+	result = do_kexec_load(entry, nr_segments, ksegments, flags);
 
+fail:
+	kfree(ksegments);
 	return result;
 }
 
@@ -272,8 +285,8 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
 		       compat_ulong_t, flags)
 {
 	struct compat_kexec_segment in;
-	struct kexec_segment out, __user *ksegments;
-	unsigned long i, result;
+	struct kexec_segment *ksegments;
+	unsigned long bytes, i, result;
 
 	result = kexec_load_check(nr_segments, flags);
 	if (result)
@@ -285,37 +298,26 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
 	if ((flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_DEFAULT)
 		return -EINVAL;
 
-	ksegments = compat_alloc_user_space(nr_segments * sizeof(out));
+	bytes = nr_segments * sizeof(ksegments[0]);
+	ksegments = kmalloc(bytes, GFP_KERNEL);
+	if (!ksegments)
+		return -ENOMEM;
+
 	for (i = 0; i < nr_segments; i++) {
 		result = copy_from_user(&in, &segments[i], sizeof(in));
 		if (result)
-			return -EFAULT;
-
-		out.buf   = compat_ptr(in.buf);
-		out.bufsz = in.bufsz;
-		out.mem   = in.mem;
-		out.memsz = in.memsz;
+			goto fail;
 
-		result = copy_to_user(&ksegments[i], &out, sizeof(out));
-		if (result)
-			return -EFAULT;
+		ksegments[i].buf   = compat_ptr(in.buf);
+		ksegments[i].bufsz = in.bufsz;
+		ksegments[i].mem   = in.mem;
+		ksegments[i].memsz = in.memsz;
 	}
 
-	/* Because we write directly to the reserved memory
-	 * region when loading crash kernels we need a mutex here to
-	 * prevent multiple crash  kernels from attempting to load
-	 * simultaneously, and to prevent a crash kernel from loading
-	 * over the top of a in use crash kernel.
-	 *
-	 * KISS: always take the mutex.
-	 */
-	if (!mutex_trylock(&kexec_mutex))
-		return -EBUSY;
-
 	result = do_kexec_load(entry, nr_segments, ksegments, flags);
 
-	mutex_unlock(&kexec_mutex);
-
+fail:
+	kfree(ksegments);
 	return result;
 }
 #endif
-- 
2.29.2

