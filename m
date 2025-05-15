Return-Path: <linux-arch+bounces-11948-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBE1AB86E4
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 14:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C353B4469
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 12:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3706C29ACE2;
	Thu, 15 May 2025 12:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEvGwZys"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E54D29ACE1;
	Thu, 15 May 2025 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313225; cv=none; b=uQiDlsByGfdAn7HZ+wC8tpUqTyCeJwn57FduMLuISPLDaI9aPHgJE2FyD/j9UB5bSTVE7sjIOBc/1XOCZRlRckAsSeLg3BocSLJx7i8ObqeLqvSNUW7hJCV4Ycewo+r+Cd3x5qdSU0ak0kdUS097D2O6epxP/e85/rNBitaXNPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313225; c=relaxed/simple;
	bh=jWZIqV+3LcIXkF+SWUyEanhdz9apJ2bmCTUUM4BXA1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSGI5i0ArpZJ0dq6i+/dnEfdBXav2QaoJCMbEWRlWo6lCWsK+gOYx5eZsYVW13WBOFy1d70BFoOrJSt7PMgNBHp5WqEItEph1gT+AzlcB5kPyhGhCONxf2lxDecOeHm0kpkvbw6wp2MPU8Ws9iNg44aCPhtVNGoFlFDMFMSkG64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEvGwZys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04102C4CEE7;
	Thu, 15 May 2025 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313224;
	bh=jWZIqV+3LcIXkF+SWUyEanhdz9apJ2bmCTUUM4BXA1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OEvGwZysIN02LjYSXXXmVSN0DlT0Z8rJM19XbpEJp6apfofkDoVz5X80muuqnLNRq
	 eUyy4ry0rWNu1CxdBK6SuXzyw5NSGmtKp1/p4CdRQTrT9i7tbns6SQuY+MAAqdl3eq
	 Ft30xm6mqwS4EcNzfJtqvnQjBsO1zbNmqN/QZB2WXaggBocc6fTVMTYNIdvAZQWBvf
	 qC6hVVttumbJIFqHjqfr4nrHIeY4e2azXa9wa8n0Ytc2+zjnXKP9DACF2pyCmc1YeV
	 8uVquPRL9X+oXJE/k9QF02T3U6DqTQx+Z+x0NSECg6KMKai1RFJqnhUL1BTiXEGtAZ
	 Y06sCccK3g9XA==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arch@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/15] bugs/powerpc: Concatenate 'cond_str' with '__FILE__' in BUG_ENTRY(), to extend WARN_ON/BUG_ON output
Date: Thu, 15 May 2025 14:46:36 +0200
Message-ID: <20250515124644.2958810-8-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250515124644.2958810-1-mingo@kernel.org>
References: <20250515124644.2958810-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend WARN_ON and BUG_ON style output from:

  WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:8511 sched_init+0x20/0x410

to:

  WARNING: CPU: 0 PID: 0 at [idx < 0 && ptr] kernel/sched/core.c:8511 sched_init+0x20/0x410

Note that the output will be further reorganized later in this series.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: <linux-arch@vger.kernel.org>
---
 arch/powerpc/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index b5537ba176b5..171b6b2ba100 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -55,7 +55,7 @@
 	__asm__ __volatile__(				\
 		"1:	" insn "\n"			\
 		_EMIT_BUG_ENTRY				\
-		: : "i" (__FILE__), "i" (__LINE__),	\
+		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
 		  "i" (flags),				\
 		  "i" (sizeof(struct bug_entry)),	\
 		  ##__VA_ARGS__)
-- 
2.45.2


