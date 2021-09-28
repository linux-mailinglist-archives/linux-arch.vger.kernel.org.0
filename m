Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F34A41B917
	for <lists+linux-arch@lfdr.de>; Tue, 28 Sep 2021 23:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242797AbhI1VRG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Sep 2021 17:17:06 -0400
Received: from mail.efficios.com ([167.114.26.124]:53520 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241482AbhI1VRA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Sep 2021 17:17:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1AFFF38BB77;
        Tue, 28 Sep 2021 17:15:20 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IXHSxix9_FH3; Tue, 28 Sep 2021 17:15:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4EFCB38BD5F;
        Tue, 28 Sep 2021 17:15:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4EFCB38BD5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1632863718;
        bh=6QNRFQLTs95DV4DW9ryMnXaQyoa+TwwvTbQ2usst3AM=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=nPNRR2RJuFwd/z7gLIzJWTg01bQG9Wx8xfEnLiN7QJ/HyIKwA0eGRiwFpgRj7b4p5
         3yAPYBrHJoyNuPnynldBVNbDx8vtdBm0HplM9URtZviRCsumHkfpq+gen1HAVzNn6h
         HoddP5/oyaSmtI9pLxwZeGcz4hZfr/Xfmw6uQRSYkwO+tEJWttdDjsQiZpzh6TfMTn
         hIbMhuedB21LD3ZUAfEh+t59iro/WHqygfXXhf1+dgz9ldIhQ7mIdntPcF/VB/aj5L
         7Xl3xAWerrwaKtb2Lnv72D2dUc2EBYNHq9iqDXUwvDMiXjsmvHwl79L+GBgo2D/Zw5
         MF3gisKgHKgXw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GB43HuW-dz2c; Tue, 28 Sep 2021 17:15:18 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id BF57238BC6D;
        Tue, 28 Sep 2021 17:15:17 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     will@kernel.org, paulmck@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-toolchains@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
Date:   Tue, 28 Sep 2021 17:15:07 -0400
Message-Id: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The control dependency ordering currently documented in
Documentation/memory-barriers.txt is fragile and can be broken by
various compiler optimizations.

The goal here is to prevent the compiler from being able to optimize a
conditional branch into something which lacks the control dependency,
while letting the compiler choose the best conditional branch in each
case.

Prevent the compiler from considering the two legs of a conditional
branch as identical by adding a distinct volatile asm in each leg of the
branch. Those asm do not emit any instruction nor data into the
resulting executable, and do not have any clobbers.

GNU describes asm volatile statements as having side-effects. [1]

C99 describes that accessing volatile objects are side-effects, and that
"at certain specified points in the execution sequence called sequence
points, all side effects of previous evaluations shall be complete
and no side effects of subsequent evaluations shall have taken
place". [2]

This ensures that the program order of READ_ONCE(), asm volatile in both
legs of the branch, and following WRITE_ONCE() and after_ctrl_dep()
barriers are preserved.

With this approach, the following code now keeps the control dependency:

        z =3D READ_ONCE(var1);
        if (ctrl_dep(z))
                WRITE_ONCE(var2, 5);
        else
                WRITE_ONCE(var2, 5);

And the ctrl_dep_eval() checking the constant triggers a build error
for:

        y =3D READ_ONCE(var1);
        if (ctrl_dep(y % 1))
                WRITE_ONCE(var2, 5);
        else
                WRITE_ONCE(var2, 6);

Which is good to have to ensure the compiler don't end up removing the
conditional branch because the it evaluates a constant.

Introduce the ctrl_dep macro in the generic headers, and use it
everywhere it appears relevant.  The approach taken is simply to
look for smp_acquire__after_ctrl_dep and "control dependency" across the
kernel sources, so a few other uses may have been missed.

The kernel documentation is also updated to reflect the need to use
the ctrl_dep macro and simplify the control dependencies section of
the documentation based on the additional guarantees provided by the
ctrl_dep macro.

In the btrfs code, change a smp_rmb() for a smp_acquire__after_ctrl_dep()=
,
which should be sufficient to guarantee LOAD-LOAD ordering.

I have validated the following code generation impacts on x86-64:

This patch does not alter the generated binary executables in ipc/sem.c,
ipc/mqueue.c, ipc/shm.c.

The presence of BUILD_BUG_ON() slightly changes the code layout in
kernel/events/ring_buffer.c, kernel/smp.c, and kernel/sched/core.c.

The asm volatile on the else leg of the control dependency further
restricts the compiler's ability to optimize code across the condition
for kernel/events/ring_buffer.c, kernel/smp.c, kernel/locking/rwsem.c.

The asm volatile on the then leg of the control dependency further
restricts the compiler's ability to optimize code across the condition
for kernel/sched/core.c, because its documented control dependency is on
the else leg of the branch.

Link: https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html [1]
Link: http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf [2]
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: will@kernel.org
Cc: paulmck@kernel.org
Cc: stern@rowland.harvard.edu
Cc: parri.andrea@gmail.com
Cc: boqun.feng@gmail.com
Cc: npiggin@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: luc.maranget@inria.fr
Cc: akiyks@gmail.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-toolchains@vger.kernel.org
Cc: linux-arch@vger.kernel.org
---
 Documentation/memory-barriers.txt | 205 ++++++++----------------------
 fs/btrfs/volumes.c                |   6 +-
 include/asm-generic/barrier.h     |  58 ++++++++-
 include/linux/refcount.h          |   2 +-
 ipc/mqueue.c                      |   2 +-
 ipc/msg.c                         |   2 +-
 ipc/sem.c                         |   2 +-
 kernel/events/ring_buffer.c       |   6 +-
 kernel/locking/rwsem.c            |   4 +-
 kernel/sched/core.c               |   2 +-
 kernel/smp.c                      |   2 +-
 11 files changed, 126 insertions(+), 165 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-bar=
riers.txt
index 7367ada13208..466f72fc4d3c 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -666,12 +666,18 @@ Control dependencies can be a bit tricky because cu=
rrent compilers do
 not understand them.  The purpose of this section is to help you prevent
 the compiler's ignorance from breaking your code.
=20
+Control dependencies should be made explicit by using ctrl_dep() around
+the condition expression of an if () statement, for () loop, or while ()
+loop.  This ensures the compiler is prohibited from optimizing away the
+conditional branch, and from lifting stores and memory barriers outside
+the selection statement.
+
 A load-load control dependency requires a full read memory barrier, not
 simply a data dependency barrier to make it work correctly.  Consider th=
e
 following bit of code:
=20
 	q =3D READ_ONCE(a);
-	if (q) {
+	if (ctrl_dep(q)) {
 		<data dependency barrier>  /* BUG: No data dependency!!! */
 		p =3D READ_ONCE(b);
 	}
@@ -683,8 +689,8 @@ the load from b as having happened before the load fr=
om a.  In such a
 case what's actually required is:
=20
 	q =3D READ_ONCE(a);
-	if (q) {
-		<read barrier>
+	if (ctrl_dep(q)) {
+		<smp_acquire__after_ctrl_dep>
 		p =3D READ_ONCE(b);
 	}
=20
@@ -692,92 +698,45 @@ However, stores are not speculated.  This means tha=
t ordering -is- provided
 for load-store control dependencies, as in the following example:
=20
 	q =3D READ_ONCE(a);
-	if (q) {
+	if (ctrl_dep(q)) {
 		WRITE_ONCE(b, 1);
 	}
=20
 Control dependencies pair normally with other types of barriers.
 That said, please note that neither READ_ONCE() nor WRITE_ONCE()
-are optional! Without the READ_ONCE(), the compiler might combine the
+are optional!  Without the READ_ONCE(), the compiler might combine the
 load from 'a' with other loads from 'a'.  Without the WRITE_ONCE(),
 the compiler might combine the store to 'b' with other stores to 'b'.
 Either can result in highly counterintuitive effects on ordering.
=20
-Worse yet, if the compiler is able to prove (say) that the value of
-variable 'a' is always non-zero, it would be well within its rights
-to optimize the original example by eliminating the "if" statement
-as follows:
-
-	q =3D a;
-	b =3D 1;  /* BUG: Compiler and CPU can both reorder!!! */
-
-So don't leave out the READ_ONCE().
+If the compiler is able to prove (say) that the value of variable 'a' is
+always non-zero, it would be well within its rights to optimize the
+original example by eliminating the "if" statement as follows.
+ctrl_dep ensures that a build error is generated if the condition
+evaluates to a true/false constant.
=20
-It is tempting to try to enforce ordering on identical stores on both
+Using ctrl_dep allows enforcing ordering on identical stores on both
 branches of the "if" statement as follows:
=20
 	q =3D READ_ONCE(a);
-	if (q) {
-		barrier();
+	if (ctrl_dep(q)) {
 		WRITE_ONCE(b, 1);
 		do_something();
 	} else {
-		barrier();
 		WRITE_ONCE(b, 1);
 		do_something_else();
 	}
=20
-Unfortunately, current compilers will transform this as follows at high
-optimization levels:
+ctrl_dep emits distinct asm volatile within each leg of the branch, thus
+preventing the compiler from lifting both WRITE_ONCE outside of the
+selection statement.
=20
-	q =3D READ_ONCE(a);
-	barrier();
-	WRITE_ONCE(b, 1);  /* BUG: No ordering vs. load from a!!! */
-	if (q) {
-		/* WRITE_ONCE(b, 1); -- moved up, BUG!!! */
-		do_something();
-	} else {
-		/* WRITE_ONCE(b, 1); -- moved up, BUG!!! */
-		do_something_else();
-	}
-
-Now there is no conditional between the load from 'a' and the store to
-'b', which means that the CPU is within its rights to reorder them:
-The conditional is absolutely required, and must be present in the
-assembly code even after all compiler optimizations have been applied.
-Therefore, if you need ordering in this example, you need explicit
-memory barriers, for example, smp_store_release():
+In addition, if operations applied to the condition variable result in
+the compiler proving it to be a constant (true/false), ctrl_dep will
+cause a compile-time error.  For example:
=20
 	q =3D READ_ONCE(a);
-	if (q) {
-		smp_store_release(&b, 1);
-		do_something();
-	} else {
-		smp_store_release(&b, 1);
-		do_something_else();
-	}
-
-In contrast, without explicit memory barriers, two-legged-if control
-ordering is guaranteed only when the stores differ, for example:
-
-	q =3D READ_ONCE(a);
-	if (q) {
-		WRITE_ONCE(b, 1);
-		do_something();
-	} else {
-		WRITE_ONCE(b, 2);
-		do_something_else();
-	}
-
-The initial READ_ONCE() is still required to prevent the compiler from
-proving the value of 'a'.
-
-In addition, you need to be careful what you do with the local variable =
'q',
-otherwise the compiler might be able to guess the value and again remove
-the needed conditional.  For example:
-
-	q =3D READ_ONCE(a);
-	if (q % MAX) {
+	if (ctrl_dep(q % MAX)) {
 		WRITE_ONCE(b, 1);
 		do_something();
 	} else {
@@ -786,86 +745,41 @@ the needed conditional.  For example:
 	}
=20
 If MAX is defined to be 1, then the compiler knows that (q % MAX) is
-equal to zero, in which case the compiler is within its rights to
-transform the above code into the following:
-
-	q =3D READ_ONCE(a);
-	WRITE_ONCE(b, 2);
-	do_something_else();
-
-Given this transformation, the CPU is not required to respect the orderi=
ng
-between the load from variable 'a' and the store to variable 'b'.  It is
-tempting to add a barrier(), but this does not help.  The conditional
-is gone, and the barrier won't bring it back.  Therefore, if you are
-relying on this ordering, you should make sure that MAX is greater than
-one, perhaps as follows:
-
-	q =3D READ_ONCE(a);
-	BUILD_BUG_ON(MAX <=3D 1); /* Order load from a with store to b. */
-	if (q % MAX) {
-		WRITE_ONCE(b, 1);
-		do_something();
-	} else {
-		WRITE_ONCE(b, 2);
-		do_something_else();
-	}
-
-Please note once again that the stores to 'b' differ.  If they were
-identical, as noted earlier, the compiler could pull this store outside
-of the 'if' statement.
+equal to zero, which would allow it to remove the conditional branch
+altogether. The ctrl_dep macro prevents this by causing a compile-time
+error.
=20
-You must also be careful not to rely too much on boolean short-circuit
-evaluation.  Consider this example:
+The same compiler error will be generated by ctrl_dep if boolean
+short-circuit evaluation ends up with a constant condition variable.
+Consider this example:
=20
 	q =3D READ_ONCE(a);
-	if (q || 1 > 0)
+	if (ctrl_dep(q || 1 > 0))
 		WRITE_ONCE(b, 1);
=20
 Because the first condition cannot fault and the second condition is
-always true, the compiler can transform this example as following,
-defeating control dependency:
-
-	q =3D READ_ONCE(a);
-	WRITE_ONCE(b, 1);
+always true, the compiler considers the condition as a constant (true).
+ctrl_dep causes a compiler error in this case.
=20
-This example underscores the need to ensure that the compiler cannot
-out-guess your code.  More generally, although READ_ONCE() does force
-the compiler to actually emit code for a given load, it does not force
-the compiler to use the results.
+By using ctrl_dep, control dependencies apply to both the then-clause
+and else-clause of the if-statement in question, as well as to code
+following the if-statement:
=20
-In addition, control dependencies apply only to the then-clause and
-else-clause of the if-statement in question.  In particular, it does
-not necessarily apply to code following the if-statement:
=20
 	q =3D READ_ONCE(a);
-	if (q) {
+	if (ctrl_dep(q)) {
 		WRITE_ONCE(b, 1);
 	} else {
 		WRITE_ONCE(b, 2);
 	}
-	WRITE_ONCE(c, 1);  /* BUG: No ordering against the read from 'a'. */
-
-It is tempting to argue that there in fact is ordering because the
-compiler cannot reorder volatile accesses and also cannot reorder
-the writes to 'b' with the condition.  Unfortunately for this line
-of reasoning, the compiler might compile the two writes to 'b' as
-conditional-move instructions, as in this fanciful pseudo-assembly
-language:
-
-	ld r1,a
-	cmp r1,$0
-	cmov,ne r4,$1
-	cmov,eq r4,$2
-	st r4,b
-	st $1,c
-
-A weakly ordered CPU would have no dependency of any sort between the lo=
ad
-from 'a' and the store to 'c'.  The control dependencies would extend
-only to the pair of cmov instructions and the store depending on them.
-In short, control dependencies apply only to the stores in the then-clau=
se
-and else-clause of the if-statement in question (including functions
-invoked by those two clauses), not to code following that if-statement.
+	WRITE_ONCE(c, 1);
=20
+Because ctrl_dep emits distinct asm volatile within each leg of the if
+statement, the compiler cannot transform the two writes to 'b' into a
+conditional-move (cmov) instruction, thus ensuring the presence of a
+conditional branch.  Also because the ctrl_dep emits asm volatile within
+each leg of the if statement, the compiler cannot move the write to 'c'
+before the conditional branch.
=20
 Note well that the ordering provided by a control dependency is local
 to the CPU containing it.  See the section on "Multicopy atomicity"
@@ -881,40 +795,33 @@ In summary:
       use smp_rmb(), smp_wmb(), or, in the case of prior stores and
       later loads, smp_mb().
=20
-  (*) If both legs of the "if" statement begin with identical stores to
-      the same variable, then those stores must be ordered, either by
-      preceding both of them with smp_mb() or by using smp_store_release=
()
-      to carry out the stores.  Please note that it is -not- sufficient
-      to use barrier() at beginning of each leg of the "if" statement
-      because, as shown by the example above, optimizing compilers can
-      destroy the control dependency while respecting the letter of the
-      barrier() law.
+  (*) Control dependencies should be made explicit using the ctrl_dep
+      macro.
=20
   (*) Control dependencies require at least one run-time conditional
       between the prior load and the subsequent store, and this
-      conditional must involve the prior load.  If the compiler is able
-      to optimize the conditional away, it will have also optimized
-      away the ordering.  Careful use of READ_ONCE() and WRITE_ONCE()
-      can help to preserve the needed conditional.
+      conditional must involve the prior load.  Careful use of
+      READ_ONCE() and WRITE_ONCE() can help to preserve the needed
+      conditional.
=20
   (*) Control dependencies require that the compiler avoid reordering th=
e
       dependency into nonexistence.  Careful use of READ_ONCE() or
       atomic{,64}_read() can help to preserve your control dependency.
       Please see the COMPILER BARRIER section for more information.
=20
-  (*) Control dependencies apply only to the then-clause and else-clause
+  (*) Control dependencies apply to the then-clause and else-clause
       of the if-statement containing the control dependency, including
-      any functions that these two clauses call.  Control dependencies
-      do -not- apply to code following the if-statement containing the
-      control dependency.
+      any functions that these two clauses call, as well as code
+      following the if-statement containing the control dependency.
=20
   (*) Control dependencies pair normally with other types of barriers.
=20
   (*) Control dependencies do -not- provide multicopy atomicity.  If you
       need all the CPUs to see a given store at the same time, use smp_m=
b().
=20
-  (*) Compilers do not understand control dependencies.  It is therefore
-      your job to ensure that they do not break your code.
+  (*) Compilers do not understand control dependencies.  Use of
+      ctrl_dep is required to prevent the compiler optimizations
+      from breaking your code.
=20
=20
 SMP BARRIER PAIRING
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2ec3b8ac8fa3..182cd06d7d37 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7772,7 +7772,7 @@ int btrfs_run_dev_stats(struct btrfs_trans_handle *=
trans)
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		stats_cnt =3D atomic_read(&device->dev_stats_ccnt);
-		if (!device->dev_stats_valid || stats_cnt =3D=3D 0)
+		if (ctrl_dep(!device->dev_stats_valid || stats_cnt =3D=3D 0))
 			continue;
=20
=20
@@ -7780,14 +7780,14 @@ int btrfs_run_dev_stats(struct btrfs_trans_handle=
 *trans)
 		 * There is a LOAD-LOAD control dependency between the value of
 		 * dev_stats_ccnt and updating the on-disk values which requires
 		 * reading the in-memory counters. Such control dependencies
-		 * require explicit read memory barriers.
+		 * require explicit acquire barriers.
 		 *
 		 * This memory barriers pairs with smp_mb__before_atomic in
 		 * btrfs_dev_stat_inc/btrfs_dev_stat_set and with the full
 		 * barrier implied by atomic_xchg in
 		 * btrfs_dev_stats_read_and_reset
 		 */
-		smp_rmb();
+		smp_acquire__after_ctrl_dep();
=20
 		ret =3D update_dev_stat_item(trans, device);
 		if (!ret)
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.=
h
index 640f09479bdf..7b32c5f67256 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -187,6 +187,60 @@ do {									\
 #define virt_store_release(p, v) __smp_store_release(p, v)
 #define virt_load_acquire(p) __smp_load_acquire(p)
=20
+#ifndef ctrl_dep_eval
+#define ctrl_dep_eval(x)        ({ BUILD_BUG_ON(__builtin_constant_p(!!(=
x))); (x); })
+#endif
+
+#ifndef ctrl_dep_asm_volatile
+/*
+ * Emit a distinct asm volatile for each leg of the branch. Their
+ * purpose is to prevent the compiler from optimizing away the
+ * conditional branch, and prevent it from lifting following volatile
+ * stores and *_after_ctrl_dep() barriers out of the selection
+ * statement.
+ *
+ * Those asm volatile do not generate any code; they only affect
+ * compiler optimizations.  They respectively emit an unused "0:"
+ * and "1:" label in each leg of the branch.
+ */
+#define ctrl_dep_asm_volatile(x)	({ asm volatile (__stringify(x) ":\n\t"=
); (x); })
+#endif
+
+
+/**
+ * ctrl_dep() - Provide a control-dependency
+ *
+ * if (ctrl_dep(READ_ONCE(A))
+ *	WRITE_ONCE(B, 1);
+ *
+ * and
+ *
+ * do {
+ *   [...]
+ * } while (ctrl_dep(READ_ONCE(A)));
+ * WRITE_ONCE(B, 1);
+ *
+ * will ensure that the STORE to B happens after the LOAD of A. Normally=
 a
+ * control dependency relies on a conditional branch having a data depen=
dency
+ * on the LOAD and an architecture's inability to speculate STOREs. IOW,=
 this
+ * provides a LOAD->STORE order.
+ *
+ * Due to optimizing compilers, extra care is needed; as per the example=
 above
+ * the LOAD must be 'volatile' qualified in order to ensure the compiler
+ * actually emits the load, such that the data-dependency to the conditi=
onal
+ * branch can be formed.
+ *
+ * Secondly, the compiler must be prohibited from lifting anything out o=
f the
+ * selection statement, as this would obviously also break the ordering.
+ *
+ * Thirdly, architectures that allow the LOAD->STORE reorder must ensure
+ * the compiler actually emits the conditional branch instruction.
+ */
+
+#ifndef ctrl_dep
+#define ctrl_dep(x)          ((ctrl_dep_eval(x) && ctrl_dep_asm_volatile=
(1)) || ctrl_dep_asm_volatile(0))
+#endif
+
 /**
  * smp_acquire__after_ctrl_dep() - Provide ACQUIRE ordering after a cont=
rol dependency
  *
@@ -201,7 +255,7 @@ do {									\
 #endif
=20
 /**
- * smp_cond_load_relaxed() - (Spin) wait for cond with no ordering guara=
ntees
+ * smp_cond_load_relaxed() - (Spin) wait for cond with control dependenc=
y
  * @ptr: pointer to the variable to wait on
  * @cond: boolean expression to wait for
  *
@@ -216,7 +270,7 @@ do {									\
 	__unqual_scalar_typeof(*ptr) VAL;			\
 	for (;;) {						\
 		VAL =3D READ_ONCE(*__PTR);			\
-		if (cond_expr)					\
+		if (ctrl_dep(cond_expr))			\
 			break;					\
 		cpu_relax();					\
 	}							\
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index b8a6e387f8f9..afc7e08648bd 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -274,7 +274,7 @@ static inline __must_check bool __refcount_sub_and_te=
st(int i, refcount_t *r, in
 	if (oldp)
 		*oldp =3D old;
=20
-	if (old =3D=3D i) {
+	if (ctrl_dep(old =3D=3D i)) {
 		smp_acquire__after_ctrl_dep();
 		return true;
 	}
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 5becca9be867..5246dec231ac 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -715,7 +715,7 @@ static int wq_sleep(struct mqueue_inode_info *info, i=
nt sr,
 		time =3D schedule_hrtimeout_range_clock(timeout, 0,
 			HRTIMER_MODE_ABS, CLOCK_REALTIME);
=20
-		if (READ_ONCE(ewp->state) =3D=3D STATE_READY) {
+		if (ctrl_dep(READ_ONCE(ewp->state) =3D=3D STATE_READY)) {
 			/* see MQ_BARRIER for purpose/pairing */
 			smp_acquire__after_ctrl_dep();
 			retval =3D 0;
diff --git a/ipc/msg.c b/ipc/msg.c
index a0d05775af2c..046c54a0c526 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -1213,7 +1213,7 @@ static long do_msgrcv(int msqid, void __user *buf, =
size_t bufsz, long msgtyp, in
 		 * signal) it will either see the message and continue ...
 		 */
 		msg =3D READ_ONCE(msr_d.r_msg);
-		if (msg !=3D ERR_PTR(-EAGAIN)) {
+		if (ctrl_dep(msg !=3D ERR_PTR(-EAGAIN))) {
 			/* see MSG_BARRIER for purpose/pairing */
 			smp_acquire__after_ctrl_dep();
=20
diff --git a/ipc/sem.c b/ipc/sem.c
index 6693daf4fe11..6d65948731e6 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -2183,7 +2183,7 @@ long __do_semtimedop(int semid, struct sembuf *sops=
,
 		 * window between wake_q_add() and wake_up_q().
 		 */
 		error =3D READ_ONCE(queue.status);
-		if (error !=3D -EINTR) {
+		if (ctrl_dep(error !=3D -EINTR)) {
 			/* see SEM_BARRIER_2 for purpose/pairing */
 			smp_acquire__after_ctrl_dep();
 			goto out;
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 52868716ec35..243c65a6d008 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -193,9 +193,9 @@ __perf_output_begin(struct perf_output_handle *handle=
,
 		tail =3D READ_ONCE(rb->user_page->data_tail);
 		offset =3D head =3D local_read(&rb->head);
 		if (!rb->overwrite) {
-			if (unlikely(!ring_buffer_has_space(head, tail,
+			if (ctrl_dep(unlikely(!ring_buffer_has_space(head, tail,
 							    perf_data_size(rb),
-							    size, backward)))
+							    size, backward))))
 				goto fail;
 		}
=20
@@ -429,7 +429,7 @@ void *perf_aux_output_begin(struct perf_output_handle=
 *handle,
 		 * control dependency barrier separating aux_tail load from aux data
 		 * store that will be enabled on successful return
 		 */
-		if (!handle->size) { /* A, matches D */
+		if (ctrl_dep(!handle->size)) { /* A, matches D */
 			event->pending_disable =3D smp_processor_id();
 			perf_output_wakeup(handle);
 			WRITE_ONCE(rb->aux_nest, 0);
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 000e8d5a2884..9ea81d1f4c37 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -942,8 +942,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, lo=
ng count, unsigned int stat
 		 * exit the slowpath and return immediately as its
 		 * RWSEM_READER_BIAS has already been set in the count.
 		 */
-		if (!(atomic_long_read(&sem->count) &
-		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
+		if (ctrl_dep(!(atomic_long_read(&sem->count) &
+		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF)))) {
 			/* Provide lock ACQUIRE */
 			smp_acquire__after_ctrl_dep();
 			raw_spin_unlock_irq(&sem->wait_lock);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1bba4128a3e6..17525063d5c0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4008,7 +4008,7 @@ try_to_wake_up(struct task_struct *p, unsigned int =
state, int wake_flags)
 	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
 	 */
 	smp_rmb();
-	if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
+	if (ctrl_dep(READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags)))
 		goto unlock;
=20
 #ifdef CONFIG_SMP
diff --git a/kernel/smp.c b/kernel/smp.c
index f43ede0ab183..a284110ed7f6 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -394,7 +394,7 @@ static void __csd_lock_wait(struct __call_single_data=
 *csd)
=20
 	ts1 =3D ts0 =3D sched_clock();
 	for (;;) {
-		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
+		if (ctrl_dep(csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id)))
 			break;
 		cpu_relax();
 	}
--=20
2.20.1

