Return-Path: <linux-arch+bounces-4267-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866B58C000F
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 16:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B621C23399
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7854986270;
	Wed,  8 May 2024 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb49OlRC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5050186630;
	Wed,  8 May 2024 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178878; cv=none; b=j9LWj7Z3H5AlQHVwE2gaEeFyJDPxwL0nc4P8anPxHcNb7BZLkaQK7s3VY9euKZUfOmxcDwxjpjqprVZ/v6TY8Ns6ybLQsloa9iWu+AWQwAxYoBok4Ikl3jpxFzyPu0COJMtAf2Bc03h/Tphg2963DDQTbym/8inUCTL0H+HN6F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178878; c=relaxed/simple;
	bh=LkpImf7Xtegq1U9a+QMyUfSZIIkF8bJjQH28HZhVga0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pdRCfcv5oTyl47h97jD2+zBB//BWUfyGxzN/JHMRA63zqMzmsd8XXJgp2YOos9gxQPswB5P68PIAr4l16JldOGvZH1fG7pfMjB/Mh/pDzWR7Gxnu+Mg4EKwyAO7detugQjJuMnELoA52vA0vqg+EekQqZepF/prwpffV4LZQ8r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb49OlRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C1CC32783;
	Wed,  8 May 2024 14:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715178877;
	bh=LkpImf7Xtegq1U9a+QMyUfSZIIkF8bJjQH28HZhVga0=;
	h=From:To:Cc:Subject:Date:From;
	b=Sb49OlRC1SeN2Z3yjggk5qbbS+bA9/SmtwkeG/4KATklP+CJdtZ2EXsJCcgoPI19L
	 u00EsvbrMumHLyBDeGfjvZMtz5Xlg44JC9XWF4fVhkhcfrAawWN9/dNRayNeU7A8OT
	 IboYGxypuslUkGCdY7BipEsqI0msBln/hKwRHdcFa4Tx65YBxL69IfAmf/9aAdL4SR
	 stdL30hqMNFSAWipoYsCjisjsHFhc0VipbCbJfw3mKqTPdYnu0R38pxOTljGKceX3t
	 glP/6q93MgUdFh3SxLtg6Hfa2J2yVvx3E2/bW0omYLgFQk3agx1Qf4+XKmMyv4xZLp
	 qBNgO1v+I/6oA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
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
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH] tools/memory-model: Add atomic_and()/or()/xor() and add_negative
Date: Wed,  8 May 2024 14:34:00 +0000
Message-Id: <20240508143400.36256-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pull-849[1] added the support of '&', '|', and '^' to the herd7 tool's
atomics operations.

Use these in linux-kernel.def to implement atomic_and()/or()/xor() with
all their ordering variants.

atomic_add_negative() is already available so add its acquire, release,
and relaxed ordering variants.

[1] https://github.com/herd/herdtools7/pull/849

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/memory-model/linux-kernel.def | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 88a39601f525..d1f11930ec51 100644
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


