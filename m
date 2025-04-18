Return-Path: <linux-arch+bounces-11455-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC6AA93BF2
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 19:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D9FA7AFF6D
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E9C21B9CD;
	Fri, 18 Apr 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foD5UtHq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6EA21B180;
	Fri, 18 Apr 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744997403; cv=none; b=lR4dY2duVzBvRMx5V9gpN6C7ksTbZW8IjVOK3mmTTGoDy2OeGaGKtUJlsfxS78IP0Kc9BzS9DQQSQG2mnAh1f5znx4kmU1V1pzdwY5+7zTgJYwZZL0SFa1namKxm0jJJeyxhC9a1p3zZAmvA8ucjoL9Yu3WUlen2tCUqERmqjM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744997403; c=relaxed/simple;
	bh=bIGvjbRKpxLkpSw3c++ottiUztM75QDoZdCAB6uB9i8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DUuxELmt5bYgS1ttefd74T8SklUTBMeLC0ZUbGI0yrpZ0wC2oa3PIGDK0nwqi2XHfshH//z01UTtr9CR0nVNc/ePw5iG7TNvLRHxgdPoofPb7S6iysC+Vu0MahTxh/J2tphrT0aHwfZ6q2LDzGSRdXyI2eyE54p3idKD6qh3C3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foD5UtHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F03C4CEEC;
	Fri, 18 Apr 2025 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744997403;
	bh=bIGvjbRKpxLkpSw3c++ottiUztM75QDoZdCAB6uB9i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=foD5UtHqiV5A2pVbJk5KS7xtU/2/x8DE7A9FMhmVD2r8G2TPBvXCb2Ex7JZr6dSH6
	 Evq6FXmN3J2lXzEPiP1suWDKqCIXoR2XX2XQYwUTw4WxbOrAQ4QfHppYFqM0g3xBn/
	 TLESZChSKlHLhZEeY8/SqNn+p67ZzxWLcIa+7pqmzGjtmcnmKNohZ9N94tRzGNfW2E
	 R9tTq34EmiL1pwPiE1GoMjwYTpAUkT8rI4PfAOMCOj2PUrhPrAhhaso8rlkrwMZkZX
	 LA+CxkrFPjDPt2SliHtO0p6CXMRcLrERPMCcb9zUWEePJVXfkWn3Ni4tiQEXU0Dd+n
	 MvXJiEAlvKrVA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7FA13CE0A6C; Fri, 18 Apr 2025 10:30:02 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	kernel-team@meta.com,
	mingo@kernel.org
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/4] tools/memory-model: docs/ordering: Fix trivial typos
Date: Fri, 18 Apr 2025 10:29:59 -0700
Message-Id: <20250418173000.1188561-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cd7fb2c4-1895-455c-84f8-8ed7252b93ff@paulmck-laptop>
References: <cd7fb2c4-1895-455c-84f8-8ed7252b93ff@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Akira Yokosawa <akiyks@gmail.com>

Fix trivial typos including:

  - Repeated "a call to"
  - Inconsistent forms of referencing functions of rcu_dereference()
    and rcu_assign_pointer()
  - Past tense used in describing normal behavior

and other minor ones.

[ paulmck: Wordsmith plus recent LWN RCU API URL. ]

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/ordering.txt | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/memory-model/Documentation/ordering.txt b/tools/memory-model/Documentation/ordering.txt
index 9b0949d3f5ec2..7ab3744929d87 100644
--- a/tools/memory-model/Documentation/ordering.txt
+++ b/tools/memory-model/Documentation/ordering.txt
@@ -223,7 +223,7 @@ The Linux kernel's compiler barrier is barrier().  This primitive
 prohibits compiler code-motion optimizations that might move memory
 references across the point in the code containing the barrier(), but
 does not constrain hardware memory ordering.  For example, this can be
-used to prevent to compiler from moving code across an infinite loop:
+used to prevent the compiler from moving code across an infinite loop:
 
 	WRITE_ONCE(x, 1);
 	while (dontstop)
@@ -274,7 +274,7 @@ different pieces of the concurrent algorithm.  The variable stored to
 by the smp_store_release(), in this case "y", will normally be used in
 an acquire operation in other parts of the concurrent algorithm.
 
-To see the performance advantages, suppose that the above example read
+To see the performance advantages, suppose that the above example reads
 from "x" instead of writing to it.  Then an smp_wmb() could not guarantee
 ordering, and an smp_mb() would be needed instead:
 
@@ -394,17 +394,17 @@ from the value returned by the rcu_dereference() or srcu_dereference()
 to that subsequent memory access.
 
 A call to rcu_dereference() for a given RCU-protected pointer is
-usually paired with a call to a call to rcu_assign_pointer() for that
-same pointer in much the same way that a call to smp_load_acquire() is
-paired with a call to smp_store_release().  Calls to rcu_dereference()
-and rcu_assign_pointer are often buried in other APIs, for example,
+usually paired with a call to rcu_assign_pointer() for that same pointer
+in much the same way that a call to smp_load_acquire() is paired with
+a call to smp_store_release().  Calls to rcu_dereference() and
+rcu_assign_pointer() are often buried in other APIs, for example,
 the RCU list API members defined in include/linux/rculist.h.  For more
 information, please see the docbook headers in that file, the most
-recent LWN article on the RCU API (https://lwn.net/Articles/777036/),
+recent LWN article on the RCU API (https://lwn.net/Articles/988638/),
 and of course the material in Documentation/RCU.
 
 If the pointer value is manipulated between the rcu_dereference()
-that returned it and a later dereference(), please read
+that returned it and a later rcu_dereference(), please read
 Documentation/RCU/rcu_dereference.rst.  It can also be quite helpful to
 review uses in the Linux kernel.
 
@@ -457,7 +457,7 @@ described earlier in this document.
 These operations come in three categories:
 
 o	Marked writes, such as WRITE_ONCE() and atomic_set().  These
-	primitives required the compiler to emit the corresponding store
+	primitives require the compiler to emit the corresponding store
 	instructions in the expected execution order, thus suppressing
 	a number of destructive optimizations.	However, they provide no
 	hardware ordering guarantees, and in fact many CPUs will happily
@@ -465,7 +465,7 @@ o	Marked writes, such as WRITE_ONCE() and atomic_set().  These
 	operations, unless these operations are to the same variable.
 
 o	Marked reads, such as READ_ONCE() and atomic_read().  These
-	primitives required the compiler to emit the corresponding load
+	primitives require the compiler to emit the corresponding load
 	instructions in the expected execution order, thus suppressing
 	a number of destructive optimizations.	However, they provide no
 	hardware ordering guarantees, and in fact many CPUs will happily
@@ -506,7 +506,7 @@ of the old value and the new value.
 
 Unmarked C-language accesses are unordered, and are also subject to
 any number of compiler optimizations, many of which can break your
-concurrent code.  It is possible to used unmarked C-language accesses for
+concurrent code.  It is possible to use unmarked C-language accesses for
 shared variables that are subject to concurrent access, but great care
 is required on an ongoing basis.  The compiler-constraining barrier()
 primitive can be helpful, as can the various ordering primitives discussed
-- 
2.40.1


