Return-Path: <linux-arch+bounces-15760-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D863DD16B95
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 06:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA29A304F2CC
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 05:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D8334B19F;
	Tue, 13 Jan 2026 05:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pYIfNDkv"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127E535CB69;
	Tue, 13 Jan 2026 05:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768282716; cv=none; b=AT8+L31amNodj5ir78DnYCPVK/KSmJ8aQI6RvZ5fnVexYDEblMWyj7LbJTYFFVGklRSiQYfCplW9ek5W5SkPJnxYktBwnqEcQgGlL3b2jjS8Dy6hBYna62WpaZyLL5uUjlRrX7kOw1lDc8o06KIPpz/O8RrSGpIwyYYGeuC/OJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768282716; c=relaxed/simple;
	bh=bZKri+q8JzKy6ytJBb/Ncm9BqY+ao0ZKXtsoGhyWbEU=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=iJmoOikh3JpsFDWSbEbmjvpWisBJuEmtYOcFcl76ZiBB1aSkx1CpdeRnQwwD6HLjoi1vD0XbNN6Ls3FQ28lrdeFHAOdw/Bgly8hXybHdl86RgMNPR/b6yg1BtKeDHjgKusZsz8QuMo2ga2pmrKTeZ6fEWex+HJWM0t1GhxIdUEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pYIfNDkv; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 175B51D000E0;
	Tue, 13 Jan 2026 00:38:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 13 Jan 2026 00:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768282713; x=
	1768369113; bh=jiBMJymXYYttEEG2SfWequihow3tSncHan9khHjXFzU=; b=p
	YIfNDkvSxwFB6PTTFMTN+zdBumshQl9Xl8MQ212eVNGTeD+Kg8VP85Hila8UsKy2
	/W3y3zAS99sEhVVl2Djw0V5rg1EQgv9oBUuqsWTbGemSJA7rQTWJDh2eEwneInNf
	Eu2NuJRCP6xg5vZFgFvA2zUdMe5XqdEXt7SglroconqEnRlZzYS6aWuWirWyCQf9
	ZAL/94jAl0doRDsjNouG361zR79zBAZMQMaUzxBHCK7bScUKIw+ksANBpLaTdq4L
	MvKUpxr0gS3+34ZK2ZWuhATvt3JgN0ZtQpKrxW/6JbOCsEzpWnco3zuK9kOETztM
	WyZPtUhYTWhuWlnDxPIuw==
X-ME-Sender: <xms:WdplacAl8kZAKOZQo7uWHRnFJioCkJCFk5-0061O4PMKQjByoKdNrg>
    <xme:WdplaSo1-skfe4TugQNsruxFwq4AH4yy828FZ24ecXJnaIpWIvKZfWp-I4EnaP8Q5
    DYUBERzP3_bmm3BBqtnbfZAEAZkUASQIxWqkEy5CmxyDaz47gLl8Q>
X-ME-Received: <xmr:WdplackdSYOzaiHdy3R0uGePZq1mN1iRYNhoHp-C99CV7BowwKCAdP7YttJ8F8RtTzsG0bxC2mWkPd2HCRxczgGeGxDhJWTrK-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkfgjfhfhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehkeduffehjedvieevkeelleegffeiuddvgeeluefhuedugeekkeehffekgffgheen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhr
    ghdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    grkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepphgv
    thgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohep
    sghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrg
    hrhihguhhordhnvghtpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:WdpladXgER1WtVs8VOBdILqmjEGlVGCwBxlMX4OUpXFlW3ZcGe95Zw>
    <xmx:WdplaYTxnY224kRPpkA0qf3xFBlGy4nOapqkClL18izFGrIJ4kPMbA>
    <xmx:WdplaQAgrF1RwFE2cXIi7eElHmNjZXACIIhq0lrf-ibXK4J_eSNKfw>
    <xmx:WdplabQ7MqRTvuvwp4_5Z0OVdImecIFxaSuBt3GX48lpWUXoDUEbxw>
    <xmx:WdplaUj-K4hrnW3BG2BJ2jI4M51ceohVVFv4e1yEnW87D-kGSOmDlVMG>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 00:38:30 -0500 (EST)
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
    Ard Biesheuvel <ardb@kernel.org>,
    "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <51ebf844e006ca0de408f5d3a831e7b39d7fc31c.1768281748.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1768281748.git.fthain@linux-m68k.org>
References: <cover.1768281748.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v7 3/4] atomic: Add alignment check to instrumented atomic
 operations
Date: Tue, 13 Jan 2026 16:22:28 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

From: Peter Zijlstra <peterz@infradead.org>

Add a Kconfig option for debug builds which logs a warning when an
instrumented atomic operation takes place that's misaligned.
Some platforms don't trap for this.

[ fthain: added __DISABLE_EXPORTS conditional and refactored as helper
function. ]

Cc: Sasha Levin <sashal@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/lkml/20250901093600.GF4067720@noisy.programming.kicks-ass.net/
Link: https://lore.kernel.org/linux-next/df9fbd22-a648-ada4-fee0-68fe4325ff82@linux-m68k.org/
Signed-off-by: Finn Thain <fthain@linux-m68k.org>

---
Checkpatch.pl says...
ERROR: Missing Signed-off-by: line by nominal patch author 'Peter Ziljstra <peterz@infradead.org>'

---
Changed since v6:
 - Implemented helper function earlier in patch series, as requested by Ard.
 - Dropped __DISABLE_BUG_TABLE macro in favour of __DISABLE_EXPORTS, as
 requested by Peter.

Changed since v5:
 - Add new __DISABLE_BUG_TABLE macro to prevent a build failure on those
architectures which use atomics in pre-boot code like the EFI stub loader:

x86_64-linux-gnu-ld: error: unplaced orphan section `__bug_table' from `arch/x86/boot/compressed/sev-handle-vc.o'

Changed since v2:
 - Always check for natural alignment.
---
 include/linux/instrumented.h | 11 +++++++++++
 lib/Kconfig.debug            | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 711a1f0d1a73..e34b6a557e0a 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -7,6 +7,7 @@
 #ifndef _LINUX_INSTRUMENTED_H
 #define _LINUX_INSTRUMENTED_H
 
+#include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/kasan-checks.h>
 #include <linux/kcsan-checks.h>
@@ -55,6 +56,13 @@ static __always_inline void instrument_read_write(const volatile void *v, size_t
 	kcsan_check_read_write(v, size);
 }
 
+static __always_inline void instrument_atomic_check_alignment(const volatile void *v, size_t size)
+{
+#ifndef __DISABLE_EXPORTS
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
+#endif
+}
+
 /**
  * instrument_atomic_read - instrument atomic read access
  * @v: address of access
@@ -67,6 +75,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
 {
 	kasan_check_read(v, size);
 	kcsan_check_atomic_read(v, size);
+	instrument_atomic_check_alignment(v, size);
 }
 
 /**
@@ -81,6 +90,7 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_write(v, size);
+	instrument_atomic_check_alignment(v, size);
 }
 
 /**
@@ -95,6 +105,7 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_read_write(v, size);
+	instrument_atomic_check_alignment(v, size);
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


