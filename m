Return-Path: <linux-arch+bounces-8029-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D35899A149
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 12:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9421C21DC3
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 10:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D2E212636;
	Fri, 11 Oct 2024 10:26:19 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CC521262B;
	Fri, 11 Oct 2024 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642379; cv=none; b=Abn6jj1+OEVSpQTS6v/fu40V+bVPt9OjiLhBhpVNRXxHWrQUw3NR/xsHV3ZTftdDwNxYeYa2Y6l3NC8blBeo0EiBfn/N2TrzKFcuwtOgEQQieCxfvsJFDPGhTylFz3nMnjrZS6fOmSiSKKDCnTIHMr/W/vq6TCIy4jw6V+jIroQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642379; c=relaxed/simple;
	bh=0dwGa9SVY9M8sJrFLhNflP9Wh3zF7oUBp2nMDwcy8DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMZEvwJkJggDkNCgrv5kqUuv8piQCdfQQGCA7Ceja4kSXE5v8kX2/FFvS310rUCYQA0ImXXeQmC75H0DdTS250MLMQZnP0FDHg3Py/pTuizPGwFc5gLwjHF17FJsFmpF6VJIpNrmAdOwL0Rv+jRQYkH+EPjb7EjLAxZhDAYuaFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828ECC4CEC3;
	Fri, 11 Oct 2024 10:26:12 +0000 (UTC)
Date: Fri, 11 Oct 2024 11:26:10 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v3] ftrace: Consolidate ftrace_regs accessor functions
 for archs using pt_regs
Message-ID: <Zwj9QocrEVtgraHp@arm.com>
References: <20241010202114.2289f6fd@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010202114.2289f6fd@gandalf.local.home>

On Thu, Oct 10, 2024 at 08:21:14PM -0400, Steven Rostedt wrote:
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index bbb69c7751b9..5ccff4de7f09 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -54,6 +54,7 @@ extern void return_to_handler(void);
>  unsigned long ftrace_call_adjust(unsigned long addr);
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> +#define HAVE_ARCH_FTRACE_REGS
>  struct dyn_ftrace;
>  struct ftrace_ops;
>  struct ftrace_regs;

In case you need an ack for the arm64 change

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

