Return-Path: <linux-arch+bounces-4114-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 318388B91CE
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 01:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A891C2146F
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 23:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02BE165FD6;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diW2GytF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64D6130A4E;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604492; cv=none; b=A4NyvUik1z4l7h9KzJ2ECQq8s52dnBpWL0dkGtZHNVJICEPT+M3luBwWAChfipJ8MY/ZyY70F6kuS8jDmNG03pJwBeLY0vOFhZrWJmYXrthW+WRPaerJ37+IYCHKXfFwkzDh7Ckz3/tgBp9wCMIc3SoZmNDcpvmMLzamFcNVjNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604492; c=relaxed/simple;
	bh=xV0bjRNG69Gk9MLDp+p1hE+J2KXV1jWcp0coMhIa834=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTSML5Z1UZUFFTO92/A6R7xtNJVVqiuuZujUkLVMfgv/GaocqjnhoJOkLKir+sllxxfWFtArw0VCmQ3ksHB8+z2YIXEydus2lKGBYgeW3miir/muOLWK5mrPmHUOfbBUZD6oRlgpZVTLJrvZ25dHAi12BAP2TSliVAUKyN6roMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diW2GytF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46977C4AF1C;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714604492;
	bh=xV0bjRNG69Gk9MLDp+p1hE+J2KXV1jWcp0coMhIa834=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=diW2GytFZI+FRAYk8CY838KC8736HkjCtvPMdrmixVTpOL/dv8LXFdB9+JaU0cG6D
	 ZnxeKzIdFLyN1sTmGKzEIO8Opojc5lXgbenCFMdwrk7cF+iYp2dJaZ5mXFbhHE02jQ
	 bzOapP/WI0B/5Rom61Ek45fK49+10lVoB8nlDglyQ9wJrs+FhlSGmGCkXlS2WquTl1
	 GMvjAGhokT09rZnHSim9bIrbSTUXmFRvaBzNJY3BxBDLuaLJ1fvthdx1emgzYVQZT3
	 ybfzp9EV8B50LfFa1uIkiFxhJboh6tRJCmJR+2z+yKc4dRuMgmCSEBcKwOU9ABVVM0
	 zS/wIOJagt2ew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C7F38CE220F; Wed,  1 May 2024 16:01:31 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: elver@google.com,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	dianders@chromium.org,
	pmladek@suse.com,
	arnd@arndb.de,
	torvalds@linux-foundation.org,
	kernel-team@meta.com,
	Al Viro <viro@zeniv.linux.org.uk>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 cmpxchg 05/13] parisc: __cmpxchg_u32(): lift conversion into the callers
Date: Wed,  1 May 2024 16:01:22 -0700
Message-Id: <20240501230130.1111603-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

__cmpxchg_u32() return value is unsigned int explicitly cast to
unsigned long.  Both callers are returns from functions that
return unsigned long; might as well have __cmpxchg_u32()
return that unsigned int (aka u32) and let the callers convert
implicitly.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/parisc/include/asm/cmpxchg.h | 3 +--
 arch/parisc/lib/bitops.c          | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
index c1d776bb16b4e..0924ebc576d28 100644
--- a/arch/parisc/include/asm/cmpxchg.h
+++ b/arch/parisc/include/asm/cmpxchg.h
@@ -57,8 +57,7 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
 extern void __cmpxchg_called_with_bad_pointer(void);
 
 /* __cmpxchg_u32/u64 defined in arch/parisc/lib/bitops.c */
-extern unsigned long __cmpxchg_u32(volatile unsigned int *m, unsigned int old,
-				   unsigned int new_);
+extern u32 __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
 extern u64 __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new_);
 extern u8 __cmpxchg_u8(volatile u8 *ptr, u8 old, u8 new_);
 
diff --git a/arch/parisc/lib/bitops.c b/arch/parisc/lib/bitops.c
index 36a3141990746..ae2231d921985 100644
--- a/arch/parisc/lib/bitops.c
+++ b/arch/parisc/lib/bitops.c
@@ -68,16 +68,16 @@ u64 notrace __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new)
 	return prev;
 }
 
-unsigned long notrace __cmpxchg_u32(volatile unsigned int *ptr, unsigned int old, unsigned int new)
+u32 notrace __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
 {
 	unsigned long flags;
-	unsigned int prev;
+	u32 prev;
 
 	_atomic_spin_lock_irqsave(ptr, flags);
 	if ((prev = *ptr) == old)
 		*ptr = new;
 	_atomic_spin_unlock_irqrestore(ptr, flags);
-	return (unsigned long)prev;
+	return prev;
 }
 
 u8 notrace __cmpxchg_u8(volatile u8 *ptr, u8 old, u8 new)
-- 
2.40.1


