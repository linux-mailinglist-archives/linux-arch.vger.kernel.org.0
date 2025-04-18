Return-Path: <linux-arch+bounces-11454-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F102A93BF1
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 19:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D2F8E4AF0
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 17:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A1B21B8F7;
	Fri, 18 Apr 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buJY8eO3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B68C215065;
	Fri, 18 Apr 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744997403; cv=none; b=hxBvqv1SFDANwV1StzUdV8dwdwgM2AobluXW326V/d3CrafGCEokoz1Sx19LVac3A0PO0t4AC3Ueni5+pX5JLyZ2eMLGK1E927QjRrI0FLB5SL75dLHodYnP5WqG/r0f1HemEzJBVy3TwNpBjbwIINsPiVxa/ChlbriP4yDVXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744997403; c=relaxed/simple;
	bh=IjhDfmevSmYVsiWymcxWZN+vN/2vH0mMRUw1OxtDFe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kPGeJ57OG9kBcM+KzPd7PNHaQXTDN/Bsuj75yZQg2ffC9A/NntpzvrUGihC+jWdVPhdhBUaufTRFoflH41vrp9SFbyAo/67QcbiWwPpgXosYIqIGOstedrkEibU3ELsKSsXIJUOFmumCI0R9ik9NlLvXQk+Omqr1QnswL/G8Ubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buJY8eO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D160BC4CEEA;
	Fri, 18 Apr 2025 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744997402;
	bh=IjhDfmevSmYVsiWymcxWZN+vN/2vH0mMRUw1OxtDFe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=buJY8eO3wX3i2ol/qlUB/JyrMlnGFYFIRxMf59woDvHHIgBjhYEbzmVXmhTbmyH9P
	 e8Tp8yQ/XfBUdBxAzwlQdytxuuAA1RZj2PAm4vmVyhXPsllP0/PPQUR0ar8Hp7cU5O
	 QWa0PW8H8dpdhhcsbJXEhPM+14f5wvMcdZMPXALmJDX2JnEYH6U+q7FA8ntd2++F81
	 RqT9zD9gG8ogaFk2+7a62iJ65EUIfIkjTV3OfwWKt7Srr0trk7QqRPocpjFwDmYhaF
	 k2JTg51yAbKx+OtNNxqp94kZUdbwWJcvQ/jfJapak9GK3ewlEb+IYAtW5c4caVPFFh
	 nAoXkm+SthokA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 788CCCE077B; Fri, 18 Apr 2025 10:30:02 -0700 (PDT)
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
Subject: [PATCH 1/4] tools/memory-model: docs/README: Update introduction of locking.txt
Date: Fri, 18 Apr 2025 10:29:57 -0700
Message-Id: <20250418173000.1188561-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cd7fb2c4-1895-455c-84f8-8ed7252b93ff@paulmck-laptop>
References: <cd7fb2c4-1895-455c-84f8-8ed7252b93ff@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Akira Yokosawa <akiyks@gmail.com>

Commit 9bc931e9e161 ("tools/memory-model: Add locking.txt and
glossary.txt to README") failed to mention the relation of the "Locking"
section in recipes.txt and locking.txt.

The latter is a detailed version of the former intended to be read on
its own.

Reword the description in README and add notes in locking.txt and
recipes.txt to clarify their relationship.

[ paulmck: Wordsmithing. ]

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/README      | 7 +++++--
 tools/memory-model/Documentation/locking.txt | 5 +++++
 tools/memory-model/Documentation/recipes.txt | 4 ++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
index 9999c1effdb65..88870b0bceea8 100644
--- a/tools/memory-model/Documentation/README
+++ b/tools/memory-model/Documentation/README
@@ -23,8 +23,11 @@ o	You are familiar with the Linux-kernel concurrency primitives
 	that you need, and just want to get started with LKMM litmus
 	tests:  litmus-tests.txt
 
-o	You would like to access lock-protected shared variables without
-	having their corresponding locks held:  locking.txt
+o	You need to locklessly access shared variables that are otherwise
+	protected by a lock: locking.txt
+
+	This locking.txt file expands on the "Locking" section in
+	recipes.txt, but is self-contained.
 
 o	You are familiar with Linux-kernel concurrency, and would
 	like a detailed intuitive understanding of LKMM, including
diff --git a/tools/memory-model/Documentation/locking.txt b/tools/memory-model/Documentation/locking.txt
index 65c898c64a93a..d6dc3cc34ab65 100644
--- a/tools/memory-model/Documentation/locking.txt
+++ b/tools/memory-model/Documentation/locking.txt
@@ -1,3 +1,8 @@
+[!] Note:
+	This file expands on the "Locking" section of recipes.txt,
+	focusing on locklessly accessing shared variables that are
+	otherwise protected by a lock.
+
 Locking
 =======
 
diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
index 03f58b11c2525..52115ee5f3939 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.txt
@@ -61,6 +61,10 @@ usual) some things to be careful of:
 Locking
 -------
 
+[!] Note:
+	locking.txt expands on this section, providing more detail on
+	locklessly accessing lock-protected shared variables.
+
 Locking is well-known and straightforward, at least if you don't think
 about it too hard.  And the basic rule is indeed quite simple: Any CPU that
 has acquired a given lock sees any changes previously seen or made by any
-- 
2.40.1


