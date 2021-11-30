Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483E846331E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Nov 2021 12:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241344AbhK3Lt7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Nov 2021 06:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240983AbhK3LtR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Nov 2021 06:49:17 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FB2C0613B1
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:48 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id n11-20020aa7c68b000000b003e7d68e9874so16699627edq.8
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FxnGx7glVXa5fb5vt97IxdOcLQo6ydeIuX4RCBDcgdw=;
        b=IuT8ETl+CUu5djE2Sc10KkM6Tnru1Bt8YznawbCvRm9Jgvp9dSU0yLe6+joi6N8O7z
         AIQMX+OAPVIR41Cfns6ghKjzo+Oma52RXEvce97BWN8XleA4vFUT7GdZPuKFrpZGlHcF
         6yYRNP/ViTSHKPJfti0Eaj1rJb2iVf9U20oiJZuzUw0D5yJerS3Bzu0/Hx+jtOL+x1E1
         R2wPF1vj6a03NK0VTctonSiFDQ5cYmZGKeIfRYdvtl5e6D9EGeuanhZY7SdpfSTa6yMo
         5PmPh+xd9A8VTGIvQ+j2BqV2x4NHt+irBixkDfvH2/M2xazm3E9FnFudLg/aEvPjG3A7
         dYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FxnGx7glVXa5fb5vt97IxdOcLQo6ydeIuX4RCBDcgdw=;
        b=PMTsoWsPTLr9zT4V2RwciwXQtrgE/JlOs8XXCBA1NPYeGe3zuXNjZxECTWy8fggQAR
         QZvFui4C8mCnpOMwR304hxJJ4AEHRmq4yiMZJUGSrbK7C7hUp55o9zWEOU0Mi2IMJ2dB
         mM+1KJ/ZZVqBefNIasfGhXVkf8pt5fDoVmcKaAozHp/vu7F6Pc8GQOD0C0H1fqeAztg7
         dLH9+26j2GWiiBuN8r9eHUT7PaDlKKDSO1q0nuLjgvYUZaz28G7x1rCD+YE2wwA7BY4l
         qdw1+LKF53hYsqD7klI4FkDACZD1gLC+f6mVZWrKmvRLRvpGvn9EWMmz9Hdqhw7h6TPa
         kYAg==
X-Gm-Message-State: AOAM531J+/mChnCdK8BacEI8rsXBHioFJxQzAB9VmlgDGQaME0oeluUI
        svQ5Elg9ih9/TlrIGjt96SB0Un8k0Q==
X-Google-Smtp-Source: ABdhPJxhBj5XWZjZdXBGffDMCoQxOuz6ni/khGb4YnRO6y4oi2+lwBW5Amf+ofP9vXsmezHPbLSJ3bZlIQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:86b7:11e9:7797:99f0])
 (user=elver job=sendgmr) by 2002:a17:907:9720:: with SMTP id
 jg32mr69349183ejc.304.1638272746945; Tue, 30 Nov 2021 03:45:46 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:44:26 +0100
In-Reply-To: <20211130114433.2580590-1-elver@google.com>
Message-Id: <20211130114433.2580590-19-elver@google.com>
Mime-Version: 1.0
References: <20211130114433.2580590-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 18/25] x86/barriers, kcsan: Use generic instrumentation for
 non-smp barriers
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

Prefix all barriers with __, now that asm-generic/barriers.h supports
defining the final instrumented version of these barriers. The change is
limited to barriers used by x86-64.

Signed-off-by: Marco Elver <elver@google.com>
---
 arch/x86/include/asm/barrier.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 3ba772a69cc8..35389b2af88e 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -19,9 +19,9 @@
 #define wmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "sfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
 #else
-#define mb() 	asm volatile("mfence":::"memory")
-#define rmb()	asm volatile("lfence":::"memory")
-#define wmb()	asm volatile("sfence" ::: "memory")
+#define __mb()	asm volatile("mfence":::"memory")
+#define __rmb()	asm volatile("lfence":::"memory")
+#define __wmb()	asm volatile("sfence" ::: "memory")
 #endif
 
 /**
@@ -51,8 +51,8 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 /* Prevent speculative execution past this barrier. */
 #define barrier_nospec() alternative("", "lfence", X86_FEATURE_LFENCE_RDTSC)
 
-#define dma_rmb()	barrier()
-#define dma_wmb()	barrier()
+#define __dma_rmb()	barrier()
+#define __dma_wmb()	barrier()
 
 #define __smp_mb()	asm volatile("lock; addl $0,-4(%%" _ASM_SP ")" ::: "memory", "cc")
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

