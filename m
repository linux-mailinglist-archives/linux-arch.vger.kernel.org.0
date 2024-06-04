Return-Path: <linux-arch+bounces-4691-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 803CC8FBEA6
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 00:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A838B1C23120
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 22:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2633B14D28F;
	Tue,  4 Jun 2024 22:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrgyCsOk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C01422C2;
	Tue,  4 Jun 2024 22:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539262; cv=none; b=Wl3SIoqTfHQ6BTVlolrvU9JYEuS1sGImvyA4XhPzfCSp4s5jkLILJxMTM86rmpd9/AVxDPzliLbbxLJks1PbC2mNfDkCCyOo7YeAyyXVzt4Tt+4JkY+WreZH0zxTiyQL0TVSp5dkERGHvhwFhrMG03gt5shE2/2ynSvsfl/+eik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539262; c=relaxed/simple;
	bh=01pGRoOVLm7FmVgPZ/DAaMBZsWrBo+heyMml9ojdBqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ltbzUVxqLDFw/R1PAtb9sbtarUpHHzuPQ4ceXY0ISpJFoJXX9qdVlLTHNs5NDUehxoih066su47S0JVl4YdxzRK0GIrGOyW2TjU//a2fRZ0Td5ws2b8Ee7ogSNgpY4TD74alnLQfvvEQIm7PcHsUTDZVUCA4yNXLczWeXP/U02k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrgyCsOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29C9C3277B;
	Tue,  4 Jun 2024 22:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539261;
	bh=01pGRoOVLm7FmVgPZ/DAaMBZsWrBo+heyMml9ojdBqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LrgyCsOkoKsbedWkJFmOXWZtCJ3EfgoRKRhDX/gCdhr3WQTecd9lSDlwg9pi2qEk0
	 cx/O+yxGhahNjUAwemYo/ABJd7i4qnnLIlLEZZ7gJcfT8IjVwyDK7hDT8gCMug/5Js
	 EQd20I+D1cDEXW/Qpqb3eaVFsyVP89uZTJb4DPZ5GzEUYqcaFrHjbOX5YqHmpZY3+s
	 9Uecvnu5CN8XdRRdkLR4xDNwlAHygBA9ustXUF7tX1DhFV6uWfYt7uzcWEHv5lHCMa
	 KnOJbX/drAbFI3upAqHoRgoiuc6lPeic9YU5Dq06dONJkgqK2laJ2glNZt7h+HecMq
	 66MVDXyG90z1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 78F41CE3ED6; Tue,  4 Jun 2024 15:14:21 -0700 (PDT)
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
Subject: [PATCH memory-model 1/3] tools/memory-model: Add atomic_and()/or()/xor() and add_negative
Date: Tue,  4 Jun 2024 15:14:17 -0700
Message-Id: <20240604221419.2370127-1-paulmck@kernel.org>
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


