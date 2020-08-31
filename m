Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2A32580E0
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 20:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgHaSUx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 14:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbgHaSUn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 14:20:43 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C6D721534;
        Mon, 31 Aug 2020 18:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598898040;
        bh=GbUimKU7zvAKgZNGhX7IhIWdtWnZAJxe/ynYeOUWm6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BjethCLNeYitW8NGP4mj8U3pGzV50+cDY3HLj1Rkbtfjer4wPgO3I9q5DfsmpsOrB
         pr6BKMxxSmIIeeF3liP01+ZkdclQQeeMwV9knYQecXHtCmXtxSQX61kdw11ZdPp/gt
         eTFDMgU8MsnKA+aQvSOp8W5AmO5Xk2t7fmnKot9o=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH kcsan 5/9] tools/memory-model: Add a simple entry point document
Date:   Mon, 31 Aug 2020 11:20:33 -0700
Message-Id: <20200831182037.2034-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831182012.GA1965@paulmck-ThinkPad-P72>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Current LKMM documentation assumes that the reader already understands
concurrency in the Linux kernel, which won't necessarily always be the
case.  This commit supplies a simple.txt file that provides a starting
point for someone who is new to concurrency in the Linux kernel.
That said, this file might also useful as a reminder to experienced
developers of simpler approaches to dealing with concurrency.

Link: Link: https://lwn.net/Articles/827180/
[ paulmck: Apply feedback from Joel Fernandes. ]
Co-developed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Co-developed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/litmus-tests.txt |   8 +-
 tools/memory-model/Documentation/simple.txt       | 271 ++++++++++++++++++++++
 tools/memory-model/README                         |   5 +
 3 files changed, 282 insertions(+), 2 deletions(-)
 create mode 100644 tools/memory-model/Documentation/simple.txt

diff --git a/tools/memory-model/Documentation/litmus-tests.txt b/tools/memory-model/Documentation/litmus-tests.txt
index 289a38d..2f840dc 100644
--- a/tools/memory-model/Documentation/litmus-tests.txt
+++ b/tools/memory-model/Documentation/litmus-tests.txt
@@ -726,8 +726,12 @@ P0()'s line 10 initializes "x" to the value 1 then line 11 links to "x"
 from "y", replacing "z".
 
 P1()'s line 20 loads a pointer from "y", and line 21 dereferences that
-pointer.  The RCU read-side critical section spanning lines 19-22 is
-just for show in this example.
+pointer.  The RCU read-side critical section spanning lines 19-22 is just
+for show in this example.  Note that the address used for line 21's load
+depends on (in this case, "is exactly the same as") the value loaded by
+line 20.  This is an example of what is called an "address dependency".
+This particular address dependency extends from the load on line 20 to the
+load on line 21.  Address dependencies provide a weak form of ordering.
 
 Running this test results in the following:
 
diff --git a/tools/memory-model/Documentation/simple.txt b/tools/memory-model/Documentation/simple.txt
new file mode 100644
index 0000000..81e1a0e
--- /dev/null
+++ b/tools/memory-model/Documentation/simple.txt
@@ -0,0 +1,271 @@
+This document provides options for those wishing to keep their
+memory-ordering lives simple, as is necessary for those whose domain
+is complex.  After all, there are bugs other than memory-ordering bugs,
+and the time spent gaining memory-ordering knowledge is not available
+for gaining domain knowledge.  Furthermore Linux-kernel memory model
+(LKMM) is quite complex, with subtle differences in code often having
+dramatic effects on correctness.
+
+The options near the beginning of this list are quite simple.  The idea
+is not that kernel hackers don't already know about them, but rather
+that they might need the occasional reminder.
+
+Please note that this is a generic guide, and that specific subsystems
+will often have special requirements or idioms.  For example, developers
+of MMIO-based device drivers will often need to use mb(), rmb(), and
+wmb(), and therefore might find smp_mb(), smp_rmb(), and smp_wmb()
+to be more natural than smp_load_acquire() and smp_store_release().
+On the other hand, those coming in from other environments will likely
+be more familiar with these last two.
+
+
+Single-threaded code
+====================
+
+In single-threaded code, there is no reordering, at least assuming
+that your toolchain and hardware are working correctly.  In addition,
+it is generally a mistake to assume your code will only run in a single
+threaded context as the kernel can enter the same code path on multiple
+CPUs at the same time.  One important exception is a function that makes
+no external data references.
+
+In the general case, you will need to take explicit steps to ensure that
+your code really is executed within a single thread that does not access
+shared variables.  A simple way to achieve this is to define a global lock
+that you acquire at the beginning of your code and release at the end,
+taking care to ensure that all references to your code's shared data are
+also carried out under that same lock.  Because only one thread can hold
+this lock at a given time, your code will be executed single-threaded.
+This approach is called "code locking".
+
+Code locking can severely limit both performance and scalability, so it
+should be used with caution, and only on code paths that execute rarely.
+After all, a huge amount of effort was required to remove the Linux
+kernel's old "Big Kernel Lock", so let's please be very careful about
+adding new "little kernel locks".
+
+One of the advantages of locking is that, in happy contrast with the
+year 1981, almost all kernel developers are very familiar with locking.
+The Linux kernel's lockdep (CONFIG_PROVE_LOCKING=y) is very helpful with
+the formerly feared deadlock scenarios.
+
+Please use the standard locking primitives provided by the kernel rather
+than rolling your own.  For one thing, the standard primitives interact
+properly with lockdep.  For another thing, these primitives have been
+tuned to deal better with high contention.  And for one final thing, it is
+surprisingly hard to correctly code production-quality lock acquisition
+and release functions.  After all, even simple non-production-quality
+locking functions must carefully prevent both the CPU and the compiler
+from moving code in either direction across the locking function.
+
+Despite the scalability limitations of single-threaded code, RCU
+takes this approach for much of its grace-period processing and also
+for early-boot operation.  The reason RCU is able to scale despite
+single-threaded grace-period processing is use of batching, where all
+updates that accumulated during one grace period are handled by the
+next one.  In other words, slowing down grace-period processing makes
+it more efficient.  Nor is RCU unique:  Similar batching optimizations
+are used in many I/O operations.
+
+
+Packaged code
+=============
+
+Even if performance and scalability concerns prevent your code from
+being completely single-threaded, it is often possible to use library
+functions that handle the concurrency nearly or entirely on their own.
+This approach delegates any LKMM worries to the library maintainer.
+
+In the kernel, what is the "library"?  Quite a bit.  It includes the
+contents of the lib/ directory, much of the include/linux/ directory along
+with a lot of other heavily used APIs.  But heavily used examples include
+the list macros (for example, include/linux/{,rcu}list.h), workqueues,
+smp_call_function(), and the various hash tables and search trees.
+
+
+Data locking
+============
+
+With code locking, we use single-threaded code execution to guarantee
+serialized access to the data that the code is accessing.  However,
+we can also achieve this by instead associating the lock with specific
+instances of the data structures.  This creates a "critical section"
+in the code execution that will execute as though it is single threaded.
+By placing all the accesses and modifications to a shared data structure
+inside a critical section, we ensure that the execution context that
+holds the lock has exclusive access to the shared data.
+
+The poster boy for this approach is the hash table, where placing a lock
+in each hash bucket allows operations on different buckets to proceed
+concurrently.  This works because the buckets do not overlap with each
+other, so that an operation on one bucket does not interfere with any
+other bucket.
+
+As the number of buckets increases, data locking scales naturally.
+In particular, if the amount of data increases with the number of CPUs,
+increasing the number of buckets as the number of CPUs increase results
+in a naturally scalable data structure.
+
+
+Per-CPU processing
+==================
+
+Partitioning processing and data over CPUs allows each CPU to take
+a single-threaded approach while providing excellent performance and
+scalability.  Of course, there is no free lunch:  The dark side of this
+excellence is substantially increased memory footprint.
+
+In addition, it is sometimes necessary to occasionally update some global
+view of this processing and data, in which case something like locking
+must be used to protect this global view.  This is the approach taken
+by the percpu_counter infrastructure. In many cases, there are already
+generic/library variants of commonly used per-cpu constructs available.
+Please use them rather than rolling your own.
+
+RCU uses DEFINE_PER_CPU*() declaration to create a number of per-CPU
+data sets.  For example, each CPU does private quiescent-state processing
+within its instance of the per-CPU rcu_data structure, and then uses data
+locking to report quiescent states up the grace-period combining tree.
+
+
+Packaged primitives: Sequence locking
+=====================================
+
+Lockless programming is considered by many to be more difficult than
+lock-based programming, but there are a few lockless design patterns that
+have been built out into an API.  One of these APIs is sequence locking.
+Although this APIs can be used in extremely complex ways, there are simple
+and effective ways of using it that avoid the need to pay attention to
+memory ordering.
+
+The basic keep-things-simple rule for sequence locking is "do not write
+in read-side code".  Yes, you can do writes from within sequence-locking
+readers, but it won't be so simple.  For example, such writes will be
+lockless and should be idempotent.
+
+For more sophisticated use cases, LKMM can guide you, including use
+cases involving combining sequence locking with other synchronization
+primitives.  (LKMM does not yet know about sequence locking, so it is
+currently necessary to open-code it in your litmus tests.)
+
+Additional information may be found in include/linux/seqlock.h.
+
+Packaged primitives: RCU
+========================
+
+Another lockless design pattern that has been baked into an API
+is RCU.  The Linux kernel makes sophisticated use of RCU, but the
+keep-things-simple rules for RCU are "do not write in read-side code"
+and "do not update anything that is visible to and accessed by readers",
+and "protect updates with locking".
+
+These rules are illustrated by the functions foo_update_a() and
+foo_get_a() shown in Documentation/RCU/whatisRCU.rst.  Additional
+RCU usage patterns maybe found in Documentation/RCU and in the
+source code.
+
+
+Packaged primitives: Atomic operations
+======================================
+
+Back in the day, the Linux kernel had three types of atomic operations:
+
+1.	Initialization and read-out, such as atomic_set() and atomic_read().
+
+2.	Operations that did not return a value and provided no ordering,
+	such as atomic_inc() and atomic_dec().
+
+3.	Operations that returned a value and provided full ordering, such as
+	atomic_add_return() and atomic_dec_and_test().  Note that some
+	value-returning operations provide full ordering only conditionally.
+	For example, cmpxchg() provides ordering only upon success.
+
+More recent kernels have operations that return a value but do not
+provide full ordering.  These are flagged with either a _relaxed()
+suffix (providing no ordering), or an _acquire() or _release() suffix
+(providing limited ordering).
+
+Additional information may be found in these files:
+
+Documentation/atomic_t.txt
+Documentation/atomic_bitops.txt
+Documentation/core-api/atomic_ops.rst
+Documentation/core-api/refcount-vs-atomic.rst
+
+Reading code using these primitives is often also quite helpful.
+
+
+Lockless, fully ordered
+=======================
+
+When using locking, there often comes a time when it is necessary
+to access some variable or another without holding the data lock
+that serializes access to that variable.
+
+If you want to keep things simple, use the initialization and read-out
+operations from the previous section only when there are no racing
+accesses.  Otherwise, use only fully ordered operations when accessing
+or modifying the variable.  This approach guarantees that code prior
+to a given access to that variable will be seen by all CPUs has having
+happened before any code following any later access to that same variable.
+
+Please note that per-CPU functions are not atomic operations and
+hence they do not provide any ordering guarantees at all.
+
+If the lockless accesses are frequently executed reads that are used
+only for heuristics, or if they are frequently executed writes that
+are used only for statistics, please see the next section.
+
+
+Lockless statistics and heuristics
+==================================
+
+Unordered primitives such as atomic_read(), atomic_set(), READ_ONCE(), and
+WRITE_ONCE() can safely be used in some cases.  These primitives provide
+no ordering, but they do prevent the compiler from carrying out a number
+of destructive optimizations (for which please see the next section).
+One example use for these primitives is statistics, such as per-CPU
+counters exemplified by the rt_cache_stat structure's routing-cache
+statistics counters.  Another example use case is heuristics, such as
+the jiffies_till_first_fqs and jiffies_till_next_fqs kernel parameters
+controlling how often RCU scans for idle CPUs.
+
+But be careful.  "Unordered" really does mean "unordered".  It is all
+too easy to assume ordering, and this assumption must be avoided when
+using these primitives.
+
+
+Don't let the compiler trip you up
+==================================
+
+It can be quite tempting to use plain C-language accesses for lockless
+loads from and stores to shared variables.  Although this is both
+possible and quite common in the Linux kernel, it does require a
+surprising amount of analysis, care, and knowledge about the compiler.
+Yes, some decades ago it was not unfair to consider a C compiler to be
+an assembler with added syntax and better portability, but the advent of
+sophisticated optimizing compilers mean that those days are long gone.
+Today's optimizing compilers can profoundly rewrite your code during the
+translation process, and have long been ready, willing, and able to do so.
+
+Therefore, if you really need to use C-language assignments instead of
+READ_ONCE(), WRITE_ONCE(), and so on, you will need to have a very good
+understanding of both the C standard and your compiler.  Here are some
+introductory references and some tooling to start you on this noble quest:
+
+Who's afraid of a big bad optimizing compiler?
+	https://lwn.net/Articles/793253/
+Calibrating your fear of big bad optimizing compilers
+	https://lwn.net/Articles/799218/
+Concurrency bugs should fear the big bad data-race detector (part 1)
+	https://lwn.net/Articles/816850/
+Concurrency bugs should fear the big bad data-race detector (part 2)
+	https://lwn.net/Articles/816854/
+
+
+More complex use cases
+======================
+
+If the alternatives above do not do what you need, please look at the
+recipes-pairs.txt file to peel off the next layer of the memory-ordering
+onion.
diff --git a/tools/memory-model/README b/tools/memory-model/README
index d2e03c4..c8144d4 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -177,6 +177,11 @@ Documentation/recipes.txt
 Documentation/references.txt
 	Provides background reading.
 
+Documentation/simple.txt
+	Starting point for someone new to Linux-kernel concurrency.
+	And also for those needing a reminder of the simpler approaches
+	to concurrency!
+
 linux-kernel.bell
 	Categorizes the relevant instructions, including memory
 	references, memory barriers, atomic read-modify-write operations,
-- 
2.9.5

