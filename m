Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358714A6466
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 20:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiBATAJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 14:00:09 -0500
Received: from netrider.rowland.org ([192.131.102.5]:55523 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S242175AbiBATAJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 14:00:09 -0500
Received: (qmail 316474 invoked by uid 1000); 1 Feb 2022 14:00:08 -0500
Date:   Tue, 1 Feb 2022 14:00:08 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>
Subject: [PATCH v2] tools/memory-model: Explain syntactic and semantic
 dependencies
Message-ID: <YfmDOF2/2n0eMu+Y@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfMKlLInsK0Qr77f@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Paul Heidekrüger pointed out that the Linux Kernel Memory Model
documentation doesn't mention the distinction between syntactic and
semantic dependencies.  This is an important difference, because the
compiler can easily break dependencies that are only syntactic, not
semantic.

This patch adds a few paragraphs to the LKMM documentation explaining
these issues and illustrating how they can matter.

Suggested-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

v2:	Incorporate changes suggested by Paul McKenney, along with a few
	other minor edits.
 

[as1970b]


 tools/memory-model/Documentation/explanation.txt |   51 +++++++++++++++++++++++
 1 file changed, 51 insertions(+)

Index: usb-devel/tools/memory-model/Documentation/explanation.txt
===================================================================
--- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
+++ usb-devel/tools/memory-model/Documentation/explanation.txt
@@ -485,6 +485,57 @@ have R ->po X.  It wouldn't make sense f
 somehow on a value that doesn't get loaded from shared memory until
 later in the code!
 
+Here's a trick question: When is a dependency not a dependency?  Answer:
+When it is purely syntactic rather than semantic.  We say a dependency
+between two accesses is purely syntactic if the second access doesn't
+actually depend on the result of the first.  Here is a trivial example:
+
+	r1 = READ_ONCE(x);
+	WRITE_ONCE(y, r1 * 0);
+
+There appears to be a data dependency from the load of x to the store
+of y, since the value to be stored is computed from the value that was
+loaded.  But in fact, the value stored does not really depend on
+anything since it will always be 0.  Thus the data dependency is only
+syntactic (it appears to exist in the code) but not semantic (the
+second access will always be the same, regardless of the value of the
+first access).  Given code like this, a compiler could simply discard
+the value returned by the load from x, which would certainly destroy
+any dependency.  (The compiler is not permitted to eliminate entirely
+the load generated for a READ_ONCE() -- that's one of the nice
+properties of READ_ONCE() -- but it is allowed to ignore the load's
+value.)
+
+It's natural to object that no one in their right mind would write
+code like the above.  However, macro expansions can easily give rise
+to this sort of thing, in ways that often are not apparent to the
+programmer.
+
+Another mechanism that can lead to purely syntactic dependencies is
+related to the notion of "undefined behavior".  Certain program
+behaviors are called "undefined" in the C language specification,
+which means that when they occur there are no guarantees at all about
+the outcome.  Consider the following example:
+
+	int a[1];
+	int i;
+
+	r1 = READ_ONCE(i);
+	r2 = READ_ONCE(a[r1]);
+
+Access beyond the end or before the beginning of an array is one kind
+of undefined behavior.  Therefore the compiler doesn't have to worry
+about what will happen if r1 is nonzero, and it can assume that r1
+will always be zero regardless of the value actually loaded from i.
+(If the assumption turns out to be wrong the resulting behavior will
+be undefined anyway, so the compiler doesn't care!)  Thus the value
+from the load can be discarded, breaking the address dependency.
+
+The LKMM is unaware that purely syntactic dependencies are different
+from semantic dependencies and therefore mistakenly predicts that the
+accesses in the two examples above will be ordered.  This is another
+example of how the compiler can undermine the memory model.  Be warned.
+
 
 THE READS-FROM RELATION: rf, rfi, and rfe
 -----------------------------------------
