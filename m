Return-Path: <linux-arch+bounces-3448-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1766898EF8
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 21:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096E428FBE9
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6D3135A63;
	Thu,  4 Apr 2024 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iK0hUQTw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0B6135A55;
	Thu,  4 Apr 2024 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258812; cv=none; b=E49Xkp+tbPi0dcRz0loCVeDATPJ0nUgEKU3BkkwbvXx8HQVMn2Fs9wF446LYm0luFJ3S+aa2/vZNq91WSo/qDb6ITsUg3DhA0osjsXYR1dseN4heBPMKkX3pCP+32ImCKm+PQFaw9NHbpsKUBI+vfRB0Uw4cgaywZo1GqG5iU1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258812; c=relaxed/simple;
	bh=0guQJ43kZOeFK9RaRxxK/HF/2Akt543i2YM1yup2VqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dI3gXCeXLT3u9Zop3jV4rmRxep6hDuI9dOdWWTzPyq8IqVsgBOOzM3ij09asChpTvK+5A+dlqA2/TUBJ46CZho9aYYRhCB0tgIKQwAwVv4Oxdb0nI8LdIYgFXVIV8aSCSnVXhMHFjryam5nqJIZu8Xcf5o7qGKSA7FOwP6tLLfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iK0hUQTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8C7C43399;
	Thu,  4 Apr 2024 19:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712258811;
	bh=0guQJ43kZOeFK9RaRxxK/HF/2Akt543i2YM1yup2VqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iK0hUQTwRSYy33JiDwuEUeSQBqdgS5YZ1GNoaKUX2jKwdjibAtwKzF3/ScOLNEKsB
	 waNLctbwNPfTnLkOS5FUPocf2RHHfPLzDmzzNAmCHqYyqvH8Ly1BQJhoV8xT8p2pFF
	 cmMVgYIsfD6E9oacNfMRrnZO9kBb9d3VE8pHNLLUVz5zBkatO4s7sUhCG7NiVrM/iv
	 o8SfU/eb5jl+bkR5F6d2KdssDw4GMyeXOcs+7IYBJpSayNfq1UjAG264wNoO9WFu3x
	 +8gqb49hGbAmM2+bwxHSi2yVzi2mCQdIA+so3BH2mkMFue/fHDL/W++rhaa1/ADMhL
	 pMMyMfalYxPuw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 90EDECE0D0C; Thu,  4 Apr 2024 12:26:51 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
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
	"Paul E. McKenney" <paulmck@kernel.org>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH memory-model 1/3] Documentation/litmus-tests: Add locking tests to README
Date: Thu,  4 Apr 2024 12:26:47 -0700
Message-Id: <20240404192649.531112-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8550daf1-4bfd-4607-8325-bfb7c1e2d8c7@paulmck-laptop>
References: <8550daf1-4bfd-4607-8325-bfb7c1e2d8c7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit documents the litmus tests in the "locking" directory.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: <linux-arch@vger.kernel.org>
Cc: <linux-doc@vger.kernel.org>
---
 Documentation/litmus-tests/README | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 658d37860d397..5c8915e6fb684 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -22,6 +22,35 @@ Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
     NOTE: Require herd7 7.56 or later which supports "(void)expr".
 
 
+locking (/locking directory)
+----------------------------
+
+DCL-broken.litmus
+	Demonstrates that double-checked locking needs more than just
+	the obvious lock acquisitions and releases.
+
+DCL-fixed.litmus
+	Demonstrates corrected double-checked locking that uses
+	smp_store_release() and smp_load_acquire() in addition to the
+	obvious lock acquisitions and releases.
+
+RM-broken.litmus
+	Demonstrates problems with "roach motel" locking, where code is
+	freely moved into lock-based critical sections.  This example also
+	shows how to use the "filter" clause to discard executions that
+	would be excluded by other code not modeled in the litmus test.
+	Note also that this "roach motel" optimization is emulated by
+	physically moving P1()'s two reads from x under the lock.
+
+	What is a roach motel?	This is from an old advertisement for
+	a cockroach trap, much later featured in one of the "Men in
+	Black" movies.	"The roaches check in.	They don't check out."
+
+RM-fixed.litmus
+	The counterpart to RM-broken.litmus, showing P0()'s two loads from
+	x safely outside of the critical section.
+
+
 RCU (/rcu directory)
 --------------------
 
-- 
2.40.1


