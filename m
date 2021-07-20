Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAF03CFE03
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jul 2021 17:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbhGTPB1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jul 2021 11:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241951AbhGTO56 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jul 2021 10:57:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3677DC061574;
        Tue, 20 Jul 2021 08:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Wj/HwXFX2bmhHvOuLlpR0gcFs8JOAD2ucTx8ZSKbwk=; b=OWbp/EA8gH0ewGwF5iqYwn5hMZ
        vMDMXsuoD6H9phlC+ZhkDCZzwsfSVfIPhbzgu1VHaodfMejY18ovrGF8pyA/qBkB7Aae/a3VVXLhR
        882WX4HufAjKw/JXXwH/UTB3Potsl4nWzOMh738U1VQyRnonmYv8dXdBIsZpck6BEj1C/Ez5HQg2R
        8OJnKbUmyAQ5WCzy/dJvEo0/ax8wHUAYMyvmYRXrSbn3FqDcGi9u28MlWgi69H9L2VuO+c5ERVPr6
        o6MdOsT7qT9yeU6t7LT9CBNmxtq/zUJYkDZl2Mno8eLVZssU+knw4fvRhuJ0KT6MK4z1WXXfHWY6Z
        /txM1gJQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5ro9-008GZ6-4O; Tue, 20 Jul 2021 15:37:28 +0000
Date:   Tue, 20 Jul 2021 16:37:21 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH v4 1/4] kexec: avoid compat_alloc_user_space
Message-ID: <YPbtsU4GX6PL7/42@infradead.org>
References: <20210720150950.3669610-1-arnd@kernel.org>
 <20210720150950.3669610-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720150950.3669610-2-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This can be simplified a little more by killing off
copy_user_segment_list entirely, using memdup_user and dropping the
not really required _locked wrapper.  The locking move might make
most sense as a separate prep patch.

diff --git a/kernel/kexec.c b/kernel/kexec.c
index c82c6c06f051..3140fe7af801 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -19,26 +19,9 @@
 
 #include "kexec_internal.h"
 
-static int copy_user_segment_list(struct kimage *image,
-				  unsigned long nr_segments,
-				  struct kexec_segment __user *segments)
-{
-	int ret;
-	size_t segment_bytes;
-
-	/* Read in the segments */
-	image->nr_segments = nr_segments;
-	segment_bytes = nr_segments * sizeof(*segments);
-	ret = copy_from_user(image->segment, segments, segment_bytes);
-	if (ret)
-		ret = -EFAULT;
-
-	return ret;
-}
-
 static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 			     unsigned long nr_segments,
-			     struct kexec_segment __user *segments,
+			     struct kexec_segment *segments,
 			     unsigned long flags)
 {
 	int ret;
@@ -58,10 +41,8 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 		return -ENOMEM;
 
 	image->start = entry;
-
-	ret = copy_user_segment_list(image, nr_segments, segments);
-	if (ret)
-		goto out_free_image;
+	image->nr_segments = nr_segments;
+	memcpy(image->segment, segments, nr_segments * sizeof(*segments));
 
 	if (kexec_on_panic) {
 		/* Enable special crash kernel control page alloc policy. */
@@ -104,11 +85,22 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 }
 
 static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
-		struct kexec_segment __user *segments, unsigned long flags)
+		struct kexec_segment *segments, unsigned long flags)
 {
 	struct kimage **dest_image, *image;
 	unsigned long i;
-	int ret;
+	int ret = 0;
+
+	/*
+	 * Because we write directly to the reserved memory region when loading
+	 * crash kernels we need a mutex here to prevent multiple crash kernels
+	 * from attempting to load simultaneously, and to prevent a crash kernel
+	 * from loading over the top of a in use crash kernel.
+	 *
+	 * KISS: always take the mutex.
+	 */
+	if (!mutex_trylock(&kexec_mutex))
+		return -EBUSY;
 
 	if (flags & KEXEC_ON_CRASH) {
 		dest_image = &kexec_crash_image;
@@ -121,7 +113,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (nr_segments == 0) {
 		/* Uninstall image */
 		kimage_free(xchg(dest_image, NULL));
-		return 0;
+		goto out_unlock;
 	}
 	if (flags & KEXEC_ON_CRASH) {
 		/*
@@ -134,7 +126,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	ret = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	if (flags & KEXEC_PRESERVE_CONTEXT)
 		image->preserve_context = 1;
@@ -171,6 +163,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 		arch_kexec_protect_crashkres();
 
 	kimage_free(image);
+out_unlock:
+	mutex_unlock(&kexec_mutex);
 	return ret;
 }
 
@@ -236,7 +230,8 @@ static inline int kexec_load_check(unsigned long nr_segments,
 SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		struct kexec_segment __user *, segments, unsigned long, flags)
 {
-	int result;
+	struct kexec_segment *ksegments;
+	unsigned long result;
 
 	result = kexec_load_check(nr_segments, flags);
 	if (result)
@@ -247,21 +242,11 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
 		return -EINVAL;
 
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
-	result = do_kexec_load(entry, nr_segments, segments, flags);
-
-	mutex_unlock(&kexec_mutex);
-
+	ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
+	if (IS_ERR(ksegments))
+		return PTR_ERR(ksegments);
+	result = do_kexec_load(entry, nr_segments, ksegments, flags);
+	kfree(ksegments);
 	return result;
 }
 
@@ -272,7 +257,7 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
 		       compat_ulong_t, flags)
 {
 	struct compat_kexec_segment in;
-	struct kexec_segment out, __user *ksegments;
+	struct kexec_segment *ksegments;
 	unsigned long i, result;
 
 	result = kexec_load_check(nr_segments, flags);
@@ -285,37 +270,24 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
 	if ((flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_DEFAULT)
 		return -EINVAL;
 
-	ksegments = compat_alloc_user_space(nr_segments * sizeof(out));
+	ksegments = kmalloc_array(nr_segments, sizeof(ksegments[0]),
+			GFP_KERNEL);
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
-
-		result = copy_to_user(&ksegments[i], &out, sizeof(out));
-		if (result)
-			return -EFAULT;
+			goto fail;
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
-
-	mutex_unlock(&kexec_mutex);
-
+fail:
+	kfree(ksegments);
 	return result;
 }
 #endif

