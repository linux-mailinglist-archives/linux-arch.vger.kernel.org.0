Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B041A144193
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 17:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgAUQFi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 11:05:38 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:33370 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbgAUQFh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 11:05:37 -0500
Received: by mail-wm1-f73.google.com with SMTP id l11so844463wmi.0
        for <linux-arch@vger.kernel.org>; Tue, 21 Jan 2020 08:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Elct5+lKhC9X7zT8nF9IWixwmqUVlFcvw9suDwdwDnE=;
        b=BBeNCO/VePLcTSLzcCCeGgXVEkSWlMwTu3VbXvcGfhP1iPUsbRj5KE87tzjUQN40gL
         qtcdybbE++t9eKqYrrZWmKpyQMxtWRYUW9igsu7VTcyQVTrKfmvNkcGXC9rGR+ngubcL
         fxwrGSmifI0FAwTwskPPs6jeSV3KUkdmEiNO/kcqwe1mI/W+4vFVTqZpVs7+4OCSxdaP
         0jcEdTQYzAyCAU6gAP4dogHCCMkX93XgLOl/6ZUeQGgMUQly3r5uStCuZFK1ONTR/Ant
         GUGtmCUqytt+ikLWZGbPo4raVo0CxNDZT/VPf4QDfZSatR7VYZ75efKSQnNqvV/nfIji
         4CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Elct5+lKhC9X7zT8nF9IWixwmqUVlFcvw9suDwdwDnE=;
        b=DgT1qDgFovNE/ZdyDDi6LuBKvxZYgktNrNN+zJZHt+B16sqs4+PthyA0xKFKyYJE6r
         k37NWYv3e3lJ4EQf/jPqcM/T72Rxd3F0PuVWNRcGdrio9r/FcNcchBrN/0JDoh0ywXMm
         zT1tc/2ONFVamPY1T7FwbxQPi3zpM9uxiaSpFMuZk/+yjdMBY2Ud3JZajTtAwGUd8DQ5
         gTxFdQUZ5btReumisrx5M4WS2zyeT91LPSOLTTpaBymp/cTWo1q6jzuhyx2shwplAMQi
         ZUH+iSBNaVraqeNd74iKq9xvm0dWD2KTebqdv15P86dWMIQX+wGUUrGZb94gQvV4neCP
         m9SQ==
X-Gm-Message-State: APjAAAVTouRoPM+WTLrG+aNDEPdvztTQoicZF8qrLYNzhhyTaAfypq5i
        Llop4b7IShBtnymnufYoJO1HQJ4jPg==
X-Google-Smtp-Source: APXvYqwi0h8m0qrPFFmbHFrsPfWgG1hho+4RJvofexg3tlhh4RJCdi83g9YTl/d38pRcvILCYcFUDlObMA==
X-Received: by 2002:a05:6000:11c5:: with SMTP id i5mr6021320wrx.102.1579622735534;
 Tue, 21 Jan 2020 08:05:35 -0800 (PST)
Date:   Tue, 21 Jan 2020 17:05:11 +0100
In-Reply-To: <20200121160512.70887-1-elver@google.com>
Message-Id: <20200121160512.70887-4-elver@google.com>
Mime-Version: 1.0
References: <20200121160512.70887-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 4/5] iov_iter: Use generic instrumented.h
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        arnd@arndb.de, viro@zeniv.linux.org.uk, dja@axtens.net,
        christophe.leroy@c-s.fr, mpe@ellerman.id.au, mhiramat@kernel.org,
        rostedt@goodmis.org, mingo@kernel.org,
        christian.brauner@ubuntu.com, daniel@iogearbox.net,
        keescook@chromium.org, cyphar@cyphar.com,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This replaces the kasan instrumentation with generic instrumentation,
implicitly adding KCSAN instrumentation support.

For KASAN no functional change is intended.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Use updated instrumented.h, removing post-hooks for user-copies.
---
 lib/iov_iter.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index fb29c02c6a3c..614b6999d2da 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -8,6 +8,7 @@
 #include <linux/splice.h>
 #include <net/checksum.h>
 #include <linux/scatterlist.h>
+#include <linux/instrumented.h>
 
 #define PIPE_PARANOIA /* for now */
 
@@ -138,7 +139,7 @@
 static int copyout(void __user *to, const void *from, size_t n)
 {
 	if (access_ok(to, n)) {
-		kasan_check_read(from, n);
+		instrument_copy_to_user(to, from, n);
 		n = raw_copy_to_user(to, from, n);
 	}
 	return n;
@@ -147,7 +148,7 @@ static int copyout(void __user *to, const void *from, size_t n)
 static int copyin(void *to, const void __user *from, size_t n)
 {
 	if (access_ok(from, n)) {
-		kasan_check_write(to, n);
+		instrument_copy_from_user(to, from, n);
 		n = raw_copy_from_user(to, from, n);
 	}
 	return n;
@@ -639,7 +640,7 @@ EXPORT_SYMBOL(_copy_to_iter);
 static int copyout_mcsafe(void __user *to, const void *from, size_t n)
 {
 	if (access_ok(to, n)) {
-		kasan_check_read(from, n);
+		instrument_copy_to_user(to, from, n);
 		n = copy_to_user_mcsafe((__force void *) to, from, n);
 	}
 	return n;
-- 
2.25.0.341.g760bfbb309-goog

