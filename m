Return-Path: <linux-arch+bounces-3498-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B8989CB0E
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 19:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02318B28F31
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88241144D0B;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyTIZnDM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7031448D4;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598587; cv=none; b=alCk//doUX8KQZNDnAqbEcNJHzYN8ijQI2HpZRZRxEx1SHXQr200dEtPRk9T+VnW7f9g03iDOEM/M6EPT7gEYEWf4mgfxtN4xagF/BCvr80TNqWsoNXHETKIsCvjjmnogM0EyJF8XVCw7OWOuTPHw6l1YOT2LWW9ud7bvANtX9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598587; c=relaxed/simple;
	bh=CsdoBFIa1iUKUh43LG7ixotspstLiAd1X2CXa4pgxHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cBuorKHF+BnrFXEsjf+iHga+nrhNcPccNwxkFeFMR+zW131f4pGW6qrdXMw+zbKphsfnbhRjHtef616efsiHnWp8mFK2V3ajqi0F14FwI4PJ+1n4MDa/nsAYEbyL+zVG8iwLE/lA0GNDsoveQzYzogx5ETGHcc7GAZcgsFaNKpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyTIZnDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FADFC41679;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712598587;
	bh=CsdoBFIa1iUKUh43LG7ixotspstLiAd1X2CXa4pgxHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AyTIZnDMdDNdEeZd8JhwXdayK4jqjWb/AQJ8n1boadxn4LgqbDKQFSVuvoL3FSTaz
	 qufXEp960YoUMK16/1hEBbFzCtUaOyca/liTZ/vOKRLCBiAoTKdMYuaDyHf32V5ADl
	 V25qgGiNzd2YB7+a/YPPYHq+Fm6IdNBjj7GtQhiXB+HetnLq779PjU/YCUCt77Bu0t
	 kkaG9fRdkygxlehPmmMHYpuO60oDnJAwNg1FWJ8SqIIJnlZ3vWAO2A/Gyv+QzsnD4v
	 fal812wQxjsFRlwCqcp31MJqDy8EmTATfV6WZb6rAjwHvkJglbJ0wMrdcDQC3i6Ss9
	 +NBhEFKZzW+5g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5A71FCE2CD9; Mon,  8 Apr 2024 10:49:46 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: elver@google.com,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	dianders@chromium.org,
	pmladek@suse.com,
	torvalds@linux-foundation.org,
	Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-sh@vger.kernel.org
Subject: [PATCH cmpxchg 12/14] sh: Emulate one-byte cmpxchg
Date: Mon,  8 Apr 2024 10:49:42 -0700
Message-Id: <20240408174944.907695-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
References: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on sh.

[ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <linux-sh@vger.kernel.org>
---
 arch/sh/Kconfig               | 1 +
 arch/sh/include/asm/cmpxchg.h | 2 ++
 2 files changed, 3 insertions(+)

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
index 5d617b3ef78f7..27a9040983cfe 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -56,6 +56,8 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
 		unsigned long new, int size)
 {
 	switch (size) {
+	case 1:
+		return cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
 	case 4:
 		return __cmpxchg_u32(ptr, old, new);
 	}
-- 
2.40.1


