Return-Path: <linux-arch+bounces-11947-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D93AB86DE
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 14:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55F517CD4E
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 12:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC4D29CB59;
	Thu, 15 May 2025 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvGjfJ3+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CCC29CB56;
	Thu, 15 May 2025 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313221; cv=none; b=Pcf+7onA78aQhN2c1uTz0kNB1CzN+0HQd21YmOZcxRcSQbYxAinCgGRo5Dp/bi4XSSn3pII2OJW2WjdeyMQKj88v6ECDXJ3F0vF3wks9OM+gyfMEnFrYEaz/YsjOHJJBpW9Ibelvf3L+/HN1Tv6YagUmFVuNnW/IlLHxxF9ZsrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313221; c=relaxed/simple;
	bh=lbZJml6REyBa5Wqf6whljObeSVlpAH/8U8yaPU9LXBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbvzVm7kDbHq8048lFBFV1HNjpATdfeWLmkaQLbnM6Yp4WCBEH+XxIvLrfNxZWzQZl5cvrmNPBzUnRMPZaOJClZRkj3dfdGms01GOOouKs9gblRQm4Q24i0IrkyWSo8pkYZXbZTQXssoWKJo6ouEqu5vP5yAF+W2v84hiobCNYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvGjfJ3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090E0C4CEE7;
	Thu, 15 May 2025 12:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313221;
	bh=lbZJml6REyBa5Wqf6whljObeSVlpAH/8U8yaPU9LXBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lvGjfJ3+EMr+uThtbSsCLWplsyajkQuighLyuqIHxjI/QTGyU5o7NouA+rn+vY1zw
	 0L0KEvo0UrWNGFIuG45GV2iNuIxDfKoSMSP1cE4VPu+eSQkh4VMiaCTEvBORAAyVLb
	 vd2mi3FCKISGyZHf43JJO/bWvm8JS9pxrQk1AyK1m0N7QoOHcDgjeikARN0j1UvM0V
	 FZG/2msPM1vzG8ods1SSdxYDFr6vgbdY79IdMvaJo//+BL3+Bzhr7CWj+XJuNT2a18
	 yJkykgWgUD+uhBf9ThEu209dO3XCx1VP49sgM7mUhdDiTfNqswLXC7Jloq3TViA84p
	 J0cPuGFlvvzTA==
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
Subject: [PATCH 06/15] bugs/powerpc: Pass in 'cond_str' to BUG_ENTRY()
Date: Thu, 15 May 2025 14:46:35 +0200
Message-ID: <20250515124644.2958810-7-mingo@kernel.org>
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

Pass in the condition string from __WARN_FLAGS(), WARN_ON()
and BUG_ON(), but don't use it yet.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: <linux-arch@vger.kernel.org>
---
 arch/powerpc/include/asm/bug.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 34d39ec79720..b5537ba176b5 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -51,7 +51,7 @@
 	".previous\n"
 #endif
 
-#define BUG_ENTRY(insn, flags, ...)			\
+#define BUG_ENTRY(cond_str, insn, flags, ...)		\
 	__asm__ __volatile__(				\
 		"1:	" insn "\n"			\
 		_EMIT_BUG_ENTRY				\
@@ -67,12 +67,12 @@
  */
 
 #define BUG() do {						\
-	BUG_ENTRY("twi 31, 0, 0", 0);				\
+	BUG_ENTRY("", "twi 31, 0, 0", 0);			\
 	unreachable();						\
 } while (0)
 #define HAVE_ARCH_BUG
 
-#define __WARN_FLAGS(cond_str, flags) BUG_ENTRY("twi 31, 0, 0", BUGFLAG_WARNING | (flags))
+#define __WARN_FLAGS(cond_str, flags) BUG_ENTRY(cond_str, "twi 31, 0, 0", BUGFLAG_WARNING | (flags))
 
 #ifdef CONFIG_PPC64
 #define BUG_ON(x) do {						\
@@ -80,7 +80,7 @@
 		if (x)						\
 			BUG();					\
 	} else {						\
-		BUG_ENTRY(PPC_TLNEI " %4, 0", 0, "r" ((__force long)(x)));	\
+		BUG_ENTRY(#x, PPC_TLNEI " %4, 0", 0, "r" ((__force long)(x)));	\
 	}							\
 } while (0)
 
@@ -90,7 +90,7 @@
 		if (__ret_warn_on)				\
 			__WARN();				\
 	} else {						\
-		BUG_ENTRY(PPC_TLNEI " %4, 0",			\
+		BUG_ENTRY(#x, PPC_TLNEI " %4, 0",			\
 			  BUGFLAG_WARNING | BUGFLAG_TAINT(TAINT_WARN),	\
 			  "r" (__ret_warn_on));	\
 	}							\
-- 
2.45.2


