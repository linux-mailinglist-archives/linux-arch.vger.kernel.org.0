Return-Path: <linux-arch+bounces-11952-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E438CAB86F1
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 14:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83F7A04372
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3D82BCF46;
	Thu, 15 May 2025 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HexE5Eej"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F22BCF43;
	Thu, 15 May 2025 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313235; cv=none; b=fQZRbaV6mg2j86AWzV2Jdb83AxYN7N6bVragP8uVO0VNyI9vUcZzhTTs3QSdoNaR/4XzOgJPHjzOXwtwmXO7FH6MDTo4ros3hV6u+fmYTPIBdXWJy4sOa129E8c+rR+tdiMpqTyBAN9TGnYGgamsT7DSIuT7wfM5haqbTZp+cys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313235; c=relaxed/simple;
	bh=molGG3aPYi74hz9WVuXlbE1iJFE0MWmpVUKVIij8Ws4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYEs94xTlsFloRprm2lhMJ6NuJSfulRURkUzYSc6fumbjjNwEb/flbupXRMcBsYsWWUSSqmDqE8C4bjlWEKQW21MU19vAos7aq992S+qhLPdbDKmuNXcgFEvLjfKinvFdxARh/2opt95X/SCiaZQ9V9CuNkL1eO3m9JYsExtNeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HexE5Eej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBECAC4CEEB;
	Thu, 15 May 2025 12:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313235;
	bh=molGG3aPYi74hz9WVuXlbE1iJFE0MWmpVUKVIij8Ws4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HexE5EejAosqid8JNqxH9pMJdNWnmOwh5C25ih8nPZirXfRTH5rFM+vh2twGdKLdL
	 aDgn+QSpoPhRyZ3LaqK6Tj8HsarJT4LqlVL+Oq0WjZliiZT9BPsAsEfILBYKepZcIL
	 09XZndnuz/sB8iaazKI/kGQ2avI6mjZY1hxWaXYTLYc4XNrbXJEL6mqcVF52vZFjKR
	 sPFrqFqYyd1+Mjzr7KXVUb3hnX3tbDoLW4wreJaqvsFQh1W/WlbX4/Zqy9h+ZXLwDB
	 5mIOJ7SDVdKWEKzUF4jPk+Wk1aTbuPU/VW5co2u75mTDNhwAP0mKnHYp3V/rdlUrbs
	 nbbM4NX7VNCeA==
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
Subject: [PATCH 11/15] bugs/riscv: Pass in 'cond_str' to __BUG_FLAGS()
Date: Thu, 15 May 2025 14:46:40 +0200
Message-ID: <20250515124644.2958810-12-mingo@kernel.org>
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

Pass in the condition string from __WARN_FLAGS() to __BUG_FLAGS(),
but don't use it yet.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org
Cc: <linux-arch@vger.kernel.org>
---
 arch/riscv/include/asm/bug.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index b22ee4d2c882..feaf456d465b 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -50,7 +50,7 @@ typedef u32 bug_insn_t;
 #endif
 
 #ifdef CONFIG_GENERIC_BUG
-#define __BUG_FLAGS(flags)					\
+#define __BUG_FLAGS(cond_str, flags)				\
 do {								\
 	__asm__ __volatile__ (					\
 		"1:\n\t"					\
@@ -66,17 +66,17 @@ do {								\
 		  "i" (sizeof(struct bug_entry)));              \
 } while (0)
 #else /* CONFIG_GENERIC_BUG */
-#define __BUG_FLAGS(flags) do {					\
+#define __BUG_FLAGS(cond_str, flags) do {			\
 	__asm__ __volatile__ ("ebreak\n");			\
 } while (0)
 #endif /* CONFIG_GENERIC_BUG */
 
 #define BUG() do {						\
-	__BUG_FLAGS(0);						\
+	__BUG_FLAGS("", 0);					\
 	unreachable();						\
 } while (0)
 
-#define __WARN_FLAGS(cond_str, flags) __BUG_FLAGS(BUGFLAG_WARNING|(flags))
+#define __WARN_FLAGS(cond_str, flags) __BUG_FLAGS(cond_str, BUGFLAG_WARNING|(flags))
 
 #define HAVE_ARCH_BUG
 
-- 
2.45.2


