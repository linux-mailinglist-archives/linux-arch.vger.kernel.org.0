Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51940257F70
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 19:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgHaRRr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 13:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgHaRRp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2020 13:17:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD6EC061575;
        Mon, 31 Aug 2020 10:17:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id s13so237955wmh.4;
        Mon, 31 Aug 2020 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1lKywOCgewMULshQ1fhTD1es/WXjCpb90ZcpjghYAz8=;
        b=A5e0XHXEa6iOT1oHt4hMz5PKSs4KoGTwOQaika020CjIZSHDKPl0UwL0/Ma3cAaIYv
         zOtAOwXgCgAb/PrNpxueysMx+6Ag+LsI5mHeW3nsDiqS2muvijWSQjksagTw7uaPByx7
         bgKxIXXIc00TeI2NkdMM9depTcfWH7dMCZHzbPnOV3d/xzIO4L2fR0aykTRuiqQuR6If
         oCIFp2JJLFkaozMrHYVe/qpB0D9Vc69YhsbMdqjVQwDH6DOJiBLciFVXqPegf1g+bT9D
         zu+QG6+IEEHP8ptLLaxVWViI8yhZW6huWtT2sF7ZIPdoMv7K8cZB9XclDjv81DfX5Mhk
         YJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1lKywOCgewMULshQ1fhTD1es/WXjCpb90ZcpjghYAz8=;
        b=q+q4XiT7UsuL1jJcY7s46Iz7qcuQZDTVQQilhk4HFy6AgPXq2RoD9vY72M9EYSlUBg
         h0w6k4EXaZN/olZSZJIdoA9IcuqFBfnBmiub/d2tkvEFkLLbh75SscaHppoLC4CDEMsD
         zwaw5YvxqJG2aWUMg5AGfthFqRa4Qx/1SdvM8/wxoLgNKTUN4fgHph9Uc08eQgDC9b9d
         Ev2NZRH76d0VtbpMKDFU9KKbB7cgrfmvwVeeHD5TytKcC31/d23bMKcbMQn2VtIDLs3l
         /euxbGWL2ji7Z9IgaastrCLQCu8lqbq7tywZ1pTVB2DS5T73J6xYwcFonVlmpv1bFok4
         hQhQ==
X-Gm-Message-State: AOAM532C4taq6rhZSibtI5h9eoC9VnXP8grWzlH0+OF05qHf4z2IMIo/
        aiH9XDhkhocwuOPAPIXQapjJHC1d4DddBQ==
X-Google-Smtp-Source: ABdhPJw1cDEdHjEdwMUef/8wVVYAcrcnABkSqmhqYrykvqv+pOw0EDMk3f3tFp6KNQ173N8Hg30flw==
X-Received: by 2002:a7b:c342:: with SMTP id l2mr295155wmj.153.1598894263651;
        Mon, 31 Aug 2020 10:17:43 -0700 (PDT)
Received: from alinde.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id w15sm840978wro.46.2020.08.31.10.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 10:17:43 -0700 (PDT)
From:   albert.linde@gmail.com
X-Google-Original-From: alinde@google.com
To:     akpm@linux-foundation.org, bp@alien8.de, mingo@redhat.com,
        corbet@lwn.net, tglx@linutronix.de, arnd@arndb.de,
        peterz@infradead.org
Cc:     akinobu.mita@gmail.com, hpa@zytor.com, viro@zeniv.linux.org.uk,
        glider@google.com, andreyknvl@google.com, dvyukov@google.com,
        elver@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, albert.linde@gmail.com,
        Albert van der Linde <alinde@google.com>
Subject: [PATCH v3 2/3] lib, uaccess: add failure injection to usercopy functions
Date:   Mon, 31 Aug 2020 17:17:32 +0000
Message-Id: <20200831171733.955393-3-alinde@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200831171733.955393-1-alinde@google.com>
References: <20200831171733.955393-1-alinde@google.com>
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

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Albert van der Linde <alinde@google.com>
---
v2:
 - removed partial failures

v3:
 - adressed comments from Peter Zijlstra (fixed ordering with might_fault())
---
 include/linux/uaccess.h | 11 ++++++++++-
 lib/iov_iter.c          |  5 +++++
 lib/strncpy_from_user.c |  3 +++
 lib/usercopy.c          |  5 ++++-
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 94b285411659..e3968727e993 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_UACCESS_H__
 #define __LINUX_UACCESS_H__
 
+#include <linux/fault-inject-usercopy.h>
 #include <linux/instrumented.h>
 #include <linux/sched.h>
 #include <linux/thread_info.h>
@@ -83,6 +84,8 @@ static __always_inline __must_check unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	might_fault();
+	if (should_fail_usercopy())
+		return n;
 	instrument_copy_from_user(to, from, n);
 	check_object_size(to, n, false);
 	return raw_copy_from_user(to, from, n);
@@ -104,6 +107,8 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
 static __always_inline __must_check unsigned long
 __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
 {
+	if (should_fail_usercopy())
+		return n;
 	instrument_copy_to_user(to, from, n);
 	check_object_size(from, n, true);
 	return raw_copy_to_user(to, from, n);
@@ -113,6 +118,8 @@ static __always_inline __must_check unsigned long
 __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_fault();
+	if (should_fail_usercopy())
+		return n;
 	instrument_copy_to_user(to, from, n);
 	check_object_size(from, n, true);
 	return raw_copy_to_user(to, from, n);
@@ -124,7 +131,7 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	unsigned long res = n;
 	might_fault();
-	if (likely(access_ok(from, n))) {
+	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
 		instrument_copy_from_user(to, from, n);
 		res = raw_copy_from_user(to, from, n);
 	}
@@ -142,6 +149,8 @@ static inline __must_check unsigned long
 _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_fault();
+	if (should_fail_usercopy())
+		return n;
 	if (access_ok(to, n)) {
 		instrument_copy_to_user(to, from, n);
 		n = raw_copy_to_user(to, from, n);
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
index 34696a348864..e6d5fcc2cdf3 100644
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
@@ -99,6 +100,8 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	unsigned long max_addr, src_addr;
 
 	might_fault();
+	if (should_fail_usercopy())
+		return -EFAULT;
 	if (unlikely(count <= 0))
 		return 0;
 
diff --git a/lib/usercopy.c b/lib/usercopy.c
index b26509f112f9..7413dd300516 100644
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
@@ -25,6 +26,8 @@ EXPORT_SYMBOL(_copy_from_user);
 unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_fault();
+	if (should_fail_usercopy())
+		return n;
 	if (likely(access_ok(to, n))) {
 		instrument_copy_to_user(to, from, n);
 		n = raw_copy_to_user(to, from, n);
-- 
2.28.0.402.g5ffc5be6b7-goog

