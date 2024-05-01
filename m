Return-Path: <linux-arch+bounces-4113-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4466A8B91CC
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 01:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048BC2833DE
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 23:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDCE165FBA;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOCq4831"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65131311AF;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604492; cv=none; b=AGaaf7GVNsylR8V7G6XGHc8aH/bPlic6uGeFoeUDUmgKUd69vbAqV1bMkwHdxe4K4tUz9PK49Msu9INwXSTKB0HGuexi/2qaSn9fX99a2GOonMQJzpHOkHPBb2oLAh8AZeWMaLmZwta+VmNXVGVoOAGvtWmBNCLNYKjdbeqXccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604492; c=relaxed/simple;
	bh=1eMVNwHdcY4Pw0fbrq6XWtA7kyaxHrAZ9QJnM9orhXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abVhbpS4X9HeCwsF1U9Tje6cjyv+YM3JzFOqMzpPrrFnh+EWJX9+lnuZr+VTpv07VyDsbA5u8DLoHhbOAaAiu9KsnRXPADsLP2gyHbfTi7kCOvOpDPbXVp3X+pzPUcddFzumYrM2By83Lg30XqsUgTjoQB4s71Yw34u9m3Z9J98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOCq4831; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43539C4AF1A;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714604492;
	bh=1eMVNwHdcY4Pw0fbrq6XWtA7kyaxHrAZ9QJnM9orhXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOCq48315zRPrdn1r25G/IMDaQzgd0easvBHNTxqNBDfhGlmbsJ9UxFy5y1b3HL9U
	 HvSZVQHcLlFVA0CzChIcKrwP+ITv6sRLIYTBgpWdXAb4ONejc4fWbOaKmpz7cXDAJt
	 2fXdLNZwu4Px9MQYRwkuBPiJcqynJWHcn3GUR+Cyf5t572bfAGGIPxAAvZTjJwVSZp
	 B45IgUsdi79yniaLQ1loLvUftAUiCPAcuTPQ7gnUy2JpdJY1K20SP8p/3dGyFxfRjl
	 aVgwo0tuKQ3Dnm8h64piBeE/ODHpIslauoHwyROCMo+dpOfz2htLaoijr9/ijtRdW9
	 9pl0BvHvvFnuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C5295CE1A05; Wed,  1 May 2024 16:01:31 -0700 (PDT)
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
Subject: [PATCH v2 cmpxchg 04/13] sparc32: add __cmpxchg_u{8,16}() and teach __cmpxchg() to handle those sizes
Date: Wed,  1 May 2024 16:01:21 -0700
Message-Id: <20240501230130.1111603-4-paulmck@kernel.org>
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


