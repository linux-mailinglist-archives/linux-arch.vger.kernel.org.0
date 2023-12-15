Return-Path: <linux-arch+bounces-1068-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D406981447A
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 10:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327A3281AED
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 09:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EDE182B9;
	Fri, 15 Dec 2023 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DJUGDSMs"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9794171A6;
	Fri, 15 Dec 2023 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=pbCkSkpL0VTDsMcIMxCWVNworlFDlzLYPEKR3Py08RA=; b=DJUGDSMsYcY1FuLTMqpTLZuuD7
	hLcMb7eOFpemVUB+Svi/65P+67gUSbeKh1GOBa7cr2FYt8/qyXeoCT/pi9uAhu9eJwsOkfFe9UNZA
	E+tGfdbdcJMPCvbJI7kQhXFFPwJ/zB9n+CEo8T0lj3ii//1wGhtPUl50MbNeh94rHVUSccRW0YYK0
	U3qkPi7dJl+StxkZqBM6AttokeY+LDewP6v1hQKFnOmnEqTogDs7l+ALwC9Yv1WLjHiAofFrqYNBs
	J4UwojSpM8p8N5gRGZbTqyJFVtkENll8kEtpzjHrxv2v395vu0J14T0nFZ4f2uZJEZWyLZsr8TYXI
	2mV7ppVg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rE4ZD-00FSOT-HF; Fri, 15 Dec 2023 09:33:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id BF53730049D; Fri, 15 Dec 2023 10:33:11 +0100 (CET)
Message-Id: <20231215092707.231038174@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 15 Dec 2023 10:12:17 +0100
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
Subject: [PATCH v3 1/7] cfi: Flip headers
References: <20231215091216.135791411@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Normal include order is that linux/foo.h should include asm/foo.h, CFI has it
the wrong way around.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/riscv/include/asm/cfi.h |    3 ++-
 arch/riscv/kernel/cfi.c      |    2 +-
 arch/x86/include/asm/cfi.h   |    3 ++-
 arch/x86/kernel/cfi.c        |    4 ++--
 include/asm-generic/Kbuild   |    1 +
 include/asm-generic/cfi.h    |    5 +++++
 include/linux/cfi.h          |    1 +
 7 files changed, 14 insertions(+), 5 deletions(-)

--- a/arch/riscv/include/asm/cfi.h
+++ b/arch/riscv/include/asm/cfi.h
@@ -7,8 +7,9 @@
  *
  * Copyright (C) 2023 Google LLC
  */
+#include <linux/bug.h>
 
-#include <linux/cfi.h>
+struct pt_regs;
 
 #ifdef CONFIG_CFI_CLANG
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
--- a/arch/riscv/kernel/cfi.c
+++ b/arch/riscv/kernel/cfi.c
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2023 Google LLC
  */
-#include <asm/cfi.h>
+#include <linux/cfi.h>
 #include <asm/insn.h>
 
 /*
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -7,8 +7,9 @@
  *
  * Copyright (C) 2022 Google LLC
  */
+#include <linux/bug.h>
 
-#include <linux/cfi.h>
+struct pt_regs;
 
 #ifdef CONFIG_CFI_CLANG
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
--- a/arch/x86/kernel/cfi.c
+++ b/arch/x86/kernel/cfi.c
@@ -4,10 +4,10 @@
  *
  * Copyright (C) 2022 Google LLC
  */
-#include <asm/cfi.h>
+#include <linux/string.h>
+#include <linux/cfi.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
-#include <linux/string.h>
 
 /*
  * Returns the target address and the expected type when regs->ip points
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -11,6 +11,7 @@ mandatory-y += bitops.h
 mandatory-y += bug.h
 mandatory-y += bugs.h
 mandatory-y += cacheflush.h
+mandatory-y += cfi.h
 mandatory-y += checksum.h
 mandatory-y += compat.h
 mandatory-y += current.h
--- /dev/null
+++ b/include/asm-generic/cfi.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_CFI_H
+#define __ASM_GENERIC_CFI_H
+
+#endif /* __ASM_GENERIC_CFI_H */
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -9,6 +9,7 @@
 
 #include <linux/bug.h>
 #include <linux/module.h>
+#include <asm/cfi.h>
 
 #ifdef CONFIG_CFI_CLANG
 enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long addr,



