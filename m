Return-Path: <linux-arch+bounces-5904-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D03F994554D
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 02:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D9E1F22F7B
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 00:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36452DDA1;
	Fri,  2 Aug 2024 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOrv9ux0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BC8A955;
	Fri,  2 Aug 2024 00:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558138; cv=none; b=nvDzlv2nOnc852jyx++o/iX63qe94DP55m5vcuZYLjwmzKwaeSyAH5ukwRWtFuFipqI6g//98eBwlA0bG+fb9HhFlWpQRxIxGNjDYgojVn2U3nJmtBIGJ/G657MIBhDhq8LzhmImBkW1ygg4d0IyCtraRmS5IbyAUcXPBOLxyGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558138; c=relaxed/simple;
	bh=HdiBZ1XC7eUKV9Q7mvlKTg9S3CesGyBkjj/5R1LjE0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n7MO0YjCu3g88qB1sE+uC5ChJ1ohjBaTlMAINbASn0W9mjT2KAegNp1HRPajmeKcT36UnX/emJXK+jc8p4SLwCMVbevkLtcZNE4MYXdCepJFDbvpuZMy6DXQdy8nGmUOCVQj87BvMb3D3RxRLpe3j4ucJYu7EJOrpP5VW1Coj+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOrv9ux0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2ADDC4AF12;
	Fri,  2 Aug 2024 00:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558137;
	bh=HdiBZ1XC7eUKV9Q7mvlKTg9S3CesGyBkjj/5R1LjE0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GOrv9ux0BHehnC9Ok4L7rx8LLFL8nOdA0BxtaB7S5lU0Ml3y3mlWBJgMCsDshpCBh
	 DsX6xyEtYMfUk5poUG60EF2u7anc9Ies934aJ1eH7bbEISg6IeoGZ4QyiV7BYscidb
	 f2KdH+x/8O2VSv1+TZLtW+C98upOTqbfsPJJC3fwSaqeVNoYv/PRN+nJygOKG9vjFs
	 WoljyS+Z6ADyDmP0xEe3icFTT9aSnDYQJ+DeFulu6boFnzX/q2335fvGtQsbbt8h3U
	 aIU22fBhqGbppeeNmX/ecPxa/t3+6Q8OvZAXfEsSOXdMmhPNReehJyj+WEoqdAy1R0
	 CKB1l25jrOf/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3B2D4CE0F69; Thu,  1 Aug 2024 17:22:17 -0700 (PDT)
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
Subject: [PATCH memory-model 5/7] tools/memory-model: simple.txt: Fix stale reference to recipes-pairs.txt
Date: Thu,  1 Aug 2024 17:22:13 -0700
Message-Id: <20240802002215.4133695-5-paulmck@kernel.org>
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

There has never been recipes-paris.txt at least since v5.11.
Fix the typo.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/simple.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/simple.txt b/tools/memory-model/Documentation/simple.txt
index 4c789ec8334fc..21f06c1d1b70d 100644
--- a/tools/memory-model/Documentation/simple.txt
+++ b/tools/memory-model/Documentation/simple.txt
@@ -266,5 +266,5 @@ More complex use cases
 ======================
 
 If the alternatives above do not do what you need, please look at the
-recipes-pairs.txt file to peel off the next layer of the memory-ordering
+recipes.txt file to peel off the next layer of the memory-ordering
 onion.
-- 
2.40.1


