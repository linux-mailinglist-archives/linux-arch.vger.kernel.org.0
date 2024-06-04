Return-Path: <linux-arch+bounces-4692-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF038FBEA7
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 00:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3111C22F59
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 22:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B44F14D29C;
	Tue,  4 Jun 2024 22:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSVr668a"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA214D296;
	Tue,  4 Jun 2024 22:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539262; cv=none; b=qvbHzOicifc4cwmlyQMhDwRXgpvOlC2tZh5kYow7/9PEMh4RhyvaFHp0l3gwkeIEHkQFds+O7xLIM6QmbrcVVOlDbD80OUM6TF4xvthLAZmvCDW4p5dvvvzARYnlhhFFW7rxlZlwbPnGM5YxLP/5/NvT+X8PCznyvOhtzwZCsMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539262; c=relaxed/simple;
	bh=21ND8h3aXwqP4GPXt1SePJHjRlQNFlNVkqExdK3K1F0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ORzUJBn9R4loSikNrXSotyKVktmr5+oroKNa4yVVc8/yOyqi/TJS5VDF/XbGCYqfGPlcFxUnq39YvX4RetoUObo1sij7wD3PPFDro2m0vCvR6sXyoY5wEQ5sUE6Mv7oTTaK4BX9oP4kqvMQlktkQkVeCFkj8NiBpgmBLc/ZDsok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSVr668a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A6EC4AF07;
	Tue,  4 Jun 2024 22:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539261;
	bh=21ND8h3aXwqP4GPXt1SePJHjRlQNFlNVkqExdK3K1F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSVr668awxDRSjBZV5RFYun+pWRsVnW0dBdtDZipl1jI3FGx//mlNRdW5gBAhtxQe
	 jZ2SZi0TV1CPBMnG9QoTIdrVBRWboQ7VsGQYXhod85XCxoHKoOBHnI8dYlzSrmojSJ
	 4bF/WHIiCbCv3t4HebkbUDA9+OqNa1ziXvD3kDtpvBLQrekOKLTFhKBLnU/Pgisytc
	 OZ58tbLJoUMhg/5yWsJ9vfKdwz0XMWIeWugZetuKvRa/HSQMWyrz1fTc1Ksx23PtXG
	 K7ofpHxf8/rZs6EwULzTdDWyzN4JFGcMpuudcp5w/Vkrm1KILCCGkbO45f6cK80Sku
	 ZXlQpsTtIqD4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7D913CE3F0F; Tue,  4 Jun 2024 15:14:21 -0700 (PDT)
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
	Puranjay Mohan <puranjay@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH memory-model 2/3] tools/memory-model: Add atomic_andnot() with its variants
Date: Tue,  4 Jun 2024 15:14:18 -0700
Message-Id: <20240604221419.2370127-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b290acd5-074f-4e17-a8bf-b444e553d986@paulmck-laptop>
References: <b290acd5-074f-4e17-a8bf-b444e553d986@paulmck-laptop>
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


