Return-Path: <linux-arch+bounces-4682-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C80B8FB9D0
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 19:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3BB1C24A58
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 17:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BFB149C7E;
	Tue,  4 Jun 2024 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqARKUI5"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF530149C67;
	Tue,  4 Jun 2024 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520681; cv=none; b=mS74vz6dVacpUlDVLFb7fsGftHFvXyJWPVPqXghlAfbGeNThPmAsLi2r6qc8qucDwIiKBsQqDKn7BhuC+Q8Cu/36+9dLsq5lzqDJo4sk4LdSwT765af5mdejQHHlULwfLtFvoFxF3eIqAmPtkT5cFUBkyY62gpmHb3fx9yePxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520681; c=relaxed/simple;
	bh=GxwVGSclRaGU/SB3ndBiNvXG+9cagR1RsASsFKDZ6S8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SxXhyTkx/gcH6SAf85SLUhIII8u9Q+D/U0W9BqhJQnj3uMvNtH53qLGoekly1jYLhNzTxmCGCpz+9KkFApuDWkWs7rZUKbOW+X0/qyXNr2rKCyS8U8Wu5dZpG4Wv/fUI+StFrWibO6Hwj6Hlo2KXPFNhKAyRCkog5a11Qy8CtUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqARKUI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618BAC4AF0A;
	Tue,  4 Jun 2024 17:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717520681;
	bh=GxwVGSclRaGU/SB3ndBiNvXG+9cagR1RsASsFKDZ6S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nqARKUI5XSSx7SeFDFVZhhnMd+v9cxXbud2egrU5rqUpu7Wn0aByJNTBInYwpf6eb
	 BGYqKqkybmoZ3Zxf7lwKE7jJt7yvxAAJSMd16HpbM0pzyxZibSZrsAfBY/lq0bJ0Qj
	 QcAUkc7hjloPQywj1HvHXDmNbqs8TDqSP3ImoJ8OXA+A8A6RQ8HbnzABAeLWOcMNPN
	 8eybIErJI5kSK3Jb3EkwlZDhSUlOHeKd5fX3mjYA9vVYw1+PsX+7YAI9ToqjT7JIDN
	 /MJp1R8HZ944N/61tin46cQ3bOSGrNi9dm9CcZ9LzDIrEF+MVNpb0QgsjR4ipjrG1U
	 VWwGUON4u80Fw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 01CFFCE1415; Tue,  4 Jun 2024 10:04:41 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	elver@google.com,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	dianders@chromium.org,
	pmladek@suse.com,
	torvalds@linux-foundation.org,
	arnd@arndb.de,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-sh@vger.kernel.org
Subject: [PATCH v3 cmpxchg 2/4] sh: Emulate one-byte cmpxchg
Date: Tue,  4 Jun 2024 10:04:35 -0700
Message-Id: <20240604170437.2362545-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1dee481f-d584-41d6-a5f1-d84375be5fe8@paulmck-laptop>
References: <1dee481f-d584-41d6-a5f1-d84375be5fe8@paulmck-laptop>
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
index 5e6a3ead51fb1..f723e2256c9c1 100644
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


