Return-Path: <linux-arch+bounces-5905-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B8494554F
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 02:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78EF2869F6
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 00:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1E311CB8;
	Fri,  2 Aug 2024 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9Wpw6Di"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F93DF58;
	Fri,  2 Aug 2024 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558138; cv=none; b=kReup8wTLFx7KJe5pRpFBqpBeiecbEoKOKMlXV2J9otuEJk1BMq5FoOJKWS+w90eqh5IDIpYiqNAO9mRBG3VRpm1AFC9T+ictd1HK3CixgAMk3gsL/83yOGzOzqeQ1FgwQ+upknliCVFYE/4IparPFhp+V0/ZByRSzRESI5EOfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558138; c=relaxed/simple;
	bh=YQa/BOhKsMMPECZqFlDEInRJsjszfx0/oAkzFKBeHPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V9HuSbmHg95/jPfKS2pL1YXwxwevcBuBFkSzUN5hfJIO8ZKSFcYIc0kX3WI5ZzIwJ7S2aHTmK14Og+zx8gA+DSPmzmuiLHMs8hbcukoUHUHZ0EDfttkxPcqHOZQHmmuKQlDLRzw7okTyfhTlvywYfsMDZO25xvvhjC77whMbJoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9Wpw6Di; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB24FC4AF4D;
	Fri,  2 Aug 2024 00:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558137;
	bh=YQa/BOhKsMMPECZqFlDEInRJsjszfx0/oAkzFKBeHPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9Wpw6Di29zAk7Jth13XJRfxf0N5JOZbcuVm0nkMP5fOHyCavyJ5mOvfXl4EP9JSH
	 jT4tsTek8Ke7PQPq4Cyixs9xvFdApPtXzfKmzJ6pwA8EWTcAE8x7NPZ+EiE2YmSvtJ
	 Y0/znLlz/WYS63e06UHxaNH0CztMeAmSEd43sFGIHL3skXWhe0QG9J7ACs/xgSlalG
	 7AqFbMwSo2ZGYXwbjKvSAswnT/OnR17NYDqDWK9f/uBuB3QvM9PC8qkNBb7IdHtdYS
	 iTrHC84k9h8oufgv9c9QrOv/6DqREimavu87LFrY1kmKnz2Mytuajq1y0URkNFriEH
	 pwmReqWtx9XRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3E39FCE0FA1; Thu,  1 Aug 2024 17:22:17 -0700 (PDT)
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
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 6/7] docs/memory-barriers.txt: Remove left-over references to "CACHE COHERENCY"
Date: Thu,  1 Aug 2024 17:22:14 -0700
Message-Id: <20240802002215.4133695-6-paulmck@kernel.org>
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

From: Akira Yokosawa <akiyks@gmail.com>

Commit 8ca924aeb4f2 ("Documentation/barriers: Remove references to
[smp_]read_barrier_depends()") removed the entire section of "CACHE
COHERENCY", without getting rid of its traces.

Remove them.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
---
 Documentation/memory-barriers.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 4202174a6262c..93d58d9a428b8 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -88,7 +88,6 @@ CONTENTS
 
  (*) The effects of the cpu cache.
 
-     - Cache coherency.
      - Cache coherency vs DMA.
      - Cache coherency vs MMIO.
 
@@ -677,8 +676,6 @@ include/linux/rcupdate.h.  This permits the current target of an RCU'd
 pointer to be replaced with a new modified target, without the replacement
 target appearing to be incompletely initialised.
 
-See also the subsection on "Cache Coherency" for a more thorough example.
-
 
 CONTROL DEPENDENCIES
 --------------------
-- 
2.40.1


