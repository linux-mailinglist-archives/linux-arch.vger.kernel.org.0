Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0366FC48F
	for <lists+linux-arch@lfdr.de>; Tue,  9 May 2023 13:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbjEILIB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 May 2023 07:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbjEILHz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 May 2023 07:07:55 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7980E49E8;
        Tue,  9 May 2023 04:07:53 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aaed87d8bdso40170405ad.3;
        Tue, 09 May 2023 04:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683630472; x=1686222472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/TV1qyfaW4H+ZAf0a23la+r/LhQ1Q6MT9vrNOWkn1M=;
        b=BNRI7BoRJTRQSz1sbFo9zjoWtGciMf5QjZD0+qm+ezlhLAsucT/+9MKc0hETMyOlVR
         pagPRZ245tn37YEGRLuMw5qpTpD/97vJxxivJAbAVswHN8p367daPMBcIPpLE7Gf7kO2
         K5jvlUH59xYoe6xW/wHWK5KhbbhF1hKncYNTnD2X8Q31v/xZjQkDz2hYlxdC8/x1z0kG
         u3iLDP2xfJPhEOrkr1uRnqmp0eqR1k1SfQB2KzzBaB7TTreL5dTrIaIO3X/LejMQYZJm
         IQ4extukaDZ6aoyK1VNzGj+HVzG0vutCCacJqppgJ5nYRhCkzoZeau1I8nwslolEv1Jo
         4lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683630472; x=1686222472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/TV1qyfaW4H+ZAf0a23la+r/LhQ1Q6MT9vrNOWkn1M=;
        b=Ust3C1psqo23ykQalKkZsEQOd3PNq8/lxknbhplFlzEeC6EvX1ElT9CyWAHgUGsOWN
         ACugjFPJl2qwk9JqmmUEuLbvSr42XB3CAz+W6FgRRfy2h/W0V+6EeUhT1revo6h9IQtu
         LdopROuwfRiGeKl5qkuQBY4Es7lEy93uOj05fBB4MPnvcQR2BF4pkcnYOYcGt8h1uc8c
         K0I9FHRt/RSx8lgeHXYDcmXjLd7Os2r4Z946mknXWQDkboT7zyuYAYFodtXVHDg/hVVL
         ROrDQ1BiZPzuj19qxiKvqFo/G07Wi+UoDn2U8Si9F4MTBRBziCzXfgYovbhw3gdOndVm
         Ophg==
X-Gm-Message-State: AC+VfDz+EB5MHGloPdF7O84a9OGbQEOgSjIALDs9O52+Pqoit60MEzua
        8E3kSEffAJbMKeo6eNDMiVEP3lAhAe0=
X-Google-Smtp-Source: ACHHUZ64qyGjldASNgG/esFSMXg5d8ytMBZLNybIsK6SKDIWgWp6SXwzpvfQD5KsO55wsJDen9FEHw==
X-Received: by 2002:a17:902:ec8c:b0:1a6:a8e5:9240 with SMTP id x12-20020a170902ec8c00b001a6a8e59240mr16317498plg.4.1683630472457;
        Tue, 09 May 2023 04:07:52 -0700 (PDT)
Received: from wheely.local0.net ([118.208.131.108])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090270c500b001a641ea111fsm1269923plt.112.2023.05.09.04.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:07:51 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 1/3] hrtimer: balance irq save/restore
Date:   Tue,  9 May 2023 21:07:37 +1000
Message-Id: <20230509110739.241735-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509110739.241735-1-npiggin@gmail.com>
References: <20230509110739.241735-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

hrtimers uses a trick where irq flags are saved initially and then
passed to callers to restore irqs when dropping the lock, which then
re-lock with raw_spin_lock_irq.

This is not actually a bug, but it is one of the few places in the
kernel that may disable irqs when they are already disabled. It would
be nice to have a debug check for that and enforce irq calls are
balanced. It's one thing for core code to be clever, but something like
this in a crufty driver could be a red flag.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/time/hrtimer.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e8c08292defc..8baa36b091f0 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1364,13 +1364,13 @@ static void hrtimer_cpu_base_unlock_expiry(struct hrtimer_cpu_base *base)
  * allows the waiter to acquire the lock and make progress.
  */
 static void hrtimer_sync_wait_running(struct hrtimer_cpu_base *cpu_base,
-				      unsigned long flags)
+				      unsigned long *flags)
 {
 	if (atomic_read(&cpu_base->timer_waiters)) {
-		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
+		raw_spin_unlock_irqrestore(&cpu_base->lock, *flags);
 		spin_unlock(&cpu_base->softirq_expiry_lock);
 		spin_lock(&cpu_base->softirq_expiry_lock);
-		raw_spin_lock_irq(&cpu_base->lock);
+		raw_spin_lock_irqsave(&cpu_base->lock, *flags);
 	}
 }
 
@@ -1424,7 +1424,7 @@ hrtimer_cpu_base_lock_expiry(struct hrtimer_cpu_base *base) { }
 static inline void
 hrtimer_cpu_base_unlock_expiry(struct hrtimer_cpu_base *base) { }
 static inline void hrtimer_sync_wait_running(struct hrtimer_cpu_base *base,
-					     unsigned long flags) { }
+					     unsigned long *flags) { }
 #endif
 
 /**
@@ -1642,7 +1642,7 @@ EXPORT_SYMBOL_GPL(hrtimer_active);
 static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 			  struct hrtimer_clock_base *base,
 			  struct hrtimer *timer, ktime_t *now,
-			  unsigned long flags) __must_hold(&cpu_base->lock)
+			  unsigned long *flags) __must_hold(&cpu_base->lock)
 {
 	enum hrtimer_restart (*fn)(struct hrtimer *);
 	bool expires_in_hardirq;
@@ -1678,7 +1678,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 	 * protected against migration to a different CPU even if the lock
 	 * is dropped.
 	 */
-	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
+	raw_spin_unlock_irqrestore(&cpu_base->lock, *flags);
 	trace_hrtimer_expire_entry(timer, now);
 	expires_in_hardirq = lockdep_hrtimer_enter(timer);
 
@@ -1686,7 +1686,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 
 	lockdep_hrtimer_exit(expires_in_hardirq);
 	trace_hrtimer_expire_exit(timer);
-	raw_spin_lock_irq(&cpu_base->lock);
+	raw_spin_lock_irqsave(&cpu_base->lock, *flags);
 
 	/*
 	 * Note: We clear the running state after enqueue_hrtimer and
@@ -1715,7 +1715,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 }
 
 static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now,
-				 unsigned long flags, unsigned int active_mask)
+				 unsigned long *flags, unsigned int active_mask)
 {
 	struct hrtimer_clock_base *base;
 	unsigned int active = cpu_base->active_bases & active_mask;
@@ -1763,7 +1763,7 @@ static __latent_entropy void hrtimer_run_softirq(struct softirq_action *h)
 	raw_spin_lock_irqsave(&cpu_base->lock, flags);
 
 	now = hrtimer_update_base(cpu_base);
-	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_SOFT);
+	__hrtimer_run_queues(cpu_base, now, &flags, HRTIMER_ACTIVE_SOFT);
 
 	cpu_base->softirq_activated = 0;
 	hrtimer_update_softirq_timer(cpu_base, true);
@@ -1808,7 +1808,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 	}
 
-	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
+	__hrtimer_run_queues(cpu_base, now, &flags, HRTIMER_ACTIVE_HARD);
 
 	/* Reevaluate the clock bases for the [soft] next expiry */
 	expires_next = hrtimer_update_next_event(cpu_base);
@@ -1921,7 +1921,7 @@ void hrtimer_run_queues(void)
 		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 	}
 
-	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
+	__hrtimer_run_queues(cpu_base, now, &flags, HRTIMER_ACTIVE_HARD);
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 }
 
-- 
2.40.1

