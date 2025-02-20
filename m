Return-Path: <linux-arch+bounces-10245-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB43A3E038
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 17:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C030C3A98E1
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFD520B1F1;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZWU+yhr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F0F205E1A;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068045; cv=none; b=ILGcD17Rvbb4Qs8Uy4ew65/Jej9hcw01+UtYSMDRVusLf/bFZA935vAAOkW/S4DGiW6d6N0GiZgmvAkJf9vWC8hkZYf1Fm37eeHXWvZVjggpZkiUgQ0402MeuthR9dMn6Km80lP7khwSyMN97ufoIhY0AFGGIV6SqRMgEcmbwtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068045; c=relaxed/simple;
	bh=WmSxWReFRSxg3AIpXyHvnAtwkV29bRIzKRwaPkY52Og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XbEfI7PhaVGrNfdE/sqqvjSPIGIHXkq9kkNO0QNWYCKuIt5JvKQDdHo9PDB6ljcGJIuLB87KKkFF9uKChITXD21sSE68TGmtUTf1gT3MonwdQhSo/35CaemXplJIPARfhaM5f0PFMw7YkjOqOHZA3VsbbrhymltC01bPhRqUlj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZWU+yhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FD5C4CEEC;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740068045;
	bh=WmSxWReFRSxg3AIpXyHvnAtwkV29bRIzKRwaPkY52Og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gZWU+yhrnnxWMvYCCs273LOHURrt8hQyzlnKBGN+wPxu5MUgxLfkmaA5uE56kDsfe
	 MY/XrJYABDYExWTf10OE2qVpvcOUjv5aXvZBxwsl+MO0JxGTu/rU7J9pSNeO1p+9lb
	 DRwbRn2+c4HxxFDTPdHcIdP1thvx1JYaq1P+O8T+0V8rEfizNH7g4hm2Cseqauu+Rw
	 wPk+syUd7pxLdmSU5mU6NPD84gZ//fwdR4jvFUR4xJG5sSgWMAyeuz0UtKsNU5/34C
	 l0J2owammTBx37a2ftwcLx3P1YIVdvkVuQhX1P8P1YwuOWs2ptzixUEik6H5lJkNf5
	 wDmBf9KPGFHPA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A928ACE0C90; Thu, 20 Feb 2025 08:14:04 -0800 (PST)
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
	Viktor Vafeiadis <viktor@mpi-sws.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 5/7] tools/memory-model: Define effect of Mb tags on RMWs in tools/...
Date: Thu, 20 Feb 2025 08:14:01 -0800
Message-Id: <20250220161403.800831-5-paulmck@kernel.org>
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

Herd7 transforms successful RMW with Mb tags by inserting smp_mb() fences
around them. We emulate this by considering imaginary po-edges before the
RMW read and before the RMW write, and extending the smp_mb() ordering
rule, which currently only applies to real po edges that would be found
around a really inserted smp_mb(), also to cases of the only imagined po
edges.

Reported-by: Viktor Vafeiadis <viktor@mpi-sws.org>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/memory-model/linux-kernel.cat | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index adf3c4f412296..d7e7bf13c831b 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -34,6 +34,16 @@ let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
 let rmb = [R4rmb] ; fencerel(Rmb) ; [R4rmb]
 let wmb = [W] ; fencerel(Wmb) ; [W]
 let mb = ([M] ; fencerel(Mb) ; [M]) |
+	(*
+	 * full-barrier RMWs (successful cmpxchg(), xchg(), etc.) act as
+	 * though there were enclosed by smp_mb().
+	 * The effect of these virtual smp_mb() is formalized by adding
+	 * Mb tags to the read and write of the operation, and providing
+	 * the same ordering as though there were additional po edges
+	 * between the Mb tag and the read resp. write.
+	 *)
+	([M] ; po ; [Mb & R]) |
+	([Mb & W] ; po ; [M]) |
 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
 	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
 	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
-- 
2.40.1


