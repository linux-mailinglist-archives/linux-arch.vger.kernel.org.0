Return-Path: <linux-arch+bounces-13571-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82B3B5641A
	for <lists+linux-arch@lfdr.de>; Sun, 14 Sep 2025 02:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC992A08C1
	for <lists+linux-arch@lfdr.de>; Sun, 14 Sep 2025 00:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E141E832A;
	Sun, 14 Sep 2025 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hnepr9Mj"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B773B1E520D;
	Sun, 14 Sep 2025 00:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757811581; cv=none; b=pCyXYsbtdY/xTKr6sI59wLGs15/7Sk1I5Cux8CIvvVPDHwm5hajUpumEuK6DBorGjwvnB8zVUspfICY5NrYkDeHIL3EjECGDOrkPed19zZIwe0uBe/wtVcPgOTFM9XCmRU9JDdZmvM2S9dV8B/dM52vv4yuVeB6d3JNQLx6g8B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757811581; c=relaxed/simple;
	bh=qTAWynOAjWSDh3uuShe8zI+vBGlDjsAZb/I/AJ5WPl8=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=PKZzSX72X36EZD5uc21TOGEyCS69/A75CpMjf+UOJjmShk5SvbTfOKiyiOZYXvQC9pse4NPAoElZaI0qqJ21lPaSapnV2WfphDDdYKtU2nnd5304Iu+g1y7bFxbbFln0NVL7aIXWWtOyPRbY3I3kcUCvQxijefeBHhPuyupbd1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hnepr9Mj; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6B1A81D00093;
	Sat, 13 Sep 2025 20:59:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 13 Sep 2025 20:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757811578; x=
	1757897978; bh=izLJPvfgu8hiylBnrHgZ4NtZIez7nQ5xOKyBKlBqlCY=; b=h
	nepr9Mj5VQCLH/bAMxokD2mipTdjHjCXb4mPH0GCiJn1BBlHks8uhNXt5weM29Jq
	a0thjOEnOpPWKb8yH7hAg7S10PAhU4McBaOD5EYsqRL5xMoiZtrfTpSF/BpNNQPN
	estK0Xf/w2FA5AMrNrMLiFaydLXW3oXwrEMoFTruA0oVvGV1DfeVE8tLiPfdEeQ4
	lT4R8JdotQd/r6gLjFIHDnB35FeUh4JyP17MSp6cD89cqYs0qXLQi+kUiIG/aZL0
	ElSHGkjqs94LqHUkbkbEs+XvWAaLoxqkzELzILn9XUWyLWV2sQ6i0hQzsXTzZGd+
	lc9wqtD5s1sDD2CnKBnHQ==
X-ME-Sender: <xms:ehPGaBz1ADFePX4aYf3BGM2f-3iB-wTVvlOLJXYR2HzzvU3X-QVF4A>
    <xme:ehPGaAegOsd8xI2MuEVE2wrsO_c2w_MlqCNR9FhGA1IruvnMaPpLomu6LYz5b1bEy
    fmdBVkgfrySngV7rlo>
X-ME-Received: <xmr:ehPGaODXYdXVpwFe3SdA7LJNcOwpuiHyVeGPT6I4bq8G1Wtx9_OgNjayCHoiUAFJOREH_Luz19E0k4Xttn2unFIr_7EphWSwCuM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeffeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefvvefkjghfhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    epheekudffheejvdeiveekleelgeffieduvdegleeuhfeuudegkeekheffkefggfehnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
    pdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    gvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhioh
    hnrdhorhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepmhgrrhhkrdhruh
    htlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdp
    rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ehPGaM5jbc1ozg6vUFQb60WIdGZDBZ4PXgBcgiMChqTxmABV1RdskQ>
    <xmx:ehPGaPfP1Jc5mJdE5GtHUul0OuJFDYGDkWrYZMxuItK8RlkMlpzs1w>
    <xmx:ehPGaKsMswhM3loS3_xoAyzlpnfQCsVhL00mDaeok2171HpvW01KXw>
    <xmx:ehPGaHnYQLQdONqaU2v1mpUIaSXAqnulj8uq5Cqc2XOlDrvghQ0EYg>
    <xmx:ehPGaDha6-qDDW1l7BDIUcil3xqzcldRjN2gbvS9bFSGpJgFOmr2piq->
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Sep 2025 20:59:34 -0400 (EDT)
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
Message-ID: <e5a38b0ccf2d37185964a69b6e8657c992966ff7.1757810729.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1757810729.git.fthain@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [RFC v2 3/3] atomic: Add alignment check to instrumented atomic
 operations
Date: Sun, 14 Sep 2025 10:45:29 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

From: Peter Zijlstra <peterz@infradead.org>

Add a Kconfig option for debug builds which logs a warning when an
instrumented atomic operation takes place at some location that isn't
a long word boundary. Some platforms don't trap for this.

Link: https://lore.kernel.org/lkml/20250901093600.GF4067720@noisy.programming.kicks-ass.net/
---
This patch differs slightly from Peter's code which checked for natural
alignment.
---
 include/linux/instrumented.h |  4 ++++
 lib/Kconfig.debug            | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 711a1f0d1a73..55f5685971a1 100644
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
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (sizeof(long) - 1)));
 }
 
 /**
@@ -81,6 +83,7 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_write(v, size);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (sizeof(long) - 1)));
 }
 
 /**
@@ -95,6 +98,7 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_read_write(v, size);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (sizeof(long) - 1)));
 }
 
 /**
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ebe33181b6e6..d82626b7d6be 100644
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


