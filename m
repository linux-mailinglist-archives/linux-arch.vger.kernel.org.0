Return-Path: <linux-arch+bounces-15620-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC10FCEB8AA
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 09:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3D313009ECA
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 08:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CA7310768;
	Wed, 31 Dec 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wuoV1y42"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92A279908;
	Wed, 31 Dec 2025 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767169968; cv=none; b=FRL7TeldJ96G0L251Ftl7eOUx1O7c1m55iMakoBih5jcjIwCex9hMT3FqPWpRv8MTyPvWhZmP1/mDBMdKi16SmX1l/DE1FAG8YGSOAhIY3YuRdaOoT1Q3aftaLb5qC5XPecKnK9VpNkQZO8e6QJLSapoNwV9OeOEA+1+8TXt6Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767169968; c=relaxed/simple;
	bh=U4VqbO4P2f3x2GMgPUIPlhERgz/ilB6phqhTbRHe7js=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=Hh4NKBcDXfALErXSq6tO1aunwWmn6MPvbVpic4qadsYSpOvviLN9An8ZJBOXD1+4vvWztHZy8IXSW8XbPtcjkdbXQrs15I+Pfps5K7APlQ4qsnp24s+BOqEBv3k9DDLRyyxix1UjEUSVTyPnG73gIdYGvsRTgD47Cbn5Vj3Qd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wuoV1y42; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C8A127A00C1;
	Wed, 31 Dec 2025 03:32:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 31 Dec 2025 03:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767169965; x=
	1767256365; bh=VIxsHF1gcnZiebTLYVRqozMlqAy59qKl00/sv4CyMFA=; b=w
	uoV1y42E7uXm6v0ZwAGLXYvJtKnAfYK9b5NUPlcXO/6lHsCfbDhhKijzkeHbpeZa
	oQn3KHNq5cm2oWQJ9JyyoLjYVtxmtc7CsOjN1v/F66zVc78Wc9RclYIjNsLE3otu
	URJDouQzhwY2uMCWtq1l8x9tqxl8kbUo7cVxJG8q5zVQXKhXo0YRgBQC2XFqVgQA
	oeBdfeqtPrSsbjbJejEipogBWik4WgS/Xe1yei+mLXlWmubZWIaq0KyZlHXPuSfH
	b70k4lmOjENX+mMp8J/f9PmWgEszOosKbMF9xqQQLMw0OmjOyAsKh247yuhHg+i5
	gkmfRrxbT+cmSmzZ480Pw==
X-ME-Sender: <xms:rd9UaVr34KJon3_IAmk_cRpxfiaWHtafyalExYbnN_IUATfdNa0pLg>
    <xme:rd9Uadqk_mOX_jWiLTGvm4nCQ2oTa_pVu_fgFmAPbeUvd5d_tPOsuXT7TpTq15tGN
    W99yhx7fU-1cRdwtGuoOfmKyZ8iuPIeqALlwUHozLmC45wqo2Xo0yFw>
X-ME-Received: <xmr:rd9UadB1QPRmm8CGcUnwyIgWTXFG2LrVeTk0qKhIZal_hLira1UnVTWf-HXSqsmaFErnU03kPjH2X-Nc-KLBPA4dcfX_b_PIlSY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekvdegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefvvefkjghfhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    epvefggfdthffhfeevuedugfdtuefgfeettdevkeeigefgudelteeggeeuheegffffnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrih
    hnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhioh
    hnrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhr
    tghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhhnugesrg
    hrnhgusgdruggvpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepmhgrrh
    hkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrtghh
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rd9UaTsafacOY59Jee01hMTskkxs5zKeijv3TH-Agx7ESvyvFW3qow>
    <xmx:rd9UaULvs5dzHZCKQC7FRMGG2PKSMzPD06PwKhNnmcOleZyQYYvxMA>
    <xmx:rd9UaSax4m-KIQxWGGBqWcnwcbtC7sEyg9Bn6AzFWLKfRu0glhkAIA>
    <xmx:rd9UaeDUA4kP3HxiYemPJaJ_PGgLR3_oUyA4JwxfbzqWRg0orLhQLA>
    <xmx:rd9UaUMVtWE7ox4BB3AmL_SzzrPEELp2-PP0hog6cqiQa2ifA6_iD3l0>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 03:32:43 -0500 (EST)
To: Andrew Morton <akpm@linux-foundation.org>,
    Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
    Boqun Feng <boqun.feng@gmail.com>,
    Gary Guo <gary@garyguo.net>,
    Mark Rutland <mark.rutland@arm.com>,
    linux-arch@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org
Message-ID: <0c8ef95ea5e9a949a28412a3c791b2167592ae80.1767169542.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1767169542.git.fthain@linux-m68k.org>
References: <cover.1767169542.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v6 4/4] atomic: Add option for weaker alignment check
Date: Wed, 31 Dec 2025 19:25:42 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Add a new Kconfig symbol to make CONFIG_DEBUG_ATOMIC more useful on
those architectures which do not align dynamic allocations to 8-byte
boundaries. Without this, CONFIG_DEBUG_ATOMIC produces excessive
WARN splats.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v5:
 - Rebased.

Changed since v3:
 - Dropped #include <linux/cache.h> to avoid a build failure on arm64.
 - Rewrote Kconfig help text to better describe preferred alignment.
 - Refactored to avoid line-wrapping and duplication.
---
 include/linux/instrumented.h | 25 ++++++++++++++++---------
 lib/Kconfig.debug            |  8 ++++++++
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index bcd1113b55a1..e8983eb8a888 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -56,6 +56,19 @@ static __always_inline void instrument_read_write(const volatile void *v, size_t
 	kcsan_check_read_write(v, size);
 }
 
+static __always_inline void instrument_atomic_check_alignment(const volatile void *v, size_t size)
+{
+#ifndef __DISABLE_BUG_TABLE
+	if (IS_ENABLED(CONFIG_DEBUG_ATOMIC)) {
+		unsigned int mask = size - 1;
+
+		if (IS_ENABLED(CONFIG_DEBUG_ATOMIC_LARGEST_ALIGN))
+			mask &= sizeof(struct { long x; } __aligned_largest) - 1;
+		WARN_ON_ONCE((unsigned long)v & mask);
+	}
+#endif
+}
+
 /**
  * instrument_atomic_read - instrument atomic read access
  * @v: address of access
@@ -68,9 +81,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
 {
 	kasan_check_read(v, size);
 	kcsan_check_atomic_read(v, size);
-#ifndef __DISABLE_BUG_TABLE
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
-#endif
+	instrument_atomic_check_alignment(v, size);
 }
 
 /**
@@ -85,9 +96,7 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_write(v, size);
-#ifndef __DISABLE_BUG_TABLE
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
-#endif
+	instrument_atomic_check_alignment(v, size);
 }
 
 /**
@@ -102,9 +111,7 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_read_write(v, size);
-#ifndef __DISABLE_BUG_TABLE
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
-#endif
+	instrument_atomic_check_alignment(v, size);
 }
 
 /**
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4b4d1445ef9c..977a2c9163a2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1369,6 +1369,14 @@ config DEBUG_ATOMIC
 
 	  This option has potentially significant overhead.
 
+config DEBUG_ATOMIC_LARGEST_ALIGN
+	bool "Check alignment only up to __aligned_largest"
+	depends on DEBUG_ATOMIC
+	help
+	  If you say Y here then the check for natural alignment of
+	  atomic accesses will be constrained to the compiler's largest
+	  alignment for scalar types.
+
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
 config LOCK_DEBUGGING_SUPPORT
-- 
2.49.1


