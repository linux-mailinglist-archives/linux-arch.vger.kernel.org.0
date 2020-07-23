Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04DB22AD0D
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 12:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGWK41 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 06:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgGWK40 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 06:56:26 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894A6C0619DC;
        Thu, 23 Jul 2020 03:56:26 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so2996109pjd.3;
        Thu, 23 Jul 2020 03:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B+mLXieEAfXnO/747XGSjyHkJWweuJW45UcNIGomDRA=;
        b=c6FyYWFei/GJd4W55hsLdi161Ij5iiz7XoxIgjk8uWEyUHjj+HzhiwHI9g/9lzjL9J
         8JwVe3kqr/y5qBDb0HaNVOemR+LFDw7OHJVDnej1EW+fUA91rBUAvZcdivH2wG9HyrMA
         3AAZN+m7GRTB8I7TT5YxXOwSvQiUwHnuEDwFGdU/KE5iIQR5Q1gdo2OvaDbfm65T0lE+
         rsA+aUfoJ3VeW58rSNvW1MOQYbzFEC1qnVTjqZi473T5DG0Scw0qWT1x7keIapAeDtLG
         b5GZT7JXPChb3Rx5F+XvVny5702h5KhkLCOO/1hUo32rBmHGDcI3qxfKzfi3AoP0TfnW
         MB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B+mLXieEAfXnO/747XGSjyHkJWweuJW45UcNIGomDRA=;
        b=LKqH+aJAj3wvXwXlW+aPLeJljY6iIq7aysBSF6/RB4RZJZG4CViVGkZb94HY0GVmP0
         5A2+0MI9fkE+9NPtH2ZNFCYxlrEdcCqslYPLCpa9bFTHMbykSFyeCxAeTJPuK8nqGmUz
         OVu2uSNoRGnRJiebMphvdFrfa1n8oNeRns+DwFmRyLDQCZG5JUnJiHoknYdp6fn/EBUH
         S7IAk0l/n7yIxi7rKtgwveFeMjVBScmb1XU4xiBVjz246ksgIdlDCbIvy96Hn8YC7w5N
         LxdJ/TDhIjtuHzeOnjYheBY3m/jaZL5uj/mNgd7AFpw8d1vcxVVrtww+3fIhX/GyYVA2
         trxg==
X-Gm-Message-State: AOAM5306xXprrellYtjJkX1Cfo4QRxweArVxW8DBZ8CcshjtAugSBErZ
        azgNym8JkY9hVsJjfJbt5xtLt5dI
X-Google-Smtp-Source: ABdhPJzn2+x7F7ArPwBbfRDcLnhlqdLSyy4lZ9Qn+NY5m6fLUb48Uxpzopafbl3UM+x1jlxLVUSumg==
X-Received: by 2002:a17:902:b20a:: with SMTP id t10mr3176863plr.185.1595501785905;
        Thu, 23 Jul 2020 03:56:25 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id 204sm2598009pfx.3.2020.07.23.03.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 03:56:25 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled synchronisation with actual irq state
Date:   Thu, 23 Jul 2020 20:56:14 +1000
Message-Id: <20200723105615.1268126-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If an interrupt is not masked by local_irq_disable (e.g., a powerpc perf
interrupt), then it can hit in local_irq_enable() after trace_hardirqs_on()
and before raw_local_irq_enable().

If that interrupt handler calls local_irq_save(), it will call
trace_hardirqs_off() but the local_irq_restore() will not call
trace_hardirqs_on() again because raw_irqs_disabled_flags(flags) is true.

This can lead lockdep_assert_irqs_enabled() to trigger false positive
warnings.

Fix this by being careful to only enable and disable trace_hardirqs with
the outer-most irq enable/disable.

Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

I haven't tested on other architectures but I imagine NMIs in general
might cause a similar problem.

Other architectures might have to be updated for patch 2, but there's
a lot of asm around interrupt/return, so I didn't have a very good
lock. The warnings should be harmless enough and uncover most places
that need updating.

 arch/powerpc/include/asm/hw_irq.h | 11 ++++-------
 include/linux/irqflags.h          | 29 ++++++++++++++++++-----------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 3a0db7b0b46e..35060be09073 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
 #define powerpc_local_irq_pmu_save(flags)			\
 	 do {							\
 		raw_local_irq_pmu_save(flags);			\
-		trace_hardirqs_off();				\
+		if (!raw_irqs_disabled_flags(flags))		\
+			trace_hardirqs_off();			\
 	} while(0)
 #define powerpc_local_irq_pmu_restore(flags)			\
 	do {							\
-		if (raw_irqs_disabled_flags(flags)) {		\
-			raw_local_irq_pmu_restore(flags);	\
-			trace_hardirqs_off();			\
-		} else {					\
+		if (!raw_irqs_disabled_flags(flags))		\
 			trace_hardirqs_on();			\
-			raw_local_irq_pmu_restore(flags);	\
-		}						\
+		raw_local_irq_pmu_restore(flags);		\
 	} while(0)
 #else
 #define powerpc_local_irq_pmu_save(flags)			\
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 6384d2813ded..571ee29ecefc 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -163,26 +163,33 @@ do {						\
  * if !TRACE_IRQFLAGS.
  */
 #ifdef CONFIG_TRACE_IRQFLAGS
-#define local_irq_enable() \
-	do { trace_hardirqs_on(); raw_local_irq_enable(); } while (0)
-#define local_irq_disable() \
-	do { raw_local_irq_disable(); trace_hardirqs_off(); } while (0)
+#define local_irq_enable()				\
+	do {						\
+		trace_hardirqs_on();			\
+		raw_local_irq_enable();			\
+	} while (0)
+
+#define local_irq_disable()				\
+	do {						\
+		bool was_disabled = raw_irqs_disabled(); \
+		raw_local_irq_disable();		\
+		if (!was_disabled)			\
+			trace_hardirqs_off();		\
+	} while (0)
+
 #define local_irq_save(flags)				\
 	do {						\
 		raw_local_irq_save(flags);		\
-		trace_hardirqs_off();			\
+		if (!raw_irqs_disabled_flags(flags))	\
+			trace_hardirqs_off();		\
 	} while (0)
 
 
 #define local_irq_restore(flags)			\
 	do {						\
-		if (raw_irqs_disabled_flags(flags)) {	\
-			raw_local_irq_restore(flags);	\
-			trace_hardirqs_off();		\
-		} else {				\
+		if (!raw_irqs_disabled_flags(flags))	\
 			trace_hardirqs_on();		\
-			raw_local_irq_restore(flags);	\
-		}					\
+		raw_local_irq_restore(flags);		\
 	} while (0)
 
 #define safe_halt()				\
-- 
2.23.0

