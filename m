Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BBB222BF2
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 21:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgGPTbD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 15:31:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54413 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729651AbgGPTbC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Jul 2020 15:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594927861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=itxmaf4yhdGWj9YzuV2AdezwoIz6PHh/DK0EyngS2Hg=;
        b=eHUwlmqRhDZZHqNZ1bKZAPQfKBRoTbPYSFXoIAsfavteuLhxeLwu3NVWnyFippjFpPXYYp
        LAf1+gnuznCtz6cEI+vyXd2aZbSN4w7wkAXwZV/Z45j6O4i+5QRa7/Sc0ET9icr23ohhrl
        iuPi+LftdY1I9EiqpNaGF57+HnDlWdk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-j_WkL_bIN7-uNjg-7mnVjg-1; Thu, 16 Jul 2020 15:30:55 -0400
X-MC-Unique: j_WkL_bIN7-uNjg-7mnVjg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8904D800460;
        Thu, 16 Jul 2020 19:30:53 +0000 (UTC)
Received: from llong.com (ovpn-119-61.rdu2.redhat.com [10.10.119.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7321F74F70;
        Thu, 16 Jul 2020 19:30:52 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/5] locking/pvqspinlock: Make pvqsinlock code easier to read
Date:   Thu, 16 Jul 2020 15:29:24 -0400
Message-Id: <20200716192927.12944-3-longman@redhat.com>
In-Reply-To: <20200716192927.12944-1-longman@redhat.com>
References: <20200716192927.12944-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The way that pv_wait_head_or_lock() gets invoked and the dummy oring
of _Q_LOCKED_VAL to its returned value is a bit hard to read. Use
the available pv_enabled() helper function to make the PV and native
paths more explicit and easier to read. It can eliminate the dummy
oring of the return value. There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c          | 12 ++++--------
 kernel/locking/qspinlock_paravirt.h |  6 ++----
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index b9515fcc9b29..b256e2d03817 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -501,16 +501,12 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * been designated yet, there is no way for the locked value to become
 	 * _Q_SLOW_VAL. So both the set_locked() and the
 	 * atomic_cmpxchg_relaxed() calls will be safe.
-	 *
-	 * If PV isn't active, 0 will be returned instead.
-	 *
 	 */
-	if ((val = pv_wait_head_or_lock(lock, node)))
-		goto locked;
-
-	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
+	if (pv_enabled())
+		val = pv_wait_head_or_lock(lock, node);
+	else
+		val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
 
-locked:
 	/*
 	 * claim the lock:
 	 *
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index e84d21aa0722..17878e531f51 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -477,12 +477,10 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 
 	/*
 	 * The cmpxchg() or xchg() call before coming here provides the
-	 * acquire semantics for locking. The dummy ORing of _Q_LOCKED_VAL
-	 * here is to indicate to the compiler that the value will always
-	 * be nozero to enable better code optimization.
+	 * acquire semantics for locking.
 	 */
 gotlock:
-	return (u32)(atomic_read(&lock->val) | _Q_LOCKED_VAL);
+	return (u32)atomic_read(&lock->val);
 }
 
 /*
-- 
2.18.1

