Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7CD167F28
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgBUNuk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:50:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45518 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbgBUNuk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=KG3O1/yo2pVL3POGn2TdWO+kBU0S42cCRJBJffKoh/4=; b=0SDH+Y2gLwIIEMyLQ1/H47TtXg
        0H8mzNmrP5RXMLghYgmxmb7YvdAGfAJnDzQS/RFJ+v0IH9oVcupakSDkTaCSrFx/qMSA85RoKpOac
        Eo+oKtbM/AjBYGBmsIQe+Rlk2WTc4VtR/SsIwWTSRgimhr6coHLplPOFufzj3pjWzh8fl+QZTiZrB
        JgpWJdNFCV9IsoehOS5cYpG/lGA5+EAs8kuYbU/FbdwOqFKsHP5813s1KRWSjf5xvFSZ3Qnvljz4n
        WV3pIsfQNgq8zhw46Am8cuCQzFjqp3bvsCn8rfTV9SNFuDr8h4iNMmKzW3qE3qglQdsY3s4M4tkzC
        oWTle0uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gu-0006Uw-Gc; Fri, 21 Feb 2020 13:50:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 889113062BA;
        Fri, 21 Feb 2020 14:48:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A6E5C209DB0E9; Fri, 21 Feb 2020 14:50:00 +0100 (CET)
Message-Id: <20200221134215.090538203@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v4 01/27] lockdep: Teach lockdep about "USED" <- "IN-NMI" inversions
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

nmi_enter() does lockdep_off() and hence lockdep ignores everything.

And NMI context makes it impossible to do full IN-NMI tracking like we
do IN-HARDIRQ, that could result in graph_lock recursion.

However, since look_up_lock_class() is lockless, we can find the class
of a lock that has prior use and detect IN-NMI after USED, just not
USED after IN-NMI.

NOTE: By shifting the lockdep_off() recursion count to bit-16, we can
easily differentiate between actual recursion and off.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |   53 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -379,13 +379,13 @@ void lockdep_init_task(struct task_struc
 
 void lockdep_off(void)
 {
-	current->lockdep_recursion++;
+	current->lockdep_recursion += BIT(16);
 }
 EXPORT_SYMBOL(lockdep_off);
 
 void lockdep_on(void)
 {
-	current->lockdep_recursion--;
+	current->lockdep_recursion -= BIT(16);
 }
 EXPORT_SYMBOL(lockdep_on);
 
@@ -575,6 +575,7 @@ static const char *usage_str[] =
 #include "lockdep_states.h"
 #undef LOCKDEP_STATE
 	[LOCK_USED] = "INITIAL USE",
+	[LOCK_USAGE_STATES] = "IN-NMI",
 };
 #endif
 
@@ -787,6 +788,7 @@ static int count_matching_names(struct l
 	return count + 1;
 }
 
+/* used from NMI context -- must be lockless */
 static inline struct lock_class *
 look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 {
@@ -4463,6 +4465,34 @@ void lock_downgrade(struct lockdep_map *
 }
 EXPORT_SYMBOL_GPL(lock_downgrade);
 
+/* NMI context !!! */
+static void verify_lock_unused(struct lockdep_map *lock, struct held_lock *hlock, int subclass)
+{
+	struct lock_class *class = look_up_lock_class(lock, subclass);
+
+	/* if it doesn't have a class (yet), it certainly hasn't been used yet */
+	if (!class)
+		return;
+
+	if (!(class->usage_mask & LOCK_USED))
+		return;
+
+	hlock->class_idx = class - lock_classes;
+
+	print_usage_bug(current, hlock, LOCK_USED, LOCK_USAGE_STATES);
+}
+
+static bool lockdep_nmi(void)
+{
+	if (current->lockdep_recursion & 0xFFFF)
+		return false;
+
+	if (!in_nmi())
+		return false;
+
+	return true;
+}
+
 /*
  * We are not always called with irqs disabled - do that here,
  * and also avoid lockdep recursion:
@@ -4473,8 +4503,25 @@ void lock_acquire(struct lockdep_map *lo
 {
 	unsigned long flags;
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(current->lockdep_recursion)) {
+		/* XXX allow trylock from NMI ?!? */
+		if (lockdep_nmi() && !trylock) {
+			struct held_lock hlock;
+
+			hlock.acquire_ip = ip;
+			hlock.instance = lock;
+			hlock.nest_lock = nest_lock;
+			hlock.irq_context = 2; // XXX
+			hlock.trylock = trylock;
+			hlock.read = read;
+			hlock.check = check;
+			hlock.hardirqs_off = true;
+			hlock.references = 0;
+
+			verify_lock_unused(lock, &hlock, subclass);
+		}
 		return;
+	}
 
 	raw_local_irq_save(flags);
 	check_flags(flags);


