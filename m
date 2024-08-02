Return-Path: <linux-arch+bounces-5901-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC01394554A
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 02:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8D81C2297D
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 00:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F7EBE4F;
	Fri,  2 Aug 2024 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaSu7pSr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C18F70;
	Fri,  2 Aug 2024 00:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558138; cv=none; b=OPkYogZNkKag06wyhJ60Zw6cYssM0+0GYcfx74aB5+pBtCXLo3FDFxuVPFFmkTaxrMiDywWp+6gzpd/kfAXUjgzHQhYowTgVBrkQcfYP7TwN2W3hEUcAzaoAvuEDlXAVKQ7KMdRwRlhNVKOKZlQRAUxQ7ZgjalCH3/ctccEfliE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558138; c=relaxed/simple;
	bh=01pGRoOVLm7FmVgPZ/DAaMBZsWrBo+heyMml9ojdBqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hx7ctJqJF7bCsn6MH+STKh8a12DWtS9W4zuINLtQyGmydz7Wj0aRKUXnyyvqzpgum2PQEd/UX7DQUXGUlsDuZ00M5i5OwKHTNhuka1l1WpOrokTL6XfOjKx7D4JalKpe5b+U/PMDfkZTo19h3xFLCtTvSgBoXGrWoCKDobRpVKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaSu7pSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761A8C32786;
	Fri,  2 Aug 2024 00:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558137;
	bh=01pGRoOVLm7FmVgPZ/DAaMBZsWrBo+heyMml9ojdBqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BaSu7pSriJHJJ3Exqnm56VYPI28kJ2IndCCZaH+vzU4k5/X6Ef+AkUUjPo1oik4v1
	 bvlGdu+dGhHHQU3t3q1dzSKB2bUdW+++cJ9HTuO0c7weHHyrygobUdftIL3hF/ShLk
	 VULLPP7vVk+JfP1nn2yAVxUnI1Fca1MsM+zl63Tpbz0duZw4enigoFDm7J+3orX+cu
	 ib3ckyn/099zt4Nib86qKiY6DyftvTtYRwisGvp5l4exeDmNMox6Z6XngGs+rq83wL
	 y7aBOh2xg0cXFK6aR4Hyctw05YvhwUMAmyD0aVesIUlT0mBL/sA0nHKhXFdrl4hXIH
	 qknbqF4iyD7pA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2D8F5CE09F8; Thu,  1 Aug 2024 17:22:17 -0700 (PDT)
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
Subject: [PATCH memory-model 1/7] tools/memory-model: Add atomic_and()/or()/xor() and add_negative
Date: Thu,  1 Aug 2024 17:22:09 -0700
Message-Id: <20240802002215.4133695-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e384a9ac-05c1-45d6-9639-28457dd183d9@paulmck-laptop>
References: <e384a9ac-05c1-45d6-9639-28457dd183d9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

Pull-849[1] added the support of '&', '|', and '^' to the herd7 tool's
atomics operations.

Use these in linux-kernel.def to implement atomic_and()/or()/xor() with
all their ordering variants.

atomic_add_negative() is already available so add its acquire, release,
and relaxed ordering variants.

[1] https://github.com/herd/herdtools7/pull/849

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: <linux-arch@vger.kernel.org>
---
 tools/memory-model/linux-kernel.def | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 88a39601f5256..d1f11930ec512 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -65,6 +65,9 @@ atomic_set_release(X,V) { smp_store_release(X,V); }
 
 atomic_add(V,X) { __atomic_op(X,+,V); }
 atomic_sub(V,X) { __atomic_op(X,-,V); }
+atomic_and(V,X) { __atomic_op(X,&,V); }
+atomic_or(V,X)  { __atomic_op(X,|,V); }
+atomic_xor(V,X) { __atomic_op(X,^,V); }
 atomic_inc(X)   { __atomic_op(X,+,1); }
 atomic_dec(X)   { __atomic_op(X,-,1); }
 
@@ -77,6 +80,21 @@ atomic_fetch_add_relaxed(V,X) __atomic_fetch_op{once}(X,+,V)
 atomic_fetch_add_acquire(V,X) __atomic_fetch_op{acquire}(X,+,V)
 atomic_fetch_add_release(V,X) __atomic_fetch_op{release}(X,+,V)
 
+atomic_fetch_and(V,X) __atomic_fetch_op{mb}(X,&,V)
+atomic_fetch_and_relaxed(V,X) __atomic_fetch_op{once}(X,&,V)
+atomic_fetch_and_acquire(V,X) __atomic_fetch_op{acquire}(X,&,V)
+atomic_fetch_and_release(V,X) __atomic_fetch_op{release}(X,&,V)
+
+atomic_fetch_or(V,X) __atomic_fetch_op{mb}(X,|,V)
+atomic_fetch_or_relaxed(V,X) __atomic_fetch_op{once}(X,|,V)
+atomic_fetch_or_acquire(V,X) __atomic_fetch_op{acquire}(X,|,V)
+atomic_fetch_or_release(V,X) __atomic_fetch_op{release}(X,|,V)
+
+atomic_fetch_xor(V,X) __atomic_fetch_op{mb}(X,^,V)
+atomic_fetch_xor_relaxed(V,X) __atomic_fetch_op{once}(X,^,V)
+atomic_fetch_xor_acquire(V,X) __atomic_fetch_op{acquire}(X,^,V)
+atomic_fetch_xor_release(V,X) __atomic_fetch_op{release}(X,^,V)
+
 atomic_inc_return(X) __atomic_op_return{mb}(X,+,1)
 atomic_inc_return_relaxed(X) __atomic_op_return{once}(X,+,1)
 atomic_inc_return_acquire(X) __atomic_op_return{acquire}(X,+,1)
@@ -117,3 +135,6 @@ atomic_sub_and_test(V,X) __atomic_op_return{mb}(X,-,V) == 0
 atomic_dec_and_test(X)  __atomic_op_return{mb}(X,-,1) == 0
 atomic_inc_and_test(X)  __atomic_op_return{mb}(X,+,1) == 0
 atomic_add_negative(V,X) __atomic_op_return{mb}(X,+,V) < 0
+atomic_add_negative_relaxed(V,X) __atomic_op_return{once}(X,+,V) < 0
+atomic_add_negative_acquire(V,X) __atomic_op_return{acquire}(X,+,V) < 0
+atomic_add_negative_release(V,X) __atomic_op_return{release}(X,+,V) < 0
-- 
2.40.1


