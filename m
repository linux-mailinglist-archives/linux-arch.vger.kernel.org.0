Return-Path: <linux-arch+bounces-3494-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F9189CB08
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 19:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459081C23A03
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594A01448DA;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeYHevdH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288261442F6;
	Mon,  8 Apr 2024 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598587; cv=none; b=JyWXVZN0ZWQDO1P7L7neLbKICLrmBYFzi/h1CVyAM/0WQ3Np8OtNj9++z4huwa0JEu+AjtxHBwmASnvBuYNJmjuHLaP11pSOPA5BgK7fjioDRHvRDO8zTLzi5X31RDrFxJTgpNBU5ETGsWyVIeEqw47ZDen3G1jcnpJjvkjO7DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598587; c=relaxed/simple;
	bh=1eMVNwHdcY4Pw0fbrq6XWtA7kyaxHrAZ9QJnM9orhXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BKuUFGuIe11FC3PZRkA9byi1nVHJ7wXZvdUrkuvHqDBWAZH7L/XMUm3iFXWq5hrkk/KI7MfzBNtU3QN4nZyDFg7B24mTLYdf0trqWxLTedt9wxQPRfc+X+4/1CdhzHvBTM5Lr+uGYAOWGti7t0tmsmK9Rj1rXMjnw/RiXOlwsbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeYHevdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E5EC433B1;
	Mon,  8 Apr 2024 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712598586;
	bh=1eMVNwHdcY4Pw0fbrq6XWtA7kyaxHrAZ9QJnM9orhXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HeYHevdHb8JNXD8d+3/qaLhicozT5IGtyN9Qef0TyneWBFJ22cJV4JHfQoFh0QRcD
	 oe+SVtnLcXDJYNdqIIUqmkjLW6TZVO7OjG2QAbgZ9lEplrJwWTxYxl3fM2+I9Kc4Ax
	 K9LjmkGODfvg7Rla6D68L6uHrQOGk+fYzub6X0Wz2xwjPUpNJXCkmxi1YYTLYbDOxp
	 UJMLgod3VW82wczSxpVQjO1Rr09JLyqPrRYRYcUYveWf1THGvUJ7umoBr1M5NXNV1o
	 Nl0cVZCv9BjbP5Sp3o9riilb5X+JwdyvbeeBni+Bo10yUOVg9MZjpGw/sCGNHYHWeO
	 5bLbVpDfqwWDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 444CACE1979; Mon,  8 Apr 2024 10:49:46 -0700 (PDT)
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
Subject: [PATCH cmpxchg 04/14] sparc32: add __cmpxchg_u{8,16}() and teach __cmpxchg() to handle those sizes
Date: Mon,  8 Apr 2024 10:49:34 -0700
Message-Id: <20240408174944.907695-4-paulmck@kernel.org>
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

trivial now

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/sparc/include/asm/cmpxchg_32.h | 16 +++++++---------
 arch/sparc/lib/atomic32.c           |  4 ++++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 05d5f86a56dc2..8c1a3ca34eeb7 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -38,21 +38,19 @@ static __always_inline unsigned long __arch_xchg(unsigned long x, __volatile__ v
 
 /* bug catcher for when unsupported size is used - won't link */
 void __cmpxchg_called_with_bad_pointer(void);
-/* we only need to support cmpxchg of a u32 on sparc */
+u8 __cmpxchg_u8(volatile u8 *m, u8 old, u8 new_);
+u16 __cmpxchg_u16(volatile u16 *m, u16 old, u16 new_);
 u32 __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
 
 /* don't worry...optimizer will get rid of most of this */
 static inline unsigned long
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 {
-	switch (size) {
-	case 4:
-		return __cmpxchg_u32(ptr, old, new_);
-	default:
-		__cmpxchg_called_with_bad_pointer();
-		break;
-	}
-	return old;
+	return
+		size == 1 ? __cmpxchg_u8(ptr, old, new_) :
+		size == 2 ? __cmpxchg_u16(ptr, old, new_) :
+		size == 4 ? __cmpxchg_u32(ptr, old, new_) :
+			(__cmpxchg_called_with_bad_pointer(), old);
 }
 
 #define arch_cmpxchg(ptr, o, n)						\
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index 0d215a772428e..8ae880ebf07aa 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -173,8 +173,12 @@ EXPORT_SYMBOL(sp32___change_bit);
 		return prev;					\
 	}
 
+CMPXCHG(u8)
+CMPXCHG(u16)
 CMPXCHG(u32)
 CMPXCHG(u64)
+EXPORT_SYMBOL(__cmpxchg_u8);
+EXPORT_SYMBOL(__cmpxchg_u16);
 EXPORT_SYMBOL(__cmpxchg_u32);
 EXPORT_SYMBOL(__cmpxchg_u64);
 
-- 
2.40.1


