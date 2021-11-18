Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495A14556BD
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 09:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244583AbhKRIR4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 03:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244456AbhKRIRO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Nov 2021 03:17:14 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700F5C079786
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:43 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id r6-20020a1c4406000000b0033119c22fdbso2252444wma.4
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FxnGx7glVXa5fb5vt97IxdOcLQo6ydeIuX4RCBDcgdw=;
        b=JzkdiCAfhGg1puCqyu7Gsl+OgpTDx9etUPuyNiUexgDmRwNvmteFPISWaLcOxGAqLq
         9DosLJK7r1BjtZ7VJduWE8TJKifTcPcJfLgzlYGR3Z/kyu7tjT3NHRQHF9l24ehmTlCC
         orKe2mqttixGcaP/+prUUVqGluahucnMKt5EtPGuD0ppVMZmAzuCqMPxo7nPc3FNfKFz
         ATUxY5vds/9KHGWQHQ6sYWo/VlJRQ+rYWLpPTW6oGYbaZzWbbyAYQVUWXGYRAhjg302o
         o/DdWseUPPUOUUpUFbVVaoFnkBSoDqCEeTVPtHy2ouz2y3UlkvpRPpISS4SSx05GZlzo
         wxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FxnGx7glVXa5fb5vt97IxdOcLQo6ydeIuX4RCBDcgdw=;
        b=rh/z0xsYm4k9E7iqrwIu2SgYqPxMNXF03Pt2aNOCVBGIgsEY7pzIpovhs2EX2cGco2
         mYZKFJKyO09K1C2owmUIdvhRlKh8Xmq9qpuQ19kv/LXPhy9XlxW48c1ZfPcAUUDrMKN/
         4ws2q/BL34RVDaZcbW0f1Z5wTUZuNlNUtllisxDZjm+xxB2GV1yOV+Hrc1eerpowQIx9
         uaGdSImS5pTxLvEJoGEqiOeQ9TqltBW5gnS39ttESIJ+hfwNX58RAyZpzAp+W0rxj/Zz
         i1/VA1ZATyqCWBCKd0SyAvQifD0/fNJjGdKpDtP4o1iaZFXL9Ay9jWx6HiY6miy3eKfZ
         5oEg==
X-Gm-Message-State: AOAM532EVYg6LCccoXseR5OjWkDC6yOm9N/N4nG3Y9nhiCTOGeHnMVnB
        lCX0mGHDK+fiayxFhBZHkf6iCLOF7w==
X-Google-Smtp-Source: ABdhPJz6FEP6GyzxCsPawUoKdjXDHZ0RCNsA/bONWiEy1yb4suQyU+ePefNEIdgwlRx7lrw+TRjThbgJRw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:7155:1b7:fca5:3926])
 (user=elver job=sendgmr) by 2002:a05:600c:1d01:: with SMTP id
 l1mr7928633wms.44.1637223102036; Thu, 18 Nov 2021 00:11:42 -0800 (PST)
Date:   Thu, 18 Nov 2021 09:10:22 +0100
In-Reply-To: <20211118081027.3175699-1-elver@google.com>
Message-Id: <20211118081027.3175699-19-elver@google.com>
Mime-Version: 1.0
References: <20211118081027.3175699-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 18/23] x86/barriers, kcsan: Use generic instrumentation for
 non-smp barriers
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
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

