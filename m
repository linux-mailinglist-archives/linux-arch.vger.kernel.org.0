Return-Path: <linux-arch+bounces-11453-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5D5A93BF0
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 19:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCEA1B67614
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 17:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEFF219A91;
	Fri, 18 Apr 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCoCSXiI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC6621ADC5;
	Fri, 18 Apr 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744997403; cv=none; b=T9pSVVA6YxgfrIxJI/oiiwhBdsELX6ynQOkDdWqCbC39GajqfAyb8S2skXp9/Z88qSOKQiZMb+A6IOp4O6SQWVFhxxYKxpY9hbyV7MszrvgbHgKsYFdoMQfLdDVGh9Uj74BESPDDq3i7h1o2Ubo6Ybvr5nOL27gg5lvm6ZjPwN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744997403; c=relaxed/simple;
	bh=jigIBvyZJZT7zaW2SNgxWJiDXAQDl7mSnIDxYmHZA6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DHNS0MJThq3PwVDbdSryhqCFzXd1hSp/E6yiZTzsca0W5q9swRrAZW6uZZwIDtNGSlaJY3NoCISoEjcKNh52BfzxIEkY7tQuHGozyFBTQnxDzEk1mBD59J8lYEXT1Fb+N1bbBg1vSZXs7uK8Cy2U/W/C1eUJ8WVE4P3RQ4fOwnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCoCSXiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD32AC4CEE2;
	Fri, 18 Apr 2025 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744997402;
	bh=jigIBvyZJZT7zaW2SNgxWJiDXAQDl7mSnIDxYmHZA6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCoCSXiIZY152OyQPerSLbLIL3sylyrp+Km0lpSWSJ330dfyi8f9JR+fT8Hz2bkLQ
	 eARU7FubXB1nHO6NUwHHxs+oDC2rCzt41QnoaJTXBf0pU/w+wLoKEy81O7rsCVTWrc
	 JLJms4b7NdQJBTBHJ5ry7BClb5eeXMDOzpPkilcfgN6eMBUzSlY3n3N92cSUmQsf3U
	 +r8tO9d0OSQ0go65NvsyCW3ON8SRz02VsWOsfzmn9RzKCwkOZTEBqifuyGuuGnyBCp
	 mg6C3LJbv/jDYz8fyCF5blYTPzn30kemZYxNJo7HHbHiNqhJmSepUXq//9uL90DtCO
	 aB9BUICqiKEOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7C4FCCE09FA; Fri, 18 Apr 2025 10:30:02 -0700 (PDT)
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
Subject: [PATCH 2/4] tools/memory-model: docs/simple.txt: Fix trivial typos
Date: Fri, 18 Apr 2025 10:29:58 -0700
Message-Id: <20250418173000.1188561-2-paulmck@kernel.org>
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

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/simple.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/Documentation/simple.txt b/tools/memory-model/Documentation/simple.txt
index 21f06c1d1b70d..2df148630cdcd 100644
--- a/tools/memory-model/Documentation/simple.txt
+++ b/tools/memory-model/Documentation/simple.txt
@@ -134,7 +134,7 @@ Packaged primitives: Sequence locking
 Lockless programming is considered by many to be more difficult than
 lock-based programming, but there are a few lockless design patterns that
 have been built out into an API.  One of these APIs is sequence locking.
-Although this APIs can be used in extremely complex ways, there are simple
+Although this API can be used in extremely complex ways, there are simple
 and effective ways of using it that avoid the need to pay attention to
 memory ordering.
 
@@ -205,7 +205,7 @@ If you want to keep things simple, use the initialization and read-out
 operations from the previous section only when there are no racing
 accesses.  Otherwise, use only fully ordered operations when accessing
 or modifying the variable.  This approach guarantees that code prior
-to a given access to that variable will be seen by all CPUs has having
+to a given access to that variable will be seen by all CPUs as having
 happened before any code following any later access to that same variable.
 
 Please note that per-CPU functions are not atomic operations and
-- 
2.40.1


