Return-Path: <linux-arch+bounces-10244-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D829A3E026
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 17:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4619422396
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 16:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56390200B9F;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IntIdG5T"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291861FCCFD;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068045; cv=none; b=Pg+FI739a6yCHw7Ik/SEFjX0/sSZ4Z4VuGWj9U/Ev2boIf7+rS4vAqubS/CBkS9MXldLbsnCni9go4xhCGLV+iLZHF3a4JFPb/KT/l4WtcDNOeJVZ6c4mC4A/W0UTHEoqFY8cJae/Q65ZwiGBbuw313hFXE6FQajjrQkNFWtXHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068045; c=relaxed/simple;
	bh=01pGRoOVLm7FmVgPZ/DAaMBZsWrBo+heyMml9ojdBqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I3teGjrtouVkBDEKKJMAPe4xdLG4BReN7AX9ytofBbDfkC8yMu5jYIFdwJpi1Z9ybhDn3o5PWB9vuWI1zLXsEcHWlBisEI9F7sjvpwb0LS07klwo6geFUxOplvJhl4ctxu3K2oMPVbKvFVbeguCORmM97t8ncdU2prAHuhzp00c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IntIdG5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25A1C4CED1;
	Thu, 20 Feb 2025 16:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740068045;
	bh=01pGRoOVLm7FmVgPZ/DAaMBZsWrBo+heyMml9ojdBqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IntIdG5TdZt9kIcE7uowpyd2fPl52hC1g4IeHUPC5ZQs7EIRUl+jdPeCLlM9cHrAW
	 uh5rqBx+TIn0zTEAypeQk1ewg+2w//4/gqtihPpNmfQmwYfsqlHczMRwwRb5O7Idv/
	 DV8xmW3bx2jQ2dJ5CpRNcDtoQfUK3rgrvH2Wn0WkwDxgGnJAXmw44sFOTBio7OBbiT
	 MUHgqCGlTRAo6QnHLHUfGE8d1rF8aHZxv0jt/lLmlLBl9LOIcZHcFVSOKaLRWvIzht
	 bxX+EktSzAaftCkMtZ1fonMbpBPLrYFLOdNLVm+qheSJzjVIPJ1BZPWagv4nXVYWn8
	 wyKaQDFEIcmKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9A69DCE0B34; Thu, 20 Feb 2025 08:14:04 -0800 (PST)
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
Date: Thu, 20 Feb 2025 08:13:57 -0800
Message-Id: <20250220161403.800831-1-paulmck@kernel.org>
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


