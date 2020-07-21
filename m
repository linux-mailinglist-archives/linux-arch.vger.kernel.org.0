Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50150227D0B
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 12:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgGUKar (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 06:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbgGUKap (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 06:30:45 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63691C0619D8
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 03:30:45 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id t36so13943686qtc.16
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 03:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zve33nddAY1CvVFMV1CpDpP9i+R8xzZxDJhHrrAhrZg=;
        b=o+Ls339+l6oe6R/c+fszNAahS+PvwvIihTw2ab2Dgd7Pz+NFkeLhuTOzqA/tK2oKi6
         0OQp0hwrc1zrTqic751h0I50NxcUOJCgN+rmkI0NInw3wudTKPe+lVdMguBFgDsRS7hK
         4vV9/ZHqy97/AU2xumW9R4Hy2mbSeoD5N1fjdzD4p9NE6Qwt9vPnbIHh6AIRsAp4SQCB
         TGWstlXI3lncN3vgRQEslBDdhz/Cm12BroSjn1xlH3rQ1e+zaUQKALrmtAcY4KWKYxS+
         ciorqVf43lqcQmcUMyyqZ/VHnFN0+2t1HYWAt5sVJCPDXhyt6t1ZpitpsNPep4HAItN1
         G3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zve33nddAY1CvVFMV1CpDpP9i+R8xzZxDJhHrrAhrZg=;
        b=WVuEU1HA6xqOluiGW3TCdKNUmvo6KjRdEAQ24IEF+LOyybUIkZ5kLOenUFRNlcoxKQ
         IhJUIgJ15w+lxHknlx3h/tgX3f3bgc0hlBA5YRy/Tq/9taB1QbLKoJttKxTVxEqQJjcN
         fXTn+tpsmowp3tkoPGV3hZQaCkNKLw/TMwgzNrIGiv/aBYcC15fGy1G6dGgku1DRfwWA
         xs7WbmLLCZYLy52Quo5x2cImQjm6qIKQTsqhBxdswdpVEymcKIzv50CLNOG60pXDb3vJ
         vEgPRVHNZVQO73U7UJzAUfab4kGLRMYZcmb/tMlGnEX52CsI/ozwf2PH6i7vUP+1p4V5
         Dknw==
X-Gm-Message-State: AOAM530ud3nfUJaW9F/JE+3GgtpZZwPdsZ+R8UuEkOQS/L5qo2RxeQBm
        mHExOCfgp6tET7dBqnbHcygpWgLQPA==
X-Google-Smtp-Source: ABdhPJw2tEGK3VOnp57lHVU1gox4lhBVs1AB6sYk1Zg3OnrZNUBhv3eRGxqly1/4XBY/WEgaqMAnJscpQw==
X-Received: by 2002:ad4:4a6d:: with SMTP id cn13mr26776898qvb.165.1595327444500;
 Tue, 21 Jul 2020 03:30:44 -0700 (PDT)
Date:   Tue, 21 Jul 2020 12:30:14 +0200
In-Reply-To: <20200721103016.3287832-1-elver@google.com>
Message-Id: <20200721103016.3287832-7-elver@google.com>
Mime-Version: 1.0
References: <20200721103016.3287832-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 6/8] instrumented.h: Introduce read-write instrumentation hooks
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce read-write instrumentation hooks, to more precisely denote an
operation's behaviour.

KCSAN is able to distinguish compound instrumentation, and with the new
instrumentation we then benefit from improved reporting. More
importantly, read-write compound operations should not implicitly be
treated as atomic, if they aren't actually atomic.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/instrumented.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 43e6ea591975..42faebbaa202 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -42,6 +42,21 @@ static __always_inline void instrument_write(const volatile void *v, size_t size
 	kcsan_check_write(v, size);
 }
 
+/**
+ * instrument_read_write - instrument regular read-write access
+ *
+ * Instrument a regular write access. The instrumentation should be inserted
+ * before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_read_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_read_write(v, size);
+}
+
 /**
  * instrument_atomic_read - instrument atomic read access
  *
@@ -72,6 +87,21 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 	kcsan_check_atomic_write(v, size);
 }
 
+/**
+ * instrument_atomic_read_write - instrument atomic read-write access
+ *
+ * Instrument an atomic read-write access. The instrumentation should be
+ * inserted before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_atomic_read_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_atomic_read_write(v, size);
+}
+
 /**
  * instrument_copy_to_user - instrument reads of copy_to_user
  *
-- 
2.28.0.rc0.105.gf9edc3c819-goog

