Return-Path: <linux-arch+bounces-7824-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABD0994508
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 12:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BFA1F23801
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 10:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3951F192591;
	Tue,  8 Oct 2024 10:04:06 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101AC19067C;
	Tue,  8 Oct 2024 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381846; cv=none; b=NeW5s6V8TT1wRPtudApoi05Qh50OP7ilvYcB//253JkwD+XsY2v6ehkCKEP3CRHHuzU07A/UXeGJydcaoMWQJH532asr2dQkjhyk6f5aX7zmdKi57pSmfGYHxJDDuyGhu+/ujbuib+8z3ZYU0/ePfIIOcsd87uYUksl56OmZAoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381846; c=relaxed/simple;
	bh=SU8Tx39SBVHlL1bRNkXM2zIDtQra3W9DOH4t5+MKZBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NU8yFGtGTbEElCcnHXnaceGJIyv/qvefbr1M7CryijC/WOEpd4HC18Z9sVam0++fveAAfvkaRfGxmPONCEcBvXVJXHLnZeLjzAKW6ms0p1QldPNVi/MnkL0XMWUrOF4Ntqq/oV8teyf4UDZUZ2fw6YWqmxALfCIyn7WQz9DzYAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49794C4CEC7;
	Tue,  8 Oct 2024 10:04:00 +0000 (UTC)
Date: Tue, 8 Oct 2024 11:03:57 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] ftrace: Make ftrace_regs abstract from direct use
Message-ID: <ZwUDjbrYZNC7HLZS@arm.com>
References: <20241007204743.41314f1d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007204743.41314f1d@gandalf.local.home>

On Mon, Oct 07, 2024 at 08:47:43PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> ftrace_regs was created to hold registers that store information to save
> function parameters, return value and stack. Since it is a subset of
> pt_regs, it should only be used by its accessor functions. But because
> pt_regs can easily be taken from ftrace_regs (on most archs), it is
> tempting to use it directly. But when running on other architectures, it
> may fail to build or worse, build but crash the kernel!
> 
> Instead, make struct ftrace_regs an empty structure and have the
> architectures define __arch_ftrace_regs and all the accessor functions
> will typecast to it to get to the actual fields. This will help avoid
> usage of ftrace_regs directly.
> 
> Link: https://lore.kernel.org/all/20241007171027.629bdafd@gandalf.local.home/
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Note, I tried to cros-compile the affected architectures,
> but my builds failed for 32 bit powerpc and s390 (without this patch).
> It mostly compiled, and the affected files seemed to build.
> 
>  arch/arm64/include/asm/ftrace.h          | 20 +++++++++--------
>  arch/arm64/kernel/asm-offsets.c          | 22 +++++++++----------
>  arch/arm64/kernel/ftrace.c               | 10 ++++-----

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

