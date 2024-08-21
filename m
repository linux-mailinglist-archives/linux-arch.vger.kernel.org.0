Return-Path: <linux-arch+bounces-6439-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA8295A470
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 20:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48940B211AA
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 18:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADFD1B3B0C;
	Wed, 21 Aug 2024 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml6UOk07"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3171B2EE2;
	Wed, 21 Aug 2024 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263813; cv=none; b=t82yHDDB3NFEEL/dtI+6ccQMU95TR692Jw5aCpapeaqkksjJAg4kiw9WizlATHVjuSAkhTaU/ezdBDy7jxKY/EdUyoJobLa3ZoWTYMjOQ3WaqmYO5uYh4SKmNjIfW8+QyaMV7l9l+0s2lknVhxHkVhlMssy84McFePPvQ/1GlZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263813; c=relaxed/simple;
	bh=rRjox4fY0egq63DbDfR2UVfQKrpoEipdNtPZ92fJEcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CnWXTODCUdK7uCrPqJTenh/U/OxpW1uX1ML1a/DNBQTuADKiP+WPPjnCx6pliObtY/7Dz3iPeOf3q2BviYc/WHuPogmCoBlRCfXsmffobhvocPoHLpponIpkovelwq9Knr9DudHkssp2uEMzLj0vgDFh3vrXHCxC6ClpFSlSJfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ml6UOk07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315AEC4AF0E;
	Wed, 21 Aug 2024 18:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724263813;
	bh=rRjox4fY0egq63DbDfR2UVfQKrpoEipdNtPZ92fJEcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ml6UOk07YO3enrVKQ0NNvDl9iFc3hFp4f1iRte27zuWvaJhi3eZYvzOkIXMwf2jtY
	 keMUS1yVsT+NdB9i0aillOCvpZhd0/wbKYrOEs1TX2q6t/7Exj6ZfIf+gYF+NyWNP9
	 DGb3HZj3ZOkWwN1Mw8swjA3a8trSybB24Pgs4EkngRtNkvjPHi0/tARtCFE/2LF3U3
	 QF5FtUkk9Icwxut7BsViLwZUblDd+5qW3wP1nW9bYoOZ2ZbvUv10LBKOUjnRODkSrl
	 7eIzte7H+FM/aY1HJf8LjAR6Xa4bif9gk86LcblyVuRMBs9HiiWCgkYd6L+xO2GQur
	 e63b+kYObalcg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BFF71CE16C8; Wed, 21 Aug 2024 11:10:12 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	elver@google.com
Cc: akpm@linux-foundation.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	torvalds@linux-foundation.org,
	arnd@arndb.de,
	geert@linux-m68k.org,
	kernel-team@meta.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH v2 cmpxchg 3/3] sh: Emulate one-byte cmpxchg
Date: Wed, 21 Aug 2024 11:10:11 -0700
Message-Id: <20240821181011.2604152-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <04a6010c-536d-4906-bf7c-b2335a2f54b0@paulmck-laptop>
References: <04a6010c-536d-4906-bf7c-b2335a2f54b0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on sh.

[ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
[ paulmck: Apply feedback from Naresh Kamboju. ]
[ Apply Geert Uytterhoeven feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <linux-sh@vger.kernel.org>
Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 arch/sh/Kconfig               | 1 +
 arch/sh/include/asm/cmpxchg.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 1aa3c4a0c5b27..e9103998cca91 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -14,6 +14,7 @@ config SUPERH
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
+	select ARCH_NEED_CMPXCHG_1_EMU
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_DECLARE_COHERENT
 	select GENERIC_ATOMIC64
diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 5d617b3ef78f7..1e5dc5ccf7bf5 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -9,6 +9,7 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/cmpxchg-emu.h>
 
 #if defined(CONFIG_GUSA_RB)
 #include <asm/cmpxchg-grb.h>
@@ -56,6 +57,8 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
 		unsigned long new, int size)
 {
 	switch (size) {
+	case 1:
+		return cmpxchg_emu_u8(ptr, old, new);
 	case 4:
 		return __cmpxchg_u32(ptr, old, new);
 	}
-- 
2.40.1


