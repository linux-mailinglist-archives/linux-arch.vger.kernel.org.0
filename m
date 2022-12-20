Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D77651B57
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 08:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiLTHOY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 02:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiLTHOA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 02:14:00 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2F618B3D;
        Mon, 19 Dec 2022 23:07:22 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id js9so11525185pjb.2;
        Mon, 19 Dec 2022 23:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AwGJvi0Hqvv9JsuJy6Gv715wZTJNC2wfNDuRpG/Z03c=;
        b=eMolG9vHTtOXK18ugSCIT0pCtnwCyoEsJeJ5PFZQGlEJEv8sGasn8k+mDNhl13PHtY
         KxdPALt6iNv1ZxEOScug4CjFT4yCtXaPilRS4KpEie5J9Y8SLqmppp5JrDNEKt+UxiZk
         eqBpTCNCaf/7o148rNd27ULe/kJ9Xn6dxiP231e6ygEywzOKaGrwUesy9DXrmQask2mJ
         QivmeB3xkmUMw8175037K8srGanPjwIp2+itZCK6uHl1Delon502RC/BOMncaixcxKaP
         c0p0fyUNurBXLQPHDAAE3x9UdnNFTS36u+ZdnOICTnOxYQF2w5zemVtMudmeT7rOIbzN
         0jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwGJvi0Hqvv9JsuJy6Gv715wZTJNC2wfNDuRpG/Z03c=;
        b=gPquulXJNuhOIpoQuDEhq2z6kNRJrpGx9JLcx908mWGEILxmKGXsb/AboKNo7Gx2U0
         Rti3PIQ/t4YxeCV40Ab7Dnyk063etWWJzTXtEI7tZIhiUPKQISrrYwkucxwXxOBD73Ox
         5NyGghyD9i7YwigRYXuqAKmwszra49lpriFNNOtoU/o0z72xyvZRcAIUDjCSMx9k1qWk
         7hQD4t7RZ0+x/fGhbPRxDzPk5zOX+YXFMnVBbxxbY4HdJvtfRtR1R/x6Fs+rVD+ysRw3
         4j58p5rX/UiscZ26sQs5GEvbK4+MOsTE2EjXzdgXu9gSeLyC6f4L4mh0fIUujFwE7Qoo
         mz2g==
X-Gm-Message-State: ANoB5pn4/4XKsNAQ9vPbeX5KET5xaY7DRcb0iXFDdfv4UF90BPC/llUq
        PVJvv0AhtkTGsjji7qN3fRIvkdUOryZVIg==
X-Google-Smtp-Source: AA0mqf4iLIizbzTJRsINqgiMybAadqDLhEvMnVzW3qXyXFfY1t4pTIN5jFY0V6pdOozi2j7p8S7Jsg==
X-Received: by 2002:a17:90b:1916:b0:21a:4bf:eeb0 with SMTP id mp22-20020a17090b191600b0021a04bfeeb0mr46812820pjb.28.1671520041576;
        Mon, 19 Dec 2022 23:07:21 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (203-219-149-28.tpgi.com.au. [203.219.149.28])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090ace0a00b00219220edf0dsm7074232pju.48.2022.12.19.23.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 23:07:20 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
Subject: [PATCH] cputime: remove cputime_to_nsecs fallback
Date:   Tue, 20 Dec 2022 17:07:05 +1000
Message-Id: <20221220070705.2958959-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The archs that use cputime_to_nsecs() internally provide their own
definition and don't need the fallback. cputime_to_usecs() unused except
in this fallback, and is not defined anywhere.

This removes the final remnant of the cputime_t code from the kernel.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
This required a couple of tweaks to s390 includes so we're not pulling
asm/cputime.h into the core header unnecessarily. In that case maybe
this can go via s390 tree because the patch should be otherwise quite
trivial. Could it get an ack or two from a core maintainer to support
that?

Thanks,
Nick

 arch/s390/kernel/idle.c       | 2 +-
 arch/s390/kernel/vtime.c      | 2 +-
 include/linux/sched/cputime.h | 9 ---------
 kernel/sched/cputime.c        | 4 ++++
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 4bf1ee293f2b..a6bbceaf7616 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -12,9 +12,9 @@
 #include <linux/notifier.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
-#include <linux/sched/cputime.h>
 #include <trace/events/power.h>
 #include <asm/cpu_mf.h>
+#include <asm/cputime.h>
 #include <asm/nmi.h>
 #include <asm/smp.h>
 #include "entry.h"
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 9436f3053b88..e0a88dcaf5cb 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -7,13 +7,13 @@
  */
 
 #include <linux/kernel_stat.h>
-#include <linux/sched/cputime.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/timex.h>
 #include <linux/types.h>
 #include <linux/time.h>
 #include <asm/alternative.h>
+#include <asm/cputime.h>
 #include <asm/vtimer.h>
 #include <asm/vtime.h>
 #include <asm/cpu_mf.h>
diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
index ce3c58286062..5f8fd5b24a2e 100644
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -8,15 +8,6 @@
  * cputime accounting APIs:
  */
 
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-#include <asm/cputime.h>
-
-#ifndef cputime_to_nsecs
-# define cputime_to_nsecs(__ct)	\
-	(cputime_to_usecs(__ct) * NSEC_PER_USEC)
-#endif
-#endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
-
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
 extern bool task_cputime(struct task_struct *t,
 			 u64 *utime, u64 *stime);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 95fc77853743..af7952f12e6c 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -3,6 +3,10 @@
  * Simple CPU accounting cgroup controller
  */
 
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+ #include <asm/cputime.h>
+#endif
+
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 
 /*
-- 
2.37.2

