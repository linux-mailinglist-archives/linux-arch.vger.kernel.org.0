Return-Path: <linux-arch+bounces-15619-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 085DFCEB8B3
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 09:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1EED302F815
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 08:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE5130BF59;
	Wed, 31 Dec 2025 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sEL39B7U"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0CB2F7455;
	Wed, 31 Dec 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767169957; cv=none; b=sV5jEza3gL9zmeOf521hBO8oo3QkiqhybZVFQIFueiqnN1GRp+MnC64JxzjQZ/OgLmlMa+t7f3AWEu6Gab/EQ9BsN7R7KL99Yo8XblzoCZqxb40kdu7mpTZkU8JD6KfdSuqTpqVI+hBrcepYhETtzLSoYe/1YUsA7u6oFfYJ1gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767169957; c=relaxed/simple;
	bh=D8CLdfYVhw03T7M683GXA2rJE7VSouolMexLSrJZi+s=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=ErqIM/AX9IspjWOBmwf+8up/L290nFH27CEbelS/IoVJf36W8c/JzxxI1VZNuVP+dikydBXbW6qHJereI8EFtsTJ4In2XzhwfGEt7J/taMz7QlGce9DYAvd+Kp3PYXJfsfeIUG0xrouPaQthIe5GlmMbuexKRbhFumMi8ned198=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sEL39B7U; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 1CE611D000C4;
	Wed, 31 Dec 2025 03:32:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 31 Dec 2025 03:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767169953; x=
	1767256353; bh=GTOExrkFdZz6ILdbiBTGhbMt+0HZHq9E17gN90wdwYg=; b=s
	EL39B7URD/7b1EY2rfw7KLprl3qc+VO5DMWLvcLsZZqT5MNNq13qeno7NsVGmscZ
	qDSKEeef15KEvl4EITkf0HiN6+8eMPFzZPtVqXhva5ucIm3cM7qpjdFcGuebuzA9
	vf2dEajXjppmhi1L5wIJC3JfN1pwAqPDkoJ+Y/ZJIB7nqs6oawi7gB813qLyrNd3
	IREBEjMpCaNnqgmraxgs0deUFuG5GQok6Kp/d6i0hEOQRF4LNbtLqJ44AVsN82jT
	b09jJijckWquJsL5S4jCRC1Cv+zxb5CzWFsEf89Z+ya/Camw6drDaTN7maz6UiwF
	sZVbJ4Gyu9O8EXqyt2l0A==
X-ME-Sender: <xms:od9UaWXyOr8S_b9ovWf9w65-1BEEb0vj-v_VvqJxzOPOxYA__fRcmg>
    <xme:od9UaR0rspE6vHj5TfVzXYAa6jwJzKbvLWaEnskd3oBvXg-xDSdQXZVGnReCJ7tt2
    4ol0iUDVQtPTdDog94-eqAhWfs1WutBNs-VcaU8xu0ilPcHihZLudg>
X-ME-Received: <xmr:od9UadNdsxrrgNvXWJi4uPK3TG2Y0y0O_puSXNeteFWuJXaze2Cl-HjmfrxORaruQrUW1zfv5UfwnVMuWo5Tz4Bq3gh82tCeNzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekvdegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefvvefkjghfhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    epheekudffheejvdeiveekleelgeffieduvdegleeuhfeuudegkeekheffkefggfehnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
    pdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehpvght
    vghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopegs
    ohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrh
    ihghhuohdrnhgvthdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:od9UaU1cAHr0mEBA8wWestIYj3apU0Pc2s4VjAfCv1TgHCox_u6U4g>
    <xmx:od9UaU3DXFXmZZLkbZMafxSb3FO7Pq4jJOoXTWo_81-xHXEx-5oQ5Q>
    <xmx:od9Uaa-k9Vx-Vw_JMdFmpDabS9CqIe5WtR_FtmJgDQn3fGr5ADQ3xw>
    <xmx:od9UaYY_9OKoRL20VNKszsgqDU9AnljuCJBuW7RyuXNmL0T3OSNgdw>
    <xmx:od9UaRy4SMsx5gy8z29mt3Uaf_58i-GxZtN4giSAEj3guA6LKPGd-JdK>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 03:32:32 -0500 (EST)
To: Andrew Morton <akpm@linux-foundation.org>,
    Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
    Boqun Feng <boqun.feng@gmail.com>,
    Gary Guo <gary@garyguo.net>,
    Mark Rutland <mark.rutland@arm.com>,
    linux-arch@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    Sasha Levin <sashal@kernel.org>,
    Thomas Gleixner <tglx@linutronix.de>,
    Ingo Molnar <mingo@redhat.com>,
    Borislav Petkov <bp@alien8.de>,
    Dave Hansen <dave.hansen@linux.intel.com>,
    x86@kernel.org,
    Ard Biesheuvel <ardb@kernel.org>,
    "H. Peter Anvin" <hpa@zytor.com>,
    linux-efi@vger.kernel.org
Message-ID: <f8cfe0d121be0849f5175495e73eafeeb85e1ad3.1767169542.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1767169542.git.fthain@linux-m68k.org>
References: <cover.1767169542.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v6 3/4] atomic: Add alignment check to instrumented atomic
 operations
Date: Wed, 31 Dec 2025 19:25:42 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

From: Peter Zijlstra <peterz@infradead.org>

Add a Kconfig option for debug builds which logs a warning when an
instrumented atomic operation takes place that's misaligned.
Some platforms don't trap for this.

[fthain: added __DISABLE_BUG_TABLE macro.]

Cc: Sasha Levin <sashal@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/lkml/20250901093600.GF4067720@noisy.programming.kicks-ass.net/
Link: https://lore.kernel.org/linux-next/df9fbd22-a648-ada4-fee0-68fe4325ff82@linux-m68k.org/
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Checkpatch.pl says...
ERROR: Missing Signed-off-by: line by nominal patch author 'Peter Ziljstra <peterz@infradead.org>'
---
Changed since v5:
 - Add new __DISABLE_BUG_TABLE macro to prevent a build failure on those
architectures which use atomics in pre-boot code like the EFI stub loader:

x86_64-linux-gnu-ld: error: unplaced orphan section `__bug_table' from `arch/x86/boot/compressed/sev-handle-vc.o'

Changed since v2:
 - Always check for natural alignment.
---
 arch/x86/boot/compressed/Makefile     |  1 +
 drivers/firmware/efi/libstub/Makefile |  1 +
 include/linux/instrumented.h          | 10 ++++++++++
 lib/Kconfig.debug                     | 10 ++++++++++
 4 files changed, 22 insertions(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 68f9d7a1683b..122967c80e48 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -42,6 +42,7 @@ KBUILD_CFLAGS += -Wno-microsoft-anon-tag
 endif
 KBUILD_CFLAGS += -Wno-pointer-sign
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
+KBUILD_CFLAGS += -D__DISABLE_BUG_TABLE
 KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 # Disable relocation relaxation in case the link is not PIE.
 KBUILD_CFLAGS += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 7d15a85d579f..ac3e7c64aedb 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -42,6 +42,7 @@ KBUILD_CFLAGS			:= $(subst $(CC_FLAGS_FTRACE),,$(cflags-y)) \
 				   -ffreestanding \
 				   -fno-stack-protector \
 				   $(call cc-option,-fno-addrsig) \
+				   -D__DISABLE_BUG_TABLE \
 				   -D__DISABLE_EXPORTS
 
 #
diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 711a1f0d1a73..bcd1113b55a1 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -7,6 +7,7 @@
 #ifndef _LINUX_INSTRUMENTED_H
 #define _LINUX_INSTRUMENTED_H
 
+#include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/kasan-checks.h>
 #include <linux/kcsan-checks.h>
@@ -67,6 +68,9 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
 {
 	kasan_check_read(v, size);
 	kcsan_check_atomic_read(v, size);
+#ifndef __DISABLE_BUG_TABLE
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
+#endif
 }
 
 /**
@@ -81,6 +85,9 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_write(v, size);
+#ifndef __DISABLE_BUG_TABLE
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
+#endif
 }
 
 /**
@@ -95,6 +102,9 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_read_write(v, size);
+#ifndef __DISABLE_BUG_TABLE
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
+#endif
 }
 
 /**
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939fda79..4b4d1445ef9c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1359,6 +1359,16 @@ config DEBUG_PREEMPT
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


