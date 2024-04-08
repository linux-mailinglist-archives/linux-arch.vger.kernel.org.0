Return-Path: <linux-arch+bounces-3492-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B02A89CB05
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 19:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E8F288C18
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 17:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D14C1448D2;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMkplKrG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A5A1442F4;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598587; cv=none; b=j0gHxmXaqK9JW71WgUVjNINOY2cCdjBAHfOU8uoC/hbq4NINLh8aGvAFqn3xkzLq9HFJ89BWZxNnRVeQ0phK9EDT4wywnw8LT6KAJB4dHH2J8qeHXrry2m8RWt6w3+aMVwPXoKaSX12bC4qFJBtWjfGueJti0D/xSxgYpwSxnr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598587; c=relaxed/simple;
	bh=ehpYlEI/7ddbuIzdM9fBMt5Xa6+QYchqcgxnWBcCufs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFAXiLBLt7AL8NO6uvpQ/ZuEw/d1NZMZBfKT8ibYYWNgtfl/wTaeJ6uP9sg0KxXgwd/SkMXD9GZjma8ifLWURs2qCHk/AaZZ6FIilK9o62ahxX55BG9GBB+w3+mYqAXJ9lD+2wsOADEojN7r2Y2+whe33+/9Qer0QDLMhAT2fE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMkplKrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3A0C43141;
	Mon,  8 Apr 2024 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712598587;
	bh=ehpYlEI/7ddbuIzdM9fBMt5Xa6+QYchqcgxnWBcCufs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KMkplKrGYFAtzogNbXrfO5h2hdRTKK2H1oDTPZK3PtZpII2Eut8dHtbmuX+0L30lo
	 yeWI9cdO+h9UMGwnPuD7g1EjVZxbgIBlnoUC/HSB7WjeziMyA2TzOxb7tuZGvtiDp3
	 VWdbTUekftlFq1IE8g4sz0PoLMrOHiyjwzl42bpahqg/ao536zBSTpO9YQu+BtUbg4
	 0qN+M4hOC6d+M2VtXjUvLrPr7+pqd3NDASqs750SMUTZc27Qrrm3e5l5B4HXcenVoX
	 x2fhiZQYipVqbaM0YIUY8R1MFK0CaejI8s1ciP13QayFQDEMp/Eewj3yUB6xzuQJPD
	 DAmVdPVDWgRQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4A1BCCE1F7A; Mon,  8 Apr 2024 10:49:46 -0700 (PDT)
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
Subject: [PATCH cmpxchg 06/14] parisc: unify implementations of __cmpxchg_u{8,32,64}
Date: Mon,  8 Apr 2024 10:49:36 -0700
Message-Id: <20240408174944.907695-6-paulmck@kernel.org>
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

identical except for type name involved

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/parisc/lib/bitops.c | 51 +++++++++++++---------------------------
 1 file changed, 16 insertions(+), 35 deletions(-)

diff --git a/arch/parisc/lib/bitops.c b/arch/parisc/lib/bitops.c
index ae2231d921985..cae30a3eb6d9b 100644
--- a/arch/parisc/lib/bitops.c
+++ b/arch/parisc/lib/bitops.c
@@ -56,38 +56,19 @@ unsigned long notrace __xchg8(char x, volatile char *ptr)
 }
 
 
-u64 notrace __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new)
-{
-	unsigned long flags;
-	u64 prev;
-
-	_atomic_spin_lock_irqsave(ptr, flags);
-	if ((prev = *ptr) == old)
-		*ptr = new;
-	_atomic_spin_unlock_irqrestore(ptr, flags);
-	return prev;
-}
-
-u32 notrace __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
-{
-	unsigned long flags;
-	u32 prev;
-
-	_atomic_spin_lock_irqsave(ptr, flags);
-	if ((prev = *ptr) == old)
-		*ptr = new;
-	_atomic_spin_unlock_irqrestore(ptr, flags);
-	return prev;
-}
-
-u8 notrace __cmpxchg_u8(volatile u8 *ptr, u8 old, u8 new)
-{
-	unsigned long flags;
-	u8 prev;
-
-	_atomic_spin_lock_irqsave(ptr, flags);
-	if ((prev = *ptr) == old)
-		*ptr = new;
-	_atomic_spin_unlock_irqrestore(ptr, flags);
-	return prev;
-}
+#define CMPXCHG(T)						\
+	T notrace __cmpxchg_##T(volatile T *ptr, T old, T new)	\
+	{							\
+		unsigned long flags;				\
+		T prev;						\
+								\
+		_atomic_spin_lock_irqsave(ptr, flags);		\
+		if ((prev = *ptr) == old)			\
+			*ptr = new;				\
+		_atomic_spin_unlock_irqrestore(ptr, flags);	\
+		return prev;					\
+	}
+
+CMPXCHG(u64)
+CMPXCHG(u32)
+CMPXCHG(u8)
-- 
2.40.1


