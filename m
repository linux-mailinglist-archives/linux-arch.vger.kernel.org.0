Return-Path: <linux-arch+bounces-15449-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC7BCC12A5
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 07:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 578C0305DCE1
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 06:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694733358C0;
	Tue, 16 Dec 2025 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y5zJYk80"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C384D2ED843;
	Tue, 16 Dec 2025 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765867151; cv=none; b=tYgB5NIhPzqTSh5SUQDJAct3LGgWjVAsQCC/VdS8JT5O8rKvi4pkIamfv6ceK7fvpLTCqTEUWOmeEpz2TBKWpnT7hAN4H0B+32QLyjrp4TGKcS2r3o9t0CVvofgnU62nqkNp/gNcGKuYqbVxz/dUDlURJ4365niWxzYr/eYhs50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765867151; c=relaxed/simple;
	bh=1cKuiAOB0DKxAQ63i2eZtsJMfsBV2PGAysuJSoeR598=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=ad8MddJbHmMNXqApWfc0EQnNai4NxpYggTPH3zTEXwl7wpD+Ho14VgG2eudN6tIq7L6dnPGD2C3apP7sJtF+OtehbiuFXKVAH6w9NYpHk+pP+qn5JS0r9YkbC6yZyLZDVxpDEcn047nX49eTnMBYne2F3rglgs9ZS0sZJ/c2XxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y5zJYk80; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 285C51D00105;
	Tue, 16 Dec 2025 01:38:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 16 Dec 2025 01:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765867138; x=
	1765953538; bh=Ob0pTTioFM66Lvq1IjZEPC6RBFduNH6Cz2/rvfNTnh8=; b=Y
	5zJYk80tcBwk+bmY0aD1m5vqj5mHwz5x0dqdK9pSzkFZHocfFuanzv2iuB1ojO7G
	/VDAuJHCUmusC+3ECQ/+r3NQ68ICwU8GCdQLhj3BtCfxL0CydZDAagXSAmd7V0Mw
	hadn1zUOkrMhqHUD8Kw6z5IUD6aD2EljzqKWgrqr6b7DfDvajUuGb3EDWVTIMrIp
	OQQ/x0J8gx9EVehzNm93Sqk+eFoYibHkL04c+IdswHqfIqGLHDJPnstXH3U4YjE4
	0Jl2r0fIfTIuskm5prR2/Nbzwz//JtBPKVTxVfjNHmq2ddwqhgSrs3nIPETsjLfo
	TcfjqoJyIUsB++Rbnp8Iw==
X-ME-Sender: <xms:gf5AaSzOLX8UBeg6ejAUZl5Fr4gEHULYRBC219TIAQ88YAYbORuPUQ>
    <xme:gf5AaUTITl-nrBH3Lwi_mMg2VU220sWZn7gUPs0Z9553SOjiww9G69xvzkNcyysCx
    2FbsnNdp8vCKFGM17uFgUG7ImJWWWuw7q7xNEN4yUlE-vSuU3LFdMzF>
X-ME-Received: <xmr:gf5AafLF6IZPhiQEKxWu80XcKD5obH2FI5VnL-kQFENdgKTRl36AIIcAP1G7isQmf3mGnbWbEaJJ8tXr32trlFGHzxO9rPgTw2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefvvefkjghfhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    epheekudffheejvdeiveekleelgeffieduvdegleeuhfeuudegkeekheffkefggfehnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
    pdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    gvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhioh
    hnrdhorhhgpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopegs
    ohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrh
    ihghhuohdrnhgvthdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:gf5AabXEfawKaJVd5GbOrhxwI85hY5iPm3iLCrKgtFPATUjgUs4c1g>
    <xmx:gf5AaTQhnkbLFrDnVKj7uEDtfAQqOf1zfEwdIY3xjcYtW6XsqRVXpA>
    <xmx:gf5AaTBhkTlf2bq8hAZHoif7YLlsL8hjnzFGetaPPEvPZcseVQQngA>
    <xmx:gf5AaSLFxU9A4o8oVCCEGmoAJQeCflkotkQsffDf1Rf42u-6Vklr7Q>
    <xmx:gv5AaR2qraDNOAUcMQ6qg53auK0u1UCMpBYPOKUXZ9bduWzNCGofjDlx>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 01:38:55 -0500 (EST)
To: Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Arnd Bergmann <arnd@arndb.de>,
    Boqun Feng <boqun.feng@gmail.com>,
    Gary Guo <gary@garyguo.net>,
    Mark Rutland <mark.rutland@arm.com>,
    linux-arch@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org
Message-ID: <0c18fd08ef19497768070783da28086e01d11a00.1765866665.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1765866665.git.fthain@linux-m68k.org>
References: <cover.1765866665.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v5 3/4] atomic: Add alignment check to instrumented atomic
 operations
Date: Tue, 16 Dec 2025 17:31:05 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

From: Peter Zijlstra <peterz@infradead.org>

Add a Kconfig option for debug builds which logs a warning when an
instrumented atomic operation takes place that's misaligned.
Some platforms don't trap for this.

Link: https://lore.kernel.org/lkml/20250901093600.GF4067720@noisy.programming.kicks-ass.net/
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v2:
 - Always check for natural alignment.
---
Checkpatch.pl says...
ERROR: Missing Signed-off-by: line by nominal patch author 'Peter Zijlstra <peterz@infradead.org>'
---
 include/linux/instrumented.h |  4 ++++
 lib/Kconfig.debug            | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 711a1f0d1a73..402a999a0d6b 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -7,6 +7,7 @@
 #ifndef _LINUX_INSTRUMENTED_H
 #define _LINUX_INSTRUMENTED_H
 
+#include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/kasan-checks.h>
 #include <linux/kcsan-checks.h>
@@ -67,6 +68,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
 {
 	kasan_check_read(v, size);
 	kcsan_check_atomic_read(v, size);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
 }
 
 /**
@@ -81,6 +83,7 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_write(v, size);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
 }
 
 /**
@@ -95,6 +98,7 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_read_write(v, size);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
 }
 
 /**
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 713cc94caa02..d080d23d9a87 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1356,6 +1356,16 @@ config DEBUG_PREEMPT
 	  depending on workload as it triggers debugging routines for each
 	  this_cpu operation. It should only be used for debugging purposes.
 
+config DEBUG_ATOMIC
+	bool "Debug atomic variables"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here then the kernel will add a runtime alignment check
+	  to atomic accesses. Useful for architectures that do not have trap on
+	  mis-aligned access.
+
+	  This option has potentially significant overhead.
+
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
 config LOCK_DEBUGGING_SUPPORT
-- 
2.49.1


