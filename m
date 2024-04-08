Return-Path: <linux-arch+bounces-3493-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F0789CB07
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 19:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21111C239BE
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 17:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5265C1448D8;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHynODyi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E641442F5;
	Mon,  8 Apr 2024 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598587; cv=none; b=HF5drZ3LJqAYVDJlbtdcu/E7pkkW74PB9aXeCdaTllOMyVlsVxmEtMISVWOfmIhdfv6w0bDzJN34ezNbosbLC+GrqXLGrXZ8Rkcc06uTs/Hm79kOd67glo3mxhrbKfjt2w9zn4O5kJ0B576FIHzZucWeB3xTREdJjPAoq7UsprU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598587; c=relaxed/simple;
	bh=xV0bjRNG69Gk9MLDp+p1hE+J2KXV1jWcp0coMhIa834=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vGJYckoS3MzrB+A6G7nUWaj+F02NeTPEpesL4YRCRjJKz3yLehkyEAxEidc6U7LULz34gr+GXlinxiQwnMHdSgdr44uPvOdsQ0EshkX9ddwIoAPel1vw7LEILX/lSHYga3wXh0p5cI5N9tb5qF2V7hoBZIRbwYhgQFpHk0oTTSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHynODyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D26C433A6;
	Mon,  8 Apr 2024 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712598586;
	bh=xV0bjRNG69Gk9MLDp+p1hE+J2KXV1jWcp0coMhIa834=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHynODyi86K0iz6CitTyqMyJyLOUHClUFN4tYtRr9OORmhm3UsY+YIyJhBBojQ0w2
	 gHlHLTEFJ+aLETIDK5/ZWSxCeNhsqrEgGzWWLuwCwyCY0z91Q+AcJCzX1uqgTlz17b
	 TRJnmS7XFmG5VZ6Eqclaqp5K2Msz3Duo3VRKIerFZ1CKenuBFnRqj9myEZUnb7d/Gh
	 9swwosCwgOr10TiWF1OD8sA3gft4cGvt/cD+ebznXVAhlnZn5RlOsOf9G5AKlJXk0p
	 VB7X4oUln+myzA2zq8L55NOv9c1txNGYMT0vt0rVHYbRvrmg/BQTkepZNoNJ4FJlQP
	 CL3rAirCHB4GA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4725ECE1E8D; Mon,  8 Apr 2024 10:49:46 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: elver@google.com,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	dianders@chromium.org,
	pmladek@suse.com,
	torvalds@linux-foundation.org,
	Arnd Bergmann <arnd@arndb.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH cmpxchg 05/14] parisc: __cmpxchg_u32(): lift conversion into the callers
Date: Mon,  8 Apr 2024 10:49:35 -0700
Message-Id: <20240408174944.907695-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
References: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
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


