Return-Path: <linux-arch+bounces-1071-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E56814487
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 10:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79381C20896
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 09:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD2A1A593;
	Fri, 15 Dec 2023 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lq2PgWht"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061F5179A2;
	Fri, 15 Dec 2023 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=b4R8oBfA9zqLdMspEmf7BM9tcAtmYn2SA6ZbJ+T1P5c=; b=Lq2PgWhtX3V8toHwd4gXthsfPV
	51X7SJQC7Nru1W8AxzAo9FgQf8X7B//HhiVa4Wni0K2G+n5NSLp0J6KuWaVPHCg5LqaWnnTct6an7
	VSn/94veX/IqLryss/BBYEDgrH3uHxiAng0tbAwUZR/2wWcS1xNJe4HBpFsWFWk2lHDRHwf+hSYIV
	jW3O6OYVrI2YIUtYDEzNZCpeDl/mhsRZv8X+fwN3HuvgHv0Zv4s2ZWXFlNfony2rirfUxjBaebt0e
	2AMaCofhDa/dAdzVSTw7hG62RjkawKG+01OP4YeCDE2L2mGeW2/sgrNjJVf24DXfwrfjR9XaYP+Bk
	aMms2tmQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rE4ZF-009rG1-0w;
	Fri, 15 Dec 2023 09:33:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D6BA730098F; Fri, 15 Dec 2023 10:33:11 +0100 (CET)
Message-Id: <20231215092707.669401084@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 15 Dec 2023 10:12:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: paul.walmsley@sifive.com,
 palmer@dabbelt.com,
 aou@eecs.berkeley.edu,
 tglx@linutronix.de,
 mingo@redhat.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 x86@kernel.org,
 hpa@zytor.com,
 davem@davemloft.net,
 dsahern@kernel.org,
 daniel@iogearbox.net,
 andrii@kernel.org,
 martin.lau@linux.dev,
 song@kernel.org,
 yonghong.song@linux.dev,
 john.fastabend@gmail.com,
 kpsingh@kernel.org,
 sdf@google.com,
 haoluo@google.com,
 jolsa@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 samitolvanen@google.com,
 keescook@chromium.org,
 nathan@kernel.org,
 ndesaulniers@google.com,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 linux-arch@vger.kernel.org,
 llvm@lists.linux.dev,
 jpoimboe@kernel.org,
 joao@overdrivepizza.com,
 mark.rutland@arm.com,
 peterz@infradead.org
Subject: [PATCH v3 5/7] cfi: Add CFI_NOSEAL()
References: <20231215091216.135791411@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Add a CFI_NOSEAL() helper to mark functions that need to retain their
CFI information, despite not otherwise leaking their address.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/cfi.h |    5 +++++
 include/linux/cfi.h        |    4 ++++
 2 files changed, 9 insertions(+)

--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -8,6 +8,7 @@
  * Copyright (C) 2022 Google LLC
  */
 #include <linux/bug.h>
+#include <asm/ibt.h>
 
 /*
  * An overview of the various calling conventions...
@@ -138,4 +139,8 @@ static inline u32 cfi_get_func_hash(void
 }
 #endif /* CONFIG_CFI_CLANG */
 
+#if HAS_KERNEL_IBT == 1
+#define CFI_NOSEAL(x)	asm(IBT_NOSEAL(__stringify(x)))
+#endif
+
 #endif /* _ASM_X86_CFI_H */
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -46,4 +46,8 @@ static inline void module_cfi_finalize(c
 #endif /* CONFIG_ARCH_USES_CFI_TRAPS */
 #endif /* CONFIG_MODULES */
 
+#ifndef CFI_NOSEAL
+#define CFI_NOSEAL(x)
+#endif
+
 #endif /* _LINUX_CFI_H */



