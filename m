Return-Path: <linux-arch+bounces-4119-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE7A8B91D3
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 01:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01EC2834B6
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 23:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CBC168B13;
	Wed,  1 May 2024 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2KtLMkK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B7C168AED;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604493; cv=none; b=qtuTBG1iu0v7bKQqNSVLx5w7OJiTRAmapONZJphNeRgCVEXojjPXT2YoF36VcYv/eVUpngE0lCS63J3SjWWP+w/GciMrmFjxCPjzpSR5rUet+qyxmuL8DNnKaieVHnB2rQouYZuqA5ASLcenOqqxZmCZjzqYuXxGikehQxMsv90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604493; c=relaxed/simple;
	bh=ehpYlEI/7ddbuIzdM9fBMt5Xa6+QYchqcgxnWBcCufs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=habGulP+3HxPtGnzer1nYPSbHyqF+UCLATlvpcnUg8NjPOLnrP8GOaT6vNhrNQA2n8ypk1nbmDEvB0zApF1X++QHJxlBaaE4CaoIEYsMqNYhJjQkC3c/yEHRdknAZqji8AKF8JAQmnIvyVteRaIztLplR/HjeOYDQCntZcrmaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2KtLMkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821FCC4AF4D;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714604492;
	bh=ehpYlEI/7ddbuIzdM9fBMt5Xa6+QYchqcgxnWBcCufs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2KtLMkKSwpi3V6yfk2x80G1xvO37BHZJpU4pzwPsYJATGnBPLIK8Xwd4b90+VtgV
	 Ucs1mN317R0+ZCd9f/u4jUetGp/Yd2epdeLdPWml5VZBzdcanpn9WOMqyd7Ebs32OS
	 QnKGSGZm+NesLnXvtgTox7Ls2fuqw/J8MvyqvRv8QCYsGRb80qxt87r3S1pGY594sI
	 VSNYFavCYTAPhQ/MFhQMy3PwpM+J57RJJT1W+UitNzQoASnfCkNyLGqbtnbgI7ETT0
	 +e9hG6sgvzTQxx4AZtKrMZPBpMwqI11zbGEDcA6VGKqoOnMzCXk0wbp1ZxPW+vFn50
	 R2KepK/5DKD8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CA9A5CE226C; Wed,  1 May 2024 16:01:31 -0700 (PDT)
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
Subject: [PATCH v2 cmpxchg 06/13] parisc: unify implementations of __cmpxchg_u{8,32,64}
Date: Wed,  1 May 2024 16:01:23 -0700
Message-Id: <20240501230130.1111603-6-paulmck@kernel.org>
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


