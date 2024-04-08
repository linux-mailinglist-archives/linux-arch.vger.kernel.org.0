Return-Path: <linux-arch+bounces-3491-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3F589CB03
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 19:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12511C2397D
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 17:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3C11442F7;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1lREVaT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAE8143C7A;
	Mon,  8 Apr 2024 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598587; cv=none; b=hPH7TfklIF8akJf67WmqxBdJt7Ihcf9ER/IN+s1/5QB9JOSxSSW9amocviae/X3bXgarFDlzb8AtgyTOIz9xmff+2QWzw0LwGR6Gx80nV4iBQKb+VFaWcZ/wPOAPrMLCAt79Gm5c+eoyHul11wqcx/l+qa2XB1ms/R0h9risTEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598587; c=relaxed/simple;
	bh=JT6TJe0r0m31NAees1xlMQgr2WRm/aZdIYw3Usfm6aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TiX2KCnvEBwbkLqxicxhA0+YTHWm9EAN0Nxkw4tVF4fUTE0ynKglL9WT3QxITkdvTSqolyB64MupjNTP3oWq+KyDQ71MeqE3MaZj6sA4klQygyAJFPfoWLFyZ/q333npluCr+rqouMoWwBkdzFKnhSG0qyQ+CQFsEMQlduA42VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1lREVaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96328C433F1;
	Mon,  8 Apr 2024 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712598586;
	bh=JT6TJe0r0m31NAees1xlMQgr2WRm/aZdIYw3Usfm6aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1lREVaTZHll7dOU9qG/m5WXusqmIbBf2zm6UHd98tytWLhw+BODrC/EN9ol2i0L2
	 YQygqNR9MO4n+Shs3SgcC1ztL31NRXXPg/V2EGD9VPwJRkOvfqyw/7iTbV7MeIjfk4
	 XpIJoyjEXE3wC/lVF0wN/a8Mwf8jkMEGLRgxYRL8X3OdPqrkHzjRhKAptvqd/BOMla
	 0e8JJIszEeP55jnKe2gJ0ouAcVE+HAzfA4voTGiBStb8arnPUjpdhHJbLKSsWJ7KL3
	 lw8q4vonJ7/GWEGRAInIW12Hq+7IOk6gB2mZ5o823raAZwajTdkp2xtX9X+Z0SL9Zl
	 fedx0oQo+JzQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3B891CE126C; Mon,  8 Apr 2024 10:49:46 -0700 (PDT)
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
Subject: [PATCH cmpxchg 01/14] sparc32: make __cmpxchg_u32() return u32
Date: Mon,  8 Apr 2024 10:49:31 -0700
Message-Id: <20240408174944.907695-1-paulmck@kernel.org>
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

Conversion between u32 and unsigned long is tautological there,
and the only use of return value is to return it from
__cmpxchg() (which return unsigned long).

Get rid of explicit casts in __cmpxchg_u32() call, while we are
at it - normal conversions for arguments will do just fine.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/sparc/include/asm/cmpxchg_32.h | 4 ++--
 arch/sparc/lib/atomic32.c           | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index d0af82c240b73..2a05cb236480c 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -39,7 +39,7 @@ static __always_inline unsigned long __arch_xchg(unsigned long x, __volatile__ v
 /* bug catcher for when unsupported size is used - won't link */
 void __cmpxchg_called_with_bad_pointer(void);
 /* we only need to support cmpxchg of a u32 on sparc */
-unsigned long __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
+u32 __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
 
 /* don't worry...optimizer will get rid of most of this */
 static inline unsigned long
@@ -47,7 +47,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 {
 	switch (size) {
 	case 4:
-		return __cmpxchg_u32((u32 *)ptr, (u32)old, (u32)new_);
+		return __cmpxchg_u32(ptr, old, new_);
 	default:
 		__cmpxchg_called_with_bad_pointer();
 		break;
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index cf80d1ae352be..d90d756123d81 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -159,7 +159,7 @@ unsigned long sp32___change_bit(unsigned long *addr, unsigned long mask)
 }
 EXPORT_SYMBOL(sp32___change_bit);
 
-unsigned long __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
+u32 __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
 {
 	unsigned long flags;
 	u32 prev;
@@ -169,7 +169,7 @@ unsigned long __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
 		*ptr = new;
 	spin_unlock_irqrestore(ATOMIC_HASH(ptr), flags);
 
-	return (unsigned long)prev;
+	return prev;
 }
 EXPORT_SYMBOL(__cmpxchg_u32);
 
-- 
2.40.1


