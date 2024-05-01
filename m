Return-Path: <linux-arch+bounces-4115-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3AE8B91CF
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 01:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82901F21E92
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 23:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A417168B09;
	Wed,  1 May 2024 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3zDz6zP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26951649A8;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604492; cv=none; b=qxJTEJhG7GFP9V0OfxhxPUaC2tdzf1dIyKwyvmGeGGLsrXxgPxa7l1euDku7YNyumttmvOttcCswS5F+YfS7Hkd44WhZOgHzbH2GSa+G39R0kr31t/wVfjJtA4Qs1arA+ufOpnfxYGzgwe5hv870iZkQO93N1Bx9dOZ1G7z7vWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604492; c=relaxed/simple;
	bh=1iPZOptm0sNwEG3zVn5V4DRrsb9XL24MUs8zOVTokRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WFm4rzQfmQG6AewAEbk1OHpbdxjTMaah3B1MJA54jmR97T25CnZLxcp8B9EWd6azZOBInFc0ttI0kTGBW6oh/Gzh1pudqcuzGGlh4A3fGxd+7hsfwBHsIb2kY/e0PnhRSRBm/L7fMq21Z21kRTkGEGPNgW3a+WMsMm1SBrFKoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3zDz6zP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D4DC4AF50;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714604492;
	bh=1iPZOptm0sNwEG3zVn5V4DRrsb9XL24MUs8zOVTokRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n3zDz6zPl0EBBQxLNdvQIX+Eby1w+zwffsIfLg6U+ij5N/QmU1XQwiXK8mzdUoCPR
	 hXkYKuVJ877tCotbA3/oUlbW+zQcSkLnLU9tB2pVqDkfMKuG/XpEk8j4+UswKbWXkz
	 Gh7m+q6FrzsmMeIHvB92ic0vQLlY19MMyFrUbthn4kHdFyKmUkuRZiKysTmvy4E6ex
	 MEuLgxJ+FWey566gz16YatvbKvrpCW7XB+vl3xqEltWtUC9ZLHjLASvEpg0D9aYwLl
	 WpKcCSOaSqtrfjWs/VtmOiZXEkDaeV5yW9tXEVLlWvGiS4oepBkg4BPr6IbtEwrqKX
	 iRVW7BMQR2lBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D06A6CE2279; Wed,  1 May 2024 16:01:31 -0700 (PDT)
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
Subject: [PATCH v2 cmpxchg 08/13] parisc: add u16 support to cmpxchg()
Date: Wed,  1 May 2024 16:01:25 -0700
Message-Id: <20240501230130.1111603-8-paulmck@kernel.org>
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

Add (and export) __cmpxchg_u16(), teach __cmpxchg() to use it.

And get rid of manual truncation down to u8, etc. in there - the
only reason for those is to avoid bogus warnings about constant
truncation from sparse, and those are easy to avoid by turning
that switch into conditional expression.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/parisc/include/asm/cmpxchg.h | 19 +++++++++----------
 arch/parisc/kernel/parisc_ksyms.c |  1 +
 arch/parisc/lib/bitops.c          |  1 +
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
index 0924ebc576d28..bf0a0f1189eb2 100644
--- a/arch/parisc/include/asm/cmpxchg.h
+++ b/arch/parisc/include/asm/cmpxchg.h
@@ -56,25 +56,24 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
 /* bug catcher for when unsupported size is used - won't link */
 extern void __cmpxchg_called_with_bad_pointer(void);
 
-/* __cmpxchg_u32/u64 defined in arch/parisc/lib/bitops.c */
+/* __cmpxchg_u... defined in arch/parisc/lib/bitops.c */
+extern u8 __cmpxchg_u8(volatile u8 *ptr, u8 old, u8 new_);
+extern u16 __cmpxchg_u16(volatile u16 *ptr, u16 old, u16 new_);
 extern u32 __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
 extern u64 __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new_);
-extern u8 __cmpxchg_u8(volatile u8 *ptr, u8 old, u8 new_);
 
 /* don't worry...optimizer will get rid of most of this */
 static inline unsigned long
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 {
-	switch (size) {
+	return
 #ifdef CONFIG_64BIT
-	case 8: return __cmpxchg_u64((u64 *)ptr, old, new_);
+		size == 8 ? __cmpxchg_u64(ptr, old, new_) :
 #endif
-	case 4: return __cmpxchg_u32((unsigned int *)ptr,
-				     (unsigned int)old, (unsigned int)new_);
-	case 1: return __cmpxchg_u8((u8 *)ptr, old & 0xff, new_ & 0xff);
-	}
-	__cmpxchg_called_with_bad_pointer();
-	return old;
+		size == 4 ? __cmpxchg_u32(ptr, old, new_) :
+		size == 2 ? __cmpxchg_u16(ptr, old, new_) :
+		size == 1 ? __cmpxchg_u8(ptr, old, new_) :
+			(__cmpxchg_called_with_bad_pointer(), old);
 }
 
 #define arch_cmpxchg(ptr, o, n)						 \
diff --git a/arch/parisc/kernel/parisc_ksyms.c b/arch/parisc/kernel/parisc_ksyms.c
index dcf61cbd31470..c1587aa35beb6 100644
--- a/arch/parisc/kernel/parisc_ksyms.c
+++ b/arch/parisc/kernel/parisc_ksyms.c
@@ -23,6 +23,7 @@ EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(__xchg8);
 EXPORT_SYMBOL(__xchg32);
 EXPORT_SYMBOL(__cmpxchg_u8);
+EXPORT_SYMBOL(__cmpxchg_u16);
 EXPORT_SYMBOL(__cmpxchg_u32);
 EXPORT_SYMBOL(__cmpxchg_u64);
 #ifdef CONFIG_SMP
diff --git a/arch/parisc/lib/bitops.c b/arch/parisc/lib/bitops.c
index cae30a3eb6d9b..9df8100506427 100644
--- a/arch/parisc/lib/bitops.c
+++ b/arch/parisc/lib/bitops.c
@@ -71,4 +71,5 @@ unsigned long notrace __xchg8(char x, volatile char *ptr)
 
 CMPXCHG(u64)
 CMPXCHG(u32)
+CMPXCHG(u16)
 CMPXCHG(u8)
-- 
2.40.1


