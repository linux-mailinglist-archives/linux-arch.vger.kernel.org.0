Return-Path: <linux-arch+bounces-10247-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1301CA3E027
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 17:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D501899C9D
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 16:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B954F20E329;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvDWkGig"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F6E2066C1;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068045; cv=none; b=UNtF9rDy7Y60ng0os4IQjqU2H0aDRvzygzpCXNdwys7MMXYSBMGeaA2yf82BNGHLxW1loXf/Bf2k+nuwH0yl+vp0wyd9Yz7J7Vv9mKCUoDtWO2euMpJaoAOzYNsb++yUIc83gYia7wKQbhfz3ViVkk60cRmLXiUwCRYyOZWtqxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068045; c=relaxed/simple;
	bh=BJSdjddDDDak8tUwLAztoLXgRW0wiWScQgn5daVIRSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tbeKm1bgRk8StSTHpVg9caqIh1kpvTOMB8XlKb65roM8v9cJxKiilkERSH9cFetZdWScgzO53efh5MCI24PI9VLbGWW+AJ/5aq4bNiEHItY/6HcsSYdX67CAYEgpoMsmRn7Q9O1yPtRL7zKuIGQgTsorgOo/4MVWKOGWqLoG9ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvDWkGig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE4AC4CEE2;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740068045;
	bh=BJSdjddDDDak8tUwLAztoLXgRW0wiWScQgn5daVIRSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvDWkGigx4owex//4esDzuokt/gCIoPWd+QMZ6lDXKZTWjm4qMtjiEKZ/9r4FQVg2
	 NuUx4F5dBCc3YXFjoIgqtsA52zdlg6JKEcI6PsSINEhqigJ0mraEw8uksgvvfZ7nRu
	 5qxgUq4Hwx6SFAQ28LXN70FIzVcm9gloG6I5QpOggkCjV+wWcZ7Ld2Za6Uj6z/dMdJ
	 3dq4sGc2iedKr9zdT2wEdA1PzgnknTD17v+lHsPf/CxpTRfq2oCbcE/SLLSSmnZMdj
	 EHuydveBP+gt/o6SuQnP7fg8AwsHpV4K3tTX00dWC2g7vubgkXGabCFwOdeeqTEOVS
	 JLn82N8pzeE0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A1787CE0BA2; Thu, 20 Feb 2025 08:14:04 -0800 (PST)
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
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 3/7] tools/memory-model: Legitimize current use of tags in LKMM macros
Date: Thu, 20 Feb 2025 08:13:59 -0800
Message-Id: <20250220161403.800831-3-paulmck@kernel.org>
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

The current macros in linux-kernel.def reference instructions such as
__xchg{mb} or __cmpxchg{acquire}, which are invalid combinations of tags
and instructions according to the declarations in linux-kernel.bell.
This works with current herd7 because herd7 removes these tags anyways
and does not actually enforce validity of combinations at all.

If a future herd7 version no longer applies these hardcoded
transformations, then all currently invalid combinations will actually
appear on some instruction.

We therefore adjust the declarations to make the resulting combinations
valid, by adding the 'mb tag to the set of Accesses and allowing all
Accesses to appear on all read, write, and RMW instructions.

Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/memory-model/linux-kernel.bell | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index ce068700939c5..dba6b5b6dee01 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -16,10 +16,11 @@
 enum Accesses = 'once (*READ_ONCE,WRITE_ONCE*) ||
 		'release (*smp_store_release*) ||
 		'acquire (*smp_load_acquire*) ||
-		'noreturn (* R of non-return RMW *)
-instructions R[{'once,'acquire,'noreturn}]
-instructions W[{'once,'release}]
-instructions RMW[{'once,'acquire,'release}]
+		'noreturn (* R of non-return RMW *) ||
+		'mb (*xchg(),cmpxchg(),...*)
+instructions R[Accesses]
+instructions W[Accesses]
+instructions RMW[Accesses]
 
 enum Barriers = 'wmb (*smp_wmb*) ||
 		'rmb (*smp_rmb*) ||
-- 
2.40.1


