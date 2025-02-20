Return-Path: <linux-arch+bounces-10250-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11838A3E076
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 17:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEB877A28BD
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A40211A0B;
	Thu, 20 Feb 2025 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlBavuS7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1853211292;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068046; cv=none; b=rd0irdzcPMmqJmXu0bPEWik3ewelOBARXI3j34mn/Ow0sS5CHA+5cyESh1BMH7g7svzqdSUHdfRMSAzeBEmB/DzL16bQQT1ukxY8qoNh3JKVxDspgnzpiBdVrG4XdVwcnXaudLEv+I1Cac+DdtapEqR912mhlSR7ECLYGZLsDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068046; c=relaxed/simple;
	bh=TsvXbj8pt31jepIWyXRjFgkBXvYwvZCcef75PEq5V2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hG9ZKzBAunYhW7AtJW/D5dHntEZ5TanB4XBpKpOmOTcunY3j2UDzH+PsjQ58ed+XjbF4kqAJVohynicaQJ7/81vQGDyVpLFUrBGkfrVXOXZBAMFu65L3hAe92L9zPAv4z0iSCBGuBtU2UNkC/Ls9WnWeUn61OrA9UAtPaqAMYl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlBavuS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7F8C4CEF4;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740068045;
	bh=TsvXbj8pt31jepIWyXRjFgkBXvYwvZCcef75PEq5V2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WlBavuS7Pm6ZbqBJFTktu4nmnnkmz+raAO0fuJW4NlW1+olnLq444kyKFyiOpLeVn
	 ask3aK6su4JZlVdgpDNGZg3DZBa0XuzGwB+v+xuSr1B57Ji5KwDQCWkvv/uDR9xEf4
	 tcRt1Lb1iX3fk6wRlW6Nb1n2rRRr115ZRoKeEyMxH3Yzd19oQUooY23cENPWJV7Qkl
	 xhkionvIAl2QO6NY/aZo3b116xEuG1Fi6uOwIqRbBGdYunZ3VmMwRaJ+ysNflJPKMQ
	 h6kC08r0C2rjoSR3uD7VtTLNT9PO9HTHLdc8LpReVfI8akMSDowrmKlmjR6V+jpbng
	 hFsFGzWuMpd+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ACFEFCE0D8A; Thu, 20 Feb 2025 08:14:04 -0800 (PST)
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
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 6/7] tools/memory-model: Switch to softcoded herd7 tags
Date: Thu, 20 Feb 2025 08:14:02 -0800
Message-Id: <20250220161403.800831-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8cfb51e3-9726-4285-b8ca-0d0abcacb07e@paulmck-laptop>
References: <8cfb51e3-9726-4285-b8ca-0d0abcacb07e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>

A new version of herd7 provides a -lkmmv2 switch which overrides the old herd7
behavior of simply ignoring any softcoded tags in the .def and .bell files. We
port LKMM to this version of herd7 by providing the switch in linux-kernel.cfg
and reporting an error if the LKMM is used without this switch.

To preserve the semantics of LKMM, we also softcode the Noreturn tag on atomic
RMW which do not return a value and define atomic_add_unless with an Mb tag in
linux-kernel.def.

We update the herd-representation.txt accordingly and clarify some of the
resulting combinations.

Signed-off-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
---
 .../Documentation/herd-representation.txt     | 27 ++++++++++---------
 tools/memory-model/README                     |  2 +-
 tools/memory-model/linux-kernel.bell          |  3 +++
 tools/memory-model/linux-kernel.cfg           |  1 +
 tools/memory-model/linux-kernel.def           | 18 +++++++------
 5 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/tools/memory-model/Documentation/herd-representation.txt b/tools/memory-model/Documentation/herd-representation.txt
index ed988906f2b71..7ae1ff3d3769e 100644
--- a/tools/memory-model/Documentation/herd-representation.txt
+++ b/tools/memory-model/Documentation/herd-representation.txt
@@ -18,6 +18,11 @@
 #
 # By convention, a blank line in a cell means "same as the preceding line".
 #
+# Note that the syntactic representation does not always match the sets and
+# relations in linux-kernel.cat, due to redefinitions in linux-kernel.bell and
+# lock.cat. For example, the po link between LKR and LKW is upgraded to an rmw
+# link, and W[acquire] are not included in the Acquire set.
+#
 # Disclaimer.  The table includes representations of "add" and "and" operations;
 # corresponding/identical representations of "sub", "inc", "dec" and "or", "xor",
 # "andnot" operations are omitted.
@@ -60,14 +65,13 @@
     ------------------------------------------------------------------------------
     |       RMW ops w/o return value |                                           |
     ------------------------------------------------------------------------------
-    |                     atomic_add | R*[noreturn] ->rmw W*[once]               |
+    |                     atomic_add | R*[noreturn] ->rmw W*[noreturn]           |
     |                     atomic_and |                                           |
     |                      spin_lock | LKR ->po LKW                              |
     ------------------------------------------------------------------------------
     |        RMW ops w/ return value |                                           |
     ------------------------------------------------------------------------------
-    |              atomic_add_return | F[mb] ->po R*[once]                       |
-    |                                |     ->rmw W*[once] ->po F[mb]             |
+    |              atomic_add_return | R*[mb] ->rmw W*[mb]                       |
     |               atomic_fetch_add |                                           |
     |               atomic_fetch_and |                                           |
     |                    atomic_xchg |                                           |
@@ -79,13 +83,13 @@
     |            atomic_xchg_relaxed |                                           |
     |                   xchg_relaxed |                                           |
     |    atomic_add_negative_relaxed |                                           |
-    |      atomic_add_return_acquire | R*[acquire] ->rmw W*[once]                |
+    |      atomic_add_return_acquire | R*[acquire] ->rmw W*[acquire]             |
     |       atomic_fetch_add_acquire |                                           |
     |       atomic_fetch_and_acquire |                                           |
     |            atomic_xchg_acquire |                                           |
     |                   xchg_acquire |                                           |
     |    atomic_add_negative_acquire |                                           |
-    |      atomic_add_return_release | R*[once] ->rmw W*[release]                |
+    |      atomic_add_return_release | R*[release] ->rmw W*[release]             |
     |       atomic_fetch_add_release |                                           |
     |       atomic_fetch_and_release |                                           |
     |            atomic_xchg_release |                                           |
@@ -94,17 +98,16 @@
     ------------------------------------------------------------------------------
     |            Conditional RMW ops |                                           |
     ------------------------------------------------------------------------------
-    |                 atomic_cmpxchg | On success: F[mb] ->po R*[once]           |
-    |                                |                 ->rmw W*[once] ->po F[mb] |
-    |                                | On failure: R*[once]                      |
+    |                 atomic_cmpxchg | On success: R*[mb] ->rmw W*[mb]           |
+    |                                | On failure: R*[mb]                        |
     |                        cmpxchg |                                           |
     |              atomic_add_unless |                                           |
     |         atomic_cmpxchg_relaxed | On success: R*[once] ->rmw W*[once]       |
     |                                | On failure: R*[once]                      |
-    |         atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[once]    |
-    |                                | On failure: R*[once]                      |
-    |         atomic_cmpxchg_release | On success: R*[once] ->rmw W*[release]    |
-    |                                | On failure: R*[once]                      |
+    |         atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[acquire] |
+    |                                | On failure: R*[acquire]                   |
+    |         atomic_cmpxchg_release | On success: R*[release] ->rmw W*[release] |
+    |                                | On failure: R*[release]                   |
     |                   spin_trylock | On success: LKR ->po LKW                  |
     |                                | On failure: LF                            |
     ------------------------------------------------------------------------------
diff --git a/tools/memory-model/README b/tools/memory-model/README
index dab38904206a0..59bc15edeb8ab 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -20,7 +20,7 @@ that litmus test to be exercised within the Linux kernel.
 REQUIREMENTS
 ============
 
-Version 7.52 or higher of the "herd7" and "klitmus7" tools must be
+Version 7.58 or higher of the "herd7" and "klitmus7" tools must be
 downloaded separately:
 
   https://github.com/herd/herdtools7
diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 7c9ae48b94377..8ae47545df978 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -94,3 +94,6 @@ let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*
 let addr = carry-dep ; addr
 let ctrl = carry-dep ; ctrl
 let data = carry-dep ; data
+
+flag ~empty (if "lkmmv2" then 0 else _)
+  as this-model-requires-variant-higher-than-lkmmv1
diff --git a/tools/memory-model/linux-kernel.cfg b/tools/memory-model/linux-kernel.cfg
index 3c8098e99f41d..69b04f3aad737 100644
--- a/tools/memory-model/linux-kernel.cfg
+++ b/tools/memory-model/linux-kernel.cfg
@@ -1,6 +1,7 @@
 macros linux-kernel.def
 bell linux-kernel.bell
 model linux-kernel.cat
+variant lkmmv2
 graph columns
 squished true
 showevents noregs
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index a12b96c547b7a..d7279a357cba0 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -63,14 +63,14 @@ atomic_set(X,V) { WRITE_ONCE(*X,V); }
 atomic_read_acquire(X) smp_load_acquire(X)
 atomic_set_release(X,V) { smp_store_release(X,V); }
 
-atomic_add(V,X) { __atomic_op(X,+,V); }
-atomic_sub(V,X) { __atomic_op(X,-,V); }
-atomic_and(V,X) { __atomic_op(X,&,V); }
-atomic_or(V,X)  { __atomic_op(X,|,V); }
-atomic_xor(V,X) { __atomic_op(X,^,V); }
-atomic_inc(X)   { __atomic_op(X,+,1); }
-atomic_dec(X)   { __atomic_op(X,-,1); }
-atomic_andnot(V,X) { __atomic_op(X,&~,V); }
+atomic_add(V,X) { __atomic_op{noreturn}(X,+,V); }
+atomic_sub(V,X) { __atomic_op{noreturn}(X,-,V); }
+atomic_and(V,X) { __atomic_op{noreturn}(X,&,V); }
+atomic_or(V,X)  { __atomic_op{noreturn}(X,|,V); }
+atomic_xor(V,X) { __atomic_op{noreturn}(X,^,V); }
+atomic_inc(X)   { __atomic_op{noreturn}(X,+,1); }
+atomic_dec(X)   { __atomic_op{noreturn}(X,-,1); }
+atomic_andnot(V,X) { __atomic_op{noreturn}(X,&~,V); }
 
 atomic_add_return(V,X) __atomic_op_return{mb}(X,+,V)
 atomic_add_return_relaxed(V,X) __atomic_op_return{once}(X,+,V)
@@ -144,3 +144,5 @@ atomic_fetch_andnot(V,X) __atomic_fetch_op{mb}(X,&~,V)
 atomic_fetch_andnot_acquire(V,X) __atomic_fetch_op{acquire}(X,&~,V)
 atomic_fetch_andnot_release(V,X) __atomic_fetch_op{release}(X,&~,V)
 atomic_fetch_andnot_relaxed(V,X) __atomic_fetch_op{once}(X,&~,V)
+
+atomic_add_unless(X,V,W) __atomic_add_unless{mb}(X,V,W)
-- 
2.40.1


