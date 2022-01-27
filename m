Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04C649ED39
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jan 2022 22:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344220AbiA0VLw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jan 2022 16:11:52 -0500
Received: from netrider.rowland.org ([192.131.102.5]:40407 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1344170AbiA0VLu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jan 2022 16:11:50 -0500
Received: (qmail 185924 invoked by uid 1000); 27 Jan 2022 16:11:48 -0500
Date:   Thu, 27 Jan 2022 16:11:48 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>
Subject: [PATCH] tools/memory-model: Explain syntactic and semantic
 dependencies
Message-ID: <YfMKlLInsK0Qr77f@rowland.harvard.edu>
References: <20220125172819.3087760-1-paul.heidekrueger@in.tum.de>
 <YfBk265vVo4FL4MJ@rowland.harvard.edu>
 <YfJ7Rr9Kdk4u78lt@Pauls-MacBook-Pro.local>
 <YfLQmgsXp6pg0XIy@rowland.harvard.edu>
 <YfMFQ5IZiGBRw7SH@Pauls-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfMFQ5IZiGBRw7SH@Pauls-MacBook-Pro.local>
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


[as1970]


 tools/memory-model/Documentation/explanation.txt |   47 +++++++++++++++++++++++
 1 file changed, 47 insertions(+)

Index: usb-devel/tools/memory-model/Documentation/explanation.txt
===================================================================
--- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
+++ usb-devel/tools/memory-model/Documentation/explanation.txt
@@ -485,6 +485,53 @@ have R ->po X.  It wouldn't make sense f
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
+There appears to be a data dependency from the load of x to the store of
+y, since the value to be stored is computed from the value that was
+loaded.  But in fact, the value stored does not really depend on
+anything since it will always be 0.  Thus the data dependency is only
+syntactic (it appears to exist in the code) but not semantic (the second
+access will always be the same, regardless of the value of the first
+access).  Given code like this, a compiler could simply eliminate the
+load from x, which would certainly destroy any dependency.
+
+(It's natural to object that no one in their right mind would write code
+like the above.  However, macro expansions can easily give rise to this
+sort of thing, in ways that generally are not apparent to the
+programmer.)
+
+Another mechanism that can give rise to purely syntactic dependencies is
+related to the notion of "undefined behavior".  Certain program behaviors
+are called "undefined" in the C language specification, which means that
+when they occur there are no guarantees at all about the outcome.
+Consider the following example:
+
+	int a[1];
+	int i;
+
+	r1 = READ_ONCE(i);
+	r2 = READ_ONCE(a[r1]);
+
+Access beyond the end or before the beginning of an array is one kind of
+undefined behavior.  Therefore the compiler doesn't have to worry about
+what will happen if r1 is nonzero, and it can assume that r1 will always
+be zero without actually loading anything from i.  (If the assumption
+turns out to be wrong, the resulting behavior will be undefined anyway
+so the compiler doesn't care!)  Thus the load from i can be eliminated,
+breaking the address dependency.
+
+The LKMM is unaware that purely syntactic dependencies are different
+from semantic dependencies and therefore mistakenly predicts that the
+accesses in the two examples above will be ordered.  This is another
+example of how the compiler can undermine the memory model.  Be warned.
+
 
 THE READS-FROM RELATION: rf, rfi, and rfe
 -----------------------------------------
