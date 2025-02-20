Return-Path: <linux-arch+bounces-10246-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C4FA3E029
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 17:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A68160BCD
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 16:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7DD20C038;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOi6qfOF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850222080CC;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068045; cv=none; b=TNV/Hiirx7WqS01Z6t4uXSrPjk/HqiPE05pHtrDQWZb1K5Xhkp7DaSk8BlR5lf+jq0i4W3eUaFTdrYY1xpPyXUEhr/Y7O9/Lrm5q3s7ZM45NGL4n5Y3CYwBvKDuHqlKdLWY17SMN83+N2QBst+gLuqIQ3cXIbve6ntpvrpMc/hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068045; c=relaxed/simple;
	bh=21ND8h3aXwqP4GPXt1SePJHjRlQNFlNVkqExdK3K1F0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E6O6kN0RLN8PfcXKep1RyjfJiQDPcueX7zjmxwJHMelFHqPYZq+LfhreWjsktT98DaI7R61Y3N79lKtsUwJJs9cZOU0gfu92g19ozIq2xdEAwJ+E05TFMAMCCScap4RIhjKYu0EClrR9o65Iyr7I9L1mDbFlNAuGfC7jzLb+eyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOi6qfOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04429C4CEDD;
	Thu, 20 Feb 2025 16:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740068045;
	bh=21ND8h3aXwqP4GPXt1SePJHjRlQNFlNVkqExdK3K1F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VOi6qfOFDxyt4RiKck5m0cbAN4YyCEcXk0Dq99Nvh3HkREbKIZp+vpxFze5Woc0z9
	 EP0/rZL3ou1HejUF0ew497eLDSEt94cCuao4Ilz9PwL9/cfCjGf1KemBADkIgzurvQ
	 kZdSM3G66az9fKE5vbYbHu9pBuxJMRUlHMomL09XO9y9qA9eYs0lxX9SUUn+5gmK+p
	 49XMflhLA2ud60wKyXr6PuEqaChE0aE+mIySkStOc6qifUQNiSWxmxdofNmuIOcd5O
	 vIFIMumwRjssuimaHYc80CULKSon8FfszG9k94d5c8GnyehLVW3HRHsvQCmCcGmiY8
	 9bxtrFvbDDaiA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9E5BACE0B9E; Thu, 20 Feb 2025 08:14:04 -0800 (PST)
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
	Puranjay Mohan <puranjay@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH memory-model 2/7] tools/memory-model: Add atomic_andnot() with its variants
Date: Thu, 20 Feb 2025 08:13:58 -0800
Message-Id: <20250220161403.800831-2-paulmck@kernel.org>
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

From: Puranjay Mohan <puranjay@kernel.org>

Pull-855[1] added the support of atomic_andnot() to the herd tool. Use
this to add the implementation in the LKMM. All of the ordering variants
are also added.

Here is a small litmus-test that uses this operation:

C andnot

{
atomic_t u = ATOMIC_INIT(7);
}

P0(atomic_t *u)
{

        r0 = atomic_fetch_andnot(3, u);
        r1 = READ_ONCE(*u);
}

exists (0:r0=7 /\ 0:r1=4)

Test andnot Allowed
States 1
0:r0=7; 0:r1=4;
Ok
Witnesses
Positive: 1 Negative: 0
Condition exists (0:r0=7 /\ 0:r1=4)
Observation andnot Always 1 0
Time andnot 0.00
Hash=78f011a0b5a0c65fa1cf106fcd62c845

[1] https://github.com/herd/herdtools7/pull/855

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: <linux-arch@vger.kernel.org>
---
 tools/memory-model/linux-kernel.def | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index d1f11930ec512..a12b96c547b7a 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -70,6 +70,7 @@ atomic_or(V,X)  { __atomic_op(X,|,V); }
 atomic_xor(V,X) { __atomic_op(X,^,V); }
 atomic_inc(X)   { __atomic_op(X,+,1); }
 atomic_dec(X)   { __atomic_op(X,-,1); }
+atomic_andnot(V,X) { __atomic_op(X,&~,V); }
 
 atomic_add_return(V,X) __atomic_op_return{mb}(X,+,V)
 atomic_add_return_relaxed(V,X) __atomic_op_return{once}(X,+,V)
@@ -138,3 +139,8 @@ atomic_add_negative(V,X) __atomic_op_return{mb}(X,+,V) < 0
 atomic_add_negative_relaxed(V,X) __atomic_op_return{once}(X,+,V) < 0
 atomic_add_negative_acquire(V,X) __atomic_op_return{acquire}(X,+,V) < 0
 atomic_add_negative_release(V,X) __atomic_op_return{release}(X,+,V) < 0
+
+atomic_fetch_andnot(V,X) __atomic_fetch_op{mb}(X,&~,V)
+atomic_fetch_andnot_acquire(V,X) __atomic_fetch_op{acquire}(X,&~,V)
+atomic_fetch_andnot_release(V,X) __atomic_fetch_op{release}(X,&~,V)
+atomic_fetch_andnot_relaxed(V,X) __atomic_fetch_op{once}(X,&~,V)
-- 
2.40.1


