Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC450255C16
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 16:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgH1OPC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgH1OOU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 10:14:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EAAC061232;
        Fri, 28 Aug 2020 07:14:18 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so1081165wmi.1;
        Fri, 28 Aug 2020 07:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3s5xm5mMIo1OIY32xSmZAX1q7xLCQQVvB9Z7RFfiPxk=;
        b=DowxzzQT/xOoC++fb60NiewH3gLIEyEL+egxOcDLZyj0z1CGA4Vtq0NyQrLF0wW+3b
         B2gOWaIkkEgfYyhJHTgKpFRH6pjjPm1RwqtiP4dv+ipYNZDyEPBkQi5H3CNyv/S3DvQl
         v8nI3HeQn2mIhPfE5tjhNlA1LJ3+vzt0zNdHHNcmBEv8O8Axd8yWH4/xwM7pxUJoJG77
         OQo1wdQ927C8l5oFpbLfjppBzBO/8HQ0dT7h9dk75JIKxTvRf0FF4N5sOQSJE/vah7au
         RrNiffqktoUsIIybXsbRgOQA/VIuhZaZfJeKIEHgj+sDBVU8f7eH51vpygKyW08aDdwC
         AOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3s5xm5mMIo1OIY32xSmZAX1q7xLCQQVvB9Z7RFfiPxk=;
        b=aiBGatzt5eTUJfhBYKqmHd6wbIOa8YcICjWiDMnecmZpdkgfkq5J1BVvV/7g7gqrj/
         0E8Xbikz4t2bPZ3olBDf/1A6vgftKkjXPVQceBspR667neUm1LRCqbRbJbA60Sz60oOa
         2GZXTN+6UHEZpe9Zosu8Pw8p4t5V/p9aKQvyjitXtXVf2FVG1M5MFZDDrzJEY1AwiQE5
         /u2J/Tqiuc0QRJ1nNxFz4Op3gE+nNUr4v/qJqrAJWo+8tm/G/wvC+GliOY0nCmaT4HRu
         oGetrGNRiv3yYGhySqU5nU0cQK65JbyoxFKys9P7oy3d2/NCrO+BxcZMZnFQ2enpdXwF
         UYxg==
X-Gm-Message-State: AOAM531el986OMQ6ykV6NpMsr7iWwNhFOwzDW34VEi4+OXv+K+rbbIZp
        wBaZJd6bRy9sOnhJoCutC40=
X-Google-Smtp-Source: ABdhPJxr0sbY0WwALMdRuopyrvwBs+tbb9J8gZGSaRmv0N2zkKq5ecHcqn8ilrGlOf/U2q/fzBsLAA==
X-Received: by 2002:a7b:c772:: with SMTP id x18mr1850240wmk.32.1598624056754;
        Fri, 28 Aug 2020 07:14:16 -0700 (PDT)
Received: from alinde.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id t4sm2248235wre.30.2020.08.28.07.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 07:14:15 -0700 (PDT)
From:   albert.linde@gmail.com
X-Google-Original-From: alinde@google.com
To:     akpm@linux-foundation.org, bp@alien8.de, mingo@redhat.com,
        corbet@lwn.net, tglx@linutronix.de, arnd@arndb.de
Cc:     akinobu.mita@gmail.com, hpa@zytor.com, viro@zeniv.linux.org.uk,
        glider@google.com, andreyknvl@google.com, dvyukov@google.com,
        elver@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, albert.linde@gmail.com,
        Albert van der Linde <alinde@google.com>
Subject: [PATCH v2 2/3] lib, uaccess: add failure injection to usercopy functions
Date:   Fri, 28 Aug 2020 14:13:43 +0000
Message-Id: <20200828141344.2277088-3-alinde@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200828141344.2277088-1-alinde@google.com>
References: <20200828141344.2277088-1-alinde@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Albert van der Linde <alinde@google.com>

To test fault-tolerance of user memory access functions, introduce fault
injection to usercopy functions.

If a failure is expected return either -EFAULT or the total amount of
bytes that were not copied.

Signed-off-by: Albert van der Linde <alinde@google.com>
---
v2:
 - removed partial failures
---
 include/linux/uaccess.h | 11 ++++++++++-
 lib/iov_iter.c          |  5 +++++
 lib/strncpy_from_user.c |  3 +++
 lib/usercopy.c          |  5 ++++-
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 94b285411659..7fd54596af17 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_UACCESS_H__
 #define __LINUX_UACCESS_H__
 
+#include <linux/fault-inject-usercopy.h>
 #include <linux/instrumented.h>
 #include <linux/sched.h>
 #include <linux/thread_info.h>
@@ -82,6 +83,8 @@ __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 static __always_inline __must_check unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
+	if (should_fail_usercopy())
+		return n;
 	might_fault();
 	instrument_copy_from_user(to, from, n);
 	check_object_size(to, n, false);
@@ -104,6 +107,8 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
 static __always_inline __must_check unsigned long
 __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
 {
+	if (should_fail_usercopy())
+		return n;
 	instrument_copy_to_user(to, from, n);
 	check_object_size(from, n, true);
 	return raw_copy_to_user(to, from, n);
@@ -112,6 +117,8 @@ __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
 static __always_inline __must_check unsigned long
 __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	if (should_fail_usercopy())
+		return n;
 	might_fault();
 	instrument_copy_to_user(to, from, n);
 	check_object_size(from, n, true);
@@ -124,7 +131,7 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	unsigned long res = n;
 	might_fault();
-	if (likely(access_ok(from, n))) {
+	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
 		instrument_copy_from_user(to, from, n);
 		res = raw_copy_from_user(to, from, n);
 	}
@@ -141,6 +148,8 @@ _copy_from_user(void *, const void __user *, unsigned long);
 static inline __must_check unsigned long
 _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	if (should_fail_usercopy())
+		return n;
 	might_fault();
 	if (access_ok(to, n)) {
 		instrument_copy_to_user(to, from, n);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5e40786c8f12..eeac08855b24 100644
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
@@ -139,6 +140,8 @@
 
 static int copyout(void __user *to, const void *from, size_t n)
 {
+	if (should_fail_usercopy())
+		return n;
 	if (access_ok(to, n)) {
 		instrument_copy_to_user(to, from, n);
 		n = raw_copy_to_user(to, from, n);
@@ -148,6 +151,8 @@ static int copyout(void __user *to, const void *from, size_t n)
 
 static int copyin(void *to, const void __user *from, size_t n)
 {
+	if (should_fail_usercopy())
+		return n;
 	if (access_ok(from, n)) {
 		instrument_copy_from_user(to, from, n);
 		n = raw_copy_from_user(to, from, n);
diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 34696a348864..eec7065e6342 100644
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
@@ -98,6 +99,8 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 {
 	unsigned long max_addr, src_addr;
 
+	if (should_fail_usercopy())
+		return -EFAULT;
 	might_fault();
 	if (unlikely(count <= 0))
 		return 0;
diff --git a/lib/usercopy.c b/lib/usercopy.c
index b26509f112f9..766b6f8a6937 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bitops.h>
+#include <linux/fault-inject-usercopy.h>
 #include <linux/instrumented.h>
 #include <linux/uaccess.h>
 
@@ -10,7 +11,7 @@ unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n
 {
 	unsigned long res = n;
 	might_fault();
-	if (likely(access_ok(from, n))) {
+	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
 		instrument_copy_from_user(to, from, n);
 		res = raw_copy_from_user(to, from, n);
 	}
@@ -24,6 +25,8 @@ EXPORT_SYMBOL(_copy_from_user);
 #ifndef INLINE_COPY_TO_USER
 unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	if (should_fail_usercopy())
+		return n;
 	might_fault();
 	if (likely(access_ok(to, n))) {
 		instrument_copy_to_user(to, from, n);
-- 
2.28.0.402.g5ffc5be6b7-goog

