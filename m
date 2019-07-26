Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC65771C8
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2019 21:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbfGZTBt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Jul 2019 15:01:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60862 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387743AbfGZTBs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Jul 2019 15:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fl6Vu1KmlAtNlOIAUYxzCXCOv5Jo7UhPrns0sxfS2vQ=; b=FnJBi1cQ1kbKDb5ChQiPsDFs3t
        aPRxLAHenfj8Vf/d1p37JAIai1YbejP9N2WWlgS/WCmSD4SIaeutgUXAZDyVNu5lTimvzkGaQnR8c
        zDY5I6jR7ihYrYrMoc7Rp/NxAUHA034+uMCZK38RBJE45ur9hwmyK/VC/O8edhBkJLgZurzQENDV9
        sK8J+jxWvT82ZEAQMOtA6L6fDW6gk6H0/GVUKjq1+xTlLpfx6OMGpHoikbgLcbgLgU3pjGKADBqGr
        YwRxyC2dDe6sn1AzAOP+KMYoRpJKjAn1wE+yePcUi4H4NycMdadWSJ4Z7/FdzoTpJX5UQPiVOrhLw
        0cWIn1YA==;
Received: from [179.95.31.157] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr5TM-0004tj-1C; Fri, 26 Jul 2019 19:01:44 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hr5TJ-0002tm-Nc; Fri, 26 Jul 2019 16:01:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        SeongJae Park <sj38.park@gmail.com>, linux-arch@vger.kernel.org
Subject: [PATCH] tools: memory-model: add it to the Documentation body
Date:   Fri, 26 Jul 2019 16:01:37 -0300
Message-Id: <5826090bf29ec831df620b79d7fe60ef7a705795.1564167643.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190726180201.GE146401@google.com>
References: <20190726180201.GE146401@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The books at tools/memory-model/Documentation are very well
formatted. Congrats to the ones that wrote them!

The manual conversion to ReST is really trivial:

	- Add document titles;
	- change the bullets on some lists;
	- mark code blocks.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/core-api/refcount-vs-atomic.rst |   2 +-
 Documentation/index.rst                       |   1 +
 Documentation/tools/memory-model              |   1 +
 .../memory-model/Documentation/cheatsheet.rst |  36 +++++
 .../memory-model/Documentation/cheatsheet.txt |  30 ----
 .../{explanation.txt => explanation.rst}      | 151 ++++++++++--------
 tools/memory-model/Documentation/index.rst    |  20 +++
 .../{recipes.txt => recipes.rst}              |  41 ++---
 .../{references.txt => references.rst}        |  46 +++---
 tools/memory-model/README                     |  10 +-
 10 files changed, 192 insertions(+), 146 deletions(-)
 create mode 120000 Documentation/tools/memory-model
 create mode 100644 tools/memory-model/Documentation/cheatsheet.rst
 delete mode 100644 tools/memory-model/Documentation/cheatsheet.txt
 rename tools/memory-model/Documentation/{explanation.txt => explanation.rst} (97%)
 create mode 100644 tools/memory-model/Documentation/index.rst
 rename tools/memory-model/Documentation/{recipes.txt => recipes.rst} (96%)
 rename tools/memory-model/Documentation/{references.txt => references.rst} (71%)

diff --git a/Documentation/core-api/refcount-vs-atomic.rst b/Documentation/core-api/refcount-vs-atomic.rst
index 976e85adffe8..7e6500a6fa76 100644
--- a/Documentation/core-api/refcount-vs-atomic.rst
+++ b/Documentation/core-api/refcount-vs-atomic.rst
@@ -17,7 +17,7 @@ in order to help maintainers validate their code against the change in
 these memory ordering guarantees.
 
 The terms used through this document try to follow the formal LKMM defined in
-tools/memory-model/Documentation/explanation.txt.
+tools/memory-model/Documentation/explanation.rst.
 
 memory-barriers.txt and atomic_t.txt provide more background to the
 memory ordering in general and for atomic operations specifically.
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 0a564f3c336e..03ff920ac1cb 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -36,6 +36,7 @@ trying to get it to work optimally on a given system.
 
    admin-guide/index
    kbuild/index
+   tools/index
 
 Firmware-related documentation
 ------------------------------
diff --git a/Documentation/tools/memory-model b/Documentation/tools/memory-model
new file mode 120000
index 000000000000..020ed38ce302
--- /dev/null
+++ b/Documentation/tools/memory-model
@@ -0,0 +1 @@
+../../tools/memory-model/Documentation/
\ No newline at end of file
diff --git a/tools/memory-model/Documentation/cheatsheet.rst b/tools/memory-model/Documentation/cheatsheet.rst
new file mode 100644
index 000000000000..35f8749b8a53
--- /dev/null
+++ b/tools/memory-model/Documentation/cheatsheet.rst
@@ -0,0 +1,36 @@
+===========
+Cheat Sheet
+===========
+
+::
+
+				    Prior Operation     Subsequent Operation
+				    ---------------  ---------------------------
+				 C  Self  R  W  RMW  Self  R  W  DR  DW  RMW  SV
+				--  ----  -  -  ---  ----  -  -  --  --  ---  --
+
+  Store, e.g., WRITE_ONCE()            Y                                       Y
+  Load, e.g., READ_ONCE()              Y                          Y   Y        Y
+  Unsuccessful RMW operation           Y                          Y   Y        Y
+  rcu_dereference()                    Y                          Y   Y        Y
+  Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
+  Successful *_release()         C        Y  Y    Y     W                      Y
+  smp_rmb()                               Y       R        Y      Y        R
+  smp_wmb()                                  Y    W           Y       Y    W
+  smp_mb() & synchronize_rcu()  CP        Y  Y    Y        Y  Y   Y   Y    Y
+  Successful full non-void RMW  CP     Y  Y  Y    Y     Y  Y  Y   Y   Y    Y   Y
+  smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
+  smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
+
+
+  Key:    C:      Ordering is cumulative
+	  P:      Ordering propagates
+	  R:      Read, for example, READ_ONCE(), or read portion of RMW
+	  W:      Write, for example, WRITE_ONCE(), or write portion of RMW
+	  Y:      Provides ordering
+	  a:      Provides ordering given intervening RMW atomic operation
+	  DR:     Dependent read (address dependency)
+	  DW:     Dependent write (address, data, or control dependency)
+	  RMW:    Atomic read-modify-write operation
+	  SELF:   Orders self, as opposed to accesses before and/or after
+	  SV:     Orders later accesses to the same variable
diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
deleted file mode 100644
index 33ba98d72b16..000000000000
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-                                  Prior Operation     Subsequent Operation
-                                  ---------------  ---------------------------
-                               C  Self  R  W  RMW  Self  R  W  DR  DW  RMW  SV
-                              --  ----  -  -  ---  ----  -  -  --  --  ---  --
-
-Store, e.g., WRITE_ONCE()            Y                                       Y
-Load, e.g., READ_ONCE()              Y                          Y   Y        Y
-Unsuccessful RMW operation           Y                          Y   Y        Y
-rcu_dereference()                    Y                          Y   Y        Y
-Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
-Successful *_release()         C        Y  Y    Y     W                      Y
-smp_rmb()                               Y       R        Y      Y        R
-smp_wmb()                                  Y    W           Y       Y    W
-smp_mb() & synchronize_rcu()  CP        Y  Y    Y        Y  Y   Y   Y    Y
-Successful full non-void RMW  CP     Y  Y  Y    Y     Y  Y  Y   Y   Y    Y   Y
-smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
-smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
-
-
-Key:	C:	Ordering is cumulative
-	P:	Ordering propagates
-	R:	Read, for example, READ_ONCE(), or read portion of RMW
-	W:	Write, for example, WRITE_ONCE(), or write portion of RMW
-	Y:	Provides ordering
-	a:	Provides ordering given intervening RMW atomic operation
-	DR:	Dependent read (address dependency)
-	DW:	Dependent write (address, data, or control dependency)
-	RMW:	Atomic read-modify-write operation
-	SELF:	Orders self, as opposed to accesses before and/or after
-	SV:	Orders later accesses to the same variable
diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.rst
similarity index 97%
rename from tools/memory-model/Documentation/explanation.txt
rename to tools/memory-model/Documentation/explanation.rst
index 68caa9a976d0..227ec75f8dc4 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.rst
@@ -1,5 +1,6 @@
+========================================================
 Explanation of the Linux-Kernel Memory Consistency Model
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+========================================================
 
 :Author: Alan Stern <stern@rowland.harvard.edu>
 :Created: October 2017
@@ -107,7 +108,7 @@ and the flag are memory locations shared between the two CPUs.
 
 We can abstract out the important pieces of the driver code as follows
 (the reason for using WRITE_ONCE() and READ_ONCE() instead of simple
-assignment statements is discussed later):
+assignment statements is discussed later)::
 
 	int buf = 0, flag = 0;
 
@@ -219,7 +220,7 @@ Ordering).  This model predicts that the undesired outcome for the MP
 pattern cannot occur, but in other respects it differs from Sequential
 Consistency.  One example is the Store Buffer (SB) pattern, in which
 each CPU stores to its own shared location and then loads from the
-other CPU's location:
+other CPU's location::
 
 	int x = 0, y = 0;
 
@@ -264,7 +265,7 @@ The counterpart to ordering is a cycle.  Ordering rules out cycles:
 It's not possible to have X ordered before Y, Y ordered before Z, and
 Z ordered before X, because this would mean that X is ordered before
 itself.  The analysis of the MP example under Sequential Consistency
-involved just such an impossible cycle:
+involved just such an impossible cycle::
 
 	W: P0 stores 1 to flag   executes before
 	X: P1 loads 1 from flag  executes before
@@ -388,7 +389,7 @@ The protections provided by READ_ONCE(), WRITE_ONCE(), and others are
 not perfect; and under some circumstances it is possible for the
 compiler to undermine the memory model.  Here is an example.  Suppose
 both branches of an "if" statement store the same value to the same
-location:
+location::
 
 	r1 = READ_ONCE(x);
 	if (r1) {
@@ -402,7 +403,7 @@ location:
 For this code, the LKMM predicts that the load from x will always be
 executed before either of the stores to y.  However, a compiler could
 lift the stores out of the conditional, transforming the code into
-something resembling:
+something resembling::
 
 	r1 = READ_ONCE(x);
 	WRITE_ONCE(y, 2);
@@ -418,7 +419,7 @@ model's original prediction could be invalidated by the compiler.
 
 Another issue arises from the fact that in C, arguments to many
 operators and function calls can be evaluated in any order.  For
-example:
+example::
 
 	r1 = f(5) + g(6);
 
@@ -440,7 +441,7 @@ control (ctrl).
 
 A read and a write event are linked by a data dependency if the value
 obtained by the read affects the value stored by the write.  As a very
-simple example:
+simple example::
 
 	int x, y;
 
@@ -455,7 +456,7 @@ values of multiple reads.
 A read event and another memory access event are linked by an address
 dependency if the value obtained by the read affects the location
 accessed by the other event.  The second event can be either a read or
-a write.  Here's another simple example:
+a write.  Here's another simple example::
 
 	int a[20];
 	int i;
@@ -471,7 +472,7 @@ pointer.
 
 Finally, a read event and another memory access event are linked by a
 control dependency if the value obtained by the read affects whether
-the second event is executed at all.  Simple example:
+the second event is executed at all.  Simple example::
 
 	int x, y;
 
@@ -510,7 +511,7 @@ Usage of the rf relation implicitly assumes that loads will always
 read from a single store.  It doesn't apply properly in the presence
 of load-tearing, where a load obtains some of its bits from one store
 and some of them from another store.  Fortunately, use of READ_ONCE()
-and WRITE_ONCE() will prevent load-tearing; it's not possible to have:
+and WRITE_ONCE() will prevent load-tearing; it's not possible to have::
 
 	int x = 0;
 
@@ -530,7 +531,7 @@ and end up with r1 = 0x1200 (partly from x's initial value and partly
 from the value stored by P0).
 
 On the other hand, load-tearing is unavoidable when mixed-size
-accesses are used.  Consider this example:
+accesses are used.  Consider this example::
 
 	union {
 		u32	w;
@@ -612,7 +613,7 @@ requirement that every store eventually becomes visible to every CPU.)
 Any reasonable memory model will include cache coherence.  Indeed, our
 expectation of cache coherence is so deeply ingrained that violations
 of its requirements look more like hardware bugs than programming
-errors:
+errors::
 
 	int x;
 
@@ -628,6 +629,8 @@ write-write coherence rule: Since the store of 23 comes later in
 program order, it must also come later in x's coherence order and
 thus must overwrite the store of 17.
 
+::
+
 	int x = 0;
 
 	P0()
@@ -644,6 +647,8 @@ program order, so it must not read from that store but rather from one
 coming earlier in the coherence order (in this case, x's initial
 value).
 
+::
+
 	int x = 0;
 
 	P0()
@@ -694,7 +699,7 @@ value that R reads is overwritten (directly or indirectly) by W, or
 equivalently, when R reads from a store which comes earlier than W in
 the coherence order.
 
-For example:
+For example::
 
 	int x = 0;
 
@@ -721,6 +726,8 @@ relations; it is not independent.  Given a read event R and a write
 event W for the same location, we will have R ->fr W if and only if
 the write which R reads from is co-before W.  In symbols,
 
+::
+
 	(R ->fr W) := (there exists W' with W' ->rf R and W' ->co W).
 
 
@@ -907,7 +914,7 @@ whenever we have X ->rf Y or X ->co Y or X ->fr Y or X ->po-loc Y, the
 X event comes before the Y event in the global ordering.  The LKMM's
 "coherence" axiom expresses this by requiring the union of these
 relations not to have any cycles.  This means it must not be possible
-to find events
+to find events::
 
 	X0 -> X1 -> X2 -> ... -> Xn -> X0,
 
@@ -929,7 +936,7 @@ this case) does not get altered between the read and the write events
 making up the atomic operation.  In particular, if two CPUs perform
 atomic_inc(&x) concurrently, it must be guaranteed that the final
 value of x will be the initial value plus two.  We should never have
-the following sequence of events:
+the following sequence of events::
 
 	CPU 0 loads x obtaining 13;
 					CPU 1 loads x obtaining 13;
@@ -951,6 +958,8 @@ atomic read-modify-write and W' is the write event which R reads from,
 there must not be any stores coming between W' and W in the coherence
 order.  Equivalently,
 
+::
+
 	(R ->rmw W) implies (there is no X with R ->fr X and X ->co W),
 
 where the rmw relation links the read and write events making up each
@@ -1021,7 +1030,7 @@ includes address dependencies to loads in the ppo relation.
 
 On the other hand, dependencies can indirectly affect the ordering of
 two loads.  This happens when there is a dependency from a load to a
-store and a second, po-later load reads from that store:
+store and a second, po-later load reads from that store::
 
 	R ->dep W ->rfi R',
 
@@ -1036,7 +1045,7 @@ R; if the speculation turns out to be wrong then the CPU merely has to
 restart or abandon R'.
 
 (In theory, a CPU might forward a store to a load when it runs across
-an address dependency like this:
+an address dependency like this::
 
 	r1 = READ_ONCE(ptr);
 	WRITE_ONCE(*r1, 17);
@@ -1048,7 +1057,7 @@ However, none of the architectures supported by the Linux kernel do
 this.)
 
 Two memory accesses of the same location must always be executed in
-program order if the second access is a store.  Thus, if we have
+program order if the second access is a store.  Thus, if we have::
 
 	R ->po-loc W
 
@@ -1056,7 +1065,7 @@ program order if the second access is a store.  Thus, if we have
 access the same location), the CPU is obliged to execute W after R.
 If it executed W first then the memory subsystem would respond to R's
 read request with the value stored by W (or an even later store), in
-violation of the read-write coherence rule.  Similarly, if we had
+violation of the read-write coherence rule.  Similarly, if we had::
 
 	W ->po-loc W'
 
@@ -1074,7 +1083,7 @@ AND THEN THERE WAS ALPHA
 
 As mentioned above, the Alpha architecture is unique in that it does
 not appear to respect address dependencies to loads.  This means that
-code such as the following:
+code such as the following::
 
 	int x = 0;
 	int y = -1;
@@ -1128,7 +1137,7 @@ nothing at all on non-Alpha builds) after every READ_ONCE() and atomic
 load.  The effect of the fence is to cause the CPU not to execute any
 po-later instructions until after the local cache has finished
 processing all the stores it has already received.  Thus, if the code
-was changed to:
+was changed to::
 
 	P1()
 	{
@@ -1199,7 +1208,7 @@ the first event in the coherence order and propagates to C before the
 second event executes.
 
 This is best explained with some examples.  The simplest case looks
-like this:
+like this::
 
 	int x;
 
@@ -1225,7 +1234,7 @@ event, because P1's store came after P0's store in x's coherence
 order, and P1's store propagated to P0 before P0's load executed.
 
 An equally simple case involves two loads of the same location that
-read from different stores:
+read from different stores::
 
 	int x = 0;
 
@@ -1252,7 +1261,7 @@ P1's store propagated to P0 before P0's second load executed.
 
 Less trivial examples of prop all involve fences.  Unlike the simple
 examples above, they can require that some instructions are executed
-out of program order.  This next one should look familiar:
+out of program order.  This next one should look familiar::
 
 	int buf = 0, flag = 0;
 
@@ -1303,7 +1312,7 @@ rfe link.  You can concoct more exotic examples, containing more than
 one fence, although this quickly leads to diminishing returns in terms
 of complexity.  For instance, here's an example containing a coe link
 followed by two fences and an rfe link, utilizing the fact that
-release fences are A-cumulative:
+release fences are A-cumulative::
 
 	int x, y, z;
 
@@ -1363,7 +1372,7 @@ links.  Let's see how this definition works out.
 
 Consider first the case where E is a store (implying that the sequence
 of links begins with coe).  Then there are events W, X, Y, and Z such
-that:
+that::
 
 	E ->coe W ->cumul-fence* X ->rfe? Y ->strong-fence Z ->hb* F,
 
@@ -1390,7 +1399,7 @@ request with the value stored by W or an even later store,
 contradicting the fact that E ->fre W.
 
 A good example illustrating how pb works is the SB pattern with strong
-fences:
+fences::
 
 	int x = 0, y = 0;
 
@@ -1449,18 +1458,18 @@ span a full grace period.  In more detail, the Guarantee says:
 	For any critical section C and any grace period G, at least
 	one of the following statements must hold:
 
-(1)	C ends before G does, and in addition, every store that
-	propagates to C's CPU before the end of C must propagate to
-	every CPU before G ends.
+	(1)	C ends before G does, and in addition, every store that
+		propagates to C's CPU before the end of C must propagate to
+		every CPU before G ends.
 
-(2)	G starts before C does, and in addition, every store that
-	propagates to G's CPU before the start of G must propagate
-	to every CPU before C starts.
+	(2)	G starts before C does, and in addition, every store that
+		propagates to G's CPU before the start of G must propagate
+		to every CPU before C starts.
 
 In particular, it is not possible for a critical section to both start
 before and end after a grace period.
 
-Here is a simple example of RCU in action:
+Here is a simple example of RCU in action::
 
 	int x, y;
 
@@ -1544,13 +1553,13 @@ the end of a critical section which starts before Z begins.
 The LKMM goes on to define the rcu-fence relation as a sequence of
 rcu-gp and rcu-rscsi links separated by rcu-link links, in which the
 number of rcu-gp links is >= the number of rcu-rscsi links.  For
-example:
+example::
 
 	X ->rcu-gp Y ->rcu-link Z ->rcu-rscsi T ->rcu-link U ->rcu-gp V
 
 would imply that X ->rcu-fence V, because this sequence contains two
 rcu-gp links and one rcu-rscsi link.  (It also implies that
-X ->rcu-fence T and Z ->rcu-fence V.)  On the other hand:
+X ->rcu-fence T and Z ->rcu-fence V.)  On the other hand::
 
 	X ->rcu-rscsi Y ->rcu-link Z ->rcu-rscsi T ->rcu-link U ->rcu-gp V
 
@@ -1566,7 +1575,7 @@ E must execute before F; in fact, each synchronize_rcu() fence event
 is linked to itself by rcu-fence as a degenerate case.)
 
 To prove this in full generality requires some intellectual effort.
-We'll consider just a very simple case:
+We'll consider just a very simple case::
 
 	G ->rcu-gp W ->rcu-link Z ->rcu-rscsi F.
 
@@ -1621,7 +1630,7 @@ question, and let S be the synchronize_rcu() fence event for the grace
 period.  Saying that the critical section starts before S means there
 are events Q and R where Q is po-after L (which marks the start of the
 critical section), Q is "before" R in the sense used by the rcu-link
-relation, and R is po-before the grace period S.  Thus we have:
+relation, and R is po-before the grace period S.  Thus we have::
 
 	L ->rcu-link S.
 
@@ -1629,20 +1638,20 @@ Let W be the store mentioned above, let Y come before the end of the
 critical section and witness that W propagates to the critical
 section's CPU by reading from W, and let Z on some arbitrary CPU be a
 witness that W has not propagated to that CPU, where Z happens after
-some event X which is po-after S.  Symbolically, this amounts to:
+some event X which is po-after S.  Symbolically, this amounts to::
 
 	S ->po X ->hb* Z ->fr W ->rf Y ->po U.
 
 The fr link from Z to W indicates that W has not propagated to Z's CPU
 at the time that Z executes.  From this, it can be shown (see the
 discussion of the rcu-link relation earlier) that S and U are related
-by rcu-link:
+by rcu-link::
 
 	S ->rcu-link U.
 
 Since S is a grace period we have S ->rcu-gp S, and since L and U are
 the start and end of the critical section C we have U ->rcu-rscsi L.
-From this we obtain:
+From this we obtain::
 
 	S ->rcu-gp S ->rcu-link U ->rcu-rscsi L ->rcu-link S,
 
@@ -1651,7 +1660,7 @@ the Grace Period Guarantee.
 
 For something a little more down-to-earth, let's see how the axiom
 works out in practice.  Consider the RCU code example from above, this
-time with statement labels added:
+time with statement labels added::
 
 	int x, y;
 
@@ -1687,7 +1696,7 @@ Then U ->rcu-rscsi L ->rcu-link S ->rcu-gp S ->rcu-link U is a
 forbidden cycle, violating the "rcu" axiom.  Hence the outcome is not
 allowed by the LKMM, as we would expect.
 
-For contrast, let's see what can happen in a more complicated example:
+For contrast, let's see what can happen in a more complicated example::
 
 	int x, y, z;
 
@@ -1726,22 +1735,22 @@ L2 ->rcu-link U0.  However this cycle is not forbidden, because the
 sequence of relations contains fewer instances of rcu-gp (one) than of
 rcu-rscsi (two).  Consequently the outcome is allowed by the LKMM.
 The following instruction timing diagram shows how it might actually
-occur:
+occur::
 
-P0			P1			P2
---------------------	--------------------	--------------------
-rcu_read_lock()
-WRITE_ONCE(y, 1)
-			r1 = READ_ONCE(y)
-			synchronize_rcu() starts
-			.			rcu_read_lock()
-			.			WRITE_ONCE(x, 1)
-r0 = READ_ONCE(x)	.
-rcu_read_unlock()	.
-			synchronize_rcu() ends
-			WRITE_ONCE(z, 1)
-						r2 = READ_ONCE(z)
-						rcu_read_unlock()
+	P0			P1			P2
+	--------------------	--------------------	--------------------
+	rcu_read_lock()
+	WRITE_ONCE(y, 1)
+				r1 = READ_ONCE(y)
+				synchronize_rcu() starts
+				.			rcu_read_lock()
+				.			WRITE_ONCE(x, 1)
+	r0 = READ_ONCE(x)	.
+	rcu_read_unlock()	.
+				synchronize_rcu() ends
+				WRITE_ONCE(z, 1)
+							r2 = READ_ONCE(z)
+							rcu_read_unlock()
 
 This requires P0 and P2 to execute their loads and stores out of
 program order, but of course they are allowed to do so.  And as you
@@ -1767,26 +1776,26 @@ The LKMM includes locking.  In fact, there is special code for locking
 in the formal model, added in order to make tools run faster.
 However, this special code is intended to be more or less equivalent
 to concepts we have already covered.  A spinlock_t variable is treated
-the same as an int, and spin_lock(&s) is treated almost the same as:
+the same as an int, and spin_lock(&s) is treated almost the same as::
 
 	while (cmpxchg_acquire(&s, 0, 1) != 0)
 		cpu_relax();
 
 This waits until s is equal to 0 and then atomically sets it to 1,
 and the read part of the cmpxchg operation acts as an acquire fence.
-An alternate way to express the same thing would be:
+An alternate way to express the same thing would be::
 
 	r = xchg_acquire(&s, 1);
 
 along with a requirement that at the end, r = 0.  Similarly,
-spin_trylock(&s) is treated almost the same as:
+spin_trylock(&s) is treated almost the same as::
 
 	return !cmpxchg_acquire(&s, 0, 1);
 
 which atomically sets s to 1 if it is currently equal to 0 and returns
 true if it succeeds (the read part of the cmpxchg operation acts as an
 acquire fence only if the operation is successful).  spin_unlock(&s)
-is treated almost the same as:
+is treated almost the same as::
 
 	smp_store_release(&s, 0);
 
@@ -1802,7 +1811,7 @@ requires that every instruction po-before the lock-release must
 execute before any instruction po-after the lock-acquire.  This would
 naturally hold if the release and acquire operations were on different
 CPUs, but the LKMM says it holds even when they are on the same CPU.
-For example:
+For example::
 
 	int x, y;
 	spinlock_t s;
@@ -1833,7 +1842,7 @@ MP pattern).
 
 This requirement does not apply to ordinary release and acquire
 fences, only to lock-related operations.  For instance, suppose P0()
-in the example had been written as:
+in the example had been written as::
 
 	P0()
 	{
@@ -1847,7 +1856,7 @@ in the example had been written as:
 
 Then the CPU would be allowed to forward the s = 1 value from the
 smp_store_release() to the smp_load_acquire(), executing the
-instructions in the following order:
+instructions in the following order::
 
 		r3 = smp_load_acquire(&s);	// Obtains r3 = 1
 		r2 = READ_ONCE(y);
@@ -1859,7 +1868,7 @@ and thus it could load y before x, obtaining r2 = 0 and r1 = 1.
 Second, when a lock-acquire reads from a lock-release, and some other
 stores W and W' occur po-before the lock-release and po-after the
 lock-acquire respectively, the LKMM requires that W must propagate to
-each CPU before W' does.  For example, consider:
+each CPU before W' does.  For example, consider::
 
 	int x, y;
 	spinlock_t x;
@@ -1928,7 +1937,7 @@ smp_store_release().)  The final effect is the same.
 Although we didn't mention it above, the instruction execution
 ordering provided by the smp_rmb() fence doesn't apply to read events
 that are part of a non-value-returning atomic update.  For instance,
-given:
+given::
 
 	atomic_inc(&x);
 	smp_rmb();
@@ -1967,14 +1976,14 @@ they behave as follows:
 	events.
 
 Interestingly, RCU and locking each introduce the possibility of
-deadlock.  When faced with code sequences such as:
+deadlock.  When faced with code sequences such as::
 
 	spin_lock(&s);
 	spin_lock(&s);
 	spin_unlock(&s);
 	spin_unlock(&s);
 
-or:
+or::
 
 	rcu_read_lock();
 	synchronize_rcu();
@@ -1984,7 +1993,7 @@ what does the LKMM have to say?  Answer: It says there are no allowed
 executions at all, which makes sense.  But this can also lead to
 misleading results, because if a piece of code has multiple possible
 executions, some of which deadlock, the model will report only on the
-non-deadlocking executions.  For example:
+non-deadlocking executions.  For example::
 
 	int x, y;
 
diff --git a/tools/memory-model/Documentation/index.rst b/tools/memory-model/Documentation/index.rst
new file mode 100644
index 000000000000..0e53d83a5a48
--- /dev/null
+++ b/tools/memory-model/Documentation/index.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Linux Memory Model Tools
+========================
+
+.. toctree::
+   :maxdepth: 1
+
+   explanation
+   recipes
+   references
+   cheatsheet
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.rst
similarity index 96%
rename from tools/memory-model/Documentation/recipes.txt
rename to tools/memory-model/Documentation/recipes.rst
index 7fe8d7aa3029..0229a431b1a2 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.rst
@@ -1,3 +1,8 @@
+=======
+Recipes
+=======
+
+
 This document provides "recipes", that is, litmus tests for commonly
 occurring situations, as well as a few that illustrate subtly broken but
 attractive nuisances.  Many of these recipes include example code from
@@ -67,7 +72,7 @@ has acquired a given lock sees any changes previously seen or made by any
 CPU before it released that same lock.  Note that this statement is a bit
 stronger than "Any CPU holding a given lock sees all changes made by any
 CPU during the time that CPU was holding this same lock".  For example,
-consider the following pair of code fragments:
+consider the following pair of code fragments::
 
 	/* See MP+polocks.litmus. */
 	void CPU0(void)
@@ -93,7 +98,7 @@ value of r1 must also be equal to 1.  In contrast, the weaker rule would
 say nothing about the final value of r1.
 
 The converse to the basic rule also holds, as illustrated by the
-following litmus test:
+following litmus test::
 
 	/* See MP+porevlocks.litmus. */
 	void CPU0(void)
@@ -124,7 +129,7 @@ across multiple CPUs.
 
 However, it is not necessarily the case that accesses ordered by
 locking will be seen as ordered by CPUs not holding that lock.
-Consider this example:
+Consider this example::
 
 	/* See Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus. */
 	void CPU0(void)
@@ -157,7 +162,7 @@ CPU2() never acquired the lock, and thus did not benefit from the
 lock's ordering properties.
 
 Ordering can be extended to CPUs not holding the lock by careful use
-of smp_mb__after_spinlock():
+of smp_mb__after_spinlock()::
 
 	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
 	void CPU0(void)
@@ -214,7 +219,7 @@ Release and acquire
 ~~~~~~~~~~~~~~~~~~~
 
 Use of smp_store_release() and smp_load_acquire() is one way to force
-the desired MP ordering.  The general approach is shown below:
+the desired MP ordering.  The general approach is shown below::
 
 	/* See MP+pooncerelease+poacquireonce.litmus. */
 	void CPU0(void)
@@ -245,7 +250,7 @@ Assign and dereference
 Use of rcu_assign_pointer() and rcu_dereference() is quite similar to the
 use of smp_store_release() and smp_load_acquire(), except that both
 rcu_assign_pointer() and rcu_dereference() operate on RCU-protected
-pointers.  The general approach is shown below:
+pointers.  The general approach is shown below::
 
 	/* See MP+onceassign+derefonce.litmus. */
 	int z;
@@ -290,7 +295,7 @@ Write and read memory barriers
 It is usually better to use smp_store_release() instead of smp_wmb()
 and to use smp_load_acquire() instead of smp_rmb().  However, the older
 smp_wmb() and smp_rmb() APIs are still heavily used, so it is important
-to understand their use cases.  The general approach is shown below:
+to understand their use cases.  The general approach is shown below::
 
 	/* See MP+fencewmbonceonce+fencermbonceonce.litmus. */
 	void CPU0(void)
@@ -312,7 +317,7 @@ smp_rmb() macro orders prior loads against later loads.  Therefore, if
 the final value of r0 is 1, the final value of r1 must also be 1.
 
 The xlog_state_switch_iclogs() function in fs/xfs/xfs_log.c contains
-the following write-side code fragment:
+the following write-side code fragment::
 
 	log->l_curr_block -= log->l_logBBsize;
 	ASSERT(log->l_curr_block >= 0);
@@ -327,7 +332,7 @@ the corresponding read-side code fragment:
 	cur_block = READ_ONCE(log->l_curr_block);
 
 Alternatively, consider the following comment in function
-perf_output_put_handle() in kernel/events/ring_buffer.c:
+perf_output_put_handle() in kernel/events/ring_buffer.c::
 
 	 *   kernel				user
 	 *
@@ -358,7 +363,7 @@ absence of any ordering it is quite possible that this may happen, as
 can be seen in the LB+poonceonces.litmus litmus test.
 
 One way of avoiding the counter-intuitive outcome is through the use of a
-control dependency paired with a full memory barrier:
+control dependency paired with a full memory barrier::
 
 	/* See LB+fencembonceonce+ctrlonceonce.litmus. */
 	void CPU0(void)
@@ -382,7 +387,7 @@ The A/D pairing from the ring-buffer use case shown earlier also
 illustrates LB.  Here is a repeat of the comment in
 perf_output_put_handle() in kernel/events/ring_buffer.c, showing a
 control dependency on the kernel side and a full memory barrier on
-the user side:
+the user side::
 
 	 *   kernel				user
 	 *
@@ -407,7 +412,7 @@ Release-acquire chains
 
 Release-acquire chains are a low-overhead, flexible, and easy-to-use
 method of maintaining order.  However, they do have some limitations that
-need to be fully understood.  Here is an example that maintains order:
+need to be fully understood.  Here is an example that maintains order::
 
 	/* See ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus. */
 	void CPU0(void)
@@ -436,7 +441,7 @@ example, ordering would still be preserved if CPU1()'s smp_load_acquire()
 invocation was replaced with READ_ONCE().
 
 It is tempting to assume that CPU0()'s store to x is globally ordered
-before CPU1()'s store to z, but this is not the case:
+before CPU1()'s store to z, but this is not the case::
 
 	/* See Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus. */
 	void CPU0(void)
@@ -474,7 +479,7 @@ Store buffering
 Store buffering can be thought of as upside-down load buffering, so
 that one CPU first stores to one variable and then loads from a second,
 while another CPU stores to the second variable and then loads from the
-first.  Preserving order requires nothing less than full barriers:
+first.  Preserving order requires nothing less than full barriers::
 
 	/* See SB+fencembonceonces.litmus. */
 	void CPU0(void)
@@ -498,7 +503,7 @@ this counter-intuitive outcome.
 This pattern most famously appears as part of Dekker's locking
 algorithm, but it has a much more practical use within the Linux kernel
 of ordering wakeups.  The following comment taken from waitqueue_active()
-in include/linux/wait.h shows the canonical pattern:
+in include/linux/wait.h shows the canonical pattern::
 
  *      CPU0 - waker                    CPU1 - waiter
  *
@@ -550,16 +555,16 @@ The strength of memory ordering required for a given litmus test to
 avoid a counter-intuitive outcome depends on the types of relations
 linking the memory accesses for the outcome in question:
 
-o	If all links are write-to-read links, then the weakest
+-	If all links are write-to-read links, then the weakest
 	possible ordering within each CPU suffices.  For example, in
 	the LB litmus test, a control dependency was enough to do the
 	job.
 
-o	If all but one of the links are write-to-read links, then a
+-	If all but one of the links are write-to-read links, then a
 	release-acquire chain suffices.  Both the MP and the ISA2
 	litmus tests illustrate this case.
 
-o	If more than one of the links are something other than
+-	If more than one of the links are something other than
 	write-to-read links, then a full memory barrier is required
 	between each successive pair of non-write-to-read links.  This
 	case is illustrated by the Z6.0 litmus tests, both in the
diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory-model/Documentation/references.rst
similarity index 71%
rename from tools/memory-model/Documentation/references.txt
rename to tools/memory-model/Documentation/references.rst
index b177f3e4a614..275876cd10b8 100644
--- a/tools/memory-model/Documentation/references.txt
+++ b/tools/memory-model/Documentation/references.rst
@@ -1,3 +1,7 @@
+==========
+References
+==========
+
 This document provides background reading for memory models and related
 tools.  These documents are aimed at kernel hackers who are interested
 in memory models.
@@ -6,64 +10,64 @@ in memory models.
 Hardware manuals and models
 ===========================
 
-o	SPARC International Inc. (Ed.). 1994. "The SPARC Architecture
+-	SPARC International Inc. (Ed.). 1994. "The SPARC Architecture
 	Reference Manual Version 9". SPARC International Inc.
 
-o	Compaq Computer Corporation (Ed.). 2002. "Alpha Architecture
+-	Compaq Computer Corporation (Ed.). 2002. "Alpha Architecture
 	Reference Manual".  Compaq Computer Corporation.
 
-o	Intel Corporation (Ed.). 2002. "A Formal Specification of Intel
+-	Intel Corporation (Ed.). 2002. "A Formal Specification of Intel
 	Itanium Processor Family Memory Ordering". Intel Corporation.
 
-o	Intel Corporation (Ed.). 2002. "Intel 64 and IA-32 Architectures
+-	Intel Corporation (Ed.). 2002. "Intel 64 and IA-32 Architectures
 	Software Developer’s Manual". Intel Corporation.
 
-o	Peter Sewell, Susmit Sarkar, Scott Owens, Francesco Zappa Nardelli,
+-	Peter Sewell, Susmit Sarkar, Scott Owens, Francesco Zappa Nardelli,
 	and Magnus O. Myreen. 2010. "x86-TSO: A Rigorous and Usable
 	Programmer's Model for x86 Multiprocessors". Commun. ACM 53, 7
 	(July, 2010), 89-97. http://doi.acm.org/10.1145/1785414.1785443
 
-o	IBM Corporation (Ed.). 2009. "Power ISA Version 2.06". IBM
+-	IBM Corporation (Ed.). 2009. "Power ISA Version 2.06". IBM
 	Corporation.
 
-o	ARM Ltd. (Ed.). 2009. "ARM Barrier Litmus Tests and Cookbook".
+-	ARM Ltd. (Ed.). 2009. "ARM Barrier Litmus Tests and Cookbook".
 	ARM Ltd.
 
-o	Susmit Sarkar, Peter Sewell, Jade Alglave, Luc Maranget, and
+-	Susmit Sarkar, Peter Sewell, Jade Alglave, Luc Maranget, and
 	Derek Williams.  2011. "Understanding POWER Multiprocessors". In
 	Proceedings of the 32Nd ACM SIGPLAN Conference on Programming
 	Language Design and Implementation (PLDI ’11). ACM, New York,
 	NY, USA, 175–186.
 
-o	Susmit Sarkar, Kayvan Memarian, Scott Owens, Mark Batty,
+-	Susmit Sarkar, Kayvan Memarian, Scott Owens, Mark Batty,
 	Peter Sewell, Luc Maranget, Jade Alglave, and Derek Williams.
 	2012. "Synchronising C/C++ and POWER". In Proceedings of the 33rd
 	ACM SIGPLAN Conference on Programming Language Design and
 	Implementation (PLDI '12). ACM, New York, NY, USA, 311-322.
 
-o	ARM Ltd. (Ed.). 2014. "ARM Architecture Reference Manual (ARMv8,
+-	ARM Ltd. (Ed.). 2014. "ARM Architecture Reference Manual (ARMv8,
 	for ARMv8-A architecture profile)". ARM Ltd.
 
-o	Imagination Technologies, LTD. 2015. "MIPS(R) Architecture
+-	Imagination Technologies, LTD. 2015. "MIPS(R) Architecture
 	For Programmers, Volume II-A: The MIPS64(R) Instruction,
 	Set Reference Manual". Imagination Technologies,
 	LTD. https://imgtec.com/?do-download=4302.
 
-o	Shaked Flur, Kathryn E. Gray, Christopher Pulte, Susmit
+-	Shaked Flur, Kathryn E. Gray, Christopher Pulte, Susmit
 	Sarkar, Ali Sezgin, Luc Maranget, Will Deacon, and Peter
 	Sewell. 2016. "Modelling the ARMv8 Architecture, Operationally:
 	Concurrency and ISA". In Proceedings of the 43rd Annual ACM
 	SIGPLAN-SIGACT Symposium on Principles of Programming Languages
 	(POPL ’16). ACM, New York, NY, USA, 608–621.
 
-o	Shaked Flur, Susmit Sarkar, Christopher Pulte, Kyndylan Nienhuis,
+-	Shaked Flur, Susmit Sarkar, Christopher Pulte, Kyndylan Nienhuis,
 	Luc Maranget, Kathryn E. Gray, Ali Sezgin, Mark Batty, and Peter
 	Sewell. 2017. "Mixed-size Concurrency: ARM, POWER, C/C++11,
 	and SC". In Proceedings of the 44th ACM SIGPLAN Symposium on
 	Principles of Programming Languages (POPL 2017). ACM, New York,
 	NY, USA, 429–442.
 
-o	Christopher Pulte, Shaked Flur, Will Deacon, Jon French,
+-	Christopher Pulte, Shaked Flur, Will Deacon, Jon French,
 	Susmit Sarkar, and Peter Sewell. 2018. "Simplifying ARM concurrency:
 	multicopy-atomic axiomatic and operational models for ARMv8". In
 	Proceedings of the ACM on Programming Languages, Volume 2, Issue
@@ -73,18 +77,18 @@ o	Christopher Pulte, Shaked Flur, Will Deacon, Jon French,
 Linux-kernel memory model
 =========================
 
-o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
+-	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
 	Alan Stern.  2018. "Frightening small children and disconcerting
 	grown-ups: Concurrency in the Linux kernel". In Proceedings of
 	the 23rd International Conference on Architectural Support for
 	Programming Languages and Operating Systems (ASPLOS 2018). ACM,
 	New York, NY, USA, 405-418.  Webpage: http://diy.inria.fr/linux/.
 
-o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
+-	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
 	Alan Stern.  2017.  "A formal kernel memory-ordering model (part 1)"
 	Linux Weekly News.  https://lwn.net/Articles/718628/
 
-o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
+-	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
 	Alan Stern.  2017.  "A formal kernel memory-ordering model (part 2)"
 	Linux Weekly News.  https://lwn.net/Articles/720550/
 
@@ -92,16 +96,16 @@ o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
 Memory-model tooling
 ====================
 
-o	Daniel Jackson. 2002. "Alloy: A Lightweight Object Modelling
+-	Daniel Jackson. 2002. "Alloy: A Lightweight Object Modelling
 	Notation". ACM Trans. Softw. Eng. Methodol. 11, 2 (April 2002),
 	256–290. http://doi.acm.org/10.1145/505145.505149
 
-o	Jade Alglave, Luc Maranget, and Michael Tautschnig. 2014. "Herding
+-	Jade Alglave, Luc Maranget, and Michael Tautschnig. 2014. "Herding
 	Cats: Modelling, Simulation, Testing, and Data Mining for Weak
 	Memory". ACM Trans. Program. Lang. Syst. 36, 2, Article 7 (July
 	2014), 7:1–7:74 pages.
 
-o	Jade Alglave, Patrick Cousot, and Luc Maranget. 2016. "Syntax and
+-	Jade Alglave, Patrick Cousot, and Luc Maranget. 2016. "Syntax and
 	semantics of the weak consistency model specification language
 	cat". CoRR abs/1608.07531 (2016). http://arxiv.org/abs/1608.07531
 
@@ -109,6 +113,6 @@ o	Jade Alglave, Patrick Cousot, and Luc Maranget. 2016. "Syntax and
 Memory-model comparisons
 ========================
 
-o	Paul E. McKenney, Ulrich Weigand, Andrea Parri, and Boqun
+-	Paul E. McKenney, Ulrich Weigand, Andrea Parri, and Boqun
 	Feng. 2016. "Linux-Kernel Memory Model". (6 June 2016).
 	http://open-std.org/JTC1/SC22/WG21/docs/papers/2016/p0124r2.html.
diff --git a/tools/memory-model/README b/tools/memory-model/README
index 2b87f3971548..04bb1fa9ed76 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -105,16 +105,16 @@ for more information.
 DESCRIPTION OF FILES
 ====================
 
-Documentation/cheatsheet.txt
+Documentation/cheatsheet.rst
 	Quick-reference guide to the Linux-kernel memory model.
 
-Documentation/explanation.txt
+Documentation/explanation.rst
 	Describes the memory model in detail.
 
-Documentation/recipes.txt
+Documentation/recipes.rst
 	Lists common memory-ordering patterns.
 
-Documentation/references.txt
+Documentation/references.rst
 	Provides background reading.
 
 linux-kernel.bell
@@ -173,7 +173,7 @@ The Linux-kernel memory model has the following limitations:
 	of READ_ONCE() and WRITE_ONCE() limits the compiler's ability
 	to optimize, but there is Linux-kernel code that uses bare C
 	memory accesses.  Handling this code is on the to-do list.
-	For more information, see Documentation/explanation.txt (in
+	For more information, see Documentation/explanation.rst (in
 	particular, the "THE PROGRAM ORDER RELATION: po AND po-loc"
 	and "A WARNING" sections).
 
-- 
2.21.0

