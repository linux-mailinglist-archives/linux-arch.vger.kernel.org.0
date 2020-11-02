Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3902A2ABC
	for <lists+linux-arch@lfdr.de>; Mon,  2 Nov 2020 13:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgKBMcW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Nov 2020 07:32:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:43650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728359AbgKBMcV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Nov 2020 07:32:21 -0500
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB355222BA;
        Mon,  2 Nov 2020 12:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604320339;
        bh=pR0lLs09MNuIjT8UFqkl89v87fssHHRgqxxRCJAIoSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EyZhfqCu6aBJFN3qmiNYQdFatyVKmXN1QpFwf9vRhlzU8iG48Enacz25lEU0bTqRn
         OoZqSKJh+W1xIvhiUqa2xNg5t74NPZVLvMnJtMywvbKX1bH8UE0c8LN7zJ2c9FTEWg
         su188ogt7UTw5LluoD95V+4+fHUjSVEzlkR/A0Xo=
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [PATCH v2 1/4] kexec: simplify compat_sys_kexec_load
Date:   Mon,  2 Nov 2020 13:31:48 +0100
Message-Id: <20201102123151.2860165-2-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201102123151.2860165-1-arnd@kernel.org>
References: <20201102123151.2860165-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The compat version of sys_kexec_load() uses compat_alloc_user_space to
convert the user-provided arguments into the native format.

Move the conversion into the regular implementation with
an in_compat_syscall() check to simplify it and avoid the
compat_alloc_user_space() call.

compat_sys_kexec_load() now behaves the same as sys_kexec_load().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/kexec.h |  2 -
 kernel/kexec.c        | 95 +++++++++++++++++++------------------------
 2 files changed, 42 insertions(+), 55 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9e93bef52968..7b6717cd5c4a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -88,14 +88,12 @@ struct kexec_segment {
 	size_t memsz;
 };
 
-#ifdef CONFIG_COMPAT
 struct compat_kexec_segment {
 	compat_uptr_t buf;
 	compat_size_t bufsz;
 	compat_ulong_t mem;	/* User space sees this as a (void *) ... */
 	compat_size_t memsz;
 };
-#endif
 
 #ifdef CONFIG_KEXEC_FILE
 struct purgatory_info {
diff --git a/kernel/kexec.c b/kernel/kexec.c
index c82c6c06f051..ec04791eea3e 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -19,21 +19,46 @@
 
 #include "kexec_internal.h"
 
+static int copy_user_compat_segment_list(struct kimage *image,
+					 unsigned long nr_segments,
+					 void __user *segments)
+{
+	struct compat_kexec_segment __user *cs = segments;
+	struct compat_kexec_segment segment;
+	int i;
+
+	for (i=0; i < nr_segments; i++) {
+		if (copy_from_user(&segment, &cs[i], sizeof(segment)))
+			return -EFAULT;
+
+		image->segment[i] = (struct kexec_segment) {
+			.buf   = compat_ptr(segment.buf),
+			.bufsz = segment.bufsz,
+			.mem   = segment.mem,
+			.memsz = segment.memsz,
+		};
+	}
+
+	return 0;
+}
+
+
 static int copy_user_segment_list(struct kimage *image,
 				  unsigned long nr_segments,
 				  struct kexec_segment __user *segments)
 {
-	int ret;
 	size_t segment_bytes;
 
 	/* Read in the segments */
 	image->nr_segments = nr_segments;
 	segment_bytes = nr_segments * sizeof(*segments);
-	ret = copy_from_user(image->segment, segments, segment_bytes);
-	if (ret)
-		ret = -EFAULT;
+	if (in_compat_syscall())
+		return copy_user_compat_segment_list(image, nr_segments, segments);
 
-	return ret;
+	if (copy_from_user(image->segment, segments, segment_bytes))
+		return -EFAULT;
+
+	return 0;
 }
 
 static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
@@ -233,8 +258,9 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	return 0;
 }
 
-SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
-		struct kexec_segment __user *, segments, unsigned long, flags)
+static int kernel_kexec_load(unsigned long entry, unsigned long nr_segments,
+			     struct kexec_segment __user * segments,
+			     unsigned long flags)
 {
 	int result;
 
@@ -265,57 +291,20 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 	return result;
 }
 
+SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
+		struct kexec_segment __user *, segments, unsigned long, flags)
+{
+	return kernel_kexec_load(entry, nr_segments, segments, flags);
+}
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
 		       compat_ulong_t, nr_segments,
 		       struct compat_kexec_segment __user *, segments,
 		       compat_ulong_t, flags)
 {
-	struct compat_kexec_segment in;
-	struct kexec_segment out, __user *ksegments;
-	unsigned long i, result;
-
-	result = kexec_load_check(nr_segments, flags);
-	if (result)
-		return result;
-
-	/* Don't allow clients that don't understand the native
-	 * architecture to do anything.
-	 */
-	if ((flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_DEFAULT)
-		return -EINVAL;
-
-	ksegments = compat_alloc_user_space(nr_segments * sizeof(out));
-	for (i = 0; i < nr_segments; i++) {
-		result = copy_from_user(&in, &segments[i], sizeof(in));
-		if (result)
-			return -EFAULT;
-
-		out.buf   = compat_ptr(in.buf);
-		out.bufsz = in.bufsz;
-		out.mem   = in.mem;
-		out.memsz = in.memsz;
-
-		result = copy_to_user(&ksegments[i], &out, sizeof(out));
-		if (result)
-			return -EFAULT;
-	}
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
-
-	result = do_kexec_load(entry, nr_segments, ksegments, flags);
-
-	mutex_unlock(&kexec_mutex);
-
-	return result;
+	return kernel_kexec_load(entry, nr_segments,
+				 (struct kexec_segment __user *)segments,
+				 flags);
 }
 #endif
-- 
2.27.0

