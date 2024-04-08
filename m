Return-Path: <linux-arch+bounces-3489-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 808C289CB02
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 19:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0761B283D1
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 17:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8E9143C7B;
	Mon,  8 Apr 2024 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkDaCYAs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C524B8662A;
	Mon,  8 Apr 2024 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598586; cv=none; b=YlTXkV1D3XVOcbzDq3FLZBr9+UZ0J1Ncdaez6QouZvNExsRjISvxBAfY5s5SJeLQzyKmSMXQWeRe1LkrFijq74oiGARGRWhWZ2/duFAUZLsAVPG0+QBmT+3/I2pJ+MEfeqt+guXCqMyu5F7BshdpSLqPRk0PbXnvvN+hKFYiL1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598586; c=relaxed/simple;
	bh=c2cXyTpfqV8tv5AG0/sE+MGJrrEmGRkliM6KcM6nVj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AEr++b6yvvmh21GcWdg5Eib5gRpogvBOUYv842MIpA5IG5nSKmcWdhNH32oDE5t9oUtIE2nq88lKyvyY86xTRkEnQMOGRAObeQDKtGtV4Bg7qiwxEwUOeo7A7MhoSTVtIczwcM1TzAP3XI0KIcO0UtJAOJsr4zjraDhMROooBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkDaCYAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B31DC43394;
	Mon,  8 Apr 2024 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712598586;
	bh=c2cXyTpfqV8tv5AG0/sE+MGJrrEmGRkliM6KcM6nVj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pkDaCYAs8wLBAmNJrQPXv0CPsOdpVGkdbWveLaEfw1DCONWIadMw4soW1dhYpyu94
	 Fdnlow2GF5HBAOWrscn4a3d48e6Df1PgZASM6kmDIH/NTP9D6dGKvJi8+Ez1zIqO8t
	 qGS9UyZYitPRSyzVY/qDb61ftb1KhNpVZHDdS6C4Pv+TD8hO7fMyrO1ED+gxNTk0fB
	 X+b7tRdoLdz3ubZ1PyfPI1w/hxtjxi5MKUsuJogRQPqXgZnbJEK6dkoAQxikoxAoNk
	 HwQ/eRmDx6HqLJmZX4XRDGNqZGfScEnjz3dVkET7J8Sl24WpKn7kgJo4LM11uzmy8j
	 3fsbrcPuREMqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 417E2CE13F0; Mon,  8 Apr 2024 10:49:46 -0700 (PDT)
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
Subject: [PATCH cmpxchg 03/14] sparc32: unify __cmpxchg_u{32,64}
Date: Mon,  8 Apr 2024 10:49:33 -0700
Message-Id: <20240408174944.907695-3-paulmck@kernel.org>
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

Add a macro that expands to one of those when given u32 or u64
as an argument - atomic32.c has a lot of similar stuff already.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/sparc/lib/atomic32.c | 41 +++++++++++++++------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index e15affbbb5238..0d215a772428e 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -159,32 +159,23 @@ unsigned long sp32___change_bit(unsigned long *addr, unsigned long mask)
 }
 EXPORT_SYMBOL(sp32___change_bit);
 
-u32 __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
-{
-	unsigned long flags;
-	u32 prev;
-
-	spin_lock_irqsave(ATOMIC_HASH(ptr), flags);
-	if ((prev = *ptr) == old)
-		*ptr = new;
-	spin_unlock_irqrestore(ATOMIC_HASH(ptr), flags);
-
-	return prev;
-}
+#define CMPXCHG(T)						\
+	T __cmpxchg_##T(volatile T *ptr, T old, T new)		\
+	{							\
+		unsigned long flags;				\
+		T prev;						\
+								\
+		spin_lock_irqsave(ATOMIC_HASH(ptr), flags);	\
+		if ((prev = *ptr) == old)			\
+			*ptr = new;				\
+		spin_unlock_irqrestore(ATOMIC_HASH(ptr), flags);\
+								\
+		return prev;					\
+	}
+
+CMPXCHG(u32)
+CMPXCHG(u64)
 EXPORT_SYMBOL(__cmpxchg_u32);
-
-u64 __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new)
-{
-	unsigned long flags;
-	u64 prev;
-
-	spin_lock_irqsave(ATOMIC_HASH(ptr), flags);
-	if ((prev = *ptr) == old)
-		*ptr = new;
-	spin_unlock_irqrestore(ATOMIC_HASH(ptr), flags);
-
-	return prev;
-}
 EXPORT_SYMBOL(__cmpxchg_u64);
 
 unsigned long __xchg_u32(volatile u32 *ptr, u32 new)
-- 
2.40.1


