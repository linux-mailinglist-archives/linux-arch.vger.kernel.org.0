Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444A9463328
	for <lists+linux-arch@lfdr.de>; Tue, 30 Nov 2021 12:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241097AbhK3LuR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Nov 2021 06:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241267AbhK3Ltm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Nov 2021 06:49:42 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C9DC06137D
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:46:03 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id l4-20020a05600c1d0400b00332f47a0fa3so12691826wms.8
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hHpI+TkJP++fcdc46vUsOPoUrJOI1E0VxBDtAT4JUtM=;
        b=ZydYBw/EQptiAQjTJgW8VFb6M+tj/jnOJSKAzEOo9ttb4/prBXxenHyAcxKFnhYPtG
         yxkoZSjdkoQwGFG90n0H+8xMHAoecs8kp2mS+zTaZsYuo/VXrNHwT1dCCGqN+qd2xKqO
         A4acfRlS2z6HmsLoxx1UolNjWfJ2+Ztsu6wU/VCsHuubkWa6zG7vvPdxEtYFrhi/J/x1
         SgdPBckdgJ9qE7I2ZNNnAqkYt2+gpBZ+AartGApj/044P+zkOJcXZg2hjzRL7no/XtPz
         MihwHIfIAQnWjB96wkXuEnhFMgqyeDJ1+RyraL9HQrgcKqeYe6aB+N/OeDIQjy/DWPFQ
         OLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hHpI+TkJP++fcdc46vUsOPoUrJOI1E0VxBDtAT4JUtM=;
        b=MXUU9g1PqUPVZiJSYdCXmeD8Idv6eYnKA9G3Fj810Kd7f//pRDTcu5koQ9kmRKbOgT
         2Rgg+HWRjCAH/GbiybuGv+M2zt5nEjGbh7sr2iOu1dtPoXQ3Y4+Y4Oa5FGWP6R4LIs8E
         P2iaMtCMm6LXoWWsZhOMlAfxbZnNzyseDxXzZl+bH/kFyndGqG3GGCfaQBkK86ZyJXX9
         08og32Px6CNo/Rwr55GuSCC1TVrLCtS1T+bnczmmHMrEV44tQJ8pTwICdNIqDv3jDcii
         oahBkjTpxZW0DAMJIUEuTeHo4uDtsnLbiiAEWqlDL45FXcfuy8V8ATBjUuE/Qd2gfsgf
         drxg==
X-Gm-Message-State: AOAM531qML3KqbwqwszHSbDIVE3cjXf8VYfY3YRKTy2aqrVZcZWNR0XQ
        0tFE02AHxRSK7fIFtgern89swhtvuQ==
X-Google-Smtp-Source: ABdhPJxBEJ1Ij4N3anSHCQ6YBfqk8LJXNhrNf/MNCN7ZMLSlwxOUn6GdF8bZmMY3PAFHnunTgtGrJWD/kQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:86b7:11e9:7797:99f0])
 (user=elver job=sendgmr) by 2002:a05:600c:4e07:: with SMTP id
 b7mr4217301wmq.16.1638272761639; Tue, 30 Nov 2021 03:46:01 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:44:32 +0100
In-Reply-To: <20211130114433.2580590-1-elver@google.com>
Message-Id: <20211130114433.2580590-25-elver@google.com>
Mime-Version: 1.0
References: <20211130114433.2580590-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 24/25] compiler_attributes.h: Add __disable_sanitizer_instrumentation
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

From: Alexander Potapenko <glider@google.com>

The new attribute maps to
__attribute__((disable_sanitizer_instrumentation)), which will be
supported by Clang >= 14.0. Future support in GCC is also possible.

This attribute disables compiler instrumentation for kernel sanitizer
tools, making it easier to implement noinstr. It is different from the
existing __no_sanitize* attributes, which may still allow certain types
of instrumentation to prevent false positives.

Signed-off-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* New patch.
---
 include/linux/compiler_attributes.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index b9121afd8733..37e260020221 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -308,6 +308,24 @@
 # define __compiletime_warning(msg)
 #endif
 
+/*
+ * Optional: only supported since clang >= 14.0
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#disable-sanitizer-instrumentation
+ *
+ * disable_sanitizer_instrumentation is not always similar to
+ * no_sanitize((<sanitizer-name>)): the latter may still let specific sanitizers
+ * insert code into functions to prevent false positives. Unlike that,
+ * disable_sanitizer_instrumentation prevents all kinds of instrumentation to
+ * functions with the attribute.
+ */
+#if __has_attribute(disable_sanitizer_instrumentation)
+# define __disable_sanitizer_instrumentation \
+	 __attribute__((disable_sanitizer_instrumentation))
+#else
+# define __disable_sanitizer_instrumentation
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-weak-variable-attribute
-- 
2.34.0.rc2.393.gf8c9666880-goog

