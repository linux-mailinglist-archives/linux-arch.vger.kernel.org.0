Return-Path: <linux-arch+bounces-4111-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5B08B91CA
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 01:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930812833B7
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 23:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB41A1635CD;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEEi0dJQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4B64F897;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604492; cv=none; b=Sz+/7jJNIe/mHXDX1hbUnbCC4xqvlhvy7MScKO3k9DUNOdj7Z54NNjs9TMW0/N9hNgCxIw4QOLrrOwj0qq8/45RfpJTPFqV3n/V4Lgnp5UOyZHCnfGQ33pl6ILzOY+k0hkJUJ/M18vzwJESwjq3U3J60IEyzc0XTZ2+XYnNAZlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604492; c=relaxed/simple;
	bh=Gwo0L9nG/Bxq+TZGLagGgn6iVboBxYsc87SIRn3872E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CA+N7shms4YPvVWXzZnrdaos/25MmElkKbjXoH+oo2891OiU72d/cC9tw/c8SLwY71Ky+BrUjwHTr8DTXEdGtGlZYVsbUUO4ToMtFqjepWHdkV1WJRb+ihR9YD6VPIY2xxZI/Csg8XAKkCguSkOLsKptVCsRlxdBGJ27OW0x1tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEEi0dJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B386C4AF14;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714604492;
	bh=Gwo0L9nG/Bxq+TZGLagGgn6iVboBxYsc87SIRn3872E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EEEi0dJQ9tPwkKw0Q/Yl3BJm0bph7/6npi8fKcU/c3JgibF0hgeVfxG7Vqd6YKurD
	 0bXE+xtjpvYV93H2i0LUpdMmVfAHGYYA+43Gp9ZrvrDroIyx1twkf5WiT3kOubyFVg
	 hpqoJkTno1QSUFG2KXAtVNyWR4pYS4aKHaQ724SH/BC6iQFsx+12V7RRHynhaNo8Zs
	 u7QXH7WmU/YXC3xtwWKvWVJgjqqw0BEAj9sSiIMtjoV2/IkIvhcnV3cW9T2Nqh7Bu9
	 MfYc+CV+7QXlwCHUxIn3gFQYuJTzaJj16v/2DF++DBcc0OEBcM8fdlGuv8bmgVmkC/
	 SUKm0WYK4A9GQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BEF95CE0808; Wed,  1 May 2024 16:01:31 -0700 (PDT)
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
Subject: [PATCH v2 cmpxchg 02/13] sparc32: make the first argument of __cmpxchg_u64() volatile u64 *
Date: Wed,  1 May 2024 16:01:19 -0700
Message-Id: <20240501230130.1111603-2-paulmck@kernel.org>
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

... to match all cmpxchg variants.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/sparc/include/asm/cmpxchg_32.h | 2 +-
 arch/sparc/lib/atomic32.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 2a05cb236480c..05d5f86a56dc2 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -63,7 +63,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 			(unsigned long)_n_, sizeof(*(ptr)));		\
 })
 
-u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new);
+u64 __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new);
 #define arch_cmpxchg64(ptr, old, new)	__cmpxchg_u64(ptr, old, new)
 
 #include <asm-generic/cmpxchg-local.h>
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index d90d756123d81..e15affbbb5238 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -173,7 +173,7 @@ u32 __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
 }
 EXPORT_SYMBOL(__cmpxchg_u32);
 
-u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new)
+u64 __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new)
 {
 	unsigned long flags;
 	u64 prev;
-- 
2.40.1


