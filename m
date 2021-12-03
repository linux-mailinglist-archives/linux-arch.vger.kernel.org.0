Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AD04680D0
	for <lists+linux-arch@lfdr.de>; Sat,  4 Dec 2021 00:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383523AbhLCXps (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 18:45:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39204 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354321AbhLCXpq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2021 18:45:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53A94B82985;
        Fri,  3 Dec 2021 23:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044B1C53FAD;
        Fri,  3 Dec 2021 23:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638574939;
        bh=X59XCqCBopk7dCtQ+gdex8i2KSU1dPvRmxvFimD4F7s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d2lVgutRr8P/vsl6vNGyb8wMZA3bm5z9NtROKgeeMfe84jaLy31SiAQLTELYwnkZJ
         Dcpvpo8JfPhDCWbazfV8hFNWiodPJI8mtFT+HBxtateS/1cXkaDnKbhIggvZsdHTB2
         vHHApN3HYnReuuf0ZgwAwY3IJAy6DBdramh9rgrOTUCLEJU2ag28mP3GT3go0n6zQw
         f8pK+jwsIiyXsuMl1m0nAFk27yq0P4DWaJl/XspqX+8USPoSPcyjhb2Sn3a4lWzD8G
         IY7UYJ+yDlPkn/YeckBZDDAiEQay0tep7sFYCf9e6D6gR9zzuie7x6tote9FumtSMD
         zMm3XxuJozpNA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9BA865C1010; Fri,  3 Dec 2021 15:42:18 -0800 (PST)
Date:   Fri, 3 Dec 2021 15:42:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
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
Subject: Re: [PATCH v3 04/25] kcsan: Add core support for a subset of weak
 memory modeling
Message-ID: <20211203234218.GA3308268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211130114433.2580590-1-elver@google.com>
 <20211130114433.2580590-5-elver@google.com>
 <YanbzWyhR0LwdinE@elver.google.com>
 <20211203165020.GR641268@paulmck-ThinkPad-P17-Gen-1>
 <20211203210856.GA712591@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203210856.GA712591@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 03, 2021 at 01:08:56PM -0800, Paul E. McKenney wrote:
> On Fri, Dec 03, 2021 at 08:50:20AM -0800, Paul E. McKenney wrote:
> > On Fri, Dec 03, 2021 at 09:56:45AM +0100, Marco Elver wrote:
> > > On Tue, Nov 30, 2021 at 12:44PM +0100, Marco Elver wrote:
> > > [...]
> > > > v3:
> > > > * Remove kcsan_noinstr hackery, since we now try to avoid adding any
> > > >   instrumentation to .noinstr.text in the first place.
> > > [...]
> > > 
> > > I missed some cleanups after changes from v2 to v3 -- the below cleanup
> > > is missing.
> > > 
> > > Full replacement patch attached.
> > 
> > I pulled this into -rcu with the other patches from your v3 post, thank
> > you all!
> 
> A few quick tests located the following:
> 
> [    0.635383] INFO: trying to register non-static key.
> [    0.635804] The code is fine but needs lockdep annotation, or maybe
> [    0.636194] you didn't initialize this object before use?
> [    0.636194] turning off the locking correctness validator.
> [    0.636194] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc1+ #3208
> [    0.636194] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [    0.636194] Call Trace:
> [    0.636194]  <TASK>
> [    0.636194]  dump_stack_lvl+0x88/0xd8
> [    0.636194]  dump_stack+0x15/0x1b
> [    0.636194]  register_lock_class+0x6b3/0x840
> [    0.636194]  ? __this_cpu_preempt_check+0x1d/0x30
> [    0.636194]  __lock_acquire+0x81/0xee0
> [    0.636194]  ? lock_is_held_type+0xf1/0x160
> [    0.636194]  lock_acquire+0xce/0x230
> [    0.636194]  ? test_barrier+0x490/0x14c7
> [    0.636194]  ? lock_is_held_type+0xf1/0x160
> [    0.636194]  ? test_barrier+0x490/0x14c7
> [    0.636194]  _raw_spin_lock+0x36/0x50
> [    0.636194]  ? test_barrier+0x490/0x14c7
> [    0.636194]  ? kcsan_init+0xf/0x80
> [    0.636194]  test_barrier+0x490/0x14c7
> [    0.636194]  ? kcsan_debugfs_init+0x1f/0x1f
> [    0.636194]  kcsan_selftest+0x47/0xa0
> [    0.636194]  do_one_initcall+0x104/0x230
> [    0.636194]  ? rcu_read_lock_sched_held+0x5b/0xc0
> [    0.636194]  ? kernel_init+0x1c/0x200
> [    0.636194]  do_initcall_level+0xa5/0xb6
> [    0.636194]  do_initcalls+0x66/0x95
> [    0.636194]  do_basic_setup+0x1d/0x23
> [    0.636194]  kernel_init_freeable+0x254/0x2ed
> [    0.636194]  ? rest_init+0x290/0x290
> [    0.636194]  kernel_init+0x1c/0x200
> [    0.636194]  ? rest_init+0x290/0x290
> [    0.636194]  ret_from_fork+0x22/0x30
> [    0.636194]  </TASK>
> 
> When running without the new patch series, this splat does not appear.
> 
> Do I need a toolchain upgrade?  I see the Clang 14.0 in the cover letter,
> but that seems to apply only to non-x86 architectures.
> 
> $ clang-11 -v
> Ubuntu clang version 11.1.0-++20210805102428+1fdec59bffc1-1~exp1~20210805203044.169

And to further extend this bug report, the following patch suppresses
the error.

							Thanx, Paul

------------------------------------------------------------------------

commit d157b802f05bd12cf40bef7a73ca6914b85c865e
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Dec 3 15:35:29 2021 -0800

    kcsan: selftest: Move test spinlock to static global
    
    Running the TREE01 or TREE02 rcutorture scenarios results in the
    following splat:
    
    ------------------------------------------------------------------------
    
     INFO: trying to register non-static key.
     The code is fine but needs lockdep annotation, or maybe
     you didn't initialize this object before use?
     turning off the locking correctness validator.
     CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc1+ #3208
     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
     Call Trace:
      <TASK>
      dump_stack_lvl+0x88/0xd8
      dump_stack+0x15/0x1b
      register_lock_class+0x6b3/0x840
      ? __this_cpu_preempt_check+0x1d/0x30
      __lock_acquire+0x81/0xee0
      ? lock_is_held_type+0xf1/0x160
      lock_acquire+0xce/0x230
      ? test_barrier+0x490/0x14c7
      ? lock_is_held_type+0xf1/0x160
      ? test_barrier+0x490/0x14c7
      _raw_spin_lock+0x36/0x50
      ? test_barrier+0x490/0x14c7
      ? kcsan_init+0xf/0x80
      test_barrier+0x490/0x14c7
      ? kcsan_debugfs_init+0x1f/0x1f
      kcsan_selftest+0x47/0xa0
      do_one_initcall+0x104/0x230
      ? rcu_read_lock_sched_held+0x5b/0xc0
      ? kernel_init+0x1c/0x200
      do_initcall_level+0xa5/0xb6
      do_initcalls+0x66/0x95
      do_basic_setup+0x1d/0x23
      kernel_init_freeable+0x254/0x2ed
      ? rest_init+0x290/0x290
      kernel_init+0x1c/0x200
      ? rest_init+0x290/0x290
      ret_from_fork+0x22/0x30
      </TASK>
    
    ------------------------------------------------------------------------
    
    This appears to be due to this line of code in kernel/kcsan/selftest.c:
    KCSAN_CHECK_READ_BARRIER(spin_unlock(&spinlock)), which operates on a
    spinlock allocated on the stack.  This shot-in-the-dark patch makes the
    spinlock instead be a static global, which suppresses the above splat.
    
    Fixes: 510b49b8d4c9 ("kcsan: selftest: Add test case to check memory barrier instrumentation")
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index 08c6b84b9ebed..05d772c9fe933 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -108,6 +108,8 @@ static bool __init test_matching_access(void)
 	return true;
 }
 
+static DEFINE_SPINLOCK(test_barrier_spinlock);
+
 /*
  * Correct memory barrier instrumentation is critical to avoiding false
  * positives: simple test to check at boot certain barriers are always properly
@@ -122,7 +124,6 @@ static bool __init test_barrier(void)
 #endif
 	bool ret = true;
 	arch_spinlock_t arch_spinlock = __ARCH_SPIN_LOCK_UNLOCKED;
-	DEFINE_SPINLOCK(spinlock);
 	atomic_t dummy;
 	long test_var;
 
@@ -172,8 +173,8 @@ static bool __init test_barrier(void)
 	KCSAN_CHECK_READ_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
 	arch_spin_lock(&arch_spinlock);
 	KCSAN_CHECK_READ_BARRIER(arch_spin_unlock(&arch_spinlock));
-	spin_lock(&spinlock);
-	KCSAN_CHECK_READ_BARRIER(spin_unlock(&spinlock));
+	spin_lock(&test_barrier_spinlock);
+	KCSAN_CHECK_READ_BARRIER(spin_unlock(&test_barrier_spinlock));
 
 	KCSAN_CHECK_WRITE_BARRIER(mb());
 	KCSAN_CHECK_WRITE_BARRIER(wmb());
@@ -202,8 +203,8 @@ static bool __init test_barrier(void)
 	KCSAN_CHECK_WRITE_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
 	arch_spin_lock(&arch_spinlock);
 	KCSAN_CHECK_WRITE_BARRIER(arch_spin_unlock(&arch_spinlock));
-	spin_lock(&spinlock);
-	KCSAN_CHECK_WRITE_BARRIER(spin_unlock(&spinlock));
+	spin_lock(&test_barrier_spinlock);
+	KCSAN_CHECK_WRITE_BARRIER(spin_unlock(&test_barrier_spinlock));
 
 	KCSAN_CHECK_RW_BARRIER(mb());
 	KCSAN_CHECK_RW_BARRIER(wmb());
@@ -235,8 +236,8 @@ static bool __init test_barrier(void)
 	KCSAN_CHECK_RW_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
 	arch_spin_lock(&arch_spinlock);
 	KCSAN_CHECK_RW_BARRIER(arch_spin_unlock(&arch_spinlock));
-	spin_lock(&spinlock);
-	KCSAN_CHECK_RW_BARRIER(spin_unlock(&spinlock));
+	spin_lock(&test_barrier_spinlock);
+	KCSAN_CHECK_RW_BARRIER(spin_unlock(&test_barrier_spinlock));
 
 	kcsan_nestable_atomic_end();
 
