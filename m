Return-Path: <linux-arch+bounces-4693-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B671D8FBEA8
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 00:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0952DB2586B
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 22:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B51814D29D;
	Tue,  4 Jun 2024 22:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjooraZf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425BC14D293;
	Tue,  4 Jun 2024 22:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539262; cv=none; b=fazv0gI/Z7Qbw1fxwCdDhUMmvQHWFMJqsMxEAyH76mGTKdRU09vA+1eq1MnVhNwt+ZH0H9y1uMIb2lAxTXBQB5bPEjLBEHfCYso8w0ywTYhTQmVv7FcgNagOVvyBz/4QtKtgQB0pFfNAv0Ne0Hmh+/Z8nyJd9pf7/kc/Qu6/Qcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539262; c=relaxed/simple;
	bh=ygTLP2T8slbXOZ6W4tEAKQMW6AwWve81xPXtxXbnv+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZqUnMZ+iCj7CBL8/CUPOp5zndm4+CaSeAtpb4GugVRKdtY7ar7aDQKp0GM4AE+rS2eqFLBBr7V3nSYRq01euKJeYNYfsrlOh2NOrpVV1y5/llq9J3oCNqB88HL4A52qeCeJazl2IqkR9zJp5YukFL4ItujHos5W58AVfNxpWfr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjooraZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D0BC2BBFC;
	Tue,  4 Jun 2024 22:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539261;
	bh=ygTLP2T8slbXOZ6W4tEAKQMW6AwWve81xPXtxXbnv+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjooraZfIwtaTfAywxDMSlOrkCdYYFPZ7+5wfes6MP1KqO38si2R1O9XoB4jYUwlI
	 J2Og1gHtAjKOaLaem9ppYfWPpUW6DHxLJurJenD1JU0GwPT0qPeo41r7Adt9KjTFBq
	 uEdit18/04o2B7B0UGOUDetssx5ohdr4k9ILzBK4BIeoGQZZ4sQHvhtovCmfzVr4ge
	 4w/XzbOT/rpklacUqKhO7et6liJdNLZPN2XuWQitcC1eXfb1LgfGCiMajbtqmqtrwU
	 U1I2dzAIJHFXBvAK4TIq6MSjNGlpCynylrIDUKsexfQMgXhSpcILLF+mdyVTOUKvcf
	 z2sAq1DrpvtQA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 81331CE3F26; Tue,  4 Jun 2024 15:14:21 -0700 (PDT)
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
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH memory-model 3/3] tools/memory-model: Add KCSAN LF mentorship session citation
Date: Tue,  4 Jun 2024 15:14:19 -0700
Message-Id: <20240604221419.2370127-3-paulmck@kernel.org>
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

Add a citation to Marco's LF mentorship session presentation entitled
"The Kernel Concurrency Sanitizer"

[ paulmck: Apply Marco Elver feedback. ]

Reported-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: <linux-arch@vger.kernel.org>
---
 tools/memory-model/Documentation/access-marking.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
index 65778222183e3..f531b0837356b 100644
--- a/tools/memory-model/Documentation/access-marking.txt
+++ b/tools/memory-model/Documentation/access-marking.txt
@@ -6,7 +6,8 @@ normal accesses to shared memory, that is "normal" as in accesses that do
 not use read-modify-write atomic operations.  It also describes how to
 document these accesses, both with comments and with special assertions
 processed by the Kernel Concurrency Sanitizer (KCSAN).  This discussion
-builds on an earlier LWN article [1].
+builds on an earlier LWN article [1] and Linux Foundation mentorship
+session [2].
 
 
 ACCESS-MARKING OPTIONS
@@ -31,7 +32,7 @@ example:
 	WRITE_ONCE(a, b + data_race(c + d) + READ_ONCE(e));
 
 Neither plain C-language accesses nor data_race() (#1 and #2 above) place
-any sort of constraint on the compiler's choice of optimizations [2].
+any sort of constraint on the compiler's choice of optimizations [3].
 In contrast, READ_ONCE() and WRITE_ONCE() (#3 and #4 above) restrict the
 compiler's use of code-motion and common-subexpression optimizations.
 Therefore, if a given access is involved in an intentional data race,
@@ -594,5 +595,8 @@ REFERENCES
 [1] "Concurrency bugs should fear the big bad data-race detector (part 2)"
     https://lwn.net/Articles/816854/
 
-[2] "Who's afraid of a big bad optimizing compiler?"
+[2] "The Kernel Concurrency Sanitizer"
+    https://www.linuxfoundation.org/webinars/the-kernel-concurrency-sanitizer
+
+[3] "Who's afraid of a big bad optimizing compiler?"
     https://lwn.net/Articles/793253/
-- 
2.40.1


