Return-Path: <linux-arch+bounces-13951-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B379BC3016
	for <lists+linux-arch@lfdr.de>; Wed, 08 Oct 2025 01:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D5014F706D
	for <lists+linux-arch@lfdr.de>; Tue,  7 Oct 2025 23:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529272609EE;
	Tue,  7 Oct 2025 23:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JHETawTw"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8884A224AF3;
	Tue,  7 Oct 2025 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881090; cv=none; b=Xmfu5rFXyyZJAVnEtetUbd0ah3hC6yKURZnahLVjW8/j36EzL5aGjnPKBTfjI9cnGXua1SGalhK6FqlR7YgjIvjgacWwXsi24lQZr7Wfl3I0qXZqTQ20/P9AabImCkXBZW97OW5w54jCjjnC5VEfL2jTks+rCNZb3xoj8Ab2fyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881090; c=relaxed/simple;
	bh=rNKE9ngzFrHTLxZ7ppLHn5u6VEyDnMzzG91YPYVvxwk=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=YGgrgYbrVKVWUcf8gB6DoLGRXtl31mSad3iPWUvfcnDeMPHPTfjJsB+RTpXp9H3EPs8BdYoXg0H+UhcCuig8idhwlcyjM7FBcfxIiJ7PWgElk32S/fsT2gb+w29ALf8I6pQUDUBmkusvDNy2+7ZF+bqAtoErqccGAOs3lG75Kqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JHETawTw; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7AFC37A0078;
	Tue,  7 Oct 2025 19:51:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 07 Oct 2025 19:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759881087; x=
	1759967487; bh=0+AdSH1sg/8lok7qtu/8oSLYuGUe0/34ymLa0qtNzl8=; b=J
	HETawTwt13D+PZ6+SnHOUkOkfOJixRcK2mEAmqGP9fpoGn44euJSdk/y6ZUdjCJa
	Zu2nqtmiu4dUjKnK4Gv0OMaOLlqKB+wYcw52F4noBx6gmiLeoWEEQtM4Z/icdxyP
	8AZjWUk9mf8kK+NxCH/bIHz4+Dgwe9yhN5q9jTGEzLbHlQLUnY1KJTjZre61HCF2
	ojSmMhMJPsvQM+63pKCrHlQxmNcGM6dF6TvkcY1jbI4DKTq+wj0wT7banc71UaDX
	6Zz7Lv22bvTQRnbPe/E7QGDoamgPSG2wGe16cMam/fCvmbZYIEHRMOmWpMBquu7H
	xvsmi84AS8IS673L98zyw==
X-ME-Sender: <xms:f6flaJvd7BrvdGXqVdvCLIj_CgzXm1_79r6xVFAZohn4mbAyjM7LDQ>
    <xme:f6flaOVvvPFSQlitVnYppi0-QVdOfyeEBGoVh_GKzbi8b2DKmTld5nXaO5yl4wgTd
    afAIPeQxDsVHu_DHl46P9fMUAt4h7OL0nxcMSGYT9QdDrKbzSmoDg>
X-ME-Received: <xmr:f6flaJx9qsZZaL_zdd4sPVviEkUtdyt3dcWVwFmRl1bF3LP0NCFArUR6N12M6bbrjTSrxZdwHx9bjoFoWMi506drQPkc6BBj_YI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkfgjfhfhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeevgffgtdfhhfefveeuudfgtdeugfeftedtveekieeggfduleetgeegueehgeffffen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeduuddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhp
    mheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghoqhhunh
    drfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhn
    vghtpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpth
    htoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhgthh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:f6flaFEOc5SyJhLVmqVkWcAcLBNa8f0_UthZVOAZjQdt6n6EgYOXrg>
    <xmx:f6flaOsX18xVBHMTErTqi9R7G7hBEQTJRYW5oG2l5t2ycyOC8ZJrZg>
    <xmx:f6flaFCOZIBezrdWTl8veOdG9OJm9Qw-tUeXtIRTkdUz5zH6RZENhg>
    <xmx:f6flaJAO99rV-WjwKcKT7kQEQfwZwZygLLhyeKlapVoGAiOXzZ55OQ>
    <xmx:f6flaA5W_ZUip7j3TxcHofm7zWfxJRP3-jNZLdX4AxXbnppvQv71x7sf>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 19:51:24 -0400 (EDT)
To: Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Boqun Feng <boqun.feng@gmail.com>,
    Jonathan Corbet <corbet@lwn.net>,
    Mark Rutland <mark.rutland@arm.com>,
    Arnd Bergmann <arnd@arndb.de>,
    linux-kernel@vger.kernel.org,
    linux-arch@vger.kernel.org,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    linux-m68k@vger.kernel.org
Message-ID: <d4ab82f5646f901b7c556c4cb8f8adf4096f0c50.1759875560.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1759875560.git.fthain@linux-m68k.org>
References: <cover.1759875560.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [RFC v3 5/5] atomic: Add option for weaker alignment check
Date: Wed, 08 Oct 2025 09:19:20 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Add a new Kconfig symbol to make CONFIG_DEBUG_ATOMIC more useful on
those architectures which do not align dynamic allocations to
8-byte boundaries. Without this, CONFIG_DEBUG_ATOMIC produces excessive
WARN splats.
---
 include/linux/instrumented.h | 14 +++++++++++---
 lib/Kconfig.debug            |  9 +++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 402a999a0d6b..3c9a570dbfa7 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -8,11 +8,13 @@
 #define _LINUX_INSTRUMENTED_H
 
 #include <linux/bug.h>
+#include <linux/cache.h>
 #include <linux/compiler.h>
 #include <linux/kasan-checks.h>
 #include <linux/kcsan-checks.h>
 #include <linux/kmsan-checks.h>
 #include <linux/types.h>
+#include <vdso/align.h>
 
 /**
  * instrument_read - instrument regular read access
@@ -68,7 +70,9 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
 {
 	kasan_check_read(v, size);
 	kcsan_check_atomic_read(v, size);
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
+	if (IS_ENABLED(CONFIG_DEBUG_ATOMIC))
+		WARN_ON_ONCE(v != PTR_ALIGN(v, IS_ENABLED(CONFIG_DEBUG_ATOMIC_LARGEST_ALIGN) ?
+					       __LARGEST_ALIGN : size));
 }
 
 /**
@@ -83,7 +87,9 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_write(v, size);
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
+	if (IS_ENABLED(CONFIG_DEBUG_ATOMIC))
+		WARN_ON_ONCE(v != PTR_ALIGN(v, IS_ENABLED(CONFIG_DEBUG_ATOMIC_LARGEST_ALIGN) ?
+					       __LARGEST_ALIGN : size));
 }
 
 /**
@@ -98,7 +104,9 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_read_write(v, size);
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
+	if (IS_ENABLED(CONFIG_DEBUG_ATOMIC))
+		WARN_ON_ONCE(v != PTR_ALIGN(v, IS_ENABLED(CONFIG_DEBUG_ATOMIC_LARGEST_ALIGN) ?
+					       __LARGEST_ALIGN : size));
 }
 
 /**
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d82626b7d6be..f81b8a9b9216 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1373,6 +1373,15 @@ config DEBUG_ATOMIC
 
 	  This option has potentially significant overhead.
 
+config DEBUG_ATOMIC_LARGEST_ALIGN
+	bool "Check alignment only up to __LARGEST_ALIGN"
+	depends on DEBUG_ATOMIC
+	help
+	  Say Y here if you require natural alignment of atomic accesses
+	  only up to long word boundaries. That is, char, short, int and long
+	  will be checked for natural alignment but anything larger checked
+	  only for alignment with a long word boundary.
+
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
 config LOCK_DEBUGGING_SUPPORT
-- 
2.49.1


