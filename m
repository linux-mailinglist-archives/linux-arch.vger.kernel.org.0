Return-Path: <linux-arch+bounces-7800-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AA8993F07
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 08:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5F32831F6
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 06:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D321D0E3A;
	Tue,  8 Oct 2024 06:24:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F12F1D097F;
	Tue,  8 Oct 2024 06:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368668; cv=none; b=vBAkHf1B3kY1oQpI6gWSqToHx1VSdcIRZk00iEbaBP5jBE25UgCgm6eNLgQiM6Vp3ju5KTCRc7jz1l/hs4eo9tlERr6x7nBBsn/JZhjWviAQ4gVwG7Lv3Dvsj/SMkd5C8FMm21qncVKQEMBWr2xGSC/hX3VrPFXpZ+Uj29MB66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368668; c=relaxed/simple;
	bh=W10THfaXd5oXjdQ1soLRjb0+jNqS8m+NgN0nOjbWOqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+V0N21cPQ6g5sNB3NHblbS41jS2D6zmLiEOSiJGssOrOe1DobzyltoORPNb7KqeaLT1tOQE3obP5HnhfPA1c+rIopwqSB/bFrgjLUD7PLtX8yTlfkHrh5CUAxtPGQo+zdMA+jFObRF+BIPx8m1Zqj5dsnSjPPppOic9hgpII6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XN5Zw3r7hz9sPd;
	Tue,  8 Oct 2024 08:24:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 83WsnfrASkNO; Tue,  8 Oct 2024 08:24:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XN5Zw2vlKz9rvV;
	Tue,  8 Oct 2024 08:24:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F4488B788;
	Tue,  8 Oct 2024 08:24:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id WqcteU_NOog8; Tue,  8 Oct 2024 08:24:24 +0200 (CEST)
Received: from [192.168.233.14] (unknown [192.168.233.14])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0CB258B763;
	Tue,  8 Oct 2024 08:24:23 +0200 (CEST)
Message-ID: <8e99826f-b38a-4cb3-ba5e-a20512248853@csgroup.eu>
Date: Tue, 8 Oct 2024 08:24:22 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ftrace: Make ftrace_regs abstract from direct use
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20241007204743.41314f1d@gandalf.local.home>
 <20241007205458.2bbdf736@gandalf.local.home>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241007205458.2bbdf736@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/10/2024 à 02:54, Steven Rostedt a écrit :
> On Mon, 7 Oct 2024 20:47:43 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> +#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
>> +struct __arch_ftrace_regs {
>> +	struct pt_regs		regs;
>> +};
>> +
>> +#define arch_ftrace_get_regs(fregs)					\
>> +	({ struct __arch_fregs_regs *__f = (struct __arch_ftrace_regs *)(fregs); \
>> +		&__f->regs;						\
>> +	})
> 
> I wrote the arch_ftrace_get_regs() at the start of creating this patch.
> 
>> +
>> +struct ftrace_regs;
>> +#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
>> +
> 
> I just realized I can simplify it with:
> 
> #define arch_ftrace_get_regs(fregs)	({ &arch_ftrace_regs(fregs)->regs; })

Is it possible to write it as a static inline function to enforce type 
checking ?

> 
> I may send a v2 (tomorrow).
> 
> -- Steve

