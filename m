Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9590E463310
	for <lists+linux-arch@lfdr.de>; Tue, 30 Nov 2021 12:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241030AbhK3Ltn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Nov 2021 06:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241056AbhK3LtM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Nov 2021 06:49:12 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9C2C061799
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:40 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id m18-20020a05600c3b1200b0033283ea5facso6060373wms.1
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T9LcpiESjlbrW6ACmq5IFNnAkv2Wwnn3szo64Ts4MTU=;
        b=r4Nym9IUPqr6smt4hSh29FgX/wEpgW1oWFkMBkLt45lZV4MsS8x2Pp29b/KcYXqGW5
         wkgAwLy1JnLd35I/Fj+l/UEsgKzPaN3fJHplny6OF4yF9Jtq0944uyqDNW80nE8eTOOs
         tD0d68ft7qYxlfnEvLZgygghFhWYO6UbSBwDu9I0tRDGua5IbN6gD97jk1bRW4gRuuZy
         L60TzPcxWQipS6+h/EMoBzRNufVYK1sioP7pHL1JTqKPI5TW33XwwzjSy7RaUlALcE+o
         dtm8pG3WMMblJczibJlop55o0nu+CZMM8tox6oeFdPlHITAjgFrbiy/Zf6uEeXftuYvt
         DRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T9LcpiESjlbrW6ACmq5IFNnAkv2Wwnn3szo64Ts4MTU=;
        b=IlnLsXfoMujPOwGqB92vIUgJHHkc4ObGVBwZ3RC41ONL3xK2hN4YEdGCiYg5Og/3yI
         rBpwzaZTk9kaExmrHx+XJxohA+YwFGyiKmEI+Rt/+I4rhFVpurrvszVwmXGo7a8H5v/5
         q8o86xgJyBs2aKTmvRCn3V5viE942hpiW8F5h+U4v68xogFhftsacJ4o2YLgGcAssucM
         uwC6WteEyO2yL1XJ+h/Y476r5qrGKQaD7xTVO/px2fX3sCD9SL9DGUfwYfDEk0moOaUk
         kQOxmGCB54e6N/riWg7QVSopQSbj9UqUVClusBoPeH2PD+ON+YyRpScZH5cOeJ5NjItX
         XHiQ==
X-Gm-Message-State: AOAM533ozw4jt+l8XwhLba4L08/uK9HD63smOyBvuik1zTauxQHk0VoA
        gDpdubOtIRx7bq118S9mU/Hhmy+oWA==
X-Google-Smtp-Source: ABdhPJyiLlXYxmElXhBKv1qI383tG/tMJUVWxzbrc6gBjqU+GoqEax55tKxqpMzboGdxCm7oCpqAkhpQnw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:86b7:11e9:7797:99f0])
 (user=elver job=sendgmr) by 2002:adf:c406:: with SMTP id v6mr39945592wrf.570.1638272739561;
 Tue, 30 Nov 2021 03:45:39 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:44:23 +0100
In-Reply-To: <20211130114433.2580590-1-elver@google.com>
Message-Id: <20211130114433.2580590-16-elver@google.com>
Mime-Version: 1.0
References: <20211130114433.2580590-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 15/25] locking/barriers, kcsan: Support generic instrumentation
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thus far only smp_*() barriers had been defined by asm-generic/barrier.h
based on __smp_*() barriers, because the !SMP case is usually generic.

With the introduction of instrumentation, it also makes sense to have
asm-generic/barrier.h assist in the definition of instrumented versions
of mb(), rmb(), wmb(), dma_rmb(), and dma_wmb().

Because there is no requirement to distinguish the !SMP case, the
definition can be simpler: we can avoid also providing fallbacks for the
__ prefixed cases, and only check if `defined(__<barrier>)`, to finally
define the KCSAN-instrumented versions.

This also allows for the compiler to complain if an architecture
accidentally defines both the normal and __ prefixed variant.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/asm-generic/barrier.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 27a9c9edfef6..02c4339c8eeb 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -21,6 +21,31 @@
 #define nop()	asm volatile ("nop")
 #endif
 
+/*
+ * Architectures that want generic instrumentation can define __ prefixed
+ * variants of all barriers.
+ */
+
+#ifdef __mb
+#define mb()	do { kcsan_mb(); __mb(); } while (0)
+#endif
+
+#ifdef __rmb
+#define rmb()	do { kcsan_rmb(); __rmb(); } while (0)
+#endif
+
+#ifdef __wmb
+#define wmb()	do { kcsan_wmb(); __wmb(); } while (0)
+#endif
+
+#ifdef __dma_rmb
+#define dma_rmb()	do { kcsan_rmb(); __dma_rmb(); } while (0)
+#endif
+
+#ifdef __dma_wmb
+#define dma_wmb()	do { kcsan_wmb(); __dma_wmb(); } while (0)
+#endif
+
 /*
  * Force strict CPU ordering. And yes, this is required on UP too when we're
  * talking to devices.
-- 
2.34.0.rc2.393.gf8c9666880-goog

