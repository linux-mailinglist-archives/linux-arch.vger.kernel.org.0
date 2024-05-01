Return-Path: <linux-arch+bounces-4112-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4037A8B91CB
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 01:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC021C21544
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 23:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB5F1635D0;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJCwT8uw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4F31304A1;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604492; cv=none; b=QCVsMqMYgzZoAy1XLqX423AfXKl0TJ3NGl4HbS7siBsoOez1F7e7UmIIy3Ndezvldp3l0GxNLnGN6TKQDISdiLXgjAdsC9L7hTnqun+eyIr9mNyFqPh25B6mFZMCvdXvFQtAhMKpRHgLJOGYg9r0IipRRjf8wN8fsUIJBor2loc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604492; c=relaxed/simple;
	bh=JT6TJe0r0m31NAees1xlMQgr2WRm/aZdIYw3Usfm6aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W3pVfZ4nHShvTCj8PCrkxEbYdZcViEuaQWMzu69kVeFTJi1QI9pN7kFw3ZTVkOmzX2hL/GFq7klglSZzJ3cmvDFuiYCVZ3aw3H72K1RpDf8Q+VAuxp9SOqFsAIplG6dZyucEmTaMEMzLnLW6B4RXFw1JkVAPVQi+BfUzmVVZvXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJCwT8uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259E6C072AA;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714604492;
	bh=JT6TJe0r0m31NAees1xlMQgr2WRm/aZdIYw3Usfm6aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vJCwT8uwqAS1XjmZUiYIgd500wozQllVLdC9W43l4kcQae9gLVbKtFxFBKwXdPGdn
	 0BcRIa+RY0Pcg4CA0XaiwjTsrx9+4gQlEMq8jR7zEIpL/f/4KTXISZyXfyZNbjJGni
	 D3q82CcGF7LEmHqJFEfvjTaweIDFXQhU7k7TnZtBNnFpGOeA9EcdVfX3KVGXzBYTL7
	 DMQuAZV67wslIYmRc6fuTAfPlsfInAjnVtOzRzGtXDRJ1fjmDhgs8DFl+KbaNMTegF
	 51DiPZvNyOuglY4d+1eo5rhMC1sEEjeTwMRstdwz0C0t2c9+yHIbNKlVcXgPe/goB/
	 rvvDVSt3w1MJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BD5CECE1073; Wed,  1 May 2024 16:01:31 -0700 (PDT)
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
Subject: [PATCH v2 cmpxchg 01/13] sparc32: make __cmpxchg_u32() return u32
Date: Wed,  1 May 2024 16:01:18 -0700
Message-Id: <20240501230130.1111603-1-paulmck@kernel.org>
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


