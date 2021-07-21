Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702F93D18C2
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jul 2021 23:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhGUU3a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jul 2021 16:29:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhGUU33 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Jul 2021 16:29:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BB8561261;
        Wed, 21 Jul 2021 21:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901805;
        bh=mjSbQ3QYH2A8e1vBzAuMY2gDKECUpXABYYIGQmWw3PI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ts86XKhT1u2Uyz7NisgYddYkR6dna5pBrVMYMih/nt0Zmo89K4Inj3PxI3UVqbNEI
         QTamCL0swY+6Ue3lx0fGcP2+LcZhMUABc+NkOTjzSXylnHncxFJMSZtL6wvLULUL2I
         kIwYhw0UYRU8CrKb26314CkukDratSoPYwgQ8cjrSLUAu+SSZgoRtZrycIPoxlftlD
         yv1jbuPnAYQWfPzrQdc66kCyRGLQ0xYTUXZYO8q+oc62hQT0UaQomxcnj/3dVa+C2z
         4d3NUDrwGN804HGXCE6F4FiqVxsHrM6VHh0KQHCO5MqkHhOmriAtSwF/VcUub4XP5A
         GGhbtIYQNmB6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 10A375C007F; Wed, 21 Jul 2021 14:10:05 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH memory-model 2/4] tools/memory-model: Add example for heuristic lockless reads
Date:   Wed, 21 Jul 2021 14:10:01 -0700
Message-Id: <20210721211003.869892-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit adds example code for heuristic lockless reads, based loosely
on the sem_lock() and sem_unlock() functions.

Reported-by: Manfred Spraul <manfred@colorfullife.com>
[ paulmck: Update per Manfred Spraul and Hillf Danton feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../Documentation/access-marking.txt          | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
index 58bff26198767..be7d507997cf8 100644
--- a/tools/memory-model/Documentation/access-marking.txt
+++ b/tools/memory-model/Documentation/access-marking.txt
@@ -319,6 +319,100 @@ of the ASSERT_EXCLUSIVE_WRITER() is to allow KCSAN to check for a buggy
 concurrent lockless write.
 
 
+Lock-Protected Writes With Heuristic Lockless Reads
+---------------------------------------------------
+
+For another example, suppose that the code can normally make use of
+a per-data-structure lock, but there are times when a global lock
+is required.  These times are indicated via a global flag.  The code
+might look as follows, and is based loosely on nf_conntrack_lock(),
+nf_conntrack_all_lock(), and nf_conntrack_all_unlock():
+
+	bool global_flag;
+	DEFINE_SPINLOCK(global_lock);
+	struct foo {
+		spinlock_t f_lock;
+		int f_data;
+	};
+
+	/* All foo structures are in the following array. */
+	int nfoo;
+	struct foo *foo_array;
+
+	void do_something_locked(struct foo *fp)
+	{
+		bool gf = true;
+
+		/* IMPORTANT: Heuristic plus spin_lock()! */
+		if (!data_race(global_flag)) {
+			spin_lock(&fp->f_lock);
+			if (!smp_load_acquire(&global_flag)) {
+				do_something(fp);
+				spin_unlock(&fp->f_lock);
+				return;
+			}
+			spin_unlock(&fp->f_lock);
+		}
+		spin_lock(&global_lock);
+		/* Lock held, thus global flag cannot change. */
+		if (!global_flag) {
+			spin_lock(&fp->f_lock);
+			spin_unlock(&global_lock);
+			gf = false;
+		}
+		do_something(fp);
+		if (fg)
+			spin_unlock(&global_lock);
+		else
+			spin_lock(&fp->f_lock);
+	}
+
+	void begin_global(void)
+	{
+		int i;
+
+		spin_lock(&global_lock);
+		WRITE_ONCE(global_flag, true);
+		for (i = 0; i < nfoo; i++) {
+			/* Wait for pre-existing local locks. */
+			spin_lock(&fp->f_lock);
+			spin_unlock(&fp->f_lock);
+		}
+	}
+
+	void end_global(void)
+	{
+		smp_store_release(&global_flag, false);
+		/* Pre-existing global lock acquisitions will recheck. */
+		spin_unlock(&global_lock);
+	}
+
+All code paths leading from the do_something_locked() function's first
+read from global_flag acquire a lock, so endless load fusing cannot
+happen.
+
+If the value read from global_flag is true, then global_flag is rechecked
+while holding global_lock, which prevents global_flag from changing.
+If this recheck finds that global_flag is now false, the acquisition
+of ->f_lock prior to the release of global_lock will result in any subsequent
+begin_global() invocation waiting to acquire ->f_lock.
+
+On the other hand, if the value read from global_flag is false, then
+global_flag, then rechecking under ->f_lock combined with synchronization
+with begin_global() guarantees than any erroneous read will cause the
+do_something_locked() function's first do_something() invocation to happen
+before begin_global() returns.  The combination of the smp_load_acquire()
+in do_something_locked() and the smp_store_release() in end_global()
+guarantees that either the do_something_locked() function's first
+do_something() invocation happens after the call to end_global() or that
+do_something_locked() acquires global_lock() and rechecks under the lock.
+
+For this to work, only those foo structures in foo_array[] may be
+passed to do_something_locked().  The reason for this is that the
+synchronization with begin_global() relies on momentarily locking each
+and every foo structure.
+
+
 Lockless Reads and Writes
 -------------------------
 
-- 
2.31.1.189.g2e36527f23

