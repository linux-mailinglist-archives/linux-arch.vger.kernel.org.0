Return-Path: <linux-arch+bounces-9984-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA11AA26E05
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 10:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754AF3A2F81
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 09:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6B9207640;
	Tue,  4 Feb 2025 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcUPcgM1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C01201009;
	Tue,  4 Feb 2025 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738660746; cv=none; b=eO/BgkVtwYLcUrQk4/InyV8MxrM0lZhIN9rtoCvTeXWNeR6eTyW9MRbIoe7hPcoY4V0ZZRm3igYgA3t28tIrNH5RqgR23/Kh4Jv+5yLNOZDNOp6PNFkb0vCGqjzv1SKdduGVc05u+7sGUHAXA93sYwYKKsLE1RpS6+EO4Bkpvxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738660746; c=relaxed/simple;
	bh=M/0MbWgQomgFkFf342WyucRNwqt3ktrigkPZJGV8u7o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=d6I93VPR9eIiF4IdivKeCp39dpFTyjZ1ir+aTYDNnLR6F8YMKvIxJFEMJ0qOXqG19/TLvDlfl8fThBGf8kGhysE/l3iACa3bLZ8pdjmizNgbgxHknbX+gO1lQW4Ryrbmxkc/kh/7+9vwrr0KdKyG487NlNGHk1hLgh7lzhrB2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcUPcgM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E636C4CEDF;
	Tue,  4 Feb 2025 09:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738660745;
	bh=M/0MbWgQomgFkFf342WyucRNwqt3ktrigkPZJGV8u7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XcUPcgM1wVGnKVUq9O/4FVPT+8Sf6nQPqbwAf4eoq19Hn39pfgdTS0Sb1xY6GBOsH
	 BsimP4qt+MEnu+W6Oiu+QYuQsHNsHzS/nPvSKdZQ7dlmdptaBjwV2uqnf3nHERjINI
	 diw9fFcmkdjmGRFOpK4H3AfhBokTyuBnCddS7dus0fAsNZ2rj1jAwZdwIAyrVTtwkY
	 wUPnYcrHa7cDUtWNgEy2UIi223mwYPDDboTSuv1Vm+6IscNnJN2XGi3xXhkZj2PpOP
	 ejPndcE4nr6vLGwKsoIui9Djyce3qkNb7NWFtKa8SFltsYlmYpZey0eRdIK1OFS0+P
	 v9thTAzkgqsDw==
Date: Tue, 4 Feb 2025 18:19:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Gabriel de Perthuis <g2p.code@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org, kernel test robot <lkp@intel.com>, Florent
 Revest <revest@chromium.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v22 19/20] ftrace: Add ftrace_get_symaddr to convert
 fentry_ip to symaddr
Message-Id: <20250204181902.dd6e02416ff5eeec3ea47a79@kernel.org>
In-Reply-To: <a87f98bf-45b1-4ef5-aa77-02f7e61203f4@gmail.com>
References: <173518987627.391279.3307342580035322889.stgit@devnote2>
	<173519011487.391279.5450806886342723151.stgit@devnote2>
	<a87f98bf-45b1-4ef5-aa77-02f7e61203f4@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 3 Feb 2025 22:33:48 +0100
Gabriel de Perthuis <g2p.code@gmail.com> wrote:

> Hello,
> 
> I got errors building Linux 6.14-rc1 that were solved by reverting this 
> patch and the one after (19/20 and 20/20).
> 
> Errors look like:
> 
> In file included from ./arch/x86/include/asm/asm-prototypes.h:2,
>                   from <stdin>:3:
> ./arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_get_symaddr':
> ./arch/x86/include/asm/ftrace.h:46:21: error: implicit declaration of 
> function 'get_kernel_nofault' [-Wimplicit-function-declaration]
>     46 |                 if (get_kernel_nofault(instr, (u32 *)(fentry_ip 
> - ENDBR_INSN_SIZE)))
>        | ^~~~~~~~~~~~~~~~~~
> 
> Will send .config on request if needed.


Thanks for the report!

-------<arch/x86/include/asm/asm-prototypes.h>
/* SPDX-License-Identifier: GPL-2.0 */
#include <asm/ftrace.h>
#include <linux/uaccess.h>
-----

Ah, that's why... get_kernel_nofault() is defined in linux/uaccess.h.
I also found that is_endbr() is in asm/ibt.h.

Can you try this?

Thank you,

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index f9cb4d07df58..d24d7c71253f 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -16,24 +16,9 @@
 # include <asm/ibt.h>
 /* Add offset for endbr64 if IBT enabled */
 # define FTRACE_MCOUNT_MAX_OFFSET	ENDBR_INSN_SIZE
-#endif
-
-#ifdef CONFIG_DYNAMIC_FTRACE
-#define ARCH_SUPPORTS_FTRACE_OPS 1
-#endif
-
-#ifndef __ASSEMBLY__
-extern void __fentry__(void);
-
-static inline unsigned long ftrace_call_adjust(unsigned long addr)
-{
-	/*
-	 * addr is the address of the mcount call instruction.
-	 * recordmcount does the necessary offset calculation.
-	 */
-	return addr;
-}
 
+#include <linux/uaccess.h>
+/* This only supports fentry based ftrace. */
 static inline unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
 {
 #ifdef CONFIG_X86_KERNEL_IBT
@@ -55,6 +40,24 @@ static inline unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
 }
 #define ftrace_get_symaddr(fentry_ip)	arch_ftrace_get_symaddr(fentry_ip)
 
+#endif
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+#define ARCH_SUPPORTS_FTRACE_OPS 1
+#endif
+
+#ifndef __ASSEMBLY__
+extern void __fentry__(void);
+
+static inline unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	/*
+	 * addr is the address of the mcount call instruction.
+	 * recordmcount does the necessary offset calculation.
+	 */
+	return addr;
+}
+
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
 #include <linux/ftrace_regs.h>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

