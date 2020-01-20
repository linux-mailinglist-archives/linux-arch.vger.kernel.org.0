Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE01142D13
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2020 15:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgATOT4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jan 2020 09:19:56 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:37587 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgATOTz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 09:19:55 -0500
Received: by mail-wr1-f73.google.com with SMTP id z14so14316989wrs.4
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 06:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sfeBMXRfbNdJgAnQzXh8K2r3zlp1l0BIMpCBNTG8NB8=;
        b=LSSEn3c2vjZu0hxjSiwTarnKg/7zNzHUTp6W7Ip9UWrzRVuZnDkSlhhXZowqJXjtzg
         urMYjrs99RlbOKWjpR219PjE4j0BGuSZn8EVeIa93/+grY7qQJq/0WiwXbIrjVxgOm1U
         RpYw3P/PfAAqTwkQUIp50nOZEQAL84wLy3/uQ6bLtMNh7/DiAIbBrfKA30BsVdqZW4q7
         skKvreC085/NbB3Gk4pzNbXRzJTqQB6ZcMvJJVks+ihIp7O9W+jjY/yGnEzov7U2GzL2
         ox30Q3SZ6FxqWLqaQMtCN34JN1gnd1e0rOsBy+wlefIlQxRUnasgGBOaecV6fIfXPuda
         z1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sfeBMXRfbNdJgAnQzXh8K2r3zlp1l0BIMpCBNTG8NB8=;
        b=tF8t5cr3rKBV5sWoZTpZMTs5FThTRFowxkNXcwnwkl5zzty49qRnI6SQkbYSPtBSzO
         0MHGL7d5J4FXScIttOaSwigsSDKEVxwoAVcKYMelrl1hN3xt5asaMhUsxbSFv/9rpK+y
         ZL31vtgI4J6F02S6d+tNsUsEuIv3ac4Z1LSdHoUsaFVXMjsjFm3TmI87pczX4FF4fu/u
         OYk+66XtCBh4Gj0BOz47vMc61Xt6xr1S33VpJs4Gg6vA2LI1T9DdksvQ6Lcc3UyFU3gP
         +mcL/q1Ro2+Gflt1N/+PXj8x1PJMXQfEC9nSQ1mAqjJrtvyFPAd181i7HDpm6Vas6rpV
         zNqA==
X-Gm-Message-State: APjAAAUMtL9aGbbNViJ2EL4cxaMMVkiPL2EQl1q6meCyjAwyRfociO/E
        5iv8Od7SMT3UY2ca7EHDnCYSrzIlJg==
X-Google-Smtp-Source: APXvYqzovcsGc038QWfGiGHCHo+z/bqiMy5fCLYOpIhcGqbJvd6Ceb9haRPFXz9ZOWkOe+tnEfMRkeuGbQ==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr18199365wrv.259.1579529993355;
 Mon, 20 Jan 2020 06:19:53 -0800 (PST)
Date:   Mon, 20 Jan 2020 15:19:27 +0100
In-Reply-To: <20200120141927.114373-1-elver@google.com>
Message-Id: <20200120141927.114373-5-elver@google.com>
Mime-Version: 1.0
References: <20200120141927.114373-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH 5/5] copy_to_user, copy_from_user: Use generic instrumented.h
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        arnd@arndb.de, viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr,
        dja@axtens.net, mpe@ellerman.id.au, rostedt@goodmis.org,
        mhiramat@kernel.org, mingo@kernel.org,
        christian.brauner@ubuntu.com, daniel@iogearbox.net,
        cyphar@cyphar.com, keescook@chromium.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This replaces the KASAN instrumentation with generic instrumentation,
implicitly adding KCSAN instrumentation support.

For KASAN no functional change is intended.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/uaccess.h | 46 +++++++++++++++++++++++++++++------------
 lib/usercopy.c          | 14 ++++++++-----
 2 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 67f016010aad..d3f2d9a8cae3 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -2,9 +2,9 @@
 #ifndef __LINUX_UACCESS_H__
 #define __LINUX_UACCESS_H__
 
+#include <linux/instrumented.h>
 #include <linux/sched.h>
 #include <linux/thread_info.h>
-#include <linux/kasan-checks.h>
 
 #define uaccess_kernel() segment_eq(get_fs(), KERNEL_DS)
 
@@ -58,18 +58,26 @@
 static __always_inline __must_check unsigned long
 __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 {
-	kasan_check_write(to, n);
+	unsigned long res;
+
 	check_object_size(to, n, false);
-	return raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_pre(to, n);
+	res = raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_post(to, n, res);
+	return res;
 }
 
 static __always_inline __must_check unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
+	unsigned long res;
+
 	might_fault();
-	kasan_check_write(to, n);
 	check_object_size(to, n, false);
-	return raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_pre(to, n);
+	res = raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_post(to, n, res);
+	return res;
 }
 
 /**
@@ -88,18 +96,26 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
 static __always_inline __must_check unsigned long
 __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
 {
-	kasan_check_read(from, n);
+	unsigned long res;
+
 	check_object_size(from, n, true);
-	return raw_copy_to_user(to, from, n);
+	instrument_copy_to_user_pre(from, n);
+	res = raw_copy_to_user(to, from, n);
+	instrument_copy_to_user_post(from, n, res);
+	return res;
 }
 
 static __always_inline __must_check unsigned long
 __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	unsigned long res;
+
 	might_fault();
-	kasan_check_read(from, n);
 	check_object_size(from, n, true);
-	return raw_copy_to_user(to, from, n);
+	instrument_copy_to_user_pre(from, n);
+	res = raw_copy_to_user(to, from, n);
+	instrument_copy_to_user_post(from, n, res);
+	return res;
 }
 
 #ifdef INLINE_COPY_FROM_USER
@@ -109,8 +125,9 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
 	unsigned long res = n;
 	might_fault();
 	if (likely(access_ok(from, n))) {
-		kasan_check_write(to, n);
+		instrument_copy_from_user_pre(to, n);
 		res = raw_copy_from_user(to, from, n);
+		instrument_copy_from_user_post(to, n, res);
 	}
 	if (unlikely(res))
 		memset(to + (n - res), 0, res);
@@ -125,12 +142,15 @@ _copy_from_user(void *, const void __user *, unsigned long);
 static inline __must_check unsigned long
 _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	unsigned long res = n;
+
 	might_fault();
 	if (access_ok(to, n)) {
-		kasan_check_read(from, n);
-		n = raw_copy_to_user(to, from, n);
+		instrument_copy_to_user_pre(from, n);
+		res = raw_copy_to_user(to, from, n);
+		instrument_copy_to_user_post(from, n, res);
 	}
-	return n;
+	return res;
 }
 #else
 extern __must_check unsigned long
diff --git a/lib/usercopy.c b/lib/usercopy.c
index cbb4d9ec00f2..1c20d4423b86 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/uaccess.h>
 #include <linux/bitops.h>
+#include <linux/instrumented.h>
+#include <linux/uaccess.h>
 
 /* out-of-line parts */
 
@@ -10,8 +11,9 @@ unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n
 	unsigned long res = n;
 	might_fault();
 	if (likely(access_ok(from, n))) {
-		kasan_check_write(to, n);
+		instrument_copy_from_user_pre(to, n);
 		res = raw_copy_from_user(to, from, n);
+		instrument_copy_from_user_post(to, n, res);
 	}
 	if (unlikely(res))
 		memset(to + (n - res), 0, res);
@@ -23,12 +25,14 @@ EXPORT_SYMBOL(_copy_from_user);
 #ifndef INLINE_COPY_TO_USER
 unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	unsigned long res = n;
 	might_fault();
 	if (likely(access_ok(to, n))) {
-		kasan_check_read(from, n);
-		n = raw_copy_to_user(to, from, n);
+		instrument_copy_to_user_pre(from, n);
+		res = raw_copy_to_user(to, from, n);
+		instrument_copy_to_user_post(from, n, res);
 	}
-	return n;
+	return res;
 }
 EXPORT_SYMBOL(_copy_to_user);
 #endif
-- 
2.25.0.341.g760bfbb309-goog

