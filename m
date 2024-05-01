Return-Path: <linux-arch+bounces-4126-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3867D8B9239
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 01:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D9D1C211FD
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 23:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E87168AFB;
	Wed,  1 May 2024 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey/sscED"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241C7168AEB;
	Wed,  1 May 2024 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605695; cv=none; b=giEuHvAQYRlLe8WgMBQych5xyyeIF4WeB4MXoSW7phZwl8L7oRDoODKBeXgIkUpu8nzSp7HpNLQSJXd7GnMzKipTxy6dVp/ugI7wwneFii7tEjD3Qifo+J0q3cigX+Bd22u/OgqViA3kOfuTb1K5O/cK6I5UR+/KPm/jUYfKcZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605695; c=relaxed/simple;
	bh=ibJ7tBfcSHE8gIrgfKmrh4eEE1rQM1LM/7svDbVFHa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AAhHyW4kXgGt3Jd/gKKaRbIHNHXeVIY0trZuPOclA8KzXC7/U0izFBYW0L6853oNYEb5d8bVGkGcPkoSfQ8cs8Thegu1KOiQlMF2TkBhYA03b15YHH6zN+KVc22RGZQb9Rt1Rp2vsohqAgz4GpgTEnJeAqiTZIQ5xPvVVWfL8FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ey/sscED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CD3C072AA;
	Wed,  1 May 2024 23:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714605694;
	bh=ibJ7tBfcSHE8gIrgfKmrh4eEE1rQM1LM/7svDbVFHa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ey/sscEDF9TXLGAIQyztoHiDad6TZo3EhhsYRD4q8JDRioozq1/o2dJh3aNT281YM
	 Far2IKzktYWQpiz89L7i+DRjK/X9rnpeGjqEDMzsQKNif9JBWeDWmkqg2XnnYRQPtQ
	 1TfLNqGbktjclvRFZNpukKhgWTLxUMsiib3gb8K4wTWzB56t4IsU6MzI8O4gS/13XD
	 c8SdgCkmYXy6npvGuvsLMSmfiljQwt8oAnBk1SmXf+jLWCve/s+XUnyt+tzIhJjZ+I
	 E6yGTk6qIeN+fkhaIYAIz87TLOSOw1HF/+4QXO1yFeY6U6Zir6OqQcflq7K3KHxqmF
	 wvZaESnZdl6uQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 62DB5CE1073; Wed,  1 May 2024 16:21:34 -0700 (PDT)
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
Subject: [PATCH memory-model 1/4] Documentation/litmus-tests: Add locking tests to README
Date: Wed,  1 May 2024 16:21:29 -0700
Message-Id: <20240501232132.1785861-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <42a43181-a431-44bd-8aff-6b305f8111ba@paulmck-laptop>
References: <42a43181-a431-44bd-8aff-6b305f8111ba@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit documents the litmus tests in the "locking" directory.

[ paulmck: Apply formatting feedback from Andrea Parri. ]

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
index 658d37860d397..26ca56df02125 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -22,6 +22,35 @@ Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
     NOTE: Require herd7 7.56 or later which supports "(void)expr".
 
 
+locking (/locking directory)
+----------------------------
+
+DCL-broken.litmus
+    Demonstrates that double-checked locking needs more than just
+    the obvious lock acquisitions and releases.
+
+DCL-fixed.litmus
+    Demonstrates corrected double-checked locking that uses
+    smp_store_release() and smp_load_acquire() in addition to the
+    obvious lock acquisitions and releases.
+
+RM-broken.litmus
+    Demonstrates problems with "roach motel" locking, where code is
+    freely moved into lock-based critical sections.  This example also
+    shows how to use the "filter" clause to discard executions that
+    would be excluded by other code not modeled in the litmus test.
+    Note also that this "roach motel" optimization is emulated by
+    physically moving P1()'s two reads from x under the lock.
+
+    What is a roach motel?  This is from an old advertisement for
+    a cockroach trap, much later featured in one of the "Men in
+    Black" movies.  "The roaches check in.  They don't check out."
+
+RM-fixed.litmus
+    The counterpart to RM-broken.litmus, showing P0()'s two loads from
+    x safely outside of the critical section.
+
+
 RCU (/rcu directory)
 --------------------
 
-- 
2.40.1


