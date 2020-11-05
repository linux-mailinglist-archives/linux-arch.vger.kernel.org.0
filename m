Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DE52A8964
	for <lists+linux-arch@lfdr.de>; Thu,  5 Nov 2020 23:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbgKEWAZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Nov 2020 17:00:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732607AbgKEWAX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Nov 2020 17:00:23 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B5DF221F8;
        Thu,  5 Nov 2020 22:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604613621;
        bh=5UwAZFgYp8w6Qj9f3NBJJNac37xTT5nnARDuRJqnktI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgMkIdSPGQVaj/+87nfOuH7S2UEIpzm3ICyffskBAAzBHy/dR8FJn1an+hfXZTn25
         tR/fy6/BgPOjqNRk9gmaYzjGMCdnJ1AlI517lkJhkNXn4fjsytLzOsNxrQ+PSJ1sFw
         IWLoznTB3y4LU7h9ZvMzekGTprV+Vpi2b9gWJhO0=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 3/8] tools/memory-model: Document categories of ordering primitives
Date:   Thu,  5 Nov 2020 14:00:12 -0800
Message-Id: <20201105220017.15410-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105215953.GA15309@paulmck-ThinkPad-P72>
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
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

[ paulmck:  Apply Akira Yokosawa file-placement feedback. ]
[ paulmck:  Apply Alan Stern feedback. ]
[ paulmck:  Apply self-review feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/README            |  19 +-
 .../Documentation/control-dependencies.txt         | 258 ++++++++++
 tools/memory-model/Documentation/ordering.txt      | 557 +++++++++++++++++++++
 3 files changed, 833 insertions(+), 1 deletion(-)
 create mode 100644 tools/memory-model/Documentation/control-dependencies.txt
 create mode 100644 tools/memory-model/Documentation/ordering.txt

diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
index 2d9539f..a50ea81 100644
--- a/tools/memory-model/Documentation/README
+++ b/tools/memory-model/Documentation/README
@@ -11,6 +11,12 @@ the material provided by documents earlier in this list.
 
 o	You are new to Linux-kernel concurrency: simple.txt
 
+o	You have some background in Linux-kernel concurrency, and would
+	like an overview of the types of low-level concurrency primitives
+	that the Linux kernel provides:  ordering.txt
+
+	Here, "low level" means atomic operations to single variables.
+
 o	You are familiar with the Linux-kernel concurrency primitives
 	that you need, and just want to get started with LKMM litmus
 	tests:  litmus-tests.txt
@@ -19,6 +25,9 @@ o	You are familiar with Linux-kernel concurrency, and would
 	like a detailed intuitive understanding of LKMM, including
 	situations involving more than two threads:  recipes.txt
 
+o	You would like a detailed understanding of what your compiler can
+	and cannot do to control dependencies:  control-dependencies.txt
+
 o	You are familiar with Linux-kernel concurrency and the use of
 	LKMM, and would like a quick reference:  cheatsheet.txt
 
@@ -41,13 +50,21 @@ README
 cheatsheet.txt
 	Quick-reference guide to the Linux-kernel memory model.
 
+control-dependencies.txt
+	Guide to preventing compiler optimizations from destroying
+	your control dependencies.
+
 explanation.txt
-	Detailed description of the memory model.
+	Detailed description of the memory model in detail.
 
 litmus-tests.txt
 	The format, features, capabilities, and limitations of the litmus
 	tests that LKMM can evaluate.
 
+ordering.txt
+	Overview of the Linux kernel's low-level memory-ordering
+	primitives by category.
+
 recipes.txt
 	Common memory-ordering patterns.
 
diff --git a/tools/memory-model/Documentation/control-dependencies.txt b/tools/memory-model/Documentation/control-dependencies.txt
new file mode 100644
index 0000000..8b743d20
--- /dev/null
+++ b/tools/memory-model/Documentation/control-dependencies.txt
@@ -0,0 +1,258 @@
+CONTROL DEPENDENCIES
+====================
+
+A major difficulty with control dependencies is that current compilers
+do not support them.  One purpose of this document is therefore to
+help you prevent your compiler from breaking your code.  However,
+control dependencies also pose other challenges, which leads to the
+second purpose of this document, namely to help you to avoid breaking
+your own code, even in the absence of help from your compiler.
+
+One such challenge is that control dependencies order only later stores.
+Therefore, a load-load control dependency will not preserve ordering
+unless a read memory barrier is provided.  Consider the following code:
+
+	q = READ_ONCE(a);
+	if (q)
+		p = READ_ONCE(b);
+
+This is not guaranteed to provide any ordering because some types of CPUs
+are permitted to predict the result of the load from "b".  This prediction
+can cause other CPUs to see this load as having happened before the load
+from "a".  This means that an explicit read barrier is required, for example
+as follows:
+
+	q = READ_ONCE(a);
+	if (q) {
+		smp_rmb();
+		p = READ_ONCE(b);
+	}
+
+However, stores are not speculated.  This means that ordering is
+(usually) guaranteed for load-store control dependencies, as in the
+following example:
+
+	q = READ_ONCE(a);
+	if (q)
+		WRITE_ONCE(b, 1);
+
+Control dependencies can pair with each other and with other types
+of ordering.  But please note that neither the READ_ONCE() nor the
+WRITE_ONCE() are optional.  Without the READ_ONCE(), the compiler might
+fuse the load from "a" with other loads.  Without the WRITE_ONCE(),
+the compiler might fuse the store to "b" with other stores.  Worse yet,
+the compiler might convert the store into a load and a check followed
+by a store, and this compiler-generated load would not be ordered by
+the control dependency.
+
+Furthermore, if the compiler is able to prove that the value of variable
+"a" is always non-zero, it would be well within its rights to optimize
+the original example by eliminating the "if" statement as follows:
+
+	q = a;
+	b = 1;  /* BUG: Compiler and CPU can both reorder!!! */
+
+So don't leave out either the READ_ONCE() or the WRITE_ONCE().
+In particular, although READ_ONCE() does force the compiler to emit a
+load, it does *not* force the compiler to actually use the loaded value.
+
+It is tempting to try use control dependencies to enforce ordering on
+identical stores on both branches of the "if" statement as follows:
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
+"b", which means that the CPU is within its rights to reorder them:  The
+conditional is absolutely required, and must be present in the final
+assembly code, after all of the compiler and link-time optimizations
+have been applied.  Therefore, if you need ordering in this example,
+you must use explicit memory ordering, for example, smp_store_release():
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
+Without explicit memory ordering, control-dependency-based ordering is
+guaranteed only when the stores differ, for example:
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
+knowing too much about the value of "a".
+
+But please note that you need to be careful what you do with the local
+variable "q", otherwise the compiler might be able to guess the value
+and again remove the conditional branch that is absolutely required to
+preserve ordering.  For example:
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
+If MAX is compile-time defined to be 1, then the compiler knows that
+(q % MAX) must be equal to zero, regardless of the value of "q".
+The compiler is therefore within its rights to transform the above code
+into the following:
+
+	q = READ_ONCE(a);
+	WRITE_ONCE(b, 2);
+	do_something_else();
+
+Given this transformation, the CPU is not required to respect the ordering
+between the load from variable "a" and the store to variable "b".  It is
+tempting to add a barrier(), but this does not help.  The conditional
+is gone, and the barrier won't bring it back.  Therefore, if you need
+to relying on control dependencies to produce this ordering, you should
+make sure that MAX is greater than one, perhaps as follows:
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
+Please note once again that each leg of the "if" statement absolutely
+must store different values to "b".  As in previous examples, if the two
+values were identical, the compiler could pull this store outside of the
+"if" statement, destroying the control dependency's ordering properties.
+
+You must also be careful avoid relying too much on boolean short-circuit
+evaluation.  Consider this example:
+
+	q = READ_ONCE(a);
+	if (q || 1 > 0)
+		WRITE_ONCE(b, 1);
+
+Because the first condition cannot fault and the second condition is
+always true, the compiler can transform this example as follows, again
+destroying the control dependency's ordering:
+
+	q = READ_ONCE(a);
+	WRITE_ONCE(b, 1);
+
+This is yet another example showing the importance of preventing the
+compiler from out-guessing your code.  Again, although READ_ONCE() really
+does force the compiler to emit code for a given load, the compiler is
+within its rights to discard the loaded value.
+
+In addition, control dependencies apply only to the then-clause and
+else-clause of the "if" statement in question.  In particular, they do
+not necessarily order the code following the entire "if" statement:
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
+The control dependencies would then extend only to the pair of cmov
+instructions and the store depending on them.  This means that a weakly
+ordered CPU would have no dependency of any sort between the load from
+"a" and the store to "c".  In short, control dependencies provide ordering
+only to the stores in the then-clause and else-clause of the "if" statement
+in question (including functions invoked by those two clauses), and not
+to code following that "if" statement.
+
+
+In summary:
+
+  (*) Control dependencies can order prior loads against later stores.
+      However, they do *not* guarantee any other sort of ordering:
+      Not prior loads against later loads, nor prior stores against
+      later anything.  If you need these other forms of ordering, use
+      smp_load_acquire(), smp_store_release(), or, in the case of prior
+      stores and later loads, smp_mb().
+
+  (*) If both legs of the "if" statement contain identical stores to
+      the same variable, then you must explicitly order those stores,
+      either by preceding both of them with smp_mb() or by using
+      smp_store_release().  Please note that it is *not* sufficient to use
+      barrier() at beginning and end of each leg of the "if" statement
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
+
+  (*) Control dependencies apply only to the then-clause and else-clause
+      of the "if" statement containing the control dependency, including
+      any functions that these two clauses call.  Control dependencies
+      do *not* apply to code beyond the end of that "if" statement.
+
+  (*) Control dependencies pair normally with other types of barriers.
+
+  (*) Control dependencies do *not* provide multicopy atomicity.  If you
+      need all the CPUs to agree on the ordering of a given store against
+      all other accesses, use smp_mb().
+
+  (*) Compilers do not understand control dependencies.  It is therefore
+      your job to ensure that they do not break your code.
diff --git a/tools/memory-model/Documentation/ordering.txt b/tools/memory-model/Documentation/ordering.txt
new file mode 100644
index 0000000..46369f4
--- /dev/null
+++ b/tools/memory-model/Documentation/ordering.txt
@@ -0,0 +1,557 @@
+This document gives an overview of the categories of memory-ordering
+operations provided by the Linux-kernel memory model (LKMM).
+
+
+Categories of Ordering
+======================
+
+This section lists LKMM's three top-level categories of memory-ordering
+operations in decreasing order of strength:
+
+1.	Barriers (also known as "fences").  A barrier orders some or
+	all of the CPU's prior operations against some or all of its
+	subsequent operations.
+
+2.	Ordered memory accesses.  These operations order themselves
+	against some or all of the CPU's prior accesses or some or all
+	of the CPU's subsequent accesses, depending on the subcategory
+	of the operation.
+
+3.	Unordered accesses, as the name indicates, have no ordering
+	properties except to the extent that they interact with an
+	operation in the previous categories.  This being the real world,
+	some of these "unordered" operations provide limited ordering
+	in some special situations.
+
+Each of the above categories is described in more detail by one of the
+following sections.
+
+
+Barriers
+========
+
+Each of the following categories of barriers is described in its own
+subsection below:
+
+a.	Full memory barriers.
+
+b.	Read-modify-write (RMW) ordering augmentation barriers.
+
+c.	Write memory barrier.
+
+d.	Read memory barrier.
+
+e.	Compiler barrier.
+
+Note well that many of these primitives generate absolutely no code
+in kernels built with CONFIG_SMP=n.  Therefore, if you are writing
+a device driver, which must correctly order accesses to a physical
+device even in kernels built with CONFIG_SMP=n, please use the
+ordering primitives provided for that purpose.  For example, instead of
+smp_mb(), use mb().  See the "Linux Kernel Device Drivers" book or the
+https://lwn.net/Articles/698014/ article for more information.
+
+
+Full Memory Barriers
+--------------------
+
+The Linux-kernel primitives that provide full ordering include:
+
+o	The smp_mb() full memory barrier.
+
+o	Value-returning RMW atomic operations whose names do not end in
+	_acquire, _release, or _relaxed.
+
+o	RCU's grace-period primitives.
+
+First, the smp_mb() full memory barrier orders all of the CPU's prior
+accesses against all subsequent accesses from the viewpoint of all CPUs.
+In other words, all CPUs will agree that any earlier action taken
+by that CPU happened before any later action taken by that same CPU.
+For example, consider the following:
+
+	WRITE_ONCE(x, 1);
+	smp_mb(); // Order store to x before load from y.
+	r1 = READ_ONCE(y);
+
+All CPUs will agree that the store to "x" happened before the load
+from "y", as indicated by the comment.  And yes, please comment your
+memory-ordering primitives.  It is surprisingly hard to remember their
+purpose after even a few months.
+
+Second, some RMW atomic operations provide full ordering.  These
+operations include value-returning RMW atomic operations (that is, those
+with non-void return types) whose names do not end in _acquire, _release,
+or _relaxed.  Examples include atomic_add_return(), atomic_dec_and_test(),
+cmpxchg(), and xchg().  Note that conditional RMW atomic operations such
+as cmpxchg() are only guaranteed to provide ordering when they succeed.
+When RMW atomic operations provide full ordering, they partition the
+CPU's accesses into three groups:
+
+1.	All code that executed prior to the RMW atomic operation.
+
+2.	The RMW atomic operation itself.
+
+3.	All code that executed after the RMW atomic operation.
+
+All CPUs will agree that any operation in a given partition happened
+before any operation in a higher-numbered partition.
+
+In contrast, non-value-returning RMW atomic operations (that is, those
+with void return types) do not guarantee any ordering whatsoever.  Nor do
+value-returning RMW atomic operations whose names end in _relaxed.
+Examples of the former include atomic_inc() and atomic_dec(),
+while examples of the latter include atomic_cmpxchg_relaxed() and
+atomic_xchg_relaxed().  Similarly, value-returning non-RMW atomic
+operations such as atomic_read() do not guarantee full ordering, and
+are covered in the later section on unordered operations.
+
+Value-returning RMW atomic operations whose names end in _acquire or
+_release provide limited ordering, and will be described later in this
+document.
+
+Finally, RCU's grace-period primitives provide full ordering.  These
+primitives include synchronize_rcu(), synchronize_rcu_expedited(),
+synchronize_srcu() and so on.  However, these primitives have orders
+of magnitude greater overhead than smp_mb(), atomic_xchg(), and so on.
+Furthermore, RCU's grace-period primitives can only be invoked in
+sleepable contexts.  Therefore, RCU's grace-period primitives are
+typically instead used to provide ordering against RCU read-side critical
+sections, as documented in their comment headers.  But of course if you
+need a synchronize_rcu() to interact with readers, it costs you nothing
+to also rely on its additional full-memory-barrier semantics.  Just please
+carefully comment this, otherwise your future self will hate you.
+
+
+RMW Ordering Augmentation Barriers
+----------------------------------
+
+As noted in the previous section, non-value-returning RMW operations
+such as atomic_inc() and atomic_dec() guarantee no ordering whatsoever.
+Nevertheless, a number of popular CPU families, including x86, provide
+full ordering for these primitives.  One way to obtain full ordering on
+all architectures is to add a call to smp_mb():
+
+	WRITE_ONCE(x, 1);
+	atomic_inc(&my_counter);
+	smp_mb(); // Inefficient on x86!!!
+	r1 = READ_ONCE(y);
+
+This works, but the added smp_mb() adds needless overhead for
+x86, on which atomic_inc() provides full ordering all by itself.
+The smp_mb__after_atomic() primitive can be used instead:
+
+	WRITE_ONCE(x, 1);
+	atomic_inc(&my_counter);
+	smp_mb__after_atomic(); // Order store to x before load from y.
+	r1 = READ_ONCE(y);
+
+The smp_mb__after_atomic() primitive emits code only on CPUs whose
+atomic_inc() implementations do not guarantee full ordering, thus
+incurring no unnecessary overhead on x86.  There are a number of
+variations on the smp_mb__*() theme:
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
+It is bad practice to place code between the smp__*() primitive and the
+operation whose ordering that it is augmenting.  The reason is that the
+ordering of this intervening code will differ from one CPU architecture
+to another.
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
+Then any given CPU will see the write to "x" has having happened before
+the write to "y".  However, you are usually better off using a release
+store, as described in the "Release Operations" section below.
+
+Note that smp_wmb() might fail to provide ordering for unmarked C-language
+stores because profile-driven optimization could determine that the
+value being overwritten is almost always equal to the new value.  Such a
+compiler might then reasonably decide to transform "x = 1" and "y = 1"
+as follows:
+
+	if (x != 1)
+		x = 1;
+	smp_wmb(); // BUG: does not order the reads!!!
+	if (y != 1)
+		y = 1;
+
+Therefore, if you need to use smp_wmb() with unmarked C-language writes,
+you will need to make sure that none of the compilers used to build
+the Linux kernel carry out this sort of transformation, both now and in
+the future.
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
+Compiler Barrier
+----------------
+
+The Linux kernel's compiler barrier is barrier().  This primitive
+prohibits compiler code-motion optimizations that might move memory
+references across the point in the code containing the barrier(), but
+does not constrain hardware memory ordering.  For example, this can be
+used to prevent to compiler from moving code across an infinite loop:
+
+	WRITE_ONCE(x, 1);
+	while (dontstop)
+		barrier();
+	r1 = READ_ONCE(y);
+
+Without the barrier(), the compiler would be within its rights to move the
+WRITE_ONCE() to follow the loop.  This code motion could be problematic
+in the case where an interrupt handler terminates the loop.  Another way
+to handle this is to use READ_ONCE() for the load of "dontstop".
+
+Note that the barriers discussed previously use barrier() or its low-level
+equivalent in their implementations.
+
+
+Ordered Memory Accesses
+=======================
+
+The Linux kernel provides a wide variety of ordered memory accesses:
+
+a.	Release operations.
+
+b.	Acquire operations.
+
+c.	RCU read-side ordering.
+
+d.	Control dependencies.
+
+Each of the above categories has its own section below.
+
+
+Release Operations
+------------------
+
+Release operations include smp_store_release(), atomic_set_release(),
+rcu_assign_pointer(), and value-returning RMW operations whose names
+end in _release.  These operations order their own store against all
+of the CPU's prior memory accesses.  Release operations often provide
+improved readability and performance compared to explicit barriers.
+For example, use of smp_store_release() saves a line compared to the
+smp_wmb() example above:
+
+	WRITE_ONCE(x, 1);
+	smp_store_release(&y, 1);
+
+More important, smp_store_release() makes it easier to connect up the
+different pieces of the concurrent algorithm.  The variable stored to
+by the smp_store_release(), in this case "y", will normally be used in
+an acquire operation in other parts of the concurrent algorithm.
+
+To see the performance advantages, suppose that the above example read
+from "x" instead of writing to it.  Then an smp_wmb() could not guarantee
+ordering, and an smp_mb() would be needed instead:
+
+	r1 = READ_ONCE(x);
+	smp_mb();
+	WRITE_ONCE(y, 1);
+
+But smp_mb() often incurs much higher overhead than does
+smp_store_release(), which still provides the needed ordering of "x"
+against "y".  On x86, the version using smp_store_release() might compile
+to a simple load instruction followed by a simple store instruction.
+In contrast, the smp_mb() compiles to an expensive instruction that
+provides the needed ordering.
+
+There is a wide variety of release operations:
+
+o	Store operations, including not only the aforementioned
+	smp_store_release(), but also atomic_set_release(), and
+	atomic_long_set_release().
+
+o	RCU's rcu_assign_pointer() operation.  This is the same as
+	smp_store_release() except that: (1) It takes the pointer to
+	be assigned to instead of a pointer to that pointer, (2) It
+	is intended to be used in conjunction with rcu_dereference()
+	and similar rather than smp_load_acquire(), and (3) It checks
+	for an RCU-protected pointer in "sparse" runs.
+
+o	Value-returning RMW operations whose names end in _release,
+	such as atomic_fetch_add_release() and cmpxchg_release().
+	Note that release ordering is guaranteed only against the
+	memory-store portion of the RMW operation, and not against the
+	memory-load portion.  Note also that conditional operations such
+	as cmpxchg_release() are only guaranteed to provide ordering
+	when they succeed.
+
+As mentioned earlier, release operations are often paired with acquire
+operations, which are the subject of the next section.
+
+
+Acquire Operations
+------------------
+
+Acquire operations include smp_load_acquire(), atomic_read_acquire(),
+and value-returning RMW operations whose names end in _acquire.   These
+operations order their own load against all of the CPU's subsequent
+memory accesses.  Acquire operations often provide improved performance
+and readability compared to explicit barriers.  For example, use of
+smp_load_acquire() saves a line compared to the smp_rmb() example above:
+
+	r0 = smp_load_acquire(&y);
+	r1 = READ_ONCE(x);
+
+As with smp_store_release(), this also makes it easier to connect
+the different pieces of the concurrent algorithm by looking for the
+smp_store_release() that stores to "y".  In addition, smp_load_acquire()
+improves upon smp_rmb() by ordering against subsequent stores as well
+as against subsequent loads.
+
+There are a couple of categories of acquire operations:
+
+o	Load operations, including not only the aforementioned
+	smp_load_acquire(), but also atomic_read_acquire(), and
+	atomic64_read_acquire().
+
+o	Value-returning RMW operations whose names end in _acquire,
+	such as atomic_xchg_acquire() and atomic_cmpxchg_acquire().
+	Note that acquire ordering is guaranteed only against the
+	memory-load portion of the RMW operation, and not against the
+	memory-store portion.  Note also that conditional operations
+	such as atomic_cmpxchg_acquire() are only guaranteed to provide
+	ordering when they succeed.
+
+Symmetry being what it is, acquire operations are often paired with the
+release operations covered earlier.  For example, consider the following
+example, where task0() and task1() execute concurrently:
+
+	void task0(void)
+	{
+		WRITE_ONCE(x, 1);
+		smp_store_release(&y, 1);
+	}
+
+	void task1(void)
+	{
+		r0 = smp_load_acquire(&y);
+		r1 = READ_ONCE(x);
+	}
+
+If "x" and "y" are both initially zero, then either r0's final value
+will be zero or r1's final value will be one, thus providing the required
+ordering.
+
+
+RCU Read-Side Ordering
+----------------------
+
+This category includes read-side markers such as rcu_read_lock()
+and rcu_read_unlock() as well as pointer-traversal primitives such as
+rcu_dereference() and srcu_dereference().
+
+Compared to locking primitives and RMW atomic operations, markers
+for RCU read-side critical sections incur very low overhead because
+they interact only with the corresponding grace-period primitives.
+For example, the rcu_read_lock() and rcu_read_unlock() markers interact
+with synchronize_rcu(), synchronize_rcu_expedited(), and call_rcu().
+The way this works is that if a given call to synchronize_rcu() cannot
+prove that it started before a given call to rcu_read_lock(), then
+that synchronize_rcu() must block until the matching rcu_read_unlock()
+is reached.  For more information, please see the synchronize_rcu()
+docbook header comment and the material in Documentation/RCU.
+
+RCU's pointer-traversal primitives, including rcu_dereference() and
+srcu_dereference(), order their load (which must be a pointer) against any
+of the CPU's subsequent memory accesses whose address has been calculated
+from the value loaded.  There is said to be an *address dependency*
+from the value returned by the rcu_dereference() or srcu_dereference()
+to that subsequent memory access.
+
+A call to rcu_dereference() for a given RCU-protected pointer is
+usually paired with a call to a call to rcu_assign_pointer() for that
+same pointer in much the same way that a call to smp_load_acquire() is
+paired with a call to smp_store_release().  Calls to rcu_dereference()
+and rcu_assign_pointer are often buried in other APIs, for example,
+the RCU list API members defined in include/linux/rculist.h.  For more
+information, please see the docbook headers in that file, the most
+recent LWN article on the RCU API (https://lwn.net/Articles/777036/),
+and of course the material in Documentation/RCU.
+
+If the pointer value is manipulated between the rcu_dereference()
+that returned it and a later dereference(), please read
+Documentation/RCU/rcu_dereference.rst.  It can also be quite helpful to
+review uses in the Linux kernel.
+
+
+Control Dependencies
+--------------------
+
+A control dependency extends from a marked load (READ_ONCE() or stronger)
+through an "if" condition to a marked store (WRITE_ONCE() or stronger)
+that is executed only by one of the legs of that "if" statement.
+Control dependencies are so named because they are mediated by
+control-flow instructions such as comparisons and conditional branches.
+
+In short, you can use a control dependency to enforce ordering between
+an READ_ONCE() and a WRITE_ONCE() when there is an "if" condition
+between them.  The canonical example is as follows:
+
+	q = READ_ONCE(a);
+	if (q)
+		WRITE_ONCE(b, 1);
+
+In this case, all CPUs would see the read from "a" as happening before
+the write to "b".
+
+However, control dependencies are easily destroyed by compiler
+optimizations, so any use of control dependencies must take into account
+all of the compilers used to build the Linux kernel.  Please see the
+"control-dependencies.txt" file for more information.
+
+
+Unordered Accesses
+==================
+
+Each of these two categories of unordered accesses has a section below:
+
+a.	Unordered marked operations.
+
+b.	Unmarked C-language accesses.
+
+
+Unordered Marked Operations
+---------------------------
+
+Unordered operations to different variables are just that, unordered.
+However, if a group of CPUs apply these operations to a single variable,
+all the CPUs will agree on the operation order.  Of course, the ordering
+of unordered marked accesses can also be constrained using the mechanisms
+described earlier in this document.
+
+These operations come in three categories:
+
+o	Marked writes, such as WRITE_ONCE() and atomic_set().  These
+	primitives required the compiler to emit the corresponding store
+	instructions in the expected execution order, thus suppressing
+	a number of destructive optimizations.	However, they provide no
+	hardware ordering guarantees, and in fact many CPUs will happily
+	reorder marked writes with each other or with other unordered
+	operations, unless these operations are to the same variable.
+
+o	Marked reads, such as READ_ONCE() and atomic_read().  These
+	primitives required the compiler to emit the corresponding load
+	instructions in the expected execution order, thus suppressing
+	a number of destructive optimizations.	However, they provide no
+	hardware ordering guarantees, and in fact many CPUs will happily
+	reorder marked reads with each other or with other unordered
+	operations, unless these operations are to the same variable.
+
+o	Unordered RMW atomic operations.  These are non-value-returning
+	RMW atomic operations whose names do not end in _acquire or
+	_release, and also value-returning RMW operations whose names
+	end in _relaxed.  Examples include atomic_add(), atomic_or(),
+	and atomic64_fetch_xor_relaxed().  These operations do carry
+	out the specified RMW operation atomically, for example, five
+	concurrent atomic_inc() operations applied to a given variable
+	will reliably increase the value of that variable by five.
+	However, many CPUs will happily reorder these operations with
+	each other or with other unordered operations.
+
+	This category of operations can be efficiently ordered using
+	smp_mb__before_atomic() and smp_mb__after_atomic(), as was
+	discussed in the "RMW Ordering Augmentation Barriers" section.
+
+In short, these operations can be freely reordered unless they are all
+operating on a single variable or unless they are constrained by one of
+the operations called out earlier in this document.
+
+
+Unmarked C-Language Accesses
+----------------------------
+
+Unmarked C-language accesses are normal variable accesses to to normal
+variables, that is, to variables that are not "volatile" and are not
+C11 atomic variables.  These operations provide no ordering guarantees,
+and further do not guarantee "atomic" access.  For example, the compiler
+might (and sometimes does) split a plain C-language store into multiple
+smaller stores.  A load from that same variable running on some other
+CPU while such a store is executing might see a value that is a mashup
+of the old value and the new value.
+
+Unmarked C-language accesses are unordered, and are also subject to
+any number of compiler optimizations, many of which can break your
+concurrent code.  It is possible to used unmarked C-language accesses for
+shared variables that are subject to concurrent access, but great care
+is required on an ongoing basis.  The compiler-constraining barrier()
+primitive can be helpful, as can the various ordering primitives discussed
+in this document.  It nevertheless bears repeating that use of unmarked
+C-language accesses requires careful attention to not just your code,
+but to all the compilers that might be used to build it.  Such compilers
+might replace a series of loads with a single load, and might replace
+a series of stores with a single store.  Some compilers will even split
+a single store into multiple smaller stores.
+
+But there are some ways of using unmarked C-language accesses for shared
+variables without such worries:
+
+o	
+	Guard all accesses to a given variable by a particular lock,
+	so that there are never concurrent conflicting accesses to
+	that variable.	(There are "conflicting accesses" when
+	(1) at least one of the concurrent accesses to a variable is an
+	unmarked C-language access and (2) when at least one of those
+	accesses is a write, whether marked or not.)
+
+o	As above, but using other synchronization primitives such
+	as reader-writer locks or sequence locks.
+
+o	Use locking or other means to ensure that all concurrent accesses
+	to a given variable are reads.
+
+o	Restrict use of a given variable to statistics or heuristics
+	where the occasional bogus value can be tolerated.
+
+o	Declare the accessed variables as C11 atomics.
+	https://lwn.net/Articles/691128/
+
+o	Declare the accessed variables as "volatile".
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
-- 
2.9.5

