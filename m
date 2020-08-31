Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897E62580DF
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 20:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgHaSUx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 14:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729824AbgHaSUo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 14:20:44 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5889021473;
        Mon, 31 Aug 2020 18:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598898041;
        bh=8BvhQjdrDnLQc5z4Mzotmt/Llj0bLYbK8rp9487b+Ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p20qhT4MVry3CA/QSqlVXnylBo3ofWqzSJve73664m3z8BqP/CY0NIoToxW8PPiRQ
         LQK5Rt4GIhPyxkFJAbojfNfDWJc+JKufO4jYfgza4qAAWwokzyPYd9PorzqZQhCcsq
         60Y+akHyvIdl7ZC4Om6Stf5fKV2pULf93FU0TixY=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 8/9] tools/memory-model: Document categories of ordering primitives
Date:   Mon, 31 Aug 2020 11:20:36 -0700
Message-Id: <20200831182037.2034-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831182012.GA1965@paulmck-ThinkPad-P72>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The Linux kernel has a number of categories of ordering primitives, which
are recorded in the LKMM implementation and hinted at by cheatsheet.txt.
But there is no overview of these categories, and such an overview
is needed in order to understand multithreaded LKMM litmus tests.
This commit therefore adds an ordering.txt as well as extracting a
control-dependencies.txt from memory-barriers.txt.  It also updates the
README file.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/README       |  24 +-
 tools/memory-model/Documentation/ordering.txt | 462 ++++++++++++++++++++++++++
 tools/memory-model/control-dependencies.txt   | 256 ++++++++++++++
 3 files changed, 740 insertions(+), 2 deletions(-)
 create mode 100644 tools/memory-model/Documentation/ordering.txt
 create mode 100644 tools/memory-model/control-dependencies.txt

diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
index 4326603..16177aa 100644
--- a/tools/memory-model/Documentation/README
+++ b/tools/memory-model/Documentation/README
@@ -8,10 +8,19 @@ number of places.
 
 This document therefore describes a number of places to start reading
 the documentation in this directory, depending on what you know and what
-you would like to learn:
+you would like to learn.  These are cumulative, that is, understanding
+of the documents earlier in this list is required by the documents later
+in this list.
 
 o	You are new to Linux-kernel concurrency: simple.txt
 
+o	You have some background in Linux-kernel concurrency, and would
+	like an overview of the types of low-level concurrency primitives
+	that are provided:  ordering.txt
+
+	Here, "low level" means atomic operations to single locations in
+	memory.
+
 o	You are familiar with the concurrency facilities that you
 	need, and just want to get started with LKMM litmus tests:
 	litmus-tests.txt
@@ -20,6 +29,9 @@ o	You are familiar with Linux-kernel concurrency, and would
 	like a detailed intuitive understanding of LKMM, including
 	situations involving more than two threads: recipes.txt
 
+o	You would like a detailed understanding of what your compiler can
+	and cannot do to control dependencies: control-dependencies.txt
+
 o	You are familiar with Linux-kernel concurrency and the
 	use of LKMM, and would like a cheat sheet to remind you
 	of LKMM's guarantees: cheatsheet.txt
@@ -37,12 +49,16 @@ o	You are interested in the publications related to LKMM, including
 DESCRIPTION OF FILES
 ====================
 
-Documentation/README
+README
 	This file.
 
 Documentation/cheatsheet.txt
 	Quick-reference guide to the Linux-kernel memory model.
 
+Documentation/control-dependencies.txt
+	A guide to preventing compiler optimizations from destroying
+	your control dependencies.
+
 Documentation/explanation.txt
 	Describes the memory model in detail.
 
@@ -50,6 +66,10 @@ Documentation/litmus-tests.txt
 	Describes the format, features, capabilities, and limitations
 	of the litmus tests that LKMM can evaluate.
 
+Documentation/ordering.txt
+	Describes the Linux kernel's low-level memory-ordering primitives
+	by category.
+
 Documentation/recipes.txt
 	Lists common memory-ordering patterns.
 
diff --git a/tools/memory-model/Documentation/ordering.txt b/tools/memory-model/Documentation/ordering.txt
new file mode 100644
index 0000000..4b2cc55
--- /dev/null
+++ b/tools/memory-model/Documentation/ordering.txt
@@ -0,0 +1,462 @@
+This document expands on the types of ordering that are summarized in
+cheatsheet.txt and used in in various other files.
+
+
+Types of Ordering
+=================
+
+This section describes the types of ordering in roughly decreasing order
+of strength on the theory that stronger ordering is more heavily used
+and easier to understand.  Each of the following types of ordering has
+its own subsection below:
+
+1.	Barriers (also known as "fences").  A barrier orders some or all
+	of the CPU's prior operations against some or all of its subsequent
+	operations.
+
+	a.	Full memory barriers:  More famously, smp_mb(), but this
+		category also includes those non-void (value returning)
+		read-modify-write (RMW) atomic operations whose
+		names do not end in _acquire, _release, or _relaxed.
+		It also includes RCU grace-period operations such as
+		synchronize_rcu(), but at a very high cost, especially
+		in terms of latency.  These operations order all prior
+		memory accesses against all subsequent memory accesses.
+
+	b.	RMW ordering augmentation.  The smp_mb__before_atomic()
+		and smp_mb__after_atomic() are by far the most heavily
+		used of these.	They provide smp_mb()-style full ordering
+		to a later (or earlier, respectively) non-value-returning
+		RMW atomic operations such as atomic_inc().
+
+	c.	Write memory barrier.  This is smp_wmb(), which orders
+		prior marked stores against later marked stores.
+
+	d.	Read memory barrier.  This is smp_rmb(), which orders
+		prior loads against later loads.
+
+2.	Ordered memory accesses.  These operations order themselves
+	against some or all of the CPUs prior or subsequent accesses,
+	depending on the category of operation.
+
+	a.	Release operations.  This category includes
+		smp_store_release(), atomic_set_release(),
+		rcu_assign_pointer(), and value-returning RMW operations
+		whose names end in _release.  These operations order
+		their own store against all of the CPU's subsequent
+		memory accesses.
+
+	b.	Acquire operations.  This category includes
+		smp_load_acquire(), atomic_read_acquire(), and
+		value-returning RMW operations whose names end in
+		_acquire.  These operations order their own load against
+		all of the CPU's prior memory accesses.
+
+	c.	RCU read-side ordering.  This category includes
+		rcu_dereference() and srcu_dereference().  These
+		operations order their load (which must be a pointer)
+		against any of the CPU's subsequent memory accesses
+		whose address has been calculated from the value loaded,
+		that is against any subsequent memory access having
+		an *address dependency* on the value returned by the
+		rcu_dereference() or srcu_dereference().
+
+	d.	Control dependencies.  A control dependency extends
+		from a marked load (READ_ONCE() or stronger) through
+		an "if" condition to a marked store (WRITE_ONCE() or
+		stronger) that is executed only one of the legs of that
+		"if" statement.  Control dependencies are fragile and
+		easily destroyed by compiler optimizers.
+
+		Control dependencies are so named because they are
+		mediated by control-flow instructions such as comparisons
+		and conditional branches.
+
+3.	Unordered accesses, as the name indicates, have no ordering
+	properties except to the extent that they interact with one of
+	the ordering mechanisms called out above.
+
+	a.	Unordered marked operations.  This category includes
+		READ_ONCE(), WRITE_ONCE(), atomic_read(), atomic_set(),
+		volatile variables (such as the "jiffies" counter),
+		value-returning RMW operations whose names end in
+		_relaxed, and non-value-returning RMW operations
+		whose names do not end in either _acquire or _release.
+		These operations provide no ordering guarantees.
+
+	b.	Unmarked C-language accesses.  This category includes
+		accesses to normal variables, that is, variables that are
+		not marked "volatile" and are not C11 atomic variables.
+		These operations provide no ordering guarantees, and
+		further do not guarantee "atomic" access.  For example,
+		the compiler might (and sometimes does) split a plain
+		C-language store into multiple smaller stores.	A load
+		from that same variable running on some other CPU while
+		such a store is executing might see a value that is a
+		mashup of the old value and the new value.
+
+Each of the above categories is covered in more detail by one of the
+following section.
+
+Note well that none of these primitives generate any code in kernels
+built with CONFIG_SMP=n.  Therefore, if you are attempting to order
+accesses to a physical device within a device driver, please use the
+ordering primitives provided for that purpose, for example, mb() instead
+of smp_mb().  See "Linux Kernel Device Drivers" for more information.
+
+
+Full Memory Barriers
+--------------------
+
+A number of Linux-kernel primitives provide full-memory-barrier semantics.
+Suppose that a given CPU invokes such a primitive.  Then all CPUs will
+agree that any earlier action taken by that CPU happened before any
+later action taken by that same CPU.  For example, consider the following:
+
+	WRITE_ONCE(x, 1);
+	smp_mb(); // Order store to x before load from y.
+	r1 = READ_ONCE(y);
+
+All CPUs will agree that the store to "x" happened before the load from "y",
+as indicated by the comment.  And yes, please comment your memory-ordering
+primitives.  It is surprisingly hard to remember what they were for even
+a few months after the fact.
+
+Linux-kernel primitives providing full ordering include the following:
+
+o	The smp_mb() full memory barrier, as shown above.
+
+o	Value-returning read-modify-write (RMW) atomic operations
+	whose names do not end in _acquire, _release, or _relaxed.
+	Value-returning operations can be recognized by their
+	non-void return types.	Examples include atomic_add_return(),
+	atomic_dec_and_test(), cmpxchg(), and xchg().  Note that
+	conditional operations such as cmpxchg() are only guaranteed
+	to provide ordering when they succeed.
+
+	In contrast, non-value-returning RMW atomic operations, that is,
+	those with void return types, do not guarantee any ordering
+	whatsoever.  Nor do value-returning RMW atomic operations
+	whose names end in _relaxed.  Examples of the former include
+	atomic_inc() and atomic_dec(), while examples of the latter
+	include atomic_cmpxchg_relaxed() and atomic_xchg_relaxed().
+
+	Value-returning RMW atomic operations whose names end in _acquire
+	or _release provide limited ordering, and will be described
+	later in this document.
+
+o	RCU's grace-period primitives, including synchronize_rcu(),
+	synchronize_rcu_expedited(), synchronize_srcu() and so on.
+	However, these primitives have orders of magnitude greater
+	overhead than smp_mb(), atomic_xchg(), and so on.  Therefore,
+	RCU's grace-period primitives are typically instead used to
+	provide ordering against RCU read-side critical sections, as
+	documented in their comment headers.  But of course if you need a
+	synchronize_rcu() to interact with readers, it costs you nothing
+	to also rely on its additional semantics as a full memory barrier.
+	Just please carefully comment this, otherwise your future self
+	will hate you.
+
+
+RMW Ordering Augmentation
+-------------------------
+
+As noted in the previous section, non-value-returning RMW operations
+such as atomic_inc() and atomic_dec() guarantee no ordering whatsoever.
+One way to get full ordering is through use of smp_mb(), for example,
+as follows:
+
+Nevertheless, a number of popular CPU families, including x86,
+nevertheless provide full ordering for these primitives.  One way to
+obtain full ordering is to use smp_mb(), like this:
+
+	WRITE_ONCE(x, 1);
+	atomic_inc(&my_counter);
+	smp_mb(); // Inefficient on x86!!!
+	r1 = READ_ONCE(y);
+
+Except that this is inefficient on x86, on which atomic_inc() provides
+full ordering all by itself.  The smp_mb__after_atomic() primitive
+can be used instead:
+
+	WRITE_ONCE(x, 1);
+	atomic_inc(&my_counter);
+	smp_mb__after_atomic(); // Order store to x before load from y.
+	r1 = READ_ONCE(y);
+
+The smp_mb__after_atomic() primitive emits code only on CPUs whose
+atomic_inc() implementations do not guarantee full ordering.  There
+are a number of variations on the smp_mb__*() theme:
+
+o	smp_mb__before_atomic(), which provides full ordering prior
+	to an unordered RMW atomic operation.
+
+o	smp_mb__after_atomic(), which, as shown above, provides full
+	ordering subsequent to an unordered RMW atomic operation.
+
+o	smp_mb__after_spinlock(), which provides full ordering subsequent
+	to a successful spinlock acquisition.  Note that spin_lock() is
+	always successful but spin_trylock() might not be.
+
+o	smp_mb__after_srcu_read_unlock(), which provides full ordering
+	subsequent to an srcu_read_unlock().
+
+Placing code between the smp__*() primitive and the thing whose ordering
+that it is augmenting is generally bad practice because the ordering of
+the intervening code will differ from one CPU architecture to another.
+
+
+Write Memory Barrier
+--------------------
+
+The Linux kernel's write memory barrier is smp_wmb().  If a CPU executes
+the following code:
+
+	WRITE_ONCE(x, 1);
+	smp_wmb();
+	WRITE_ONCE(y, 1);
+
+Then any given CPU will see the write to "x" has having preceded the write
+to "y".  However, you are usually better off using a release store, as
+described in the "Release Operations" section below.
+
+Note that smp_wmb() might fail to provide ordering for unmarked C-language
+stores because profile-driven optimization could determine that the value
+being overwritten is almost always the value being written.  Such a compiler
+might then reasonably decide to transform "x = 1" and "y = 1" as follows:
+
+	if (x != 1)
+		x = 1;
+	smp_wmb(); // BUG: does not order the reads!!!
+	if (y != 1)
+		y = 1;
+
+Therefore, if you need to use smp_wmb() with unmarked C-language
+writes, please make sure that your compiler will not make this sort
+of transformation.
+
+
+Read Memory Barrier
+-------------------
+
+The Linux kernel's read memory barrier is smp_rmb().  If a CPU executes
+the following code:
+
+	r0 = READ_ONCE(y);
+	smp_rmb();
+	r1 = READ_ONCE(x);
+
+Then any given CPU will see the read from "y" as having preceded the read from
+"x".  However, you are usually better off using an acquire load, as described
+in the "Acquire Operations" section below.
+
+
+Release Operations
+------------------
+
+The smp_wmb() example shown above is usually improved by instead using
+a release store:
+
+	WRITE_ONCE(x, 1);
+	smp_store_release(&y, 1);
+
+This saves a line of code, and more important makes it easier to connect
+up the different pieces of the concurrent algorithm.  The variable stored
+to by the smp_store_release(), in this case "y", will normally be used
+in an acquire operation in the other piece of the concurrent algorithm.
+
+There is a wide variety of release operations:
+
+o	Store operations, including smp_store_release(),
+	atomic_set_release(), and atomic_long_set_release().
+
+o	RCU's rcu_assign_pointer() operation.  This is the same as
+	smp_store_release() except that: (1) It takes the pointer
+	to be assigned to instead of a pointer to that pointer,
+	as smp_store_release() would, (2) It is intended to be used
+	in conjunction with rcu_dereference() and similar, and
+	(3) It checks for an RCU-protected pointer.
+
+o	Value-returning RMW operations whose names end in _release,
+	such as atomic_fetch_add_release() and cmpxchg_release().
+	Note that release ordering is provided only against the
+	memory-store portion of the RMW operation.  Note also that
+	conditional operations such as cmpxchg_release() are
+	only guaranteed to provide ordering when they succeed.
+
+As mentioned earlier, release operations are often paired with
+acquire operations, which are the subject of the next section.
+
+
+Acquire Operations
+------------------
+
+The smp_rmb() example shown above is usually improved by instead using
+an acquire load:
+
+	r0 = smp_load_acquire(&y);
+	r1 = READ_ONCE(x);
+
+As with smp_store_release(), this saves a line of code and makes it easier
+to connect the different pieces of the concurrent algorithm by looking for
+the smp_store_release() that stores to "y".
+
+There are a couple of categories of acquire operations:
+
+o	Load operations, including smp_load_acquire(),
+	atomic_read_acquire(), and atomic64_read_acquire().
+
+o	Value-returning RMW operations whose names end in _acquire, such
+	as atomic_xchg_acquire() and atomic_cmpxchg_acquire().	Note that
+	release ordering is provided only against the memory-load portion
+	of the RMW operation.  Note also that conditional operations
+	such as atomic_cmpxchg_acquire() are only guaranteed to provide
+	ordering when they succeed.
+
+Symmetry being what it is, acquire operations are often paired with
+release operations.
+
+
+RCU Read-Side Ordering
+----------------------
+
+There are two major types of RCU read-side ordering:
+
+o	Marking of RCU read-side critical sections, for example,
+	via rcu_read_lock() and rcu_read_unlock().  These operations
+	incur very low overhead because they interact only with
+	the corresponding grace-period primitives, in this case,
+	synchronize_rcu() and friends.	The way this works is that
+	if a given call to synchronize_rcu() cannot prove that it
+	started before a given call to rcu_read_lock(), then that
+	synchronize_rcu() is not permitted to return until the matching
+	rcu_read_unlock() is reached.
+
+	For more information, please see the synchronize_rcu() docbook
+	header comment and the material in Documentation/RCU.
+
+o	Accessing RCU-protected pointers via rcu_dereference()
+	and friends.  A call to rcu_dereference() is usually paired
+	with a call to rcu_assign_pointer() in much the same way
+	that a call to smp_load_acquire() could be paired with a
+	call to smp_store_release().  Calls to rcu_dereference() and
+	rcu_assign_pointer are often buried in other APIs, for example,
+	the RCU list API members defined in include/linux/rculist.h.
+	For more information, please see the docbook headers in that
+	file and again the material in Documentation/RCU.
+
+	If there is any significant processing of the pointer value
+	between the rcu_dereference() that returned it and a later
+	dereference(), please read Documentation/RCU/rcu_dereference.txt.
+
+It can also be quite helpful to review uses in the Linux kernel.
+
+
+Control Dependencies
+--------------------
+
+A control dependency can enforce ordering between an READ_ONCE() and
+a WRITE_ONCE() when there is an "if" condition between them.  The
+classic example is as follows:
+
+	q = READ_ONCE(a);
+	if (q) {
+		WRITE_ONCE(b, 1);
+	}
+
+In this case, all CPUs would see the read from "a" as happening before
+the write to "b".
+
+However, control dependencies are easily destroyed by compiler
+optimizations.  Please see the "control-dependencies.txt" file for
+more information.
+
+
+Unordered Marked Operations
+---------------------------
+
+Unordered operations to different variables are just that, unordered.
+However, if a group of CPUs apply these operations to a single variable,
+all the CPUs will agree on the operation order.  Of course, it is also
+possible to constrain reordering of unordered operations to different
+variables using the various mechanisms described earlier in this document.
+
+These operations come in three categories:
+
+o	Marked writes, such as WRITE_ONCE() and atomic_set().  These
+	primitives prevent the compiler from a number of destructive
+	optimizations such as omitting an early write to a variable
+	in favor of a later write to that same variable.  They provide
+	no ordering guarantees, and in fact many CPUs will happily
+	reorder marked writes with each other or with other unordered
+	operations, unless these operations are on the same variable.
+
+o	Marked reads, such as READ_ONCE() and atomic_read().  These
+	primitives prevent the compiler from a number of destructive
+	optimizations such as fusing a pair of successive reads from
+	the same variable into a single read.  They provide no ordering
+	guarantees, and in fact many CPUs will happily reorder marked
+	reads with each other or with other unordered operations, unless
+	these operations are on the same variable.
+
+o	Unordered RMW atomic operations.  These are non-value-returning
+	RMW atomic operations whose names do not end in _acquire or
+	_release, and also value-returning RMW operations whose names
+	end in _relaxed.  Examples include atomic_add(), atomic_or(),
+	and atomic64_fetch_xor_relaxed().  These operations do carry
+	out the specified RMW operation atomically, for example, five
+	concurrent atomic_add() operations applied to a given variable
+	will reliably increase the value of that variable by five.
+	However, many CPUs will happily reorder these operations with
+	each other or with other unordered operations.
+
+	This category of operations can be efficiently ordered using
+	smp_mb__before_atomic() and smp_mb__after_atomic().  as was
+	discussed in the "RMW Ordering Augmentation" section
+
+In short, these operations can be freely reordered unless they are all
+operating on a single variable or unless they are constrained by one of
+the operations called out earlier in this document.
+
+
+Unmarked C-Language Accesses
+----------------------------
+
+Unmarked C-language accesses are unordered, and are also subject to
+any number of compiler optimizations, many of which can break your
+concurrent code.  It is possible to used unmarked C-language accesses for
+shared variables that are subject to concurrent access, but great care
+is required on an ongoing basis.  The compiler-constraining barrier()
+primitive can be helpful, as can the various ordering primitives discussed
+in this document.  It nevertheless bears repeating that use of unmarked
+C-language accesses requires careful attention to not just your code,
+but to all the compilers that might be used to build it.
+
+Here are some ways of using unmarked C-language accesses for shared
+variables without such worries:
+
+o	Guard all accesses to a given variable by a particular lock,
+	so that there are never concurrent conflicting accesses to that
+	variable.  (There are "conflicting accesses" when at least one of
+	the concurrent accesses to a variable is an unmarked C-language
+	access and when at least one of those accesses is a write.)
+
+o	As above, but using other synchronization primitives such
+	as reader-writer locks or sequence locks as designed.
+
+o	Restrict use of a given variable to statistics or heuristics
+	where the occasional bogus value can be tolerated.
+
+If you need to live more dangerously, please do take the time to
+understand the compilers.  One place to start is these two LWN
+articles:
+
+Who's afraid of a big bad optimizing compiler?
+	https://lwn.net/Articles/793253
+Calibrating your fear of big bad optimizing compilers
+	https://lwn.net/Articles/799218
+
+Used properly, unmarked C-language accesses can reduce overhead on
+fastpaths.  However, the price is great care and continual attention
+to your compiler as new versions come out and as new optimizations
+are enabled.
diff --git a/tools/memory-model/control-dependencies.txt b/tools/memory-model/control-dependencies.txt
new file mode 100644
index 0000000..366520c
--- /dev/null
+++ b/tools/memory-model/control-dependencies.txt
@@ -0,0 +1,256 @@
+CONTROL DEPENDENCIES
+====================
+
+Control dependencies can be a bit tricky because current compilers do
+not understand them.  The purpose of this section is to help you prevent
+the compiler's ignorance from breaking your code.
+
+A load-load control dependency requires a full read memory barrier, not
+simply a data dependency barrier to make it work correctly.  Consider the
+following bit of code:
+
+	q = READ_ONCE(a);
+	if (q) {
+		<data dependency barrier>  /* BUG: No data dependency!!! */
+		p = READ_ONCE(b);
+	}
+
+This will not have the desired effect because there is no actual data
+dependency, but rather a control dependency that the CPU may short-circuit
+by attempting to predict the outcome in advance, so that other CPUs see
+the load from b as having happened before the load from a.  In such a
+case what's actually required is:
+
+	q = READ_ONCE(a);
+	if (q) {
+		<read barrier>
+		p = READ_ONCE(b);
+	}
+
+However, stores are not speculated.  This means that ordering -is- provided
+for load-store control dependencies, as in the following example:
+
+	q = READ_ONCE(a);
+	if (q) {
+		WRITE_ONCE(b, 1);
+	}
+
+Control dependencies pair normally with other types of barriers.
+That said, please note that neither READ_ONCE() nor WRITE_ONCE()
+are optional! Without the READ_ONCE(), the compiler might combine the
+load from "a" with other loads from "a".  Without the WRITE_ONCE(),
+the compiler might combine the store to "b" with other stores to "b",
+or, worse yet, convert the store into a check followed by a store.
+
+Worse yet, if the compiler is able to prove (say) that the value of
+variable "a" is always non-zero, it would be well within its rights
+to optimize the original example by eliminating the "if" statement
+as follows:
+
+	q = a;
+	b = 1;  /* BUG: Compiler and CPU can both reorder!!! */
+
+So don't leave out either the READ_ONCE() or the WRITE_ONCE().
+
+It is tempting to try to enforce ordering on identical stores on both
+branches of the "if" statement as follows:
+
+	q = READ_ONCE(a);
+	if (q) {
+		barrier();
+		WRITE_ONCE(b, 1);
+		do_something();
+	} else {
+		barrier();
+		WRITE_ONCE(b, 1);
+		do_something_else();
+	}
+
+Unfortunately, current compilers will transform this as follows at high
+optimization levels:
+
+	q = READ_ONCE(a);
+	barrier();
+	WRITE_ONCE(b, 1);  /* BUG: No ordering vs. load from a!!! */
+	if (q) {
+		/* WRITE_ONCE(b, 1); -- moved up, BUG!!! */
+		do_something();
+	} else {
+		/* WRITE_ONCE(b, 1); -- moved up, BUG!!! */
+		do_something_else();
+	}
+
+Now there is no conditional between the load from "a" and the store to
+"b", which means that the CPU is within its rights to reorder them:
+The conditional is absolutely required, and must be present in the
+assembly code even after all compiler optimizations have been applied.
+Therefore, if you need ordering in this example, you need explicit
+memory barriers, for example, smp_store_release():
+
+	q = READ_ONCE(a);
+	if (q) {
+		smp_store_release(&b, 1);
+		do_something();
+	} else {
+		smp_store_release(&b, 1);
+		do_something_else();
+	}
+
+In contrast, without explicit memory barriers, two-legged-if control
+ordering is guaranteed only when the stores differ, for example:
+
+	q = READ_ONCE(a);
+	if (q) {
+		WRITE_ONCE(b, 1);
+		do_something();
+	} else {
+		WRITE_ONCE(b, 2);
+		do_something_else();
+	}
+
+The initial READ_ONCE() is still required to prevent the compiler from
+proving the value of "a".
+
+In addition, you need to be careful what you do with the local variable "q",
+otherwise the compiler might be able to guess the value and again remove
+the needed conditional.  For example:
+
+	q = READ_ONCE(a);
+	if (q % MAX) {
+		WRITE_ONCE(b, 1);
+		do_something();
+	} else {
+		WRITE_ONCE(b, 2);
+		do_something_else();
+	}
+
+If MAX is defined to be 1, then the compiler knows that (q % MAX) is
+equal to zero, in which case the compiler is within its rights to
+transform the above code into the following:
+
+	q = READ_ONCE(a);
+	WRITE_ONCE(b, 2);
+	do_something_else();
+
+Given this transformation, the CPU is not required to respect the ordering
+between the load from variable "a" and the store to variable "b".  It is
+tempting to add a barrier(), but this does not help.  The conditional
+is gone, and the barrier won't bring it back.  Therefore, if you are
+relying on this ordering, you should make sure that MAX is greater than
+one, perhaps as follows:
+
+	q = READ_ONCE(a);
+	BUILD_BUG_ON(MAX <= 1); /* Order load from a with store to b. */
+	if (q % MAX) {
+		WRITE_ONCE(b, 1);
+		do_something();
+	} else {
+		WRITE_ONCE(b, 2);
+		do_something_else();
+	}
+
+Please note once again that the stores to "b" differ.  If they were
+identical, as noted earlier, the compiler could pull this store outside
+of the 'if' statement.
+
+You must also be careful not to rely too much on boolean short-circuit
+evaluation.  Consider this example:
+
+	q = READ_ONCE(a);
+	if (q || 1 > 0)
+		WRITE_ONCE(b, 1);
+
+Because the first condition cannot fault and the second condition is
+always true, the compiler can transform this example as following,
+defeating control dependency:
+
+	q = READ_ONCE(a);
+	WRITE_ONCE(b, 1);
+
+This example underscores the need to ensure that the compiler cannot
+out-guess your code.  More generally, although READ_ONCE() does force
+the compiler to actually emit code for a given load, it does not force
+the compiler to use the results.
+
+In addition, control dependencies apply only to the then-clause and
+else-clause of the if-statement in question.  In particular, it does
+not necessarily apply to code following the if-statement:
+
+	q = READ_ONCE(a);
+	if (q) {
+		WRITE_ONCE(b, 1);
+	} else {
+		WRITE_ONCE(b, 2);
+	}
+	WRITE_ONCE(c, 1);  /* BUG: No ordering against the read from "a". */
+
+It is tempting to argue that there in fact is ordering because the
+compiler cannot reorder volatile accesses and also cannot reorder
+the writes to "b" with the condition.  Unfortunately for this line
+of reasoning, the compiler might compile the two writes to "b" as
+conditional-move instructions, as in this fanciful pseudo-assembly
+language:
+
+	ld r1,a
+	cmp r1,$0
+	cmov,ne r4,$1
+	cmov,eq r4,$2
+	st r4,b
+	st $1,c
+
+A weakly ordered CPU would have no dependency of any sort between the load
+from "a" and the store to "c".  The control dependencies would extend
+only to the pair of cmov instructions and the store depending on them.
+In short, control dependencies apply only to the stores in the then-clause
+and else-clause of the if-statement in question (including functions
+invoked by those two clauses), not to code following that if-statement.
+
+
+Note well that the ordering provided by a control dependency is local
+to the CPU containing it.  See the section on "Multicopy atomicity"
+for more information.
+
+
+In summary:
+
+  (*) Control dependencies can order prior loads against later stores.
+      However, they do -not- guarantee any other sort of ordering:
+      Not prior loads against later loads, nor prior stores against
+      later anything.  If you need these other forms of ordering,
+      use smp_rmb(), smp_wmb(), or, in the case of prior stores and
+      later loads, smp_mb().
+
+  (*) If both legs of the "if" statement begin with identical stores to
+      the same variable, then those stores must be ordered, either by
+      preceding both of them with smp_mb() or by using smp_store_release()
+      to carry out the stores.  Please note that it is -not- sufficient
+      to use barrier() at beginning of each leg of the "if" statement
+      because, as shown by the example above, optimizing compilers can
+      destroy the control dependency while respecting the letter of the
+      barrier() law.
+
+  (*) Control dependencies require at least one run-time conditional
+      between the prior load and the subsequent store, and this
+      conditional must involve the prior load.  If the compiler is able
+      to optimize the conditional away, it will have also optimized
+      away the ordering.  Careful use of READ_ONCE() and WRITE_ONCE()
+      can help to preserve the needed conditional.
+
+  (*) Control dependencies require that the compiler avoid reordering the
+      dependency into nonexistence.  Careful use of READ_ONCE() or
+      atomic{,64}_read() can help to preserve your control dependency.
+      Please see the COMPILER BARRIER section for more information.
+
+  (*) Control dependencies apply only to the then-clause and else-clause
+      of the if-statement containing the control dependency, including
+      any functions that these two clauses call.  Control dependencies
+      do -not- apply to code following the if-statement containing the
+      control dependency.
+
+  (*) Control dependencies pair normally with other types of barriers.
+
+  (*) Control dependencies do -not- provide multicopy atomicity.  If you
+      need all the CPUs to see a given store at the same time, use smp_mb().
+
+  (*) Compilers do not understand control dependencies.  It is therefore
+      your job to ensure that they do not break your code.
-- 
2.9.5

