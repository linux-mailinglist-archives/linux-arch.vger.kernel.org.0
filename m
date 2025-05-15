Return-Path: <linux-arch+bounces-11953-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C20EFAB86F0
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 14:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B647C1BC31FA
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 12:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2952BCF6A;
	Thu, 15 May 2025 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3Oo7c4a"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF72BCF67;
	Thu, 15 May 2025 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313238; cv=none; b=OqyR6QRMHMl7gT1aPa9oXgqLPUfzG9u1/PAIWYP8z0TPaa1RRV+/JuXwdjFYi66IVQc2wNYW5boryZBYikE43E4siQkPPyXFn71VV/f2DvNElYn5M34JinoKGnkh1Z7CK2ugkWmCRRPH3n7/hMYwN+P3eaRvMB6XjYNoWFcZORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313238; c=relaxed/simple;
	bh=9LwOHpGDLFZKgszWtNvO5DQHvwl986zoPmxZXPECuAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFHMFr/pKunYR7diqi3xctKEWarrxupoJ1OZ7Xq6STnutVgI+DoS38AHIhZv1Svj/KyhexVqDBbio8OUXVtIJesjALQzqzT8EwR4BXDnOYRaQrjatGiINSRZdd7EWNXgpDNulKJkktk5fbjo5EJnabayDY2Ylx6yWsfHSYiTuiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3Oo7c4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF63C4CEEB;
	Thu, 15 May 2025 12:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313237;
	bh=9LwOHpGDLFZKgszWtNvO5DQHvwl986zoPmxZXPECuAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H3Oo7c4aQqjCA0KblghIzrcJ/6KL1ZnahcRyERc/zXDuFT2ljlqfEEv/ldVmgTY9E
	 r0HEhNxXv2ElHClBjIhqubLRhaDl7I6Vne0bHOe/0f7cLAMKycdBs971+Ksujwczia
	 DiqHS5fnebXHIZmD6Moq+Pq7QJnuD1/XWecHt+ztdaNW/FIdLp5UBPiIs+sZUcy6Dd
	 BHezXDc+vNyWMYIfULQ6rZ6rswutj7DDWc7Wq0NyDwG6SVmlqsIZ2JacvuCYlM74v9
	 PuH/LmG8BzA5IKvcdaSTtvPatnlsWY8Wxg6h6XXso8YetINcAY8U8Xl70vleN61gf8
	 vwXAw0KFqzPeQ==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arch@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org
Subject: [PATCH 12/15] bugs/riscv: Concatenate 'cond_str' with '__FILE__' in __BUG_FLAGS(), to extend WARN_ON/BUG_ON output
Date: Thu, 15 May 2025 14:46:41 +0200
Message-ID: <20250515124644.2958810-13-mingo@kernel.org>
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
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org
Cc: <linux-arch@vger.kernel.org>
---
 arch/riscv/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index feaf456d465b..da9b8e83934d 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -61,7 +61,7 @@ do {								\
 			".org 2b + %3\n\t"                      \
 			".popsection"				\
 		:						\
-		: "i" (__FILE__), "i" (__LINE__),		\
+		: "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
 		  "i" (flags),					\
 		  "i" (sizeof(struct bug_entry)));              \
 } while (0)
-- 
2.45.2


