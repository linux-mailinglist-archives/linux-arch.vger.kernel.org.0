Return-Path: <linux-arch+bounces-5906-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B4894554E
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 02:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6FCC1C22AA7
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 00:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0F111CAB;
	Fri,  2 Aug 2024 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mU8V7dPG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F3BDDC5;
	Fri,  2 Aug 2024 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558138; cv=none; b=P34ybGUcWDpscjOvjYIL8KnSvGHE4qAl7i+4j0q9xBYoPv2QO2p4p90/4jaZDhsMK3uILVQpxkxP3mQaJraOoQhiI0bKHsHztFltYYmMeupf45E72eXwtIqLVtfpGcTKNjvtuEIfr1VUunfPaZqkxD4eQix+PUL6xiCaV+26k7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558138; c=relaxed/simple;
	bh=fGwyHF+1MAl/tYpvKYg2zAfXlaeo9X5p2H1ojxOUXCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8DKy6VAMXj3YugMSD6gOF2Pa+CRBppF0m/KYtmEPLTgnVkCBm8zEo2dybxY3AxM4M/lJ27uNYywSIWg/EU0JF0OqONyW5hL5YilAwP9NjTMITEz3EnUBvVxgb7s0Z9TxxITQwEKgHnmW7MR7GqMd8lYldUY/lXf24XX4jb/UZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mU8V7dPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2876C4AF51;
	Fri,  2 Aug 2024 00:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558137;
	bh=fGwyHF+1MAl/tYpvKYg2zAfXlaeo9X5p2H1ojxOUXCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mU8V7dPGz3HPDbGIUbXdgIw6lNkhoGkZFiAeIYUmllEmdQ2YEEWcgtQ7/aXdTtLXs
	 Uogwkyp3DvKe5J1/6LbP4kEll0IliBsI416ckz1tm7qmC425vYXs/ccqkWRj37MTqx
	 iC6Rel22dmGmhe14OEZboBa++014bL88xXK38UKylQFsimo5XOSiDZJg7Q1Crry4M9
	 k42zizgqMH0gHgKv5W2GcjHKwsejff/3Zy0aV77QtOmzl6fB/hjQKp278dwq/tgbzw
	 DvnxteuqmomE6PMRbezZLQbUJ+tL9+7b6UcqNfp0/lhHfKzfp3pY/kFNSJhj0K6myK
	 e4SOdutkHEHsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 40F51CE0FA9; Thu,  1 Aug 2024 17:22:17 -0700 (PDT)
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
Subject: [PATCH memory-model 7/7] MAINTAINERS: Add the dedicated maillist info for LKMM
Date: Thu,  1 Aug 2024 17:22:15 -0700
Message-Id: <20240802002215.4133695-7-paulmck@kernel.org>
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

From: Boqun Feng <boqun.feng@gmail.com>

A dedicated mail list has been created for Linux kernel memory model
discussion, which could help people more easily track memory model
related discussions.  This could also help bring memory model discussions
to a broader audience.  Therefore, add the list information to the LKMM
maintainers entry.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde383206..0a3a769148fd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12993,6 +12993,7 @@ R:	Daniel Lustig <dlustig@nvidia.com>
 R:	Joel Fernandes <joel@joelfernandes.org>
 L:	linux-kernel@vger.kernel.org
 L:	linux-arch@vger.kernel.org
+L:	lkmm@lists.linux.dev
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
 F:	Documentation/atomic_bitops.txt
-- 
2.40.1


