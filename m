Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A463D78DE
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 16:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbhG0Ouq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 10:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236909AbhG0Ott (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Jul 2021 10:49:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F238F61B05;
        Tue, 27 Jul 2021 14:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627397371;
        bh=uEwQ9C0cLg3IwMIORY/37dlh5O4fu4jNkU/FjsRvIrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kj/IVvXy3JHWkqM0XFNYDPQdxSxj8JggLNuER9Hto8/iywRcIWO4ntU+1XOU+vznN
         nwEKRsA+VKIKup4+NtVyRDYRpls5U2TXGCwqj3BJNmiv5sKmAucefRYvBWnZGg/gWZ
         c82xtneZYpDFHr8DZcbROOlVG3lPysp9nfW3etc11bBGulX+P5auZXokAklC34LE09
         zwwS/wKlWBr3BJYnxmJQmo/nNvm9893oVZ0YfCEUg2WJgjbqKzN5nBIr50IymV9mHv
         xGRSVKAvWuWMXXuS4LWxtdDEitvbuLrJU8AGGYaPMslKu0GUWYCUOcXlo8lTk6GhMM
         d1I9fnI2UDWGQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christoph Hellwig <hch@infradead.org>,
        Feng Tang <feng.tang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v5 2/6] kexec: avoid compat_alloc_user_space
Date:   Tue, 27 Jul 2021 16:48:55 +0200
Message-Id: <20210727144859.4150043-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210727144859.4150043-1-arnd@kernel.org>
References: <20210727144859.4150043-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

kimage_alloc_init() expects a __user pointer, so compat_sys_kexec_load()
uses compat_alloc_user_space() to convert the layout and put it back
onto the user space caller stack.

Moving the user space access into the syscall handler directly actually
makes the code simpler, as the conversion for compat mode can now be
done on kernel memory.

Co-developed-by: Eric Biederman <ebiederm@xmission.com>
Co-developed-by: Christoph Hellwig <hch@infradead.org>
Link: https://lore.kernel.org/lkml/YPbtsU4GX6PL7%2F42@infradead.org/
Link: https://lore.kernel.org/lkml/m1y2cbzmnw.fsf@fess.ebiederm.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/kexec.c | 61 +++++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 9c7aef8f4bb6..b5e40f069768 100644
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
@@ -104,7 +85,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 }
 
 static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
-		struct kexec_segment __user *segments, unsigned long flags)
+		struct kexec_segment *segments, unsigned long flags)
 {
 	struct kimage **dest_image, *image;
 	unsigned long i;
@@ -250,7 +231,8 @@ static inline int kexec_load_check(unsigned long nr_segments,
 SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		struct kexec_segment __user *, segments, unsigned long, flags)
 {
-	int result;
+	struct kexec_segment *ksegments;
+	unsigned long result;
 
 	result = kexec_load_check(nr_segments, flags);
 	if (result)
@@ -261,7 +243,12 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
 		return -EINVAL;
 
-	result = do_kexec_load(entry, nr_segments, segments, flags);
+	ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
+	if (IS_ERR(ksegments))
+		return PTR_ERR(ksegments);
+
+	result = do_kexec_load(entry, nr_segments, ksegments, flags);
+	kfree(ksegments);
 
 	return result;
 }
@@ -273,7 +260,7 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
 		       compat_ulong_t, flags)
 {
 	struct compat_kexec_segment in;
-	struct kexec_segment out, __user *ksegments;
+	struct kexec_segment *ksegments;
 	unsigned long i, result;
 
 	result = kexec_load_check(nr_segments, flags);
@@ -286,24 +273,26 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
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
+			goto fail;
 
-		out.buf   = compat_ptr(in.buf);
-		out.bufsz = in.bufsz;
-		out.mem   = in.mem;
-		out.memsz = in.memsz;
-
-		result = copy_to_user(&ksegments[i], &out, sizeof(out));
-		if (result)
-			return -EFAULT;
+		ksegments[i].buf   = compat_ptr(in.buf);
+		ksegments[i].bufsz = in.bufsz;
+		ksegments[i].mem   = in.mem;
+		ksegments[i].memsz = in.memsz;
 	}
 
 	result = do_kexec_load(entry, nr_segments, ksegments, flags);
 
+fail:
+	kfree(ksegments);
 	return result;
 }
 #endif
-- 
2.29.2

