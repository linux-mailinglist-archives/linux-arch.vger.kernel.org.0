Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B32F3203BD
	for <lists+linux-arch@lfdr.de>; Sat, 20 Feb 2021 06:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhBTFKm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Feb 2021 00:10:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhBTFKl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 20 Feb 2021 00:10:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 591AF60202;
        Sat, 20 Feb 2021 05:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613797800;
        bh=Eb+Mkb/Z90CSARrGwdVygF/YtNDENF7tA64iK9cTe6g=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=BZve10rJfADduovbeuKFFnpA0sV8TFwf6dqbMkAaTvyWaLZ7yNjpHPZH5d4jUUdpB
         ZCPglP1UOmjfuWIuh82CjKPvUhQOye9++CNh548g0clchLGv2LJMbchXk+sXW+6X3/
         Yg3waTmoBhIqPSJPRSwn465CxoBj7McCdXTLGlKjsyr25FjIWKEDQkkOd79busFw4U
         vxDX5UInHmLRppDrRdR3NsDmLuzIyWG7yrnTp+fb/u2Ti56SkmkCnlNY6kxMbMIVTQ
         efwOyPe2W0KNirdIYev08rz0CzAcncdVV9vOykKu3n9F1H6HjX1FAFpJdUaZRPh3bX
         5ALtp7ujbH/Rw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 19196352259C; Fri, 19 Feb 2021 21:10:00 -0800 (PST)
Date:   Fri, 19 Feb 2021 21:10:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@kernel.org, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, elver@google.com, pbonzini@redhat.com
Subject: [PATCH RFC tools/memory-model] Add access-marking documentation
Message-ID: <20210220051000.GA457@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit adapts the "Concurrency bugs should fear the big bad data-race
detector (part 2)" LWN article (https://lwn.net/Articles/816854/)
to kernel-documentation form.  This allows more easily updating the
material as needed.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
[ paulmck: Apply Marco Elver feedback. ]
Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
new file mode 100644
index 0000000..accb79f
--- /dev/null
+++ b/tools/memory-model/Documentation/access-marking.txt
@@ -0,0 +1,474 @@
+MARKING SHARED-MEMORY ACCESSES
+==============================
+
+This document provides guidelines for marking intentionally concurrent
+normal accesses to shared memory, that is "normal" as in accesses that do
+not use read-modify-write atomic operations.  It also describes how to
+document these accesses, both with comments and with special assertions
+processed by the Kernel Concurrency Sanitizer (KCSAN).  This discussion
+builds on an earlier LWN article [1].
+
+
+ACCESS-MARKING OPTIONS
+======================
+
+The Linux kernel provides the following access-marking options:
+
+1.	Plain C-language accesses (unmarked), for example, "a = b;"
+
+2.	Data-race marking, for example, "data_race(a = b);"
+
+3.	READ_ONCE(), for example, "a = READ_ONCE(b);"
+	The various forms of atomic_read() also fit in here.
+
+4.	WRITE_ONCE(), for example, "WRITE_ONCE(a, b);"
+	The various forms of atomic_set() also fit in here.
+
+
+These may be used in combination, as shown in this admittedly improbable
+example:
+
+	WRITE_ONCE(a, b + data_race(c + d) + READ_ONCE(e));
+
+Neither plain C-language accesses nor data_race() (#1 and #2 above) place
+any sort of constraint on the compiler's choice of optimizations [2].
+In contrast, READ_ONCE() and WRITE_ONCE() (#3 and #4 above) restrict the
+compiler's use of code-motion and common-subexpression optimizations.
+Therefore, if a given access is involved in an intentional data race,
+using READ_ONCE() for loads and WRITE_ONCE() for stores is usually
+preferable to data_race(), which in turn is usually preferable to plain
+C-language accesses.
+
+KCSAN will complain about many types of data races involving plain
+C-language accesses, but marking all accesses involved in a given data
+race with one of data_race(), READ_ONCE(), or WRITE_ONCE(), will prevent
+KCSAN from complaining.  Of course, lack of KCSAN complaints does not
+imply correct code.  Therefore, please take a thoughtful approach
+when responding to KCSAN complaints.  Churning the code base with
+ill-considered additions of data_race(), READ_ONCE(), and WRITE_ONCE()
+is unhelpful.
+
+In fact, the following sections describe situations where use of
+data_race() and even plain C-language accesses is preferable to
+READ_ONCE() and WRITE_ONCE().
+
+
+Use of the data_race() Macro
+----------------------------
+
+Here are some situations where data_race() should be used instead of
+READ_ONCE() and WRITE_ONCE():
+
+1.	Data-racy loads from shared variables whose values are used only
+	for diagnostic purposes.
+
+2.	Data-racy reads whose values are checked against marked reload.
+
+3.	Reads whose values feed into error-tolerant heuristics.
+
+4.	Writes setting values that feed into error-tolerant heuristics.
+
+
+Data-Racy Reads for Approximate Diagnostics
+
+Approximate diagnostics include lockdep reports, monitoring/statistics
+(including /proc and /sys output), WARN*()/BUG*() checks whose return
+values are ignored, and other situations where reads from shared variables
+are not an integral part of the core concurrency design.
+
+In fact, use of data_race() instead READ_ONCE() for these diagnostic
+reads can enable better checking of the remaining accesses implementing
+the core concurrency design.  For example, suppose that the core design
+prevents any non-diagnostic reads from shared variable x from running
+concurrently with updates to x.  Then using plain C-language writes
+to x allows KCSAN to detect reads from x from within regions of code
+that fail to exclude the updates.  In this case, it is important to use
+data_race() for the diagnostic reads because otherwise KCSAN would give
+false-positive warnings about these diagnostic reads.
+
+In theory, plain C-language loads can also be used for this use case.
+In practice, doing so is an excellent way to generate KCSAN false
+positives, because KCSAN does not know that the data race is intentional.
+
+
+Data-Racy Reads That Are Checked Against Marked Reload
+
+The values from some reads are not implicitly trusted.  They are instead
+fed into some operation that checks the full value against a later marked
+load from memory, which means that the occasional arbitrarily bogus value
+is not a problem.  For example, if a bogus value is fed into cmpxchg(),
+all that happens is that this cmpxchg() fails, which normally results
+in a retry.  Unless the race condition that resulted in the bogus value
+recurs, this retry will with high probability succeed, so no harm done.
+
+However, please keep in mind that a data_race() load feeding into
+a cmpxchg_relaxed() might still be subject to load fusing on some
+architectures.  Therefore, it is best to capture the return value from
+the failing cmpxchg() for the next iteration of the loop, an approach
+that provides the compiler much less scope for mischievous optimizations.
+Capturing the return value from cmpxchg() also saves a memory reference
+in many cases.
+
+In theory, plain C-language loads can also be used for this use case.
+In practice, doing so is an excellent way to generate KCSAN false
+positives, because KCSAN does not know that the data race is intentional.
+
+
+Reads Feeding Into Error-Tolerant Heuristics
+
+Values from some reads feed into heuristics that can tolerate occasional
+errors.  Such reads can use data_race(), thus allowing KCSAN to focus on
+the other accesses to the relevant shared variables.  But please note
+that data_race() loads are subject to load fusing, which can result in
+consistent errors, which in turn are quite capable of breaking heuristics.
+Therefore use of data_race() should be limited to cases where some other
+code (such as a barrier() call) will force the occasional reload.
+
+In theory, plain C-language loads can also be used for this use case.
+In practice, doing so is an excellent way to generate KCSAN false
+positives, because KCSAN does not know that the data race is intentional.
+
+
+Writes Setting Values Feeding Into Error-Tolerant Heuristics
+
+The values read into error-tolerant heuristics come from somewhere,
+for example, from sysfs.  This means that some code in sysfs writes
+to this same variable, and these writes can also use data_race().
+After all, if the heuristic can tolerate the occasional bogus value
+due to compiler-mangled reads, it can also tolerate the occasional
+compiler-mangled write, at least assuming that the proper value is in
+place once the write completes.
+
+In theory, plain C-language loads can also be used for this use case.
+In practice, doing so is an excellent way to generate KCSAN false
+positives, because KCSAN does not know that the data race is intentional.
+
+
+Use of Plain C-Language Accesses
+--------------------------------
+
+Here are some example situations where plain C-language accesses should
+used instead of READ_ONCE(), WRITE_ONCE(), and data_race():
+
+1.	Accesses protected by mutual exclusion, including strict locking
+	and sequence locking.
+
+2.	Initialization-time and cleanup-time accesses.	This covers a
+	wide variety of situations, including the uniprocessor phase of
+	system boot, variables to be used by not-yet-spawned kthreads,
+	structures not yet published to reference-counted or RCU-protected
+	data structures, and the cleanup side of any of these situations.
+
+3.	Per-CPU variables that are not accessed from other CPUs.
+
+4.	Private per-task variables, including on-stack variables, some
+	fields in the task_struct structure, and task-private heap data.
+
+5.	Any other loads for which there is not supposed to be a concurrent
+	store to that same variable.
+
+6.	Any other stores for which there should be neither concurrent
+	loads nor concurrent stores to that same variable.
+	
+	But note that KCSAN makes two explicit exceptions to this rule
+	by default, refraining from flagging plain C-language stores:
+
+	a.	No matter what.  You can override this default by building
+		with CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n.
+
+	b.	When the store writes the value already contained in
+		that variable.	You can override this default by building
+		with CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n.
+
+	c.	When one of the stores is in an interrupt handler and
+		the other in the interrupted code.  You can override this
+		default by building with CONFIG_KCSAN_INTERRUPT_WATCHER=y.
+
+Note that it is important to use plain C-language accesses in these cases,
+because doing otherwise prevents KCSAN from detecting violations of your
+code's synchronization rules.
+
+
+ACCESS-DOCUMENTATION OPTIONS
+============================
+
+It is important to comment marked accesses so that people reading your
+code, yourself included, are reminded of the synchronization design.
+However, it is even more important to comment plain C-language accesses
+that are intentionally involved in data races.  Such comments are
+needed to remind people reading your code, again, yourself included,
+of how the compiler has been prevented from optimizing those accesses
+into concurrency bugs.
+
+It is also possible to tell KCSAN about your synchronization design.
+For example, ASSERT_EXCLUSIVE_ACCESS(foo) tells KCSAN that any
+concurrent access to variable foo by any other CPU is an error, even
+if that concurrent access is marked with READ_ONCE().  In addition,
+ASSERT_EXCLUSIVE_WRITER(foo) tells KCSAN that although it is OK for there
+to be concurrent reads from foo from other CPUs, it is an error for some
+other CPU to be concurrently writing to foo, even if that concurrent
+write is marked with data_race() or WRITE_ONCE().
+
+Note that although KCSAN will call out data races involving either
+ASSERT_EXCLUSIVE_ACCESS() or ASSERT_EXCLUSIVE_WRITER() on the one hand
+and data_race() writes on the other, KCSAN will not report the location
+of these data_race() writes.
+
+
+EXAMPLES
+========
+
+As noted earlier, the goal is to prevent the compiler from destroying
+your concurrent algorithm, to help the human reader, and to inform
+KCSAN of aspects of your concurrency design.  This section looks at a
+few examples showing how this can be done.
+
+
+Lock Protection With Lockless Diagnostic Access
+-----------------------------------------------
+
+For example, suppose a shared variable "foo" is read only while a
+reader-writer spinlock is read-held, written only while that same
+spinlock is write-held, except that it is also read locklessly for
+diagnostic purposes.  The code might look as follows:
+
+	int foo;
+	DEFINE_RWLOCK(foo_rwlock);
+
+	void update_foo(int newval)
+	{
+		write_lock(&foo_rwlock);
+		foo = newval;
+		do_something(newval);
+		write_unlock(&foo_rwlock);
+	}
+
+	int read_foo(void)
+	{
+		int ret;
+
+		read_lock(&foo_rwlock);
+		do_something_else();
+		ret = foo;
+		read_unlock(&foo_rwlock);
+		return ret;
+	}
+
+	int read_foo_diagnostic(void)
+	{
+		return data_race(foo);
+	}
+
+The reader-writer lock prevents the compiler from introducing concurrency
+bugs into any part of the main algorithm using foo, which means that
+the accesses to foo within both update_foo() and read_foo() can (and
+should) be plain C-language accesses.  One benefit of making them be
+plain C-language accesses is that KCSAN can detect any erroneous lockless
+reads from or updates to foo.  The data_race() in read_foo_diagnostic()
+tells KCSAN that data races are expected, and should be silently
+ignored.  This data_race() also tells the human reading the code that
+read_foo_diagnostic() might sometimes return a bogus value.
+
+However, please note that your kernel must be built with
+CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n in order for KCSAN to
+detect a buggy lockless write.  If you need KCSAN to detect such a
+write even if that write did not change the value of foo, you also
+need CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n.  If you need KCSAN to
+detect such a write happening in an interrupt handler running on the
+same CPU doing the legitimate lock-protected write, you also need
+CONFIG_KCSAN_INTERRUPT_WATCHER=y.  With some or all of these Kconfig
+options set properly, KCSAN can be quite helpful, although it is not
+necessarily a full replacement for hardware watchpoints.  On the other
+hand, neither are hardware watchpoints a full replacement for KCSAN
+because it is not always easy to tell hardware watchpoint to conditionally
+trap on accesses.
+
+
+Lock-Protected Writes With Lockless Reads
+-----------------------------------------
+
+For another example, suppose a shared variable "foo" is updated only
+while holding a spinlock, but is read locklessly.  The code might look
+as follows:
+
+	int foo;
+	DEFINE_SPINLOCK(foo_lock);
+
+	void update_foo(int newval)
+	{
+		spin_lock(&foo_lock);
+		WRITE_ONCE(foo, newval);
+		ASSERT_EXCLUSIVE_WRITER(foo);
+		do_something(newval);
+		spin_unlock(&foo_wlock);
+	}
+
+	int read_foo(void)
+	{
+		do_something_else();
+		return READ_ONCE(foo);
+	}
+
+Because foo is read locklessly, all accesses are marked.  The purpose
+of the ASSERT_EXCLUSIVE_WRITER() is to allow KCSAN to check for a buggy
+concurrent lockless write.
+
+
+Lockless Reads and Writes
+-------------------------
+
+For another example, suppose a shared variable "foo" is both read and
+updated locklessly.  The code might look as follows:
+
+	int foo;
+
+	int update_foo(int newval)
+	{
+		int ret;
+
+		ret = xchg(&foo, newval);
+		do_something(newval);
+		return ret;
+	}
+
+	int read_foo(void)
+	{
+		do_something_else();
+		return READ_ONCE(foo);
+	}
+
+Because foo is accessed locklessly, all accesses are marked.  It does
+not make sense to use ASSERT_EXCLUSIVE_WRITER() in this case because
+there really can be concurrent lockless writers.  KCSAN would
+flag any concurrent plain C-language reads from foo, and given
+CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n, also any concurrent plain
+C-language writes to foo.
+
+
+Lockless Reads and Writes, But With Single-Threaded Initialization
+------------------------------------------------------------------
+
+For yet another example, suppose that foo is initialized in a
+single-threaded manner, but that a number of kthreads are then created
+that locklessly and concurrently access foo.  Some snippets of this code
+might look as follows:
+
+	int foo;
+
+	void initialize_foo(int initval, int nkthreads)
+	{
+		int i;
+
+		foo = initval;
+		ASSERT_EXCLUSIVE_ACCESS(foo);
+		for (i = 0; i < nkthreads; i++)
+			kthread_run(access_foo_concurrently, ...);
+	}
+
+	/* Called from access_foo_concurrently(). */
+	int update_foo(int newval)
+	{
+		int ret;
+
+		ret = xchg(&foo, newval);
+		do_something(newval);
+		return ret;
+	}
+
+	/* Also called from access_foo_concurrently(). */
+	int read_foo(void)
+	{
+		do_something_else();
+		return READ_ONCE(foo);
+	}
+
+The initialize_foo() uses a plain C-language write to foo because there
+are not supposed to be concurrent accesses during initialization.  The
+ASSERT_EXCLUSIVE_ACCESS() allows KCSAN to flag buggy concurrent unmarked
+reads, and the ASSERT_EXCLUSIVE_ACCESS() call further allows KCSAN to
+flag buggy concurrent writes, even if:  (1) Those writes are marked or
+(2) The kernel was built with CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y.
+
+
+Checking Stress-Test Race Coverage
+----------------------------------
+
+When designing stress tests it is important to ensure that race conditions
+of interest really do occur.  For example, consider the following code
+fragment:
+
+	int foo;
+
+	int update_foo(int newval)
+	{
+		return xchg(&foo, newval);
+	}
+
+	int xor_shift_foo(int shift, int mask)
+	{
+		int old, new, newold;
+
+		newold = data_race(foo); /* Checked by cmpxchg(). */
+		do {
+			old = newold;
+			new = (old << shift) ^ mask;
+			newold = cmpxchg(&foo, old, new);
+		} while (newold != old);
+		return old;
+	}
+
+	int read_foo(void)
+	{
+		return READ_ONCE(foo);
+	}
+
+If it is possible for update_foo(), xor_shift_foo(), and read_foo() to be
+invoked concurrently, the stress test should force this concurrency to
+actually happen.  KCSAN can evaluate the stress test when the above code
+is modified to read as follows:
+
+	int foo;
+
+	int update_foo(int newval)
+	{
+		ASSERT_EXCLUSIVE_ACCESS(foo);
+		return xchg(&foo, newval);
+	}
+
+	int xor_shift_foo(int shift, int mask)
+	{
+		int old, new, newold;
+
+		newold = data_race(foo); /* Checked by cmpxchg(). */
+		do {
+			old = newold;
+			new = (old << shift) ^ mask;
+			ASSERT_EXCLUSIVE_ACCESS(foo);
+			newold = cmpxchg(&foo, old, new);
+		} while (newold != old);
+		return old;
+	}
+
+
+	int read_foo(void)
+	{
+		ASSERT_EXCLUSIVE_ACCESS(foo);
+		return READ_ONCE(foo);
+	}
+
+If a given stress-test run does not result in KCSAN complaints from
+each possible pair of ASSERT_EXCLUSIVE_ACCESS() invocations, the
+stress test needs improvement.  If the stress test was to be evaluated
+on a regular basis, it would be wise to place the above instances of
+ASSERT_EXCLUSIVE_ACCESS() under #ifdef so that they did not result in
+false positives when not evaluating the stress test.
+
+
+REFERENCES
+==========
+
+[1] "Concurrency bugs should fear the big bad data-race detector (part 2)"
+    https://lwn.net/Articles/816854/
+
+[2] "Who's afraid of a big bad optimizing compiler?"
+    https://lwn.net/Articles/793253/
