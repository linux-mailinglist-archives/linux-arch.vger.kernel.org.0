Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58ED28DAB9
	for <lists+linux-arch@lfdr.de>; Wed, 14 Oct 2020 09:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgJNH4M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 03:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgJNH4M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Oct 2020 03:56:12 -0400
Received: from coco.lan (ip5f5ad5dc.dynamic.kabel-deutschland.de [95.90.213.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F4072222A;
        Wed, 14 Oct 2020 07:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602662170;
        bh=54xdnNzCIbZVeo8uxGRflH+LIH/mn4SRDcVW6H6rs8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RkzdEdmgopn/v1H4MjXYaHoxAoI9dBDQZomJlXHjFTeQu7pHlO9LefQG/YjP6bF1P
         eCJh9nyX8JWvlPoPiKwcvANi7iOuqADIr0WL1q1uFWls/Tkbz1T37A9LbevIX6yt+U
         66JESt5eoc+a2vi6C05FB0uxFdauKFGaLdgmb3+o=
Date:   Wed, 14 Oct 2020 09:56:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/24] tools: docs: memory-model: fix references for
 some files
Message-ID: <20201014095603.0d899da7@coco.lan>
In-Reply-To: <20201014015840.GR3249@paulmck-ThinkPad-P72>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
        <44baab3643aeefdb68f1682d89672fad44aa2c67.1602590106.git.mchehab+huawei@kernel.org>
        <20201013163354.GO3249@paulmck-ThinkPad-P72>
        <20201013163836.GC670875@rowland.harvard.edu>
        <20201014015840.GR3249@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Em Tue, 13 Oct 2020 18:58:40 -0700
"Paul E. McKenney" <paulmck@kernel.org> escreveu:

> On Tue, Oct 13, 2020 at 12:38:36PM -0400, Alan Stern wrote:
> > On Tue, Oct 13, 2020 at 09:33:54AM -0700, Paul E. McKenney wrote:  
> > > On Tue, Oct 13, 2020 at 02:14:29PM +0200, Mauro Carvalho Chehab wrote:  
> > > > - The sysfs.txt file was converted to ReST and renamed;
> > > > - The control-dependencies.txt is not at
> > > >   Documentation/control-dependencies.txt. As it is at the
> > > >   same dir as the README file, which mentions it, just
> > > >   remove Documentation/.
> > > > 
> > > > With that, ./scripts/documentation-file-ref-check script
> > > > is now happy again for files under tools/.
> > > > 
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> > > 
> > > Queued for review and testing, likely target v5.11.  
> > 
> > Instead of changing the path in the README reference, shouldn't 
> > tools/memory-model/control-dependencies.txt be moved to its proper 
> > position in .../Documentation?  
> 
> You are of course quite right.  My thought is to let Mauro go ahead,
> given his short deadline.  We can then make this "git mv" change once
> v5.10-rc1 comes out, given that it should have Mauro's patches.  I have
> added a reminder to my calendar.

Sounds like a plan to me.


If it helps on 5.11 plans, converting this file to ReST format is quite
trivial: it just needs to use "::" for C/asm code literal blocks, and 
to replace "(*) " by something that matches ReST syntax for lists,
like "(#) " or just "* ":

	https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#bullet-lists

See enclosed.

Thanks,
Mauro

[PATCH] convert control-dependencies.rst to ReST

- Mark literal blocks as such;
- Use a numbered list at the summary.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/tools/memory-model/Documentation/control-dependencies.rst b/tools/memory-model/Documentation/control-dependencies.rst
index 366520cac937..52dc6a5bc173 100644
--- a/tools/memory-model/Documentation/control-dependencies.rst
+++ b/tools/memory-model/Documentation/control-dependencies.rst
@@ -7,7 +7,7 @@ the compiler's ignorance from breaking your code.
 
 A load-load control dependency requires a full read memory barrier, not
 simply a data dependency barrier to make it work correctly.  Consider the
-following bit of code:
+following bit of code::
 
 	q = READ_ONCE(a);
 	if (q) {
@@ -19,7 +19,7 @@ This will not have the desired effect because there is no actual data
 dependency, but rather a control dependency that the CPU may short-circuit
 by attempting to predict the outcome in advance, so that other CPUs see
 the load from b as having happened before the load from a.  In such a
-case what's actually required is:
+case what's actually required is::
 
 	q = READ_ONCE(a);
 	if (q) {
@@ -28,7 +28,7 @@ case what's actually required is:
 	}
 
 However, stores are not speculated.  This means that ordering -is- provided
-for load-store control dependencies, as in the following example:
+for load-store control dependencies, as in the following example::
 
 	q = READ_ONCE(a);
 	if (q) {
@@ -45,7 +45,7 @@ or, worse yet, convert the store into a check followed by a store.
 Worse yet, if the compiler is able to prove (say) that the value of
 variable "a" is always non-zero, it would be well within its rights
 to optimize the original example by eliminating the "if" statement
-as follows:
+as follows::
 
 	q = a;
 	b = 1;  /* BUG: Compiler and CPU can both reorder!!! */
@@ -53,7 +53,7 @@ as follows:
 So don't leave out either the READ_ONCE() or the WRITE_ONCE().
 
 It is tempting to try to enforce ordering on identical stores on both
-branches of the "if" statement as follows:
+branches of the "if" statement as follows::
 
 	q = READ_ONCE(a);
 	if (q) {
@@ -67,7 +67,7 @@ branches of the "if" statement as follows:
 	}
 
 Unfortunately, current compilers will transform this as follows at high
-optimization levels:
+optimization levels::
 
 	q = READ_ONCE(a);
 	barrier();
@@ -85,7 +85,7 @@ Now there is no conditional between the load from "a" and the store to
 The conditional is absolutely required, and must be present in the
 assembly code even after all compiler optimizations have been applied.
 Therefore, if you need ordering in this example, you need explicit
-memory barriers, for example, smp_store_release():
+memory barriers, for example, smp_store_release()::
 
 	q = READ_ONCE(a);
 	if (q) {
@@ -97,7 +97,7 @@ memory barriers, for example, smp_store_release():
 	}
 
 In contrast, without explicit memory barriers, two-legged-if control
-ordering is guaranteed only when the stores differ, for example:
+ordering is guaranteed only when the stores differ, for example::
 
 	q = READ_ONCE(a);
 	if (q) {
@@ -113,7 +113,7 @@ proving the value of "a".
 
 In addition, you need to be careful what you do with the local variable "q",
 otherwise the compiler might be able to guess the value and again remove
-the needed conditional.  For example:
+the needed conditional.  For example::
 
 	q = READ_ONCE(a);
 	if (q % MAX) {
@@ -126,7 +126,7 @@ the needed conditional.  For example:
 
 If MAX is defined to be 1, then the compiler knows that (q % MAX) is
 equal to zero, in which case the compiler is within its rights to
-transform the above code into the following:
+transform the above code into the following::
 
 	q = READ_ONCE(a);
 	WRITE_ONCE(b, 2);
@@ -137,7 +137,7 @@ between the load from variable "a" and the store to variable "b".  It is
 tempting to add a barrier(), but this does not help.  The conditional
 is gone, and the barrier won't bring it back.  Therefore, if you are
 relying on this ordering, you should make sure that MAX is greater than
-one, perhaps as follows:
+one, perhaps as follows::
 
 	q = READ_ONCE(a);
 	BUILD_BUG_ON(MAX <= 1); /* Order load from a with store to b. */
@@ -154,7 +154,7 @@ identical, as noted earlier, the compiler could pull this store outside
 of the 'if' statement.
 
 You must also be careful not to rely too much on boolean short-circuit
-evaluation.  Consider this example:
+evaluation.  Consider this example::
 
 	q = READ_ONCE(a);
 	if (q || 1 > 0)
@@ -162,7 +162,7 @@ evaluation.  Consider this example:
 
 Because the first condition cannot fault and the second condition is
 always true, the compiler can transform this example as following,
-defeating control dependency:
+defeating control dependency::
 
 	q = READ_ONCE(a);
 	WRITE_ONCE(b, 1);
@@ -174,7 +174,7 @@ the compiler to use the results.
 
 In addition, control dependencies apply only to the then-clause and
 else-clause of the if-statement in question.  In particular, it does
-not necessarily apply to code following the if-statement:
+not necessarily apply to code following the if-statement::
 
 	q = READ_ONCE(a);
 	if (q) {
@@ -189,7 +189,7 @@ compiler cannot reorder volatile accesses and also cannot reorder
 the writes to "b" with the condition.  Unfortunately for this line
 of reasoning, the compiler might compile the two writes to "b" as
 conditional-move instructions, as in this fanciful pseudo-assembly
-language:
+language::
 
 	ld r1,a
 	cmp r1,$0
@@ -213,14 +213,14 @@ for more information.
 
 In summary:
 
-  (*) Control dependencies can order prior loads against later stores.
+  (#) Control dependencies can order prior loads against later stores.
       However, they do -not- guarantee any other sort of ordering:
       Not prior loads against later loads, nor prior stores against
       later anything.  If you need these other forms of ordering,
       use smp_rmb(), smp_wmb(), or, in the case of prior stores and
       later loads, smp_mb().
 
-  (*) If both legs of the "if" statement begin with identical stores to
+  (#) If both legs of the "if" statement begin with identical stores to
       the same variable, then those stores must be ordered, either by
       preceding both of them with smp_mb() or by using smp_store_release()
       to carry out the stores.  Please note that it is -not- sufficient
@@ -229,28 +229,28 @@ In summary:
       destroy the control dependency while respecting the letter of the
       barrier() law.
 
-  (*) Control dependencies require at least one run-time conditional
+  (#) Control dependencies require at least one run-time conditional
       between the prior load and the subsequent store, and this
       conditional must involve the prior load.  If the compiler is able
       to optimize the conditional away, it will have also optimized
       away the ordering.  Careful use of READ_ONCE() and WRITE_ONCE()
       can help to preserve the needed conditional.
 
-  (*) Control dependencies require that the compiler avoid reordering the
+  (#) Control dependencies require that the compiler avoid reordering the
       dependency into nonexistence.  Careful use of READ_ONCE() or
       atomic{,64}_read() can help to preserve your control dependency.
       Please see the COMPILER BARRIER section for more information.
 
-  (*) Control dependencies apply only to the then-clause and else-clause
+  (#) Control dependencies apply only to the then-clause and else-clause
       of the if-statement containing the control dependency, including
       any functions that these two clauses call.  Control dependencies
       do -not- apply to code following the if-statement containing the
       control dependency.
 
-  (*) Control dependencies pair normally with other types of barriers.
+  (#) Control dependencies pair normally with other types of barriers.
 
-  (*) Control dependencies do -not- provide multicopy atomicity.  If you
+  (#) Control dependencies do -not- provide multicopy atomicity.  If you
       need all the CPUs to see a given store at the same time, use smp_mb().
 
-  (*) Compilers do not understand control dependencies.  It is therefore
+  (#) Compilers do not understand control dependencies.  It is therefore
       your job to ensure that they do not break your code.

