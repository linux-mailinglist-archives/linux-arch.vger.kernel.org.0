Return-Path: <linux-arch+bounces-5995-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3AF948236
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 21:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D72F8B21920
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 19:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E62216B396;
	Mon,  5 Aug 2024 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeZmvV35"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBDB15B147;
	Mon,  5 Aug 2024 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885682; cv=none; b=IUmvpxaVF/2MhejuHTRivY22qgJZ3fSTktZQAB+hocxXB5KBhwoL0NH2dnC0u0JskmSx4FOwGVomInfF4QxGez3xC/r5dcgjIpkHCkYmYE8+hRxdI1B4/kzNkM5TIH/NAkDfRCMLtiTLIzRdVny0nolPg831FPvJXlJXlhBVcBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885682; c=relaxed/simple;
	bh=rHLBTLGCozsc8ZYyoVtgXgyWtG7mLnt/2HwV6ku00sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t8mh2dJz5TEx+PVv4XNB0rF72kgt8E4YH8oDRngghesuIKz/P6yaOX9GhWtdAUailQ36btjhKqOUVzMfAFGJKhZdbuTeOaV2/eUd+czVZ4JEu9SjrsamKalR4trLsxIhpOVuLnPOhO4/z0EgQOc7cqj7jrVlwu8g+qbJEvgATaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeZmvV35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF64C4AF0E;
	Mon,  5 Aug 2024 19:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722885681;
	bh=rHLBTLGCozsc8ZYyoVtgXgyWtG7mLnt/2HwV6ku00sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JeZmvV35UmDfaPr6trM/HZwiyXgBBYiM79k8hwahfN7zysawZ9ZqeljXBeibBxhTW
	 XmZ9krPGcFEJSs02cDDOTWMyZaSRF7znUDHVev751sJP0Gv5Td6hPaXpo+hdRa6EyB
	 5yuvlDFujJRFq97YX050Lb3StOqrAPuPbgKchfcTNY5az670n41g+A3MhzgD3p3TgV
	 LSkTsnSq9XxjrehqV/uoL5inxzoPMRQsSfLRdZErvkfBpWnqKK/HFzqcgXxjreH/hs
	 gShiXwGHYVqWM8a5NnGHyjoTrn6zX/ubBKFaYnIOFb9aYMfniRuOSfOnGj4/V90E4B
	 JLUUqZiU5AaXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 50378CE10F9; Mon,  5 Aug 2024 12:21:21 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: elver@google.com,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	torvalds@linux-foundation.org,
	arnd@arndb.de,
	geert@linux-m68k.org,
	palmer@rivosinc.com,
	mhiramat@kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH cmpxchg 3/3] sh: Emulate one-byte cmpxchg
Date: Mon,  5 Aug 2024 12:21:19 -0700
Message-Id: <20240805192119.56816-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c1b7f3a2-da50-4dfb-af6f-a1898eaf2b79@paulmck-laptop>
References: <c1b7f3a2-da50-4dfb-af6f-a1898eaf2b79@paulmck-laptop>
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


