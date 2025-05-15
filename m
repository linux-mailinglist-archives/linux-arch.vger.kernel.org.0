Return-Path: <linux-arch+bounces-11949-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FAEAB86E6
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 14:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D2F1BA576C
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B30D29DB8B;
	Thu, 15 May 2025 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3GN9FSW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0552129DB86;
	Thu, 15 May 2025 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313227; cv=none; b=AY9M9iQ9/8Nd8xiyHrFWgDkWElW4K77++b/2/55UqpkgWJv7xRytfrXpOJfja09MxuuNfrk41rqSpIII5eOaSZX2ar3LS/9J+KUgJnvYR6xm9T5CdvGY42hbGpqNNNd5mnyxMkKuTbFIdc+F1JG4mCcxWUqZiehdJpsFtAJi2Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313227; c=relaxed/simple;
	bh=AwKLO6MlaTLedN7k+hdE1I2gJG0P/wVaqml4h5jIdvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ly+Wy/19Wo4hcm4FDjn+uZBjEg/zKrlGoMOzKYrkfiCBzkL1ciXq1Cv34u6JkLLAsECiDCfIHdDRozmmkPBM5Uaf+ru/NToXKTGt18pdsajZGFfMf/KNiO1KS5TFex0WGkMmZtDvknGAOs2Eb3FAuoCbD4lMPBqwUMZ+uyF2f24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3GN9FSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDB8C4CEEB;
	Thu, 15 May 2025 12:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313226;
	bh=AwKLO6MlaTLedN7k+hdE1I2gJG0P/wVaqml4h5jIdvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s3GN9FSWT5BU+aUhkcJEq3h0a46WFComiGq7+G9OywxjtQzPC0jbVOal0OAaMe4xP
	 9uoa3lo5isjl/5VP5g0xm47HBYYFMlF52TvWn2oC/jUZvyGmwGrorsqx7d3Dr1o339
	 0L0imSC0xIJAWBOg9Nm+/Px3WpD1mtFsPaGCQF4QvMv2+mmJMrpTUZ/OrDPkky16BV
	 7wUGJvi5FwfbiL4XPNBbqPwtBRy2PwRHSUB45f8diPmO/QhON+QYh+rjhoz8S/hU38
	 uY75fPQM8FdVpm9R8Jz7DI/zb14Ks1kmRrPOYXTrEQzOREX0DecZIiW++d0jl33WId
	 oXVPIN3A+dCow==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arch@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 08/15] bugs/LoongArch: Pass in 'cond_str' to __BUG_ENTRY()
Date: Thu, 15 May 2025 14:46:37 +0200
Message-ID: <20250515124644.2958810-9-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250515124644.2958810-1-mingo@kernel.org>
References: <20250515124644.2958810-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass in the condition string from __WARN_FLAGS(), but don't use it yet.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: <linux-arch@vger.kernel.org>
---
 arch/loongarch/include/asm/bug.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
index 51c2cb98d728..3c377984457d 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -20,39 +20,38 @@
 #endif
 
 #ifndef CONFIG_GENERIC_BUG
-#define __BUG_ENTRY(flags)
+#define __BUG_ENTRY(cond_str, flags)
 #else
-#define __BUG_ENTRY(flags) 					\
+#define __BUG_ENTRY(cond_str, flags)				\
 		.pushsection __bug_table, "aw";			\
 		.align 2;					\
 	10000:	.long 10001f - .;				\
 		_BUGVERBOSE_LOCATION(__FILE__, __LINE__)	\
-		.short flags; 					\
+		.short flags;					\
 		.popsection;					\
 	10001:
 #endif
 
-#define ASM_BUG_FLAGS(flags)					\
-	__BUG_ENTRY(flags)					\
+#define ASM_BUG_FLAGS(cond_str, flags)				\
+	__BUG_ENTRY(cond_str, flags)				\
 	break		BRK_BUG;
 
-#define ASM_BUG()	ASM_BUG_FLAGS(0)
+#define ASM_BUG()	ASM_BUG_FLAGS("", 0)
 
-#define __BUG_FLAGS(flags, extra)					\
-	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags))		\
-			     extra);
+#define __BUG_FLAGS(cond_str, flags, extra)			\
+	asm_inline volatile (__stringify(ASM_BUG_FLAGS(cond_str, flags)) extra);
 
 #define __WARN_FLAGS(cond_str, flags)				\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ANNOTATE_REACHABLE(10001b));\
+	__BUG_FLAGS(cond_str, BUGFLAG_WARNING|(flags), ANNOTATE_REACHABLE(10001b));\
 	instrumentation_end();					\
 } while (0)
 
 #define BUG()							\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(0, "");					\
+	__BUG_FLAGS("", 0, "");					\
 	unreachable();						\
 } while (0)
 
-- 
2.45.2


