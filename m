Return-Path: <linux-arch+bounces-4392-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C968C4F00
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 12:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8311A1C2048C
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 10:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9705B13440F;
	Tue, 14 May 2024 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4HGvJ05"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDE753E15;
	Tue, 14 May 2024 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680017; cv=none; b=Dg2k+NFUch2BS/ZnAAgyHMRo4Uotdir/PGMgk87I4VPo8wwFI4v8hTe8oL6BLFAoAFRWgtlpfE8UFBB/mvfSb/cTdv4bXWT01EUVsFAgzuKwp/d6IhEJP8UJCfnan6UD2hHmjXZml5Gjy5FhLsXFqX2RMxYpljSJtRcoc7G/Hnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680017; c=relaxed/simple;
	bh=dfYJ4UEi4cz7TvFXBGiFzXx4XErQQccYti1P3UdmCOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ntA8nqIQ284HVuUlgd8vETHqoK+Qa+nxAIisB52jWUfH3qTSsIzu1/+M0kdp0LLk7lgvy47rAnC0OQ7eBvg0l2mGU7v7IlvlrUyuHvH6Vm2vUrB2BNorcrLXNjB2iHYTa4fvE5eEHsMbzBChvQU2MheSdhyOAO3wEYn2DSF1a2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4HGvJ05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921E4C32786;
	Tue, 14 May 2024 09:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715680016;
	bh=dfYJ4UEi4cz7TvFXBGiFzXx4XErQQccYti1P3UdmCOU=;
	h=From:To:Cc:Subject:Date:From;
	b=L4HGvJ05P1kdy7JsAeGZzTWy5UC5yCDkt7J4izjjNlV+W1yVKpSVB3AtSEcgQn/dm
	 dOpsRZfjdp3lMmQzu5bajEURt5cuBIFXiyE/2Gi7E5myVtrp3WG2pcvJrAcIAfYOMk
	 uCvh68F2oD1Oeot5H0m3JzViCCsqxBMn3rXPkmDSTtFzH4JTu8oH7FmlOutWCqEbL4
	 xMd2Z6jvh6U9uqYYcma+yR5QPY8qCu8ze5eaubLROkaibqDDwpev+M8tfnIcGm/fUd
	 oIdSDo/05EN2KwpW4RqaFcl0Xam4bNAfNT+GTfv5aWlfX8VJDVMwmXIHTwdphmpoQd
	 TzvCQAAUS2CmQ==
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
Subject: [PATCH] tools/memory-model: Add atomic_andnot() with its variants
Date: Tue, 14 May 2024 09:46:33 +0000
Message-Id: <20240514094633.48067-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---

This commit is based on the commit[1] that is adding `&`, `|`, and `^`.

Both of these patches should go together when the next version of herd7 is
released. I will update the "REQUIREMENTS" section when the new version is
released.

Later on, I will add some example litmus tests to showcase the usage of
these new operations.

[1] https://lore.kernel.org/all/20240508143400.36256-1-puranjay@kernel.org/

---
 tools/memory-model/linux-kernel.def | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index d1f11930ec51..a12b96c547b7 100644
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


