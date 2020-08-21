Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FBF24D330
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 12:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgHUKvL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 06:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgHUKuv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 06:50:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A29C061387;
        Fri, 21 Aug 2020 03:50:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id p20so1543412wrf.0;
        Fri, 21 Aug 2020 03:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c83q5vqNKGOYTEaYuNPD3RF5llns44+uvOpRPNGbhr8=;
        b=Y/J5P1iLE3jv3mivXZyMaUhUyYYIHQvqKkRQ3h0ZL2R0FijUSSSlVSo2r0Dwse6CSA
         hICztQUtXcS6OzQFrk0Y4tQSD22V/JNtwHGCc+Bq/63DS5DntTh/c45WX/vRzpap8seE
         1JQy/6vNfO1NCUvuEq+czrKCJ+5FrYl2k69fq3Q0Rp8A3HTZYzeasqRwyQnGQ+ZHOIa0
         aBoLtIYkHdD9yx8CpuW+MCuerXhwGCc3eGwlRO4UBCOIKw0qNdZta0oLXcW3KQrLQf6X
         kRgugGv69XTtbTSrAhrjR9BfVYEf7BID7V7oqKlz66TuPRWJ//BIoQkXaP41/8lznAEh
         uE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c83q5vqNKGOYTEaYuNPD3RF5llns44+uvOpRPNGbhr8=;
        b=NRYUIUikcFIqxHxCvsjYDfGNUAUrvOmX7QZ+jLj7Ql2dnLMv1IiNq2ShcjQ8ZWI5s5
         7CCvFZF8chtnQpYTSO5dMRyRlU5qEiuByTwE7J/o5Sc1TtSBP6L5f6DPjrbr6KQDWj0z
         SWV8O34m6qYJwTm/xWv1pOs2TZfvFtr/o/AZrXgmXEGOZPDUNFu0Nul9m83VRaTCONQs
         mu4/YFM9Q+PguZC0YpdBiNBgQH3U8aTwmLxkgPJBZ7PNZ7faTjA9s3e8XzshpwwdLgi6
         M0Yc8b+hfYrgO0+ifddF8qa/naX/fr3Fx12TN9ACEkIYUvs9wMJ1ayY9RW7kGeoSoq8s
         Va0w==
X-Gm-Message-State: AOAM531RnBiXyqnCOGnaj7aWyyC1+u/iDiy8KZZ/I6AACUWlehhuXGGB
        VaLUfbNNlkXefbJtlYwoFMI=
X-Google-Smtp-Source: ABdhPJwde2bx/W7qHqB9zj1bQDGXTqsFNKULBzBmK3e7+KQxDtyIzW20mwPUs6MDGII5g2PJJn+Ijw==
X-Received: by 2002:adf:82a6:: with SMTP id 35mr668351wrc.141.1598007048944;
        Fri, 21 Aug 2020 03:50:48 -0700 (PDT)
Received: from alinde.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 8sm3784911wrl.7.2020.08.21.03.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:50:48 -0700 (PDT)
From:   albert.linde@gmail.com
X-Google-Original-From: alinde@google.com
To:     akpm@linux-foundation.org, bp@alien8.de, mingo@redhat.com,
        corbet@lwn.net, tglx@linutronix.de, arnd@arndb.de
Cc:     akinobu.mita@gmail.com, hpa@zytor.com, viro@zeniv.linux.org.uk,
        glider@google.com, andreyknvl@google.com, dvyukov@google.com,
        elver@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, Albert van der Linde <alinde@google.com>
Subject: [PATCH 2/3] lib, uaccess: add failure injection to usercopy functions
Date:   Fri, 21 Aug 2020 10:49:24 +0000
Message-Id: <20200821104926.828511-3-alinde@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200821104926.828511-1-alinde@google.com>
References: <20200821104926.828511-1-alinde@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Albert van der Linde <alinde@google.com>

To test fault-tolerance of usercopy accesses, introduce fault injection
in usercopy functions.

Adds failure injection to usercopy functions. If a failure is expected
we return either the failure or the total amount of bytes. As many
usercopy functions can fail partially, permit also partial failures:
e.g., copy_from_user can fail copying between 0 and n.

Signed-off-by: Albert van der Linde <alinde@google.com>
---
 include/linux/uaccess.h | 31 ++++++++++++++++++++++++++-----
 lib/iov_iter.c          | 20 +++++++++++++++++---
 lib/strncpy_from_user.c |  3 +++
 lib/usercopy.c          | 13 +++++++++++--
 4 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 94b285411659..79e736077ef4 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_UACCESS_H__
 #define __LINUX_UACCESS_H__
 
+#include <linux/fault-inject-usercopy.h>
 #include <linux/instrumented.h>
 #include <linux/sched.h>
 #include <linux/thread_info.h>
@@ -82,10 +83,14 @@ __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 static __always_inline __must_check unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
+	long not_copied = should_fail_usercopy(n);
+
+	if (not_copied < 0)
+		not_copied = n;
 	might_fault();
 	instrument_copy_from_user(to, from, n);
 	check_object_size(to, n, false);
-	return raw_copy_from_user(to, from, n);
+	return not_copied + raw_copy_from_user(to, from, n - not_copied);
 }
 
 /**
@@ -104,18 +109,26 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
 static __always_inline __must_check unsigned long
 __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
 {
+	long not_copied = should_fail_usercopy(n);
+
+	if (not_copied < 0)
+		not_copied = n;
 	instrument_copy_to_user(to, from, n);
 	check_object_size(from, n, true);
-	return raw_copy_to_user(to, from, n);
+	return not_copied + raw_copy_to_user(to, from, n - not_copied);
 }
 
 static __always_inline __must_check unsigned long
 __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	long not_copied = should_fail_usercopy(n);
+
+	if (not_copied < 0)
+		not_copied = n;
 	might_fault();
 	instrument_copy_to_user(to, from, n);
 	check_object_size(from, n, true);
-	return raw_copy_to_user(to, from, n);
+	return not_copied + raw_copy_to_user(to, from, n - not_copied);
 }
 
 #ifdef INLINE_COPY_FROM_USER
@@ -123,10 +136,14 @@ static inline __must_check unsigned long
 _copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	unsigned long res = n;
+	long not_copied = should_fail_usercopy(n);
+
+	if (not_copied < 0)
+		not_copied = n;
 	might_fault();
 	if (likely(access_ok(from, n))) {
 		instrument_copy_from_user(to, from, n);
-		res = raw_copy_from_user(to, from, n);
+		res = not_copied + raw_copy_from_user(to, from, n - not_copied);
 	}
 	if (unlikely(res))
 		memset(to + (n - res), 0, res);
@@ -141,10 +158,14 @@ _copy_from_user(void *, const void __user *, unsigned long);
 static inline __must_check unsigned long
 _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	long not_copied = should_fail_usercopy(n);
+
+	if (not_copied < 0)
+		not_copied = n;
 	might_fault();
 	if (access_ok(to, n)) {
 		instrument_copy_to_user(to, from, n);
-		n = raw_copy_to_user(to, from, n);
+		n = not_copied + raw_copy_to_user(to, from, n - not_copied);
 	}
 	return n;
 }
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5e40786c8f12..c55c9bff9b0c 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -2,6 +2,7 @@
 #include <crypto/hash.h>
 #include <linux/export.h>
 #include <linux/bvec.h>
+#include <linux/fault-inject-usercopy.h>
 #include <linux/uio.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
@@ -139,18 +140,26 @@
 
 static int copyout(void __user *to, const void *from, size_t n)
 {
+	long not_copied = should_fail_usercopy(n);
+
+	if (not_copied < 0)
+		return not_copied;
 	if (access_ok(to, n)) {
 		instrument_copy_to_user(to, from, n);
-		n = raw_copy_to_user(to, from, n);
+		n = not_copied + raw_copy_to_user(to, from, n - not_copied);
 	}
 	return n;
 }
 
 static int copyin(void *to, const void __user *from, size_t n)
 {
+	long not_copied = should_fail_usercopy(n);
+
+	if (not_copied < 0)
+		return not_copied;
 	if (access_ok(from, n)) {
 		instrument_copy_from_user(to, from, n);
-		n = raw_copy_from_user(to, from, n);
+		n = not_copied + raw_copy_from_user(to, from, n - not_copied);
 	}
 	return n;
 }
@@ -640,9 +649,14 @@ EXPORT_SYMBOL(_copy_to_iter);
 #ifdef CONFIG_ARCH_HAS_UACCESS_MCSAFE
 static int copyout_mcsafe(void __user *to, const void *from, size_t n)
 {
+	long not_copied = should_fail_usercopy(n);
+
+	if (not_copied < 0)
+		return not_copied;
 	if (access_ok(to, n)) {
 		instrument_copy_to_user(to, from, n);
-		n = copy_to_user_mcsafe((__force void *) to, from, n);
+		n = not_copied + copy_to_user_mcsafe((__force void *) to,
+			       from, n - not_copied);
 	}
 	return n;
 }
diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 34696a348864..f65973007931 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <linux/export.h>
+#include <linux/fault-inject-usercopy.h>
 #include <linux/kasan-checks.h>
 #include <linux/thread_info.h>
 #include <linux/uaccess.h>
@@ -101,6 +102,8 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	might_fault();
 	if (unlikely(count <= 0))
 		return 0;
+	if (should_fail_usercopy(count))
+		return -EFAULT;
 
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)untagged_addr(src);
diff --git a/lib/usercopy.c b/lib/usercopy.c
index b26509f112f9..e79716b4634b 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bitops.h>
+#include <linux/fault-inject-usercopy.h>
 #include <linux/instrumented.h>
 #include <linux/uaccess.h>
 
@@ -9,10 +10,14 @@
 unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	unsigned long res = n;
+	long not_copied = should_fail_usercopy(n);
+
+	if (not_copied < 0)
+		not_copied = n;
 	might_fault();
 	if (likely(access_ok(from, n))) {
 		instrument_copy_from_user(to, from, n);
-		res = raw_copy_from_user(to, from, n);
+		res = not_copied + raw_copy_from_user(to, from, n - not_copied);
 	}
 	if (unlikely(res))
 		memset(to + (n - res), 0, res);
@@ -24,10 +29,14 @@ EXPORT_SYMBOL(_copy_from_user);
 #ifndef INLINE_COPY_TO_USER
 unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	long not_copied = should_fail_usercopy(n);
+
+	if (not_copied < 0)
+		not_copied = n;
 	might_fault();
 	if (likely(access_ok(to, n))) {
 		instrument_copy_to_user(to, from, n);
-		n = raw_copy_to_user(to, from, n);
+		n = not_copied + raw_copy_to_user(to, from, n - not_copied);
 	}
 	return n;
 }
-- 
2.28.0.297.g1956fa8f8d-goog

