Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452983D946E
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 19:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhG1Rk5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 13:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhG1Rk5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jul 2021 13:40:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3F6A60238;
        Wed, 28 Jul 2021 17:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627494055;
        bh=4ubaP3xAeTeUiJRqybWFV/LSjFpv/srCYUsWlwLVoNA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=caJb4tX2QUDhE4l30ZFZHwbuwgdR4mKqQQfeyia16umy2cpqnC3GtFznHOEFHDgWm
         rFQxInaXMp1O2+XOUyVgl4M9sl5E/jcuAuonO2u80fFgCjK54+kIEN1pU3u3GRzFk9
         MBcmot6lTIknQR6EVH52hYlGdHuplVC8c8W0Esd4OgcICA4Jv27aYjVCM6im7ya5oZ
         huOPaDKzw2QQggjdssBuyT1u1XDkJSyFDE/v8ORKJsszb0mPnjBt+CrBXrmYxIfzkn
         r0nMr1Nuw0AZ4bE4dQSVb3Zh6AlwcPZIDjItvqawTqZ6gOyigG4efTWmJ34hKf7Y+X
         PZl1Bg0lmAQfA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7A5FA5C048D; Wed, 28 Jul 2021 10:40:55 -0700 (PDT)
Date:   Wed, 28 Jul 2021 10:40:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH v2 memory-model 2/4] tools/memory-model: Add example for
 heuristic lockless reads
Message-ID: <20210728174055.GA9718@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
 <20210721211003.869892-2-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721211003.869892-2-paulmck@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit adds example code for heuristic lockless reads, based loosely
on the sem_lock() and sem_unlock() functions.

[ paulmck: Apply Alan Stern and Manfred Spraul feedback. ]

Reported-by: Manfred Spraul <manfred@colorfullife.com>
[ paulmck: Update per Manfred Spraul and Hillf Danton feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
index 58bff26198767..d96fe20ed582a 100644
--- a/tools/memory-model/Documentation/access-marking.txt
+++ b/tools/memory-model/Documentation/access-marking.txt
@@ -319,6 +319,99 @@ of the ASSERT_EXCLUSIVE_WRITER() is to allow KCSAN to check for a buggy
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
+		/* This works even if data_race() returns nonsense. */
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
+		/* global_lock held, thus global flag cannot be set. */
+		spin_lock(&fp->f_lock);
+		spin_unlock(&global_lock);
+		/*
+		 * global_flag might be set here, but begin_global()
+		 * will wait for ->f_lock to be released.
+		 */
+		do_something(fp);
+		spin_unlock(&fp->f_lock);
+	}
+
+	void begin_global(void)
+	{
+		int i;
+
+		spin_lock(&global_lock);
+		WRITE_ONCE(global_flag, true);
+		for (i = 0; i < nfoo; i++) {
+			/*
+			 * Wait for pre-existing local locks.  One at
+			 * a time to avoid lockdep limitations.
+			 */
+			spin_lock(&fp->f_lock);
+			spin_unlock(&fp->f_lock);
+		}
+	}
+
+	void end_global(void)
+	{
+		smp_store_release(&global_flag, false);
+		spin_unlock(&global_lock);
+	}
+
+All code paths leading from the do_something_locked() function's first
+read from global_flag acquire a lock, so endless load fusing cannot
+happen.
+
+If the value read from global_flag is true, then global_flag is
+rechecked while holding ->f_lock, which, if global_flag is now false,
+prevents begin_global() from completing.  It is therefore safe to invoke
+do_something().
+
+Otherwise, if either value read from global_flag is true, then after
+global_lock is acquired global_flag must be false.  The acquisition of
+->f_lock will prevent any call to begin_global() from returning, which
+means that it is safe to release global_lock and invoke do_something().
+
+For this to work, only those foo structures in foo_array[] may be passed
+to do_something_locked().  The reason for this is that the synchronization
+with begin_global() relies on momentarily holding the lock of each and
+every foo structure.
+
+The smp_load_acquire() and smp_store_release() are required because
+changes to a foo structure between calls to begin_global() and
+end_global() are carried out without holding that structure's ->f_lock.
+The smp_load_acquire() and smp_store_release() ensure that the next
+invocation of do_something() from do_something_locked() will see those
+changes.
+
+
 Lockless Reads and Writes
 -------------------------
 
