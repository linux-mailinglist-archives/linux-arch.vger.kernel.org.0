Return-Path: <linux-arch+bounces-4110-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C618B91CD
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 01:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39666B21419
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 23:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66791635C7;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGvXB9Ll"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C47A1C68D;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604492; cv=none; b=pc6AKr5xzLygtfBPiaSHDtYTJ+vxvXLWEvseu3/naOBMnTj3J9tK/FAfQ8BEeXhO+/GrVGf0tD0/I69eAUitOJr6ceisxBW0w1IyEo0Qv4vZeaFOl8DprJAB0KeL5aSkuYQQ+FAdtPgEx48jxh53/zyFc1nFaBnP+PpMlsSHVq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604492; c=relaxed/simple;
	bh=c2cXyTpfqV8tv5AG0/sE+MGJrrEmGRkliM6KcM6nVj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O0HyerSL3EeXHSl8kfNLJjg18Um8xeDJkCHhiYZPfFUFpm2YZXJnopqqS1S5JvNWR/uNaXBumJhBNJGy9zT8BxVryLjFU5dVvnba29+aDFFefMjgqqi4tUt+Mkuu5OeButp/v2kMEyGJdqNWLv+CKy6PuIkHPe3pjCtY//MzDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGvXB9Ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAC4C113CC;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714604492;
	bh=c2cXyTpfqV8tv5AG0/sE+MGJrrEmGRkliM6KcM6nVj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGvXB9LlhqVYz9frifnxysqDrtE+jmWBR03s0B56jvhEG3Ymd7tVXjgkZAMxW6ivR
	 +Zp68VPpFb0ljMEp0FbMzXL6pG632LywY7u5Olj0HqJaj05HqTQp3/d6F0SBzKGlDw
	 tQqA8K4zfsUWBBJgGTXAjKQELAJq1Xrbxt66WKVOEe1G+vjbJfDh4Syqqv52/kuoT1
	 NhwUdtDaubhxyvyTFwoqK//sjsCB8EOz3PidkwlCzfhPgihJL/k4c65DvuQX9fpmO9
	 NG5Rfet6CiTDz4x0KKXHVtMw5FDKU2vVxDtjfQX3+Cl3XGLcDv6CMLbCtNRGgmmOdw
	 RI3p9EBhOq2Og==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C23BFCE1415; Wed,  1 May 2024 16:01:31 -0700 (PDT)
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
Subject: [PATCH v2 cmpxchg 03/13] sparc32: unify __cmpxchg_u{32,64}
Date: Wed,  1 May 2024 16:01:20 -0700
Message-Id: <20240501230130.1111603-3-paulmck@kernel.org>
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


