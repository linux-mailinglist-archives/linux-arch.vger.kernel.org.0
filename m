Return-Path: <linux-arch+bounces-4224-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 524368BD46A
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 20:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4DC282ECF
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 18:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707E2158855;
	Mon,  6 May 2024 18:15:15 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED85156641;
	Mon,  6 May 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715019315; cv=none; b=h3+ymjmW45lCp+GvN6GKcyrsNL5QsCBLiSeilSszSMDyvqIghA8HEoJ9GOLiN8K2EvjtvQQ+lHNjvOfEQfs+oLXpgOUvWQDHRBiGyUponEeg/ZkJwMPydJU8K5dd2BX+eYzb9ifvl5jERSbTlbh/myPpuYG+Si37qXkVv+IWKfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715019315; c=relaxed/simple;
	bh=ZhH5iWadclZ9+WfXofPKpyaOZHjgm7/VzbgUngE0oP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FanQkZg96UguXoIjJosomOTl3sHWhTjfV+Vg5/uElN9flOe52yatyN7YRdjzVCx/X6V51ZD/OWxeAoeLgbMJBBBkcqJxYGfcWGMMrYP9oLl5nrF7Wxhp7HCeClcibsg72o4+mj+DmAXslWlI3vrp/vi/0C1SLgy99q6lliPLErw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4789AC116B1;
	Mon,  6 May 2024 18:15:10 +0000 (UTC)
Date: Mon, 6 May 2024 14:15:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, "David S. Miller"
 <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Donald Dutile
 <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, Heiko Carstens
 <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen
 <chenhuacai@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, Liviu
 Dudau <liviu@dudau.co.uk>, Luis Chamberlain <mcgrof@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nadav Amit <nadav.amit@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Russell King
 <linux@armlinux.org.uk>, Sam Ravnborg <sam@ravnborg.org>, Song Liu
 <song@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas
 Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v8 06/17] mm: introduce execmem_alloc() and
 execmem_free()
Message-ID: <20240506141515.10fb2a69@gandalf.local.home>
In-Reply-To: <20240505142600.2322517-7-rppt@kernel.org>
References: <20240505142600.2322517-1-rppt@kernel.org>
	<20240505142600.2322517-7-rppt@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 May 2024 17:25:49 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 70139d9d2e01..c8ddb7abda7c 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -25,6 +25,7 @@
>  #include <linux/memory.h>
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
> +#include <linux/execmem.h>
>  
>  #include <trace/syscall.h>
>  
> @@ -261,15 +262,14 @@ void arch_ftrace_update_code(int command)
>  #ifdef CONFIG_X86_64
>  
>  #ifdef CONFIG_MODULES
> -#include <linux/moduleloader.h>
>  /* Module allocation simplifies allocating memory for code */
>  static inline void *alloc_tramp(unsigned long size)
>  {
> -	return module_alloc(size);
> +	return execmem_alloc(EXECMEM_FTRACE, size);
>  }
>  static inline void tramp_free(void *tramp)
>  {
> -	module_memfree(tramp);
> +	execmem_free(tramp);
>  }
>  #else
>  /* Trampolines can only be created if modules are supported */
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

