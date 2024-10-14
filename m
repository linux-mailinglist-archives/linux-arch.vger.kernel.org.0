Return-Path: <linux-arch+bounces-8069-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A95299C5EF
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 11:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80297B222F0
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B750155303;
	Mon, 14 Oct 2024 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="PGxm1Fmp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59D13DDAA;
	Mon, 14 Oct 2024 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898505; cv=none; b=rpcT6hWd2KipAqZaOQOUcytO5u1SbLvycb176OWGh3FXhl9CN6cNAbq0PqSReTWVAcwjPofIUsTYOipLqPhpz0iaGA6Us8he06PtsFBpKczC+EiKBKry40uxrYER9537IHXv+cp8WA7aJgRSUARWcq9J8ZboLqguEq4ZNSmOsKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898505; c=relaxed/simple;
	bh=x+/ck9aSh/7gVu837hFafgBrqLRUSUaV7ySbBYzEog4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dapbfAsPnst0WLZ0uRboa85LtLnt5OgSendgRtSIvD2GpmCNcF13T9LBDiy+k7PDPEbyaKBu1a3EOSaMkrIRSokE1aeVFRIDUoO9BMsMKpiHkNw/eMBVEDHTZ8l+WanjZWTkdp4gSVaL+Y5QrcnZ53cOkAvKtn27XacUQnDO5EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=PGxm1Fmp; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1728898499;
	bh=8yoW/bMMuUhsNoIY+v03cV8Q96rOm7zzVNxOIEq8g1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PGxm1FmpnYKCOYZYldJbve93zPeip8NT8lNVexJfj88C+KlBtt0XdbTEYrHZAvz1V
	 B58uehx94E4sgjuY+XEpn1IQkx2SpdYJYY8wEggF7xP7T61kW/caf4yiV0lILKw2N4
	 zf0K5Y/DT4AOlxmLmzEuk5LbAdMKnnuNzcWmXR9apHO6VnEimT+ogxzj7+oH0wa6Bw
	 Qe4k2nuLx8KTUYrwqFQklRQpchinn74TXgmmfA49qZjxGaBgbOpdS99PsfNJE+tZd9
	 UwvwBS/y3GB3Sa+tSx5O/DCEXvnzt/v0ppfakLsbIZdZ1O4OUB2NOFWKYA0/Cq8JGr
	 5m5WbVOeW3dIg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XRsWz6R99z4wbr;
	Mon, 14 Oct 2024 20:34:55 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, "x86@kernel.org"
 <x86@kernel.org>, Will Deacon <will@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Catalin
 Marinas <catalin.marinas@arm.com>
Subject: Re: [for-next][PATCH 4/4] ftrace: Consolidate ftrace_regs accessor
 functions for archs using pt_regs
In-Reply-To: <20241011132956.899228335@goodmis.org>
References: <20241011132941.339392460@goodmis.org>
 <20241011132956.899228335@goodmis.org>
Date: Mon, 14 Oct 2024 20:34:52 +1100
Message-ID: <87iktv58oz.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:
> From: Steven Rostedt <rostedt@goodmis.org>
>
> Most architectures use pt_regs within ftrace_regs making a lot of the
> accessor functions just calls to the pt_regs internally. Instead of
> duplication this effort, use a HAVE_ARCH_FTRACE_REGS for architectures
> that have their own ftrace_regs that is not based on pt_regs and will
> define all the accessor functions, and for the architectures that just use
> pt_regs, it will leave it undefined, and the default accessor functions
> will be used.
>
> Note, this will also make it easier to add new accessor functions to
> ftrace_regs as it will mean having to touch less architectures.
>
> Cc: <linux-arch@vger.kernel.org>
> Cc: "x86@kernel.org" <x86@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Naveen N Rao <naveen@kernel.org>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Link: https://lore.kernel.org/20241010202114.2289f6fd@gandalf.local.home
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  arch/arm64/include/asm/ftrace.h     |  1 +
>  arch/loongarch/include/asm/ftrace.h | 25 +-------------------
>  arch/powerpc/include/asm/ftrace.h   | 26 +--------------------
  
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

>  arch/riscv/include/asm/ftrace.h     |  1 +
>  arch/s390/include/asm/ftrace.h      | 26 +--------------------
>  arch/x86/include/asm/ftrace.h       | 21 +----------------
>  include/linux/ftrace.h              | 32 ++++++-------------------
>  include/linux/ftrace_regs.h         | 36 +++++++++++++++++++++++++++++
>  8 files changed, 49 insertions(+), 119 deletions(-)
>  create mode 100644 include/linux/ftrace_regs.h

