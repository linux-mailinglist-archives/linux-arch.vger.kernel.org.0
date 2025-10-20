Return-Path: <linux-arch+bounces-14237-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56813BF3F15
	for <lists+linux-arch@lfdr.de>; Tue, 21 Oct 2025 00:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B5918C638A
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 22:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA9E2F28EB;
	Mon, 20 Oct 2025 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eWr514gx"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5692F39A4;
	Mon, 20 Oct 2025 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999804; cv=none; b=uLk0hVINuXXPmZcdyWhZC6peQSFJrAjj1g0bmXJLa0LfJigW5tVxc4LjoayXUOBJCXmUwlfFnbi6CeB4HRaE2L4yTSBTUTaJ9cgEjZU2ieLd9dFRaV7L1Y8MpjDlxDEMwFqhlQ6wYMIMsEnvNB0h8EojPBSDeZZiiqaYFKrhB9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999804; c=relaxed/simple;
	bh=yybUSf5T3g/3w85klnU1zuJcnxM9ZRoEL4oq6VF0u5w=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=IsbBhHGG7py5xJgaF5IIQ1/1RE1ZKKbUhk4istm8HPZfNOEgXpfznBJhw/n6y3drN3qjZy9Dt/gKarDnl+n3eiGWMQ2f8gK+vyRkFIpB+t2TN+Z5UbDgOI600S/Lfg6dPorut6GFN4GGm/Zdh2UYWM9PsZMOBYNrTGwCCeLZ2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eWr514gx; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D532A1D0013B;
	Mon, 20 Oct 2025 18:36:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 20 Oct 2025 18:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760999801; x=
	1761086201; bh=Of30O2Rz6y1OZ0rGOWsuDyxzWM+1+/UyDo323/R5FGA=; b=e
	Wr514gxs7XHhxnXDx33HM79f8FpGzy11zZr8o58/ddhcZi+bIsKL17ERx0z6W+Ok
	XSAC854j1ld8xfWEQlbJvu0/FTifGVo9hOKlT3D/zBSe4/6g8qJRMoL9c/7aWpau
	Miv+EtNzVoDRJ+4j4W2mkDtDpZCoWSyMdhhOZm7fQR/hqql+NVYtFp9wYKksH8oJ
	7hWjqZHAgNwbsEIJafBxX5J1fMQaD1i4GrYg5Rq0zcv33JcyIqYDhrW7TGekycx+
	YHlheC3Qm1p4cKcH98AoEqgw0pYpj5el+7HJnamR4uLI4Xfw1yviOVicXn6ZUWPZ
	ZOsy8wm/9YMA/1epwMB3g==
X-ME-Sender: <xms:ebn2aJqe3wCQztty0Eg7JO0cBdpNkaBUi1NWvfg6myVjEqNuUgWvNg>
    <xme:ebn2aBpbr-Lc7Qubd2DasScwikzAWyyRh-rmfb6chc0cCP3ydhRFkF0QhMUccAAi7
    agI-C3tfJFa6eoWNkcrLrboD8gI8QDD4QPGSyQJRMIvhVYXRIEQlw>
X-ME-Received: <xmr:ebn2aBCPOyzeLdxNoS7XgseyaSewb6ntphcd6mizRgq9q5AhR715HzR9FGS7c3d1zqDWAPb6YDEfKW-MHyeJGxoLwT0PWa6oSE4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkfgjfhfhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehkeduffehjedvieevkeelleegffeiuddvgeeluefhuedugeekkeehffekgffgheen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhr
    ghdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeifihhllheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohep
    sghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgvvghrtheslh
    hinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmheikehksehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ebn2aHtaFt3xcLClVGePvHw78UM2pz-tnMBVOLTuimkKvLnCNiafbw>
    <xmx:ebn2aILKrdSWiX7_kIY0kSGTk29cuFV50PgPoNkRnVWPfFiWgpHGYg>
    <xmx:ebn2aGaLQIADTMPb_fZ8HVXG-971zt9z7gM3IonV0_5ZlH69Pg8U2w>
    <xmx:ebn2aCBCD4YtGT9_aUIKsolfx3BJ3cIaVWbEC2TRztzgOnaNazmpPA>
    <xmx:ebn2aLLa9Rb_sgXBEtYgaSjLLmDM2o3mitZDR346egTg0hwtQdQVzkX6>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 18:36:38 -0400 (EDT)
To: Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Arnd Bergmann <arnd@arndb.de>,
    Boqun Feng <boqun.feng@gmail.com>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    linux-arch@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@vger.kernel.org,
    Mark Rutland <mark.rutland@arm.com>
Message-ID: <7943c7f0196171c918df671c68003e62b69c8509.1760999284.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1760999284.git.fthain@linux-m68k.org>
References: <cover.1760999284.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [RFC v4 4/5] atomic: Add alignment check to instrumented atomic
 operations
Date: Tue, 21 Oct 2025 09:28:04 +1100
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
---
Changed since v2:
 - Always check for natural alignment.
---
To make this useful on those architectures that don't naturally align
scalars (x86-32, m68k and sh come to mind), please also use
"[PATCH] atomic: skip alignment check for try_cmpxchg() old arg"
https://lore.kernel.org/all/20251006110740.468309-1-arnd@kernel.org/
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
index dc0e0c6ed075..1c7e30cdfe04 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1363,6 +1363,16 @@ config DEBUG_PREEMPT
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


