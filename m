Return-Path: <linux-arch+bounces-8760-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6400D9B9301
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2024 15:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFED91F221E5
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2024 14:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF31E1A726B;
	Fri,  1 Nov 2024 14:21:18 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A11A7060;
	Fri,  1 Nov 2024 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730470878; cv=none; b=q6ozqGPyIL/yESx5nEVNwQmp9GtHqVzUAbcp7Yyx6BqSKoVhwI323TtW2h/TIwafd2to1GvU7GgLuGx7KEbLyl1BcT70DREOQJthECQLPxj6lUzaFTJQcAr9dqnSwoUPMn5MDbjmFfhlAHaFwZJRVRvtUokBj0CxdkaaY3NtlD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730470878; c=relaxed/simple;
	bh=S7KBA8xEO6BpAvteapa4TKEuJiHMXUfN+fW77Vcz0uU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9ymUTkRzeSTYhUkPdLoxtO8b2wpibf2IyTN3mcBIxauyAhHc3PVgEqC6PNgB3a80LGgDcB3imxSILf8d5aS0ylDAGInZ+Bn0MLBL+Zq8hbOlKdRlVGB2nNFYEa5irzUZX6dwY+LxMf1pBS+1gnZHKRgGegVEr1qTGe8VUQyVTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDAFC4CECD;
	Fri,  1 Nov 2024 14:21:14 +0000 (UTC)
Date: Fri, 1 Nov 2024 10:22:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v18 12/17] fprobe: Add fprobe_header encoding feature
Message-ID: <20241101102212.5e9d74d9@gandalf.local.home>
In-Reply-To: <172991747946.443985.11014834036464028393.stgit@devnote2>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
	<172991747946.443985.11014834036464028393.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Oct 2024 13:37:59 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fprobe store its data structure address and size on the fgraph return stack
> by __fprobe_header. But most 64bit architecture can combine those to
> one unsigned long value because 4 MSB in the kernel address are the same.
> With this encoding, fprobe can consume less space on ret_stack.
> 
> This introduces asm/fprobe.h to define arch dependent encode/decode
> macros. Note that since fprobe depends on CONFIG_HAVE_FUNCTION_GRAPH_FREGS,
> currently only arm64, loongarch, riscv, s390 and x86 are supported.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  arch/arm64/include/asm/fprobe.h     |    7 +++++++
>  arch/loongarch/include/asm/fprobe.h |    5 +++++
>  arch/riscv/include/asm/fprobe.h     |    9 +++++++++
>  arch/s390/include/asm/fprobe.h      |   10 ++++++++++
>  arch/x86/include/asm/fprobe.h       |    9 +++++++++
>  include/asm-generic/fprobe.h        |   33 +++++++++++++++++++++++++++++++++
>  kernel/trace/fprobe.c               |   29 +++++++++++++++++++++++++++++
>  7 files changed, 102 insertions(+)
>  create mode 100644 arch/arm64/include/asm/fprobe.h
>  create mode 100644 arch/loongarch/include/asm/fprobe.h
>  create mode 100644 arch/riscv/include/asm/fprobe.h
>  create mode 100644 arch/s390/include/asm/fprobe.h
>  create mode 100644 arch/x86/include/asm/fprobe.h
>  create mode 100644 include/asm-generic/fprobe.h
> 
> diff --git a/arch/arm64/include/asm/fprobe.h b/arch/arm64/include/asm/fprobe.h
> new file mode 100644
> index 000000000000..bbf254db878d
> --- /dev/null
> +++ b/arch/arm64/include/asm/fprobe.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM64_FPROBE_H
> +#define _ASM_ARM64_FPROBE_H
> +
> +#include <asm-generic/fprobe.h>
> +
> +#endif /* _ASM_ARM64_FPROBE_H */
> \ No newline at end of file

This isn't the way to add asm-generic code to architectures. It needs to be
in the Kbuild file. Like this:

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 4e350df9a02d..0d0a638d41a8 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -14,6 +14,7 @@ generic-y += qrwlock.h
 generic-y += qspinlock.h
 generic-y += parport.h
 generic-y += user.h
+generic-y += fprobe.h
 
 generated-y += cpucap-defs.h
 generated-y += sysreg-defs.h


> diff --git a/arch/loongarch/include/asm/fprobe.h b/arch/loongarch/include/asm/fprobe.h
> new file mode 100644
> index 000000000000..68156a66873c
> --- /dev/null
> +++ b/arch/loongarch/include/asm/fprobe.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_LOONGARCH_FPROBE_H
> +#define _ASM_LOONGARCH_FPROBE_H
> +
> +#endif /* _ASM_LOONGARCH_FPROBE_H */
> \ No newline at end of file
> diff --git a/arch/riscv/include/asm/fprobe.h b/arch/riscv/include/asm/fprobe.h
> new file mode 100644
> index 000000000000..51fc2ef3eda1
> --- /dev/null
> +++ b/arch/riscv/include/asm/fprobe.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_FPROBE_H
> +#define _ASM_RISCV_FPROBE_H
> +
> +#ifdef CONFIG_64BIT
> +#include <asm-generic/fprobe.h>
> +#endif
> +
> +#endif /* _ASM_RISCV_FPROBE_H */
> \ No newline at end of file
> diff --git a/arch/s390/include/asm/fprobe.h b/arch/s390/include/asm/fprobe.h
> new file mode 100644
> index 000000000000..84b94ba6e3a4
> --- /dev/null
> +++ b/arch/s390/include/asm/fprobe.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_S390_FPROBE_H
> +#define _ASM_S390_FPROBE_H
> +
> +#include <asm-generic/fprobe.h>
> +
> +#undef FPROBE_HEADER_MSB_PATTERN
> +#define FPROBE_HEADER_MSB_PATTERN 0
> +
> +#endif /* _ASM_S390_FPROBE_H */
> \ No newline at end of file
> diff --git a/arch/x86/include/asm/fprobe.h b/arch/x86/include/asm/fprobe.h
> new file mode 100644
> index 000000000000..c863518bef90
> --- /dev/null
> +++ b/arch/x86/include/asm/fprobe.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_FPROBE_H
> +#define _ASM_X86_FPROBE_H
> +
> +#ifdef CONFIG_64BIT
> +#include <asm-generic/fprobe.h>
> +#endif
> +
> +#endif /* _ASM_X86_FPROBE_H */
> \ No newline at end of file

Same for the above.

-- Steve

