Return-Path: <linux-arch+bounces-10248-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5DCA3E02A
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 17:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0441B42255C
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 16:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB0920E718;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3ad2uzf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FC8206F0C;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068045; cv=none; b=kzKRlvI20vVM6GQG6DDwseIIdFTzbyKVZI6vYAUScEXRt9gkFHm2GoSAMJCTnBpzPe7DbzzfLrRYrikYpekVaqKDhfR86WKywkTYg7CH67ETSK2e/Ub+uussx9yFpGYrjkI+Ur4RGtXV0e/+gl7E0UDlCfieL+QiiG2/lnieG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068045; c=relaxed/simple;
	bh=+b8V+UTHefEjZ4Z9F9NJkPT29CpP1j9+D+uE5/v1wfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T+rdff9F+X2tgJd25EItUIHu62/WRewImBuc8WIOgHfgQbXXVCoxJnaVnQdSSGxP8BsRadNC7E+20valSaMKwWjdUgjbIVXnH9eqVh4FNc4goDkq2gtpTVLtaFnZwsVN2KnSfPc3oJ7thFW7FTUvGzJ+CTI4UF3XKuOl8CZ5T4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3ad2uzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CFEC4CEE9;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740068045;
	bh=+b8V+UTHefEjZ4Z9F9NJkPT29CpP1j9+D+uE5/v1wfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3ad2uzfSsY+KEGFG5Kor13n706xTsF8vHl+cu7ig+UxnUhS/xlSCM4ixY1ZRxtjt
	 2yp7dn+/+N7rN+aL4U0eDQt9Fgx30tIWq1i/yD0laqhj/J8T9fw9Tg31yHMzbDLLWg
	 X49r6m5+hppaHcEvkKODgv92ak4BMeSaXwFazp3PXx7/js3wj+spjieo8SM96elRbv
	 V9P5n+BySjRTcuAIIS41CNo4wm7fW60aFWcRlAXTwKQ2BTb1cyWCzfQLYaJWSgUHVe
	 mmeC/McNTPIl50uBbvR7c1V2bTP67ms04HNji4OXg5L+uYD99KXGWVlH0bvUplt0Ba
	 UgF5STB/hrmPQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A54C1CE0C4A; Thu, 20 Feb 2025 08:14:04 -0800 (PST)
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
Subject: [PATCH memory-model 4/7] tools/memory-model: Define applicable tags on operation in tools/...
Date: Thu, 20 Feb 2025 08:14:00 -0800
Message-Id: <20250220161403.800831-4-paulmck@kernel.org>
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

Herd7 transforms reads, writes, and read-modify-writes by eliminating
'acquire tags from writes, 'release tags from reads, and 'acquire,
'release, and 'mb tags from failed read-modify-writes. We emulate this
behavior by redefining Acquire, Release, and Mb sets in linux-kernel.bell
to explicitly exclude those combinations.

Herd7 furthermore adds 'noreturn tag to certain reads. Currently herd7
does not allow specifying the 'noreturn tag manually, but such manual
declaration (e.g., through a syntax __atomic_op{noreturn}) would add
invalid 'noreturn tags to writes; in preparation, we already also exclude
this combination.

Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/memory-model/linux-kernel.bell | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index dba6b5b6dee01..7c9ae48b94377 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -36,6 +36,17 @@ enum Barriers = 'wmb (*smp_wmb*) ||
 		'after-srcu-read-unlock (*smp_mb__after_srcu_read_unlock*)
 instructions F[Barriers]
 
+
+(*
+ * Filter out syntactic annotations that do not provide the corresponding
+ * semantic ordering, such as Acquire on a store or Mb on a failed RMW.
+ *)
+let FailedRMW = RMW \ (domain(rmw) | range(rmw))
+let Acquire = Acquire \ W \ FailedRMW
+let Release = Release \ R \ FailedRMW
+let Mb = Mb \ FailedRMW
+let Noreturn = Noreturn \ W
+
 (* SRCU *)
 enum SRCU = 'srcu-lock || 'srcu-unlock || 'sync-srcu
 instructions SRCU[SRCU]
-- 
2.40.1


