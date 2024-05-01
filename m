Return-Path: <linux-arch+bounces-4122-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36FD8B91DB
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 01:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7AC3B21CB7
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 23:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E68916ABD5;
	Wed,  1 May 2024 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udk4pKYq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31477168B10;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604493; cv=none; b=ESw3IBFe0L6VyFb+JpevCuAggcCs0RowuYtH2bLoo/Tbipfam5b5ZUoUYAOYVR5QOj4jOr7+wyf3X9fFNQf8JrcRTbvL+4i26d7O4w0ujjkhWsUqRk+MBe7YG5AV23pcaXWqNDvg/YnX+H62I4RtZPQ0RO7rarH4Qu0ASJ5exXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604493; c=relaxed/simple;
	bh=PpSTQpZbHQunQSUzzPQvUIJ+CP30HDC9CfjkaUYmrk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eaGLkvhzKPB+P9gI7SM71TMpys8ER/wPvXiUQZcdV72AcUXmv65EBqdyQpakM2DT+Qm6CzN/mMZG1Sn+W1xZaS3cTrOpiR3vY5Caw29AROX2Vog+cp1hwi3j+Kr9rOvRuvogfgB4WbGU0VZLjgefB6vPUJnSUFUps79tJXLBcnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udk4pKYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC62FC4AF63;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714604492;
	bh=PpSTQpZbHQunQSUzzPQvUIJ+CP30HDC9CfjkaUYmrk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udk4pKYqRq0ueXXLHSRjrkKMd/zpUR+9miHTot+JmCll3YBJkGiBLy86jszq+qFzF
	 GeiObNB8nitkHY1DOg59JDhvvnvfgvAlFcK0cjZqjpZ/ssuPrnPX606CQdDWYZA9vm
	 ONxY1yJYUndEIBYXfeTXWQQYDUw79U1RTnQDHrE3HBeEN5D2Yh4dVy5ZnfXIHoTenM
	 tVSKIczrGG7Zg4rkoYiLRrVdBAN2aYxyZiKsbOGqpPEQMk5hRz6G23DnMoepDRx0me
	 ZhR/DNTlAzRfa6sR+giejx0/bFLv/kZQfz865i0CFh/ldfTHdBFcL3zRfpLmXyCB1T
	 XVsxhkv6E0z/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DCFFECE2A4B; Wed,  1 May 2024 16:01:31 -0700 (PDT)
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
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-sh@vger.kernel.org
Subject: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
Date: Wed,  1 May 2024 16:01:29 -0700
Message-Id: <20240501230130.1111603-12-paulmck@kernel.org>
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
index 2ad3e29f0ebec..f47e9ccf4efd2 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -16,6 +16,7 @@ config SUPERH
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


